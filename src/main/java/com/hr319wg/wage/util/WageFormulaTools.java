package com.hr319wg.wage.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import bsh.Interpreter;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageConstBO;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.ucc.IWageConstUCC;
import com.hr319wg.wage.ucc.impl.WageConstUCC;

public class WageFormulaTools
{
  public Vector queryInfoItems(String formulaStr)
    throws SysException
  {
    Vector vct = new Vector();
    try {
      String resStr = "_{1}[a-z]{1}[0-9]{3}\\.{1}[a-z]{1}[0-9]{6}";
      Pattern p = Pattern.compile(resStr, 2);
      Matcher m = p.matcher(formulaStr);
      while (m.find()) {
        String item = m.group();
        if (!vct.contains(item))
          vct.addElement(item);
      }
      if (formulaStr.indexOf("PREV") >= 0) {
        resStr = "_{1}[a-z]{1}[0-9]{3}P{1}R{1}E{1}V{1}\\.{1}[a-z]{1}[0-9]{6}";
        p = Pattern.compile(resStr, 2);
        m = p.matcher(formulaStr);
        while (m.find()) {
          String item = m.group();
          if (!vct.contains(item))
            vct.addElement(item);
        }
      }
    } catch (Exception ex) {
      ex.printStackTrace();
      throw new SysException("", "正则表达式解析错误", ex, getClass());
    }
    return vct;
  }

  public String dealInfoItems(String formulaStr, Vector vct, String resultFld)
    throws SysException
  {
    try
    {
      if (formulaStr.indexOf(resultFld) == -1) {
        throw new SysException("公式定义错误，没有定义结果指标");
      }
      int len = 0;
      if (vct != null)
        len = vct.size();
      for (int i = 0; i < len; i++) {
        String item = (String)vct.elementAt(i);
        String tmp = item.substring(1);
        int loc = tmp.indexOf(".");
        String table = tmp.substring(0, loc);
        String field = tmp.substring(loc + 1);

        InfoItemBO itemObj = SysCacheTool.findInfoItem(table, field);

        if (itemObj == null)
          throw new SysException("公式定义错误，" + tmp + "不存在");
        if (resultFld.equals(tmp))
        {
          formulaStr = CommonFuns.replaceAllString(formulaStr, item, "result");
        }
        else if ("6".equals(itemObj.getItemDataType())) {
          formulaStr = CommonFuns.replaceAllString(formulaStr, item + "==", "0.0==0.");
          formulaStr = CommonFuns.replaceAllString(formulaStr, item + "!=", "0.0!=0.");
        }
        else {
          formulaStr = CommonFuns.replaceAllString(formulaStr, item, String.valueOf("0.0"));
        }
      }

      return "double result;" + formulaStr;
    } catch (Exception ex) {
      ex.printStackTrace();
    }throw new SysException("处理公式中的工资项失败");
  }

  public String makeFormula(String exp)
    throws SysException
  {
    try
    {
      String express = exp;

      Interpreter bsh = new Interpreter();
      bsh.eval(express);
      String result = String.valueOf(bsh.get("result"));
      if ((result == null) || ("".equals(result)))
        result = "0.0";
      return result;
    } catch (Exception ex) {
      ex.printStackTrace();
      throw new SysException("公式定义错误:" + ex.getMessage());
    }
  }

  public Hashtable queryConstTable() {
    try {
      IWageConstUCC wageconstucc = (WageConstUCC)SysContext.getBean("wage_ConstUccImpl");
      return wageconstucc.queryAllToTable();
    } catch (Exception e) {
    }
    return new Hashtable();
  }

  public String formulaConstSet(String formulaStr, Hashtable consttable) {
    String result = formulaStr;
    try {
      Iterator it = consttable.keySet().iterator();
      while (it.hasNext()) {
        String constid = it.next().toString();
        WageConstBO wb = (WageConstBO)consttable.get(constid);
        if ((wb != null) && (wb.getConstValue() != null) && (!"".equals(wb.getConstValue()))) {
          result = result.replaceAll(wb.getConstID(), wb.getConstValue());
        }
        else {
          result = result.replaceAll(wb.getConstID(), "0");
        }
      }
      return result;
    } catch (Exception e) {
    }
    return formulaStr;
  }

  private String formulaString(String formulaStr)
  {
    StringBuffer Result = new StringBuffer();
    boolean find = false;
    for (int i = 0; i < formulaStr.length(); i++) {
      if (formulaStr.substring(i, i + 1).equals("'")) {
        if (!find) {
          Result.append("0.0");
        }
        find = !find;
      }
      else if (!find) {
        Result.append(formulaStr.substring(i, i + 1));
      }
    }
    return Result.toString();
  }

