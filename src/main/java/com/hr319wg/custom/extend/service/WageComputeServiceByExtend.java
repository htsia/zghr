package com.hr319wg.custom.extend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageStandardBO;
import com.hr319wg.wage.pojo.bo.WageStdItemBO;
import com.hr319wg.wage.service.WageComputeService;
import com.hr319wg.wage.util.WageFormulaTools;
import com.hr319wg.wage.util.WageFunctionTools;

public class WageComputeServiceByExtend extends WageComputeService {

	  public Vector computePerson(boolean isTry, String setId, String dateId, String[] personId, String payoffDate, String unitId)
	    throws SysException
	  {
	    this.getWagesetdao().initProcess(setId);
	    try
	    {
	      batchHandleStandardItem(isTry, setId, personId, payoffDate);
	    } catch (SysException e) {
	      throw new RollbackableException("", "计算标准项出错；" + e.getSysMsg().getMessage(), e, getClass());
	    }

	    Vector vt = null;
	    try {
	      vt = batchHandleFormulaItem(isTry, setId, dateId, personId, payoffDate, unitId, false);
	    }
	    catch (RollbackableException be) {
	      throw be;
	    } catch (SysException e) {
	      throw new RollbackableException("", "计算公式项出错；" + e.getSysMsg().getMessage(), e, getClass());
	    }

	    try
	    {
	      computeAnnu(isTry, setId, dateId, personId, payoffDate, unitId);
	    } catch (SysException e) {
	      throw new RollbackableException("", "计算年金出错；" + e.getSysMsg().getMessage(), e, getClass());
	    }

	    try
	    {
	      if ("1".equals(Constants.WAGE_DATA_FORMAT))
	        adjustDataFormat(setId);
	    }
	    catch (SysException e) {
	      throw new RollbackableException("", "调整格式出错；" + e.getSysMsg().getMessage(), e, getClass());
	    }

	    String sql = "update wage_payoff set cacl_date='" + CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss") + "' where payoff_id='" + dateId + "'";
	    this.getApi().executeSql(sql);
	    return vt;
	  }
	/**
	 * 计算标准表,一次把该帐套中所有标准表计算完成
	 * @param isTry
	 * @param setId
	 * @param personId
	 * @param payoffDate
	 * @throws SysException
	 */
	@SuppressWarnings("unchecked")
	public void batchHandleStandardItem(boolean isTry, String setId, String[] personId, String payoffDate) throws SysException {
		//List<WageSetItemBO> setStdItemList = this.getWagesetitemdao().querySetItemByType(setId, "0");//要查表的工资项目信息
		List<WageSetItemBO> setStdItemList = this.getWagesetitemdao().getHibernatetemplate()
				.find("from WageSetItemBO where item_type = '0' and set_id = '"+setId+"' order by count_sequence");
		if ((setStdItemList != null) && (setStdItemList.size() > 0)) { //有元素才计算
			List<WageStdItemBO> stdItemList = new ArrayList<WageStdItemBO>(); //当前帐套中的所有工资项目
			List<String> stdValue = new ArrayList();//记录要查表的项目是根据哪两个其它项目查出来的

			List<String> sqlList = new ArrayList<String>();//保存要执行的SQL，最后一起执行

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
				//对应标准表
				WageStandardBO wsbo = (WageStandardBO)this.getWagestandarddao().findBoById(WageStandardBO.class, stdId);
				//适用月份不是本月不处理
				if ((wsbo.getApplyMonth() != null) && (!"".equals(wsbo.getApplyMonth())) && (wsbo.getApplyMonth().indexOf("-1") < 0) && (payoffDate != null) && (payoffDate.length() >= 7))
				{
					String month = payoffDate.substring(5, 7);
					if (wsbo.getApplyMonth().indexOf(month) < 0)
					{
						continue;
					}
				}
				//处理标准表中设置的过虑条件
				if ((wsbo.getFilterField() != null) && (!"".equals(wsbo.getFilterField())) && (!"-1".equals(wsbo.getFilterField()))) {
					if (from.indexOf("A796") < 0) {
						from.append(" left join A796 B on B.id=A001.id");
					}
					if (select.indexOf(wsbo.getFilterField()) < 0) {
						select.append(",").append(wsbo.getFilterField());
					}

				}

				List<WageStdItemBO> tmp = this.getWagestditemdao().queryStdItemByStdId(stdId);
				String r_item = "";
				String h_item = "";
				String v_item = "";
				int len = tmp.size();
				for (int k = 0; k < len; k++) {//处理标准表的三个指标：纵，横，结果
					WageStdItemBO stdItem = (WageStdItemBO)tmp.get(k);
					if ("2".equals(stdItem.getType())) {//2横坐标
						r_item = stdItem.getField();
					} else if ("0".equals(stdItem.getType())) {//0指标项,结果要保存的字段
						h_item = h_item + stdItem.getField() + ",";
						InfoItemBO itembo = SysCacheTool.findInfoItem("", stdItem.getField());
						if ((("2".equals(itembo.getItemDataType())) || ("1".equals(itembo.getItemDataType()))) && 
								(numberList.get(itembo.getItemId()) == null)) {
							numberList.put(itembo.getItemId(), itembo);
						}
					}
					else if ("1".equals(stdItem.getType())) {//1竖坐标
						v_item = v_item + stdItem.getField() + ",";
						InfoItemBO itembo = SysCacheTool.findInfoItem("", stdItem.getField());
						if ((("2".equals(itembo.getItemDataType())) || ("1".equals(itembo.getItemDataType()))) && 
								(numberList.get(itembo.getItemId()) == null)) {
							numberList.put(itembo.getItemId(), itembo);
						}
					}

					stdItemList.add(stdItem);
				}
				stdValue.add(r_item+":"+stdId + "|" + h_item + "|" + v_item);
			}//end for，预处理每个要查表的工资顶结束

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
					WageStandardBO wsbo = (WageStandardBO)this.getWagestandarddao().findBoById(WageStandardBO.class, sibo.getStdId());
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
						      
							if ((wsbo.getFilterField() != null) && (!"".equals(wsbo.getFilterField()))) {
								codeSql += " and " + wsbo.getFilterSql();
					        }
							sqlList.add(codeSql);
						}
					}
				}
			}

			String field = "";
			for (String emn : stdValue) {
				String key = emn.split(":")[0];
				if(!field.contains(key)){
					field = field + key + ",";
				}
				String value = emn.split(":")[1];
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




	//计算公式项
	public Vector batchHandleFormulaItem(boolean isTry, String setId, String dateId, String[] personId, String payoffDate, String unitId, boolean isInit) throws SysException
	{
		try {
			String maxItem = this.getWageapi().getMaxforDepSum(setId);

			List formualList = null;//取出所有公式
			if (!isInit) {
				formualList = this.getWagesetitemdao().queryFormulaBySetId(setId);
			}
			else {
				formualList = this.getWagesetinitdao().getFormularBySetId(setId);
			}

			boolean computeTax = false;//是否计算税
			WageSetBO sb = this.getWagesetdao().findSetBySetId(setId);
			if (((sb.getCessID() != null) && (!"".equals(sb.getCessID()))) || ((sb.getCessID2() != null) && (!"".equals(sb.getCessID2()))))
			{
				computeTax = true;
			}

			if ((formualList != null) && (formualList.size() > 0)) {//有公式时计算
				HashMap expressHash = new HashMap();
				List flaCountOrder = new ArrayList();
				List fieldList = new ArrayList();
				List sqlList = new ArrayList();
				List FNamelist = new ArrayList();

				if ("".equals(maxItem)) {
					sqlList.add("DeptSum");
					FNamelist.add("部门汇总");
				}
				if (computeTax) {
					fieldList.add("_A815.A815996");
					fieldList.add("_A815.A815997");
				}
				int count = formualList.size();
				WageFormulaTools fCommonFuns = new WageFormulaTools();
				Hashtable consttable = fCommonFuns.queryConstTable();
				boolean calcYearTax = false;
				for (int i = 0; i < count; i++) {//循环每一个公式，填充公式中的变量,生成参与计算的字段列表
					WageFormulaBO formula = (WageFormulaBO)formualList.get(i);
					try
					{
						String express = fCommonFuns.formulaConstSet(formula.getExpress(), consttable);

						express = express.replaceAll("~", "'")
								.replaceAll("GetDays\\(_A815.A815701\\)", "GetDays('"+payoffDate+"')")
								.replaceAll("GetMonth\\(_A815.A815701\\)", "GetMonth('"+payoffDate+"')")
								.replaceAll("GetYear\\(_A815.A815701\\)", "GetYear('"+payoffDate+"')")
								.replaceAll("GetWorkDays\\(_A815.A815701\\)", "GetWorkDays('"+payoffDate+"')");
						formula.setExpress(express);
						expressHash.put(formula.getRsField(), formula);
						flaCountOrder.add(formula.getRsField());

						Vector fld = fCommonFuns.queryInfoItems(express);
						fieldList.addAll(fld);
						if ((formula.getRsField().equals("A815713")) || (formula.getRsField().equals("A815711"))) {
							fieldList.add("_A815.A815714");
						}
						if (formula.getRsField().equals("A815711")) {
							fieldList.add("_A815.A815710");
						}
						if (formula.getRsField().equals("A815755")) {
							fieldList.add("_A815.A815756");
							calcYearTax = true;
						}
					} catch (Exception e) {
						throw new RollbackableException("", "计算公式'" + formula.getName() + "'时出错；", e, getClass());
					}
				}//循环每一个公式，填充公式中的变量完成

				if (calcYearTax) {//年税
					boolean have = false;
					for (int i = 0; i < fieldList.size(); i++) {
						if (((String)fieldList.get(i)).equals("_A815.A815713")) {
							have = true;
							break;
						}
					}
					if (!have) {
						fieldList.add("_A815.A815713");
					}

				}
				
				//生成查找帐套中人员ID的SQL
				count = fieldList.size();
				StringBuffer select = new StringBuffer(" select A001.ID ");
				StringBuffer from = new StringBuffer(" from  (select * from wage_set_pers_r").append(" where wage_set_pers_r.A815700='" + setId + "') ");
				from.append("wage_set_pers_r");
				from.append(" left join A001 on wage_set_pers_r.ID=A001.ID");

				StringBuffer where = new StringBuffer(" where ");
				if (personId != null)
					where.append(CommonFuns.splitInSql(personId, "A001.ID"));
				else {
					where.append(" 1=1 ");
				}

				String[] allField = new String[count];
				for (int i = 0; i < count; i++) {
					try {
						String[] tmp = ((String)fieldList.get(i)).split("\\.");
						String infoSetId = tmp[0].substring(1);
						String field = tmp[1];

						if ((infoSetId.equals("A815PREV")) && 
								(!field.endsWith("PREV"))) {
							field = field + "PREV";
						}

						allField[i] = field;
						if (select.indexOf(field + ",") < 0) {
							InfoItemBO ibo = SysCacheTool.findInfoItem("", field.replaceAll("PREV", ""));
							if ("6".equals(ibo.getItemDataType())) {
								select.append(",isnull(" + field + ",'0') as " + field);
							}
							else {
								select.append(",isnull(" + field + ",'0.0') as " + field);
							}
							InfoSetBO infoset = null;
							if (infoSetId.equals("A815PREV"))
								infoset = SysCacheTool.findInfoSet("A815");
							else {
								infoset = SysCacheTool.findInfoSet(infoSetId);
							}
							if (!"A815".equals(infoSetId))
							{
								if (from.indexOf(infoSetId) < 0) {
									if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType())) {
										if (infoSetId.equals("A815PREV")) {
											String lastdateid = this.getWageapi().getLastDateID(setId, dateId);
											from.append(" left join (select wage_pers_rela_history.pers_id as ID," + field.substring(0, 7) + " as " + field + " from A815 left join wage_pers_rela_history on A815.id=replace(wage_pers_rela_history.pers_id,'@','') and payoff_id='" + lastdateid + "' where a815702='" + lastdateid + "') A" + i);
											from.append(" on A" + i + ".ID=A001.ID");
										}
										else if (infoSetId.equals("B732")) {
											from.append(" left join (select A001.ID," + field.substring(0, 7) + " as " + field + "  from BBBB left join a001 on BBBB.id=a001.id left join B732 on a001743=b732700 and B732001='" + dateId + "') A" + i);
											from.append(" on A" + i + ".ID=A001.ID");
										}
										else if (infoSetId.equals("B026")) {
											from.append(" left join (select A001.ID," + field.substring(0, 7) + " as " + field + "  from CCCC left join a001 on CCCC.id=a001.id left join B026 on a001701=orguid and B026701=substr(a815701,1,7)) A" + i);
											from.append(" on A" + i + ".ID=A001.ID");
										}
										else if (infoSetId.equals("C018")) {
											from.append(" left join (select A001.ID," + field.substring(0, 7) + " as " + field + " from DDDD left join a001 on DDDD.id=a001.id left join C018 on C018.postid=A001.A001715 and C018000='00901') A" + i);
											from.append(" on A" + i + ".ID=A001.ID");
										}
										else if (infoSetId.equals("A003")) {
											from.append(" left join (select ID," + field.substring(0, 7) + " as " + field + "  from A003 where A003001='" + dateId + "') A" + i);
											from.append(" on A" + i + ".ID=A001.ID");
										}
										else {
											from.append(" left join (select ID," + field + " from " + infoSetId + " where " + infoSetId + "000='" + "00901" + "') A" + i);
											from.append(" on A" + i + ".ID=A001.ID");
										}
									}
									else if (!"A001".equals(infoSetId)) {
										from.append(" left join ").append(infoSetId);
										from.append(" on " + infoSetId + ".ID=A001.ID");
									}

								}
								else if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType()))
									if (infoSetId.equals("A815PREV")) {
										int index = from.indexOf("from A815");
										from.insert(index, "," + field.substring(0, 7) + " as " + field + " ");
									}
									else if (infoSetId.equals("B732")) {
										int index = from.indexOf("from BBBB ");
										from.insert(index, "," + field + " ");
									}
									else if (infoSetId.equals("B026")) {
										int index = from.indexOf("from CCCC ");
										from.insert(index, "," + field + " ");
									}
									else if (infoSetId.equals("C018")) {
										int index = from.indexOf("from DDDD ");
										from.insert(index, "," + field + " ");
									}
									else {
										int index = from.indexOf("from " + infoSetId);
										from.insert(index, "," + field + " ");
									}
							}
						}
					}
					catch (Exception e)
					{
						throw new RollbackableException("", "计算公式项'" + allField[i] + "'时出错；", e, getClass());
					}
				}
				String flaCountTable = "hr319#_" + setId + "_" + CommonFuns.getSysDate("MMddHHss");
				flaCountTable = flaCountTable.toUpperCase();
				StringBuffer sql = new StringBuffer();
				if ("ORACLE".equals(Constants.DB_TYPE)) {
					sql.append("create table ").append(flaCountTable).append(" as ").append(select.toString()).append(from.toString()).append(where.toString());
				}
				else
				{
					sql.append("select * into ").append(flaCountTable).append(" from  ( ").append(select.toString()).append(from.toString()).append(where.toString()).append(" ) aaa");
				}

				String createSql = "";
				if (isTry) {
					createSql = sql.toString().replaceAll("BBBB", "A815_TRY_" + setId).replaceAll("CCCC", "A815_TRY_" + setId).replaceAll("DDDD", "A815_TRY_" + setId);
				}
				else {
					createSql = sql.toString().replaceAll("BBBB", "A815_SET_" + setId).replaceAll("CCCC", "A815_SET_" + setId).replaceAll("DDDD", "A815_SET_" + setId);
				}

				if (isDBTable(flaCountTable)) {
					this.getApi().executeSql("drop table " + flaCountTable);
				}
				this.getApi().executeSql(createSql);
				CommonFuns.DebugLog(createSql);

				String pkName = "PK_" + flaCountTable + "_ID";
				if (pkName.length() > 30) {
					pkName = "PK_" + flaCountTable.substring(0, 23) + "_ID";
				}
				if ("SQL SERVER".equals(Constants.DB_TYPE)) {
					this.getApi().executeSql("alter table " + flaCountTable + " alter column ID nvarchar(100) not null");
					if (this.getApi().queryForInt("select count(*) from syscolumns where id=object_id('" + flaCountTable + "') and name='A815714'") > 0) {
						this.getApi().executeSql("alter table " + flaCountTable + " alter column A815714 nvarchar(100)  null");
					}
				}
				this.getApi().executeSql("alter table " + flaCountTable + "  add constraint " + pkName + " primary key (ID)");

				if (calcYearTax) {
					if ("ORACLE".equals(Constants.DB_TYPE)) {
						this.getApi().executeSql("alter table " + flaCountTable + " add YEARBASE number(20,2)");
					}
					else {
						this.getApi().executeSql("alter table " + flaCountTable + " add YEARBASE NUMERIC(20,2)");
					}
				}

				if (select.indexOf("A810702") >= 0) {
					String tmpsql = "select ID from " + flaCountTable + " where id like '#%'";
					CellVO[] header = new CellVO[1];
					header[0] = new CellVO();
					header[0].setItemId("ID");

					Vector vt = this.getApi().getDataListBySql(header, tmpsql);
					if ((vt.size() > 0) && ("SQL SERVER".equals(Constants.DB_TYPE))) {
						this.getApi().executeSql("alter table " + flaCountTable + " alter column A810702 nvarchar(100)  null");
					}
					for (int i = 0; i < vt.size(); i++) {
						CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
						String id = row[0].getValue().replaceAll("#", "");

						tmpsql = "update " + flaCountTable + " set A810702=(select isnull(A810791,isnull(A810702,'0.0')) from A810 where id='" + id + "' and A810000='00901') where id='#" + id + "'";
						this.getApi().executeSql(tmpsql);

						tmpsql = "update " + flaCountTable + " set A810702=(select isnull(A810792,isnull(A810702,'0.0')) from A810 where id='" + id + "' and A810000='00901') where id='" + id + "'";
						this.getApi().executeSql(tmpsql);
					}
					this.getApi().executeSql("update " + flaCountTable + " set A810702='0.00' where A810702 is null or A810702=''");
				}

				if (computeTax)
				{
					String taxAddTable = "hr319#_" + CommonFuns.getRandomNum(6);
					if (this.getApi().isDBTable(taxAddTable)) {
						this.getApi().executeSql("drop table " + taxAddTable);
					}
					FNamelist.add("生成多次交税临时表");
					if ("SQL SERVER".equals(Constants.DB_TYPE)) {
						sqlList.add("select ID, sum(cast(A815714 as NUMERIC(20,2))) taxSum,sum(cast(A815713 as NUMERIC(20,2))) wageSum  into " + taxAddTable + " from A815  where  id in (select id from " + flaCountTable + ") and A815701 like '" + payoffDate.substring(0, 7) + "%' group by ID");
					}
					else {
						sqlList.add("create table " + taxAddTable + " as select ID, sum(A815714) as taxSum,sum(A815713) as wageSum   from A815  where  id in (select id from " + flaCountTable + ") and A815701 like '" + payoffDate.substring(0, 7) + "%' group by ID");
					}

					String tmpSql = "update " + flaCountTable + "  set A815997=(select taxSum from " + taxAddTable + " where " + taxAddTable + ".ID = " + flaCountTable + ".ID) where id in (select id from " + taxAddTable + ")";
					FNamelist.add("多次交税");
					sqlList.add(tmpSql);

					tmpSql = "update " + flaCountTable + "  set A815996=(select wageSum from " + taxAddTable + " where " + taxAddTable + ".ID = " + flaCountTable + ".ID) where id in (select id from " + taxAddTable + ")";
					FNamelist.add("多次交税");
					sqlList.add(tmpSql);

					FNamelist.add("删除多次交税临时表");
					sqlList.add("drop table " + taxAddTable);

					tmpSql = "update " + flaCountTable + "  set A815996='0.0' where A815996 is null or A815996=''";
					sqlList.add(tmpSql);
					FNamelist.add("多次交税");

					tmpSql = "update " + flaCountTable + "  set A815997='0.0' where A815997 is null or A815997=''";
					sqlList.add(tmpSql);
					FNamelist.add("多次交税");
				}

				int size = flaCountOrder.size();

				String clearSql = "update " + flaCountTable + " set ";
				for (int i = 0; i < size; i++) {
					clearSql = clearSql + (String)flaCountOrder.get(i) + "='0.0',";
				}
				clearSql = clearSql.substring(0, clearSql.length() - 1);
				sqlList.add(clearSql);
				FNamelist.add("清除结果");

				String idStr = CommonFuns.splitInSql(personId, "ID");
				String resStr = "";

				WageFunctionTools functionTool = new WageFunctionTools();

				WageFormulaTools formulaTool = new WageFormulaTools();
				boolean haveA815713 = false;
				for (int i = 0; i < size; i++) {
					String rsField = flaCountOrder.get(i).toString();
					WageFormulaBO formula = (WageFormulaBO)expressHash.get(rsField);

					if ((formula.getApplyMonth() != null) && (!"".equals(formula.getApplyMonth())) && (formula.getApplyMonth().indexOf("-1") < 0) && (payoffDate != null) && (payoffDate.length() >= 7))
					{
						String month = payoffDate.substring(5, 7);
						if (formula.getApplyMonth().indexOf(month) < 0) {
							continue;
						}
					}
					String express = formula.getExpress();
					express = functionTool.preProcess(express, setId, payoffDate);
					resStr = "_{1}[a-z]{1}[0-9]{3}\\.{1}";
					Pattern p = Pattern.compile(resStr, 2);
					Matcher m = p.matcher(express);
					express = m.replaceAll("");

					resStr = "_{1}[a-z]{1}[0-9]{3}P{1}R{1}E{1}V{1}\\.{1}";
					p = Pattern.compile(resStr, 2);
					m = p.matcher(express);
					express = m.replaceAll("");

					String field = formula.getRsField();

					if (express.indexOf("if") != -1) {
						if (personId != null) {
							List proTemp = formulaTool.dealIfElse(express, idStr, flaCountTable);
							sqlList.addAll(proTemp);
							List proTempName = new ArrayList();
							for (int j = 0; j < proTemp.size(); j++) {
								proTempName.add(formula.getName());
							}
							FNamelist.addAll(proTempName);
						} else {
							List proTemp = formulaTool.dealIfElse(express, null, flaCountTable);
							sqlList.addAll(proTemp);
							List proTempName = new ArrayList();
							for (int j = 0; j < proTemp.size(); j++) {
								proTempName.add(formula.getName());
							}
							FNamelist.addAll(proTempName);
						}
					} else {
						express = express.replaceAll(";", "");
						express = formulaTool.transExpress(express);
						String updateSql = "update " + flaCountTable + " set " + express;
						if (personId != null) {
							updateSql = updateSql + " where " + idStr;
						}
						sqlList.add(updateSql);
						FNamelist.add(formula.getName());
					}

					String sbTmp = "";
					if ("ORACLE".equals(Constants.DB_TYPE)) {
						sbTmp = "update " + flaCountTable + " set " + field + "=concat('0'," + field + ") where " + field + " like '.%'";
					}
					else {
						sbTmp = "update " + flaCountTable + " set " + field + "='0'+" + field + " where " + field + " like '.%'";
					}
					sqlList.add(sbTmp);
					FNamelist.add(formula.getName());

					if (rsField.equals(maxItem)) {
						sqlList.add("DeptSum");
						FNamelist.add("部门汇总");
					}

					if (rsField.equals("A815713")) {
						haveA815713 = true;
						WageSetBO setbo = this.getWagesetdao().findSetBySetId(setId);
						if ("1".equals(setbo.getMergeTax())) {
							if ("ORACLE".equals(Constants.DB_TYPE)) {
								sqlList.add("update " + flaCountTable + " set A815713=A815713+A815996 ");
							}
							else {
								sqlList.add("update " + flaCountTable + " set A815713=cast(A815713 as numeric(18,2))+cast(A815996 as numeric(18,2)) ");
							}
							FNamelist.add("合并计税");
						}
						if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
							String taxSql = this.getWageapi().TaxCount(setId, setbo.getCessID(), flaCountTable, "A815713", setbo.getFilterField(), setbo.getFilterValues());
							if (!"".equals(taxSql)) {
								sqlList.add(taxSql);
								FNamelist.add("第一税率表计算");
								if ("ORACLE".equals(Constants.DB_TYPE)) {
									sqlList.add("update " + flaCountTable + " set A815714=round((0+A815714)/2,2) where id in (select id from a796 where A796712='00901')");
								}
								else {
									sqlList.add("update " + flaCountTable + " set A815714=round(cast(A815714 as numeric(20,2))/2,2) where id in (select id from a796 where A796712='00901')");
								}
								FNamelist.add("第一税率表残疾人减半");
							}
						}

						if ((setbo.getCessID2() != null) && (!"".equals(setbo.getCessID2()))) {
							String taxSql = this.getWageapi().TaxCount(setId, setbo.getCessID2(), flaCountTable, "A815713", setbo.getFilterField2(), setbo.getFilterValues2());
							if (!"".equals(taxSql)) {
								sqlList.add(taxSql);
								FNamelist.add("第二税率表计算");

								if ("ORACLE".equals(Constants.DB_TYPE)) {
									sqlList.add("update " + flaCountTable + " set A815714=round((0+A815714)/2,2) where id in (select id from a796 where A796712='00901')");
								}
								else {
									sqlList.add("update " + flaCountTable + " set A815714=round(cast(A815714 as numeric(20,2))/2,2) where id in (select id from a796 where A796712='00901')");
								}
								FNamelist.add("第二税率表残疾人减半");
							}
						}
						if ((setbo.getCessID3() != null) && (!"".equals(setbo.getCessID3()))) {
							String taxSql = this.getWageapi().TaxCount(setId, setbo.getCessID3(), flaCountTable, "A815713", setbo.getFilterField3(), setbo.getFilterValues3());
							if (!"".equals(taxSql)) {
								sqlList.add(taxSql);
								FNamelist.add("第三税率表计算");

								if ("ORACLE".equals(Constants.DB_TYPE)) {
									sqlList.add("update " + flaCountTable + " set A815714=round((0+A815714)/2,2) where id in (select id from a796 where A796712='00901')");
								}
								else {
									sqlList.add("update " + flaCountTable + " set A815714=round(cast(A815714 as numeric(20,2))/2,2) where id in (select id from a796 where A796712='00901')");
								}
								FNamelist.add("第三税率表残疾人减半");
							}
						}

						if ("1".equals(setbo.getMergeTax())) {
							if ("ORACLE".equals(Constants.DB_TYPE)) {
								sqlList.add("update " + flaCountTable + " set A815714=A815714-A815997");
							}
							else {
								sqlList.add("update " + flaCountTable + " set A815714=cast(A815714 as numeric(18,2))-cast(A815997 as numeric(18,2))");
							}
							FNamelist.add("合并计税");
						}

					}

					if (rsField.equals("A815755")) {
						WageSetBO setbo = this.getWagesetdao().findSetBySetId(setId);
						if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
							String[] taxSql = this.getWageapi().yearTaxCount(setId, setbo.getCessID(), flaCountTable);
							if (taxSql != null) {
								sqlList.add(taxSql[0]);
								FNamelist.add("年终奖计税计算");

								sqlList.add(taxSql[1]);
								FNamelist.add("年终奖计税计算");
							}

						}

					}

					if (rsField.equals("A815711")) {
						WageSetBO setbo = this.getWagesetdao().findSetBySetId(setId);
						if (haveA815713) {
							if ("ORACLE".equals(Constants.DB_TYPE)) {
								sqlList.add("update " + flaCountTable + " set A815712=0+A815713-A815714+A815711 where A815711>0");
							}
							else {
								sqlList.add("update " + flaCountTable + " set A815712=cast(A815713 as NUMERIC(18,2))-cast(A815714 as NUMERIC(18,2))+cast(A815711 as NUMERIC(18,2)) where cast(A815711 as NUMERIC(18,2))>0 ");
							}
							FNamelist.add("计算实发");

							if ((setbo.getActCessID() != null) && (!"".equals(setbo.getActCessID()))) {
								String resql = this.getWageapi().RerserveTaxCount(setId, setbo.getActCessID(), setbo.getCessID(), flaCountTable, "A815712");
								if ((resql != null) && (!"".equals(resql))) {
									sqlList.add(resql);
									FNamelist.add("反算应发计算");
								}
							}
							if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
								String taxSql = this.getWageapi().TaxCount(setId, setbo.getCessID(), flaCountTable, "A815708", setbo.getFilterField(), setbo.getFilterValues());
								if (!"".equals(taxSql)) {
									if ("ORACLE".equals(Constants.DB_TYPE)) {
										taxSql = taxSql + " where A815711>0";
									}
									else {
										taxSql = taxSql + " where cast(A815711 as NUMERIC(18,2))>0";
									}
									sqlList.add(taxSql);
									FNamelist.add("第一税率表计算");
								}
							}
							if ("ORACLE".equals(Constants.DB_TYPE)) {
								sqlList.add("update " + flaCountTable + " set A815710=0+A815708-A815713 where A815711>0");
							}
							else {
								sqlList.add("update " + flaCountTable + " set A815710=cast(A815708 as NUMERIC(18,2))-cast(A815713 as NUMERIC(18,2)) where cast(A815711 as NUMERIC(18,2))>0");
							}
							FNamelist.add("计算不含税所得反算应发");
						}
						else {
							if ((setbo.getActCessID() != null) && (!"".equals(setbo.getActCessID()))) {
								String resql = this.getWageapi().RerserveTaxCount(setId, setbo.getActCessID(), setbo.getCessID(), flaCountTable, "A815711");
								if ((resql != null) && (!"".equals(resql))) {
									sqlList.add(resql);
									FNamelist.add("反算应发计算");
								}
							}
							if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
								String taxSql = this.getWageapi().TaxCount(setId, setbo.getCessID(), flaCountTable, "A815708", setbo.getFilterField(), setbo.getFilterValues());
								if (!"".equals(taxSql)) {
									sqlList.add(taxSql);
									FNamelist.add("第一税率表计算");
								}
							}
						}
					}
				}

				String tmpTable = this.getTmp_table() + setId;
				if (isTry) {
					tmpTable = this.getTry_table() + setId;
				}

				String field = "";
				for (int i = 0; i < size; i++) {
					field = field + (String)flaCountOrder.get(i) + ",";
				}
				idStr = CommonFuns.splitInSql(personId, tmpTable + "." + "ID");
				field = field.substring(0, field.length() - 1);

				if ((field.indexOf("A815714") < 0) && ((field.indexOf("A815713") >= 0) || (field.indexOf("A815711") >= 0))) {
					field = field + ",A815714";
				}
				if ((field.indexOf("A815710") < 0) && (field.indexOf("A815711") >= 0)) {
					field = field + ",A815710";
				}
				if ((field.indexOf("A815756") < 0) && (field.indexOf("A815755") >= 0)) {
					field = field + ",A815756";
				}

				String updateData = "";
				if ("ORACLE".equals(Constants.DB_TYPE)) {
					updateData = "update " + tmpTable + " set (" + field + ") =(select " + field + " from " + flaCountTable + " where " + flaCountTable + ".id=" + tmpTable + ".id ) ";
					if (personId != null)
						updateData = updateData + " where (" + idStr + ")";
					else
						updateData = updateData + " where exists (select " + field + " from " + flaCountTable + " where " + flaCountTable + ".id=" + tmpTable + ".id)";
				}
				else
				{
					updateData = "update " + tmpTable + " set ";
					String[] fs = field.split(",");
					String set = "";
					for (int j = 0; j < fs.length; j++) {
						if (j == 0) {
							set = fs[j] + "=aaa." + fs[j];
						}
						else {
							set = set + "," + fs[j] + "=aaa." + fs[j];
						}
					}
					updateData = updateData + set;
					updateData = updateData + " from " + flaCountTable + " aaa ";
					updateData = updateData + " where aaa.id=" + tmpTable + ".id ";
					if (personId != null)
						updateData = updateData + " and (" + idStr + ")";
					else {
						updateData = updateData + " and exists (select " + field + " from " + flaCountTable + " where " + flaCountTable + ".id=" + tmpTable + ".id)";
					}
				}

				sqlList.add(updateData);
				FNamelist.add("更新结果");

				String dropsql = "drop table " + flaCountTable;

				String tempsql = "";
				for (int j = 0; j < sqlList.size(); j++) {
					try {
						tempsql = (String)sqlList.get(j);

						if ("DeptSum".equals(tempsql))
						{
							batchHandleWageDept(allField, setId, flaCountTable, dateId, unitId);
						}
						else
							this.getApi().update(tempsql);
					}
					catch (SysException e)
					{
						String err = "批量处理公式[" + (String)FNamelist.get(j) + "]失败,SQL:" + tempsql + ",原因:" + e.getSysMsg().getMessage();
						System.out.println(err);
						throw new RollbackableException("", err, e, getClass());
					}
				}
				this.getApi().executeSql(dropsql);
			}
		} catch (RollbackableException be) {
			throw be;
		} catch (Exception e) {
			throw new RollbackableException("", "未知错误；" + e.getMessage(), e, getClass());
		}
		return null;
	}
	
	

	  private void adjustDataFormat(String set) throws SysException {
	    String fun = "";
	    String fun1 = "";

	    if ("ORACLE".equals(Constants.DB_TYPE)) {
	      fun = "FormateMoney";
	    }
	    else {
	      fun = "dbo.FormateMoney";
	    }

	    if ("ORACLE".equals(Constants.DB_TYPE)) {
	      fun1 = "FormateMoneyOne";
	    }
	    else {
	      fun1 = "dbo.FormateMoneyOne";
	    }

	    List list = this.getWagesetitemdao().querySetItemBySetId(set);

	    if (list.size() > 0) {
	      String sql = "update A815_set_" + set + " set ";
	      boolean have = false;
	      String setSql = "";
	      for (int i = 0; i < list.size(); i++) {
	        WageSetItemBO wb = (WageSetItemBO)list.get(i);
	        if ((!"2".equals(wb.gettype())) && (!"0".equals(wb.gettype()))) {
	          InfoItemBO ib = SysCacheTool.findInfoItem("", wb.getField());
	          if (("2".equals(ib.getItemPrecision())) && ("2".equals(ib.getItemDataType()))) {
	            have = true;
	            if ("".equals(setSql)) {
	              setSql = setSql + wb.getField() + "=" + fun + "(" + wb.getField() + ")";
	            }
	            else {
	              setSql = setSql + "," + wb.getField() + "=" + fun + "(" + wb.getField() + ")";
	            }
	          }
	          else if (("1".equals(ib.getItemPrecision())) && ("2".equals(ib.getItemDataType()))) {
	            have = true;
	            if ("".equals(setSql)) {
	              setSql = setSql + wb.getField() + "=" + fun1 + "(" + wb.getField() + ")";
	            }
	            else {
	              setSql = setSql + "," + wb.getField() + "=" + fun1 + "(" + wb.getField() + ")";
	            }
	          }

	          if ("A815713".equals(ib.getItemId())) {
	            InfoItemBO A815714 = SysCacheTool.findInfoItem("", "A815714");
	            if (("2".equals(A815714.getItemPrecision())) && ("2".equals(A815714.getItemDataType()))) {
	              have = true;
	              if ("".equals(setSql)) {
	                setSql = setSql + "A815714=" + fun + "(A815714)";
	              }
	              else {
	                setSql = setSql + ",A815714=" + fun + "(A815714)";
	              }
	            }
	            else if (("1".equals(A815714.getItemPrecision())) && ("2".equals(A815714.getItemDataType()))) {
	              have = true;
	              if ("".equals(setSql)) {
	                setSql = setSql + "A815714=" + fun1 + "(A815714)";
	              }
	              else {
	                setSql = setSql + ",A815714=" + fun1 + "(A815714)";
	              }
	            }
	          }
	          else if ("A815755".equals(ib.getItemId())) {
	            InfoItemBO A815756 = SysCacheTool.findInfoItem("", "A815756");
	            if (("2".equals(A815756.getItemPrecision())) && ("2".equals(A815756.getItemDataType()))) {
	              have = true;
	              if ("".equals(setSql)) {
	                setSql = setSql + "A815756=" + fun + "(A815756)";
	              }
	              else {
	                setSql = setSql + ",A815756=" + fun + "(A815756)";
	              }
	            }
	            else if (("1".equals(A815756.getItemPrecision())) && ("2".equals(A815756.getItemDataType()))) {
	              have = true;
	              if ("".equals(setSql)) {
	                setSql = setSql + "A815756=" + fun1 + "(A815756)";
	              }
	              else
	                setSql = setSql + ",A815756=" + fun1 + "(A815756)";
	            }
	          }
	        }
	      }
	      if (have)
	        this.getApi().executeSql(sql + setSql);
	    }
	  }

}
