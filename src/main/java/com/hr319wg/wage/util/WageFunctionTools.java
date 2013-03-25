package com.hr319wg.wage.util;

import java.text.DecimalFormat;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import bsh.Interpreter;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.util.CommonFuns;

public class WageFunctionTools
{
  public static final String Fun_Round_Res = "Round\\([^,]*,{1}[0-9]{1}\\)";
  public static final String Fun_GetYear_Res = "GetYear\\(.{13}\\)";
  public static final String Fun_GetMonth_Res = "GetMonth\\(.{13}\\)";
  public static final String Fun_GetSum_ByYear = "GetSumByYear\\(.{13}\\)";
  public static final String Fun_GetSum_ByMonth = "GetSumByMonth\\(.{13},{1}[0-9]{1,2},{1}[0-9]{1,2}\\)";
  public static final String Fun_GetSum_ByMonth_Last = "GetSumByMonth_Last\\(.{13},{1}[0-9]{1,2},{1}[0-9]{1,2}\\)";
  public static final String Fun_MonthDiff = "MonthDiff\\(.{13}\\)";

  public Vector checkFunction(String input, String resStr)
  {
    Pattern p = Pattern.compile(resStr, 2);
    Matcher m = p.matcher(input);
    Vector vct = new Vector();
    while (m.find()) {
      String item = m.group();
      vct.addElement(item);
    }
    return vct;
  }

  public String makeFunction(String input)
    throws SysException
  {
    try
    {
      input = replaceFunction(input, "Round\\([^,]*,{1}[0-9]{1}\\)");
      input = replaceFunction(input, "GetYear\\(.{13}\\)");
      input = replaceFunction(input, "GetMonth\\(.{13}\\)");
      input = replaceFunction(input, "GetDays\\(.{13}\\)");
      input = replaceFunction(input, "GetWorkDays\\(.{13}\\)");
      input = replaceFunction(input, "GetSumByYear\\(.{13}\\)");
      input = replaceFunction(input, "GetSumByMonth\\(.{13},{1}[0-9]{1,2},{1}[0-9]{1,2}\\)");
      input = replaceFunction(input, "GetSumByMonth_Last\\(.{13},{1}[0-9]{1,2},{1}[0-9]{1,2}\\)");
      input = replaceFunction(input, "MonthDiff\\(.{13}\\)");
    }
    catch (Exception he) {
      he.printStackTrace();
      throw new SysException();
    }
    return input;
  }

  public String calRoundFun(String input)
    throws SysException
  {
    try
    {
      Vector vct = checkFunction(input, "Round\\([^,]*,{1}[0-9]{1}\\)");
      int len = vct.size();
      String format = "0";
      String formatStr = "#########";
      for (int i = 0; i < len; i++) {
        String str = (String)vct.elementAt(i);
        int loc1 = str.indexOf("(");
        int loc2 = str.indexOf(",");
        int loc3 = str.lastIndexOf(")");
        String value = str.substring(loc1 + 1, loc2).trim();
        int num = Integer.parseInt(str.substring(loc2 + 1, loc3).trim());
        String tmp = formatStr.substring(0, num);
        if (tmp.length() > 0)
          format = format + "." + tmp;
        DecimalFormat df = new DecimalFormat(format);
        Interpreter bsh = new Interpreter();
        if (value.indexOf("result") == -1) {
          value = String.valueOf(bsh.eval(value));
        } else {
          bsh.eval(value);
          value = String.valueOf(bsh.get("result"));
        }
        value = df.format(Double.parseDouble(value));
        if (Double.parseDouble(value) < 0.0D)
          value = "(" + value + ")";
        input = CommonFuns.replaceAllString(input, str, value);
      }
    } catch (Exception ex) {
      throw new SysException("四舍五入函数处理错误");
    }
    return input;
  }