  public void checkFormula(String formulaStr, String fieldId)
    throws SysException
  {
    if ((formulaStr == null) || ("".equals(formulaStr))) {
      throw new SysException("参数错误，公式不能为空");
    }
    Hashtable ht = queryConstTable();
    formulaStr = formulaConstSet(formulaStr, ht);

    formulaStr = formulaString(formulaStr);
    if ((fieldId == null) || ("".equals(fieldId)))
      throw new SysException("参数错误，公式对应的结果字段不能为空");
    try {
      WageFunctionTools funCommonFuns = new WageFunctionTools();

      formulaStr = funCommonFuns.makeFunction(formulaStr);

      formulaStr = funCommonFuns.makeFunction(formulaStr);

      Vector vct = queryInfoItems(formulaStr);

      String exp = dealInfoItems(formulaStr, vct, fieldId);

      StringTokenizer st = new StringTokenizer(exp, "{,}", false);
      while (st.hasMoreElements()) {
        String token = st.nextToken();
        if ((token.indexOf("if") < 0) && (token.indexOf("else if") < 0) && (token.indexOf("else") < 0)) {
          if (token.indexOf("==") > 0)
            throw new SysException("检查公式错误，计算表达式中不能含有“==”符号");
          if ((token.indexOf("=") < 0) || (token.indexOf("=") == token.length())) {
            throw new SysException("检查公式错误，计算表达式不完整");
          }
          String leftStr = "";
          if (token.indexOf("double") >= 0)
            leftStr = token.substring(token.indexOf(";") + 1, token.indexOf("="));
          else
            leftStr = token.substring(0, token.indexOf("="));
          if (leftStr.lastIndexOf("result") > 0) {
            throw new SysException("检查公式错误，公式结果重复定义");
          }

        }

      }

      int scan = 0;
      while (true) {
        scan++;
        if (scan > 5) break;
        int posb = exp.indexOf("~");
        if (posb < 0) break;
        int pose = exp.indexOf("~", posb >= 0 ? posb + 1 : 0);
        if ((posb >= 0) && (pose >= 0) && (pose > posb)) {
          String re = exp.substring(posb, pose + 1);
          exp = exp.replaceAll(re, "0.0");
        }
      }
      makeFormula(exp);
    } catch (SysException he) {
      throw he;
    } catch (Exception ex) {
      throw new SysException("", "公式检查失败:" + ex.getMessage(), ex, getClass());
    }
  }

  public String transIfExpress(String express) {
    String tmp = express;
    if ("SQL SERVER".equals(Constants.DB_TYPE)) {
      String resStr = "[a-z]{1}[0-9]{6}[^']";
      Pattern p = Pattern.compile(resStr, 2);
      Matcher m = p.matcher(express);
      HashMap hm = new HashMap();
      ArrayList array = new ArrayList();
      while (m.find()) {
        String temp = m.group();
        if (hm.get(temp.substring(0, 7)) == null) {
          array.add(m.group());
          hm.put(temp.substring(0, 7), temp);
        }
      }
      for (int i = 0; i < array.size(); i++) {
        String field = ((String)array.get(i)).substring(0, 7);
        tmp = tmp.replaceAll(field, " cast( dbo.myisnull(" + field + ",'0') as numeric(30,2))");
      }
      if ("SQL SERVER".equals(Constants.DB_TYPE)) {
        tmp = tmp.replaceAll("GetYear", "dbo.GetYear").replaceAll("GetMonth", "dbo.GetMonth").replaceAll("GetSumByYear", "dbo.GetSumByYear");
      }
    }
    return tmp;
  }

  public String transExpress(String express)
  {
    String tempstr = express;
    int equal = tempstr.indexOf("=");
    String left = tempstr.substring(0, equal);
    String right = tempstr.substring(equal + 1);

    if ("SQL SERVER".equals(Constants.DB_TYPE)) {
      String resStr = "[a-z]{1}[0-9]{6}(PREV)*";
      Pattern p = Pattern.compile(resStr, 2);
      Matcher m = p.matcher(right);
      ArrayList array = new ArrayList();
      HashMap hm = new HashMap();
      while (m.find()) {
        String temp = m.group();
        if (temp.indexOf("PREV") >= 0) {
          temp = temp.substring(0, 11);
        }
        else {
          temp = temp.substring(0, 7);
        }
        if (hm.get(temp) == null) {
          array.add(temp);
          hm.put(temp, temp);
        }
      }
      for (int i = 0; i < array.size(); i++) {
        String field = (String)array.get(i);
        right = right.replaceAll(field, " cast( dbo.myisnull(" + field + ",'0') as numeric(30,2))");
      }
      tempstr = left + "=" + right;
      tempstr = tempstr.replaceAll("GetYear", "dbo.GetYear").replaceAll("GetMonth", "dbo.GetMonth").replaceAll("GetSumByYear", "dbo.GetSumByYear");
    }
    return tempstr;
  }

  public List dealIfElse(String content, String idStr, String tableName)
    throws SysException
  {
    try
    {
      content = content.trim();
      String[] strs = content.split("\\}");
      List updateSql = new ArrayList();

      StringBuffer tmp = new StringBuffer();
      int count = strs.length;
      for (int j = 0; j < count; j++) {
        String str = strs[j];
        String expressStr = "";
        String whereStr = "";
        if ((str.indexOf("else") != -1) && (str.indexOf("if") == -1)) {
          int starthualoc = str.indexOf("{");
          expressStr = str.substring(starthualoc + 1).trim();
          StringBuffer tmpcon = new StringBuffer();
          tmpcon.append(tmp);
          tmpcon.delete(0, 2);
          tmpcon.insert(0, " (id not in(select id from " + tableName + " where ");
          tmpcon.append("))");
          whereStr = tmpcon.toString();
        } else {
          int startloc = str.indexOf("(");
          int starthualoc = str.indexOf("{");
          int endloc = str.substring(0, starthualoc).lastIndexOf(")");

          expressStr = str.substring(starthualoc + 1).trim();
          if (str.indexOf("else") != -1) {
            StringBuffer tmpcon = new StringBuffer();
            tmpcon.append(tmp);
            tmpcon.delete(0, 2);
            tmpcon.insert(0, " and (id not in(select id from " + tableName + " where ");
            tmpcon.append("))");
            tmpcon.insert(0, str.substring(startloc + 1, endloc));
            whereStr = tmpcon.toString();
          }
          else {
            whereStr = str.substring(startloc + 1, endloc);
          }
          tmp.append("or (").append(str.substring(startloc + 1, endloc)).append(") ");
        }
        whereStr = whereStr.replaceAll("&&", " and ");
        whereStr = whereStr.replaceAll("\\|\\|", " or ");
        whereStr = whereStr.replaceAll("==", "=");

        expressStr = expressStr.replaceAll(";", "");

        if (idStr == null)
          updateSql.add("update " + tableName + " set " + transExpress(expressStr) + " where (" + transIfExpress(whereStr) + ") ");
        else {
          updateSql.add("update " + tableName + " set " + transExpress(expressStr) + " where (" + transIfExpress(whereStr) + ") and " + idStr);
        }
      }
      return updateSql;
    } catch (Exception he) {
      he.printStackTrace();
    }throw new SysException("处理公式中的if else 语句失败");
  }

  public Hashtable computeFormulaNoBuss(String personId, WageFormulaBO[] fmls, Hashtable hashtab)
    throws SysException
  {
    try
    {
      WageFunctionTools sf = new WageFunctionTools();
      int len = fmls.length;
      Hashtable valuehash = new Hashtable(len);
      for (int i = 0; i < len; i++) {
        String field = fmls[i].getRsField();
        String content = fmls[i].getExpress();
        String fmlfld = "_" + fmls[i].getRsTable() + "." + fmls[i].getRsField();
        content = CommonFuns.replaceAllString(content, fmlfld, "result");
        Vector vct = queryInfoItems(content);
        for (int j = 0; j < vct.size(); j++) {
          String item = (String)vct.elementAt(j);
          String tmp = item.substring(1);
          int loc = tmp.indexOf(".");
          String fld = tmp.substring(loc + 1);
          String fldvalue = (String)hashtab.get(fld);
          if (Double.parseDouble(fldvalue) < 0.0D)
            fldvalue = "(" + fldvalue + ")";
          content = CommonFuns.replaceAllString(content, item, fldvalue);
        }
        content = sf.calRoundFun(content);
        content = "double result;" + content;
        String value = makeFormula(content);
        hashtab.remove(field);
        hashtab.put(field, value);
        valuehash.put(field, value);
      }
      return valuehash; } catch (Exception ex) {
    }
    throw new SysException("公式计算失败");
  }
}