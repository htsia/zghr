package com.hr319wg.custom.extend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageStandardBO;
import com.hr319wg.wage.pojo.bo.WageStdItemBO;
import com.hr319wg.wage.service.WageComputeService;

public class WageComputeServiceByExtend extends WageComputeService {

	  public void batchHandleStandardItem(boolean isTry, String setId, String[] personId, String payoffDate) throws SysException {
	    List setStdItemList = this.getWagesetitemdao().querySetItemByType(setId, "0");//要查表的工资项目信息
	    if ((setStdItemList != null) && (setStdItemList.size() > 0)) {//有元素才计算
	      List<WageStdItemBO> stdItemList = new ArrayList(); //当前帐套中的所有工资项目
	      HashMap stdValue = new HashMap();//记录要查表的项目是根据哪两个其它项目查出来的
	      
	      List sqlList = new ArrayList();

	      HashMap numberList = new HashMap();//进一步把stdValue转换成对象,x/y轴对应的字段对象
	      
	      StringBuffer select = new StringBuffer(" select A001.ID ");//查询本帐套人员的SQL
	      StringBuffer from = new StringBuffer(" from wage_set_pers_r left join A001 ");
	      from.append(" on wage_set_pers_r.ID=A001.ID");

	      StringBuffer where = new StringBuffer(" where 1=1 ");
	      where.append(" and wage_set_pers_r.A815700='" + setId + "'");
	      if (personId != null) {
	        where.append(" and ").append(CommonFuns.splitInSql(personId, "A001.ID"));
	      }

	      int count = setStdItemList.size();

	      for (int i = 0; i < count; i++) {//循环处理要查表的工资项目
	        WageSetItemBO setStdItem = (WageSetItemBO)setStdItemList.get(i);
	        String stdId = setStdItem.getLinkId();

	        WageStandardBO wsbo = (WageStandardBO)this.getWagestandarddao().findBoById(WageStandardBO.class, stdId);

	        if ((wsbo.getApplyMonth() != null) && (!"".equals(wsbo.getApplyMonth())) && (wsbo.getApplyMonth().indexOf("-1") < 0) && (payoffDate != null) && (payoffDate.length() >= 7))
	        {
	          String month = payoffDate.substring(5, 7);
	          if (wsbo.getApplyMonth().indexOf(month) < 0)
	          {
	            continue;
	          }
	        }
	        if ((wsbo.getFilterField() != null) && (!"".equals(wsbo.getFilterField())) && (!"-1".equals(wsbo.getFilterField()))) {
	          if (from.indexOf("A796") < 0) {
	            from.append(" left join A796 B on B.id=A001.id");
	          }
	          if (select.indexOf(wsbo.getFilterField()) < 0) {
	            select.append(",").append(wsbo.getFilterField());
	          }

	        }

	        List tmp = this.getWagestditemdao().queryStdItemByStdId(stdId);
	        String r_item = "";
	        String h_item = "";
	        String v_item = "";
	        int len = tmp.size();
	        for (int k = 0; k < len; k++) {
	          WageStdItemBO stdItem = (WageStdItemBO)tmp.get(k);
	          if ("2".equals(stdItem.getType())) {
	            r_item = stdItem.getField();
	          } else if ("0".equals(stdItem.getType())) {
	            h_item = h_item + stdItem.getField() + ",";
	            InfoItemBO itembo = SysCacheTool.findInfoItem("", stdItem.getField());
	            if ((("2".equals(itembo.getItemDataType())) || ("1".equals(itembo.getItemDataType()))) && 
	              (numberList.get(itembo.getItemId()) == null)) {
	              numberList.put(itembo.getItemId(), itembo);
	            }
	          }
	          else if ("1".equals(stdItem.getType())) {
	            v_item = v_item + stdItem.getField() + ",";
	            InfoItemBO itembo = SysCacheTool.findInfoItem("", stdItem.getField());
	            if ((("2".equals(itembo.getItemDataType())) || ("1".equals(itembo.getItemDataType()))) && 
	              (numberList.get(itembo.getItemId()) == null)) {
	              numberList.put(itembo.getItemId(), itembo);
	            }
	          }

	          stdItemList.add(stdItem);
	        }
	        stdValue.put(r_item, stdId + "|" + h_item + "|" + v_item);
	      }
	      int size = stdItemList.size();

	      for (int j = 0; j < size; j++) {
	        WageStdItemBO stdItem = (WageStdItemBO)stdItemList.get(j);
	        if (select.indexOf(stdItem.getField()) < 0) {
	          select.append("," + stdItem.getField());
	          InfoSetBO infoset = SysCacheTool.findInfoSet(stdItem.getTable());

	          if ("A815".equals(infoset.getSetId()))
	            continue;
	          if (from.indexOf(stdItem.getTable()) < 0) {
	            if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType())) {
	              from.append(" left join (select ID," + stdItem.getField() + " from " + stdItem.getTable() + " where " + stdItem.getTable() + "000='" + "00901" + "') A" + j);
	              from.append(" on A" + j + ".ID=A001.ID");
	            }
	            else if (!"A001".equals(stdItem.getTable())) {
	              from.append(" left join ").append(stdItem.getTable());
	              from.append(" on  " + stdItem.getTable() + ".ID=A001.ID");
	            }

	          }
	          else if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType())) {
	            int index = from.indexOf("from " + stdItem.getTable());
	            from.insert(index, "," + stdItem.getField() + " ");
	          }

	        }

	      }

	      String stdCountTable = "HR319#" + setId + CommonFuns.getSysDate("yyyyMMddHHss");
	      StringBuffer createTableSql = new StringBuffer();
	      if ("ORACLE".equals(Constants.DB_TYPE)) {
	        createTableSql.append("create table ").append(stdCountTable).append(" as ");
	        createTableSql.append(select.toString()).append(from.toString()).append(where.toString());
	      }
	      else {
	        createTableSql.append("select * into ").append(stdCountTable).append(" from (");
	        createTableSql.append(select.toString()).append(from.toString()).append(where.toString());
	        createTableSql.append(") aaa");
	      }
	      sqlList.add(createTableSql.toString());

	      if ("SQL SERVER".equals(Constants.DB_TYPE)) {
	        sqlList.add("alter table " + stdCountTable + " alter column ID nvarchar(200) not null");
	      }
	      String indexSql = "alter table " + stdCountTable + "  add constraint PK_" + stdCountTable + " primary key (ID)";
	      sqlList.add(indexSql);
	      sqlList.add("alter table " + stdCountTable + " add changed int");

	      if (stdItemList.size() > 0) {
	        Iterator it = stdItemList.iterator();
	        while (it.hasNext()) {
	          sqlList.add("update " + stdCountTable + " set changed=0");
	          WageStdItemBO sibo = (WageStdItemBO) it.next();
	          if (sibo != null) {
	            List codeList = SysCacheTool.queryCodeItemBySetId(sibo.getCodeSetId());
	            for (int k = 0; k < codeList.size(); k++) {
	              CodeItemBO cb = (CodeItemBO)codeList.get(k);
	              String codeSql = "";
	              if ("SQL SERVER".equals(Constants.DB_TYPE)) {
	                if ((cb.getHighValue() != null) && (!"".equals(cb.getHighValue()))) {
	                  codeSql = "update " + stdCountTable + " set changed=1," + sibo.getField() + "='" + cb.getItemId() + "' where changed=0 and cast(" + sibo.getField()  + " as numeric(20,2))>=" + cb.getLowValue() + " and cast(" + sibo.getField()  + " as numeric(20,2))<" + cb.getHighValue();
	                }
	                else {
	                  codeSql = "update " + stdCountTable + " set changed=1," +  sibo.getField()  + "='" + cb.getItemId() + "' where changed=0 and cast(" + sibo.getField()  + " as numeric(20,2))>=" + cb.getLowValue();
	                }

	              }
	              else if ((cb.getHighValue() != null) && (!"".equals(cb.getHighValue()))) {
	                codeSql = "update " + stdCountTable + " set changed=1," + sibo.getField()  + "='" + cb.getItemId() + "' where changed=0 and 0.0+" + sibo.getField()  + ">=" + cb.getLowValue() + " and 0.0+" + sibo.getField()  + "<" + cb.getHighValue();
	              }
	              else {
	                codeSql = "update " + stdCountTable + " set changed=1," + sibo.getField()  + "='" + cb.getItemId() + "' where changed=0 and 0.0+" + sibo.getField()  + ">=" + cb.getLowValue();
	              }

	              sqlList.add(codeSql);
	            }
	          }
	        }
	      }

	      String field = "";
	      Iterator iterator = stdValue.keySet().iterator();
	      while (iterator.hasNext()) {
	        String key = (String)iterator.next();
	        field = field + key + ",";
	        String value = (String)stdValue.get(key);
	        String[] rs = value.split("\\|");
	        String stdId = rs[0];

	        String h_item = rs[1];
	        String v_item = rs[2];
	        WageStandardBO wsbo = (WageStandardBO)this.getWagestandarddao().findBoById(WageStandardBO.class, stdId);
	        if ((h_item != null) && (h_item.length() > 0)) {
	          h_item = h_item.substring(0, h_item.length() - 1);
	          h_item = h_item.replaceAll(",", " || ',' || tmp.");
	          h_item = stdCountTable + "." + h_item;
	        }
	        if ((v_item != null) && (v_item.length() > 0)) {
	          v_item = v_item.substring(0, v_item.length() - 1);
	          v_item = v_item.replaceAll(",", " || ',' || tmp.");
	          v_item = stdCountTable + "." + v_item;
	        }
	        StringBuffer sb = new StringBuffer();
	        sb.append(" select wage_standard_value.cell_value from wage_standard_value");
	        sb.append(" where wage_standard_value.std_id='" + stdId + "'");
	        if ((h_item != null) && (h_item.length() > 0)) {
	          sb.append(" and " + h_item + " = wage_standard_value.hcode_value ");
	        }
	        if ((v_item != null) && (v_item.length() > 0)) {
	          sb.append(" and " + v_item + " = wage_standard_value.vcode_value ");
	        }

	        StringBuffer tmpsql = new StringBuffer("update ").append(stdCountTable).append("  set ").append(key).append("=(").append(sb).append(") where exists (").append(sb).append(")");
	        if ((wsbo.getFilterField() != null) && (!"".equals(wsbo.getFilterField()))) {
	          tmpsql.append(" and " + wsbo.getFilterSql());
	        }
	        sqlList.add(tmpsql.toString());

	        if ((wsbo.getSaveAsField() != null) && (!"".equals(wsbo.getSaveAsField()))) {
	          InfoItemBO iib = SysCacheTool.findInfoItem("", wsbo.getSaveAsField());
	          InfoSetBO isb = SysCacheTool.findInfoSet(iib.getSetId());
	          if (InfoSetBO.RS_TYPE_SINGLE.equals(isb.getSet_rsType())) {
	            String write = "update " + isb.getSetId() + "  set " + iib.getItemId() + "=(select " + key + " from " + stdCountTable + " bbb  where " + isb.getSetId() + ".id=bbb.id) where id in (select id from " + stdCountTable + ")";
	            sqlList.add(write);
	          }
	          else {
	            String write = "update " + isb.getSetId() + "  set " + iib.getItemId() + "=(select " + key + " from " + stdCountTable + " bbb  where " + isb.getSetId() + ".id=bbb.id) where id in (select id from " + stdCountTable + ") and " + isb.getSetId() + "000='00901'";
	            sqlList.add(write);
	          }
	        }
	      }
	      String clearDataSql = "update " + stdCountTable + " set " + field;
	      clearDataSql = clearDataSql.replaceAll(",", "='0.0',");
	      clearDataSql = clearDataSql.substring(0, clearDataSql.length() - 1);
	      sqlList.add(1, clearDataSql);

	      String tmpTable = this.getTmp_table() + setId;
	      if (isTry) {
	        tmpTable = this.getTry_table() + setId;
	      }
	      StringBuffer updateCountTable = new StringBuffer();
	      field = field.substring(0, field.length() - 1);
	      String idStr = CommonFuns.splitInSql(personId, tmpTable + "." + "ID");

	      if ("ORACLE".equals(Constants.DB_TYPE)) {
	        updateCountTable.append("update ").append(tmpTable).append(" set (").append(field).append(") =");
	        updateCountTable.append("(").append("select " + field + " from " + stdCountTable + " where " + tmpTable + ".ID=" + stdCountTable + ".ID").append(")");
	        if (personId != null)
	          updateCountTable.append(" where (").append(idStr).append(")");
	        else
	          updateCountTable.append(" where exists ").append("(").append("select " + field + " from " + stdCountTable + " where " + tmpTable + ".ID=" + stdCountTable + ".ID").append(")");
	      }
	      else
	      {
	        String[] fs = field.split(",");
	        String set = "";
	        for (int i = 0; i < fs.length; i++) {
	          if ("".equals(set)) {
	            set = fs[i] + "=" + stdCountTable + "." + fs[i];
	          }
	          else {
	            set = set + "," + fs[i] + "=" + stdCountTable + "." + fs[i];
	          }
	        }
	        updateCountTable.append(" update ").append(tmpTable).append(" set ").append(set);
	        updateCountTable.append(" from  ").append(stdCountTable);
	        updateCountTable.append(" where " + tmpTable + ".ID=" + stdCountTable + ".ID");
	        if (personId != null)
	          updateCountTable.append(" and (").append(idStr).append(")");
	        else {
	          updateCountTable.append(" and exists ").append("(").append("select " + field + " from " + stdCountTable + " where " + tmpTable + ".ID=" + stdCountTable + ".ID").append(")");
	        }
	      }
	      sqlList.add(updateCountTable.toString());

	      String rlaTable = "wage_set_pers_r";
	      StringBuffer updateRlatTable = new StringBuffer();
	      updateRlatTable.delete(0, updateRlatTable.length());
	      idStr = CommonFuns.splitInSql(personId, rlaTable + "." + "ID");
	      if ("ORACLE".equals(Constants.DB_TYPE)) {
	        updateRlatTable.append("update ").append(rlaTable).append(" set (").append(field).append(") =");
	        updateRlatTable.append("(").append("select " + field + " from " + stdCountTable + " where " + rlaTable + ".ID=" + stdCountTable + ".ID ").append(")");
	        if (personId != null)
	          updateRlatTable.append(" where (" + rlaTable + "." + "A815700" + "='" + setId + "' and " + idStr + ")");
	        else
	          updateRlatTable.append(" where(" + rlaTable + "." + "A815700" + "='" + setId + "')");
	      }
	      else
	      {
	        String[] fs = field.split(",");
	        String set = "";
	        for (int i = 0; i < fs.length; i++) {
	          if ("".equals(set)) {
	            set = fs[i] + "=" + stdCountTable + "." + fs[i];
	          }
	          else {
	            set = set + "," + fs[i] + "=" + stdCountTable + "." + fs[i];
	          }
	        }

	        updateRlatTable.append(" update ").append(rlaTable).append(" set ").append(set);
	        updateRlatTable.append(" from ").append(stdCountTable);
	        updateRlatTable.append(" where " + rlaTable + ".ID=" + stdCountTable + ".ID ");
	        if (personId != null)
	          updateRlatTable.append(" and (" + rlaTable + "." + "A815700" + "='" + setId + "' and " + idStr + ")");
	        else {
	          updateRlatTable.append(" and(" + rlaTable + "." + "A815700" + "='" + setId + "')");
	        }
	      }
	      sqlList.add(updateRlatTable.toString());

	      String dropsql = "drop table " + stdCountTable;
	      int index = 0;
	      try {
	        for (; index < sqlList.size(); index++)
	          this.getApi().executeSql((String)sqlList.get(index));
	      }
	      catch (SysException e) {
	        throw new RollbackableException("计算标准表出错");
	      } finally {
	        if (this.getApi().isDBTable(stdCountTable)){
	          this.getApi().executeSql(dropsql);
	        }
	      }
	    }
	  }

}