  public String replaceFunction(String input, String resStr)
    throws SysException
  {
    try
    {
      Vector vct = checkFunction(input, resStr);
      int len = vct.size();
      for (int i = 0; i < len; i++) {
        String str = (String)vct.elementAt(i);
        if ((str.startsWith("GetYear")) || (str.startsWith("GetMonth")) || (str.startsWith("GetDays")) || (str.startsWith("GetWorkDays")) || (str.startsWith("GetSumByYear")) || 
        		(str.startsWith("GetSumByMonth")) || (str.startsWith("GetSumByMonth_Last")) || (str.startsWith("MonthDiff")))
        {
          input = CommonFuns.replaceAllString(input, str, "0");
        }
        else {
          int loc1 = str.indexOf("(");
          int loc2 = str.indexOf(",");
          input = CommonFuns.replaceAllString(input, str, str.substring(loc1 + 1, loc2).trim());
        }
      }
    } catch (Exception ex) {
      throw new SysException("函数定义错误");
    }
    return input;
  }
  public String preProcess(String input, String setid, String paydate) throws SysException {
    Vector vct = checkFunction(input, "GetSumByYear\\(.{13}\\)");
    int len = vct.size();
    for (int i = 0; i < len; i++) {
      String str = (String)vct.elementAt(i);
      String para = str.replaceAll("GetSumByYear\\(", "").replaceAll("\\)", "");
      String replace = "GetSumByYear\\(ID,'" + setid + "','" + paydate + "','" + para + "'\\)";
      input = input.replaceAll("GetSumByYear\\(" + para + "\\)", replace);
    }

    vct = checkFunction(input, "GetSumByMonth\\(.{13},{1}[0-9]{1,2},{1}[0-9]{1,2}\\)");
    len = vct.size();
    for (int i = 0; i < len; i++) {
      String str = (String)vct.elementAt(i);
      String parastr = str.replaceAll("GetSumByMonth\\(", "").replaceAll("\\)", "");
      String[] para = parastr.split(",");
      String begin = paydate.substring(0, 4) + "-" + CommonFuns.leftPad(para[1], 2, "0");
      String end = paydate.substring(0, 4) + "-" + CommonFuns.leftPad(para[2], 2, "0");
      String replace = "GetSumByMonth\\(ID,'" + setid + "','" + para[0] + "','" + begin + "','" + end + "'\\)";
      input = input.replaceAll("GetSumByMonth\\(" + para[0] + "," + para[1] + "," + para[2] + "\\)", replace);
    }

    vct = checkFunction(input, "GetSumByMonth_Last\\(.{13},{1}[0-9]{1,2},{1}[0-9]{1,2}\\)");
    len = vct.size();
    for (int i = 0; i < len; i++) {
      String str = (String)vct.elementAt(i);
      String parastr = str.replaceAll("GetSumByMonth_Last\\(", "").replaceAll("\\)", "");
      String[] para = parastr.split(",");
      String begin = CommonFuns.StringMinus(paydate.substring(0, 4), "1") + "-" + CommonFuns.leftPad(para[1], 2, "0");
      String end = CommonFuns.StringMinus(paydate.substring(0, 4), "1") + "-" + CommonFuns.leftPad(para[2], 2, "0");
      String replace = "GetSumByMonth_Last\\(ID,'" + setid + "','" + para[0] + "','" + begin + "','" + end + "'\\)";
      input = input.replaceAll("GetSumByMonth_Last\\(" + para[0] + "," + para[1] + "," + para[2] + "\\)", replace);
    }

    vct = checkFunction(input, "MonthDiff\\(.{13}\\)");
    len = vct.size();
    for (int i = 0; i < len; i++) {
      String str = (String)vct.elementAt(i);
      String para = str.replaceAll("MonthDiff\\(", "").replaceAll("\\)", "");
      String replace = "MonthDiff\\(" + para + ",'" + paydate + "'\\)";
      if ("SQL SERVER".equals(Constants.DB_TYPE)) {
        replace = "dbo.MonthDiff\\(" + para + ",'" + paydate + "'\\)";
      }
      input = input.replaceAll("MonthDiff\\(" + para + "\\)", replace);
    }
    return input;
  }
}