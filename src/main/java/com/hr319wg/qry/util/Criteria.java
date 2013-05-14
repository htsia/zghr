package com.hr319wg.qry.util;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.util.CommonFuns;

public class Criteria {
	protected String pk = "ID";
	protected String historyTable = "ID";
	protected String groupDef;
	protected Map queryTableHash = new TreeMap();
	protected Hashtable groupHash = new Hashtable();
	protected String setType;

	public void init(String groupDef, String setType, String historyTable) {
		this.setType = setType;
		this.groupDef = groupDef;
		this.historyTable = historyTable;
		if ("A".equals(setType))
			this.pk = "ID";
		else if ("B".equals(setType))
			this.pk = "ORGUID";
		else if ("C".equals(setType))
			this.pk = "POSTID";
		else if ("D".equals(setType))
			this.pk = "PARTYID";
	}

	protected String getValue(String infoItemId, String value, String code)
			throws SysException {
		try {
			InfoItemBO b = SysCacheTool.findInfoItem(null, infoItemId);
			b = (InfoItemBO) CommonFuns.filterNull(InfoItemBO.class, b);
			String codeSetId = null;
			if ("6".equals(b.getItemDataType()))
				codeSetId = b.getItemCodeSet();
			String ret;
			if ((code != null) && (!"".equals(code)))
				ret = CommonFuns.filterNull(code);
			else
				ret = CommonFuns.filterNull(value);
			if ((codeSetId != null) && (ret.indexOf(",") == -1)
					&& (ret.indexOf(codeSetId) == -1)) {
				ret = codeSetId + ret;
			} else if ((codeSetId != null) && (ret.indexOf(",") != -1)) {
				String[] rets = ret.split(",");
				ret = "";
				for (int i = 0; i < rets.length; i++) {
					if (rets[i].indexOf(codeSetId) == -1)
						ret = ret + codeSetId + rets[i] + ",";
					else
						ret = ret + rets[i] + ",";
				}
				if (ret.length() > 0)
					ret = ret.substring(0, ret.length() - 1);
			}
			return ret;
		} catch (Exception ex) {
			throw new SysException("得条件值", "得条件值过程出错", ex, getClass());
		}
	}

	protected void clear() {
		this.queryTableHash.clear();
		this.groupHash.clear();
	}

	public String equal(String groupId, String field, String value, String code)
			throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		StringBuffer rt = new StringBuffer().append(field).append(" = '")
				.append(tmp).append("' ");
		this.groupHash.put(groupId, rt.toString());
		return rt.toString();
	}

	public String notequal(String groupId, String field, String value,
			String code) throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		StringBuffer rt = new StringBuffer().append("nvl(").append(field)
				.append(",' ') <> '").append(tmp).append("' ");
		this.groupHash.put(groupId, rt.toString());
		return rt.toString();
	}

	public String morethan(String groupId, String field, String value,
			String code) throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		InfoItemBO bo = SysCacheTool.findInfoItem(null, field);
		if (bo == null) {
			return null;
		}
		StringBuffer rt = new StringBuffer();
		String operator = "> ";
		if ((CommonFuns.filterNull(bo.getItemCodeSet()).length() > 0)
				&& (CommonFuns.filterNull(Constants.QRY_CODE_REVERSE).indexOf(
						bo.getItemCodeSet()) != -1)) {
			operator = "< ";
		}
		if (("1".equals(bo.getItemDataType()))
				|| ("2".equals(bo.getItemDataType()))
				|| ("9".equals(bo.getItemDataType()))) {
			if ("ORACLE".equals(Constants.DB_TYPE)) {
				rt.append(field).append(" + 0 ").append(operator).append(tmp)
						.append(" ");
			} else {
				rt.append("cast(").append(field).append(" as float)")
						.append(operator).append(tmp).append(" ");
			}
		} else
			rt.append(field).append(" ").append(operator).append("'")
					.append(tmp).append("' ");
		this.groupHash.put(groupId, rt.toString());
		return rt.toString();
	}

	public String lessthan(String groupId, String field, String value,
			String code) throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		InfoItemBO bo = SysCacheTool.findInfoItem(null, field);
		if (bo == null)
			return null;
		String operator = "< ";
		if ((CommonFuns.filterNull(bo.getItemCodeSet()).length() > 0)
				&& (CommonFuns.filterNull(Constants.QRY_CODE_REVERSE).indexOf(
						bo.getItemCodeSet()) != -1)) {
			operator = "> ";
		}
		StringBuffer rt = new StringBuffer();
		if (("1".equals(bo.getItemDataType()))
				|| ("2".equals(bo.getItemDataType()))
				|| ("9".equals(bo.getItemDataType()))) {
			if ("ORACLE".equals(Constants.DB_TYPE)) {
				rt.append(field).append(" + 0 ").append(operator).append(tmp)
						.append(" ");
			} else {
				rt.append("cast(").append(field).append(" as float)")
						.append(operator).append(tmp).append(" ");
			}
		} else
			rt.append(field).append(" ").append(operator).append("'")
					.append(tmp).append("' ");
		this.groupHash.put(groupId, rt.toString());
		return rt.toString();
	}

	public String moreequal(String groupId, String field, String value,
			String code) throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		InfoItemBO bo = SysCacheTool.findInfoItem(null, field);
		if (bo == null)
			return null;
		String operator = ">= ";
		if ((CommonFuns.filterNull(bo.getItemCodeSet()).length() > 0)
				&& (CommonFuns.filterNull(Constants.QRY_CODE_REVERSE).indexOf(
						bo.getItemCodeSet()) != -1)) {
			operator = "<= ";
		}
		StringBuffer rt = new StringBuffer();
		if (("1".equals(bo.getItemDataType()))
				|| ("2".equals(bo.getItemDataType()))
				|| ("9".equals(bo.getItemDataType()))) {
			if ("ORACLE".equals(Constants.DB_TYPE)) {
				rt.append(field).append(" + 0 ").append(operator).append(tmp)
						.append(" ");
			} else {
				rt.append("cast(").append(field).append(" as float)")
						.append(operator).append(tmp).append(" ");
			}
		} else
			rt.append(field).append(" ").append(operator).append("'")
					.append(tmp).append("' ");
		this.groupHash.put(groupId, rt.toString());
		return rt.toString();
	}

	public String lessequal(String groupId, String field, String value,
			String code) throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		InfoItemBO bo = SysCacheTool.findInfoItem(null, field);
		if (bo == null)
			return null;
		String operator = "<= ";
		if ((CommonFuns.filterNull(bo.getItemCodeSet()).length() > 0)
				&& (CommonFuns.filterNull(Constants.QRY_CODE_REVERSE).indexOf(
						bo.getItemCodeSet()) != -1))
			operator = ">= ";
		StringBuffer rt = new StringBuffer();
		if (("1".equals(bo.getItemDataType()))
				|| ("2".equals(bo.getItemDataType()))
				|| ("9".equals(bo.getItemDataType()))) {
			if ("ORACLE".equals(Constants.DB_TYPE)) {
				rt.append(field).append(" + 0 ").append(operator).append(tmp)
						.append(" ");
			} else {
				rt.append("cast(").append(field).append(" as float)")
						.append(operator).append(tmp).append(" ");
			}
		} else
			rt.append(field).append(" ").append(operator).append("'")
					.append(tmp).append("' ");
		this.groupHash.put(groupId, rt.toString());
		return rt.toString();
	}

	public String in(String groupId, String field, String value, String code)
			throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		tmp = "'" + tmp.replaceAll(",", "','") + "'";
		String rt = field + " in (" + tmp + ") ";
		this.groupHash.put(groupId, rt);
		return rt;
	}

	public String notin(String groupId, String field, String value, String code)
			throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		tmp = "'" + tmp.replaceAll(",", "','") + "'";
		String rt = "nvl(" + field + ",' ') not in (" + tmp + ") ";
		this.groupHash.put(groupId, rt);
		return rt;
	}

	public String like(String groupId, String field, String value, String code)
			throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		if (tmp.indexOf("%") == -1)
			tmp = "%" + tmp + "%";
		String rt = field + " like '" + tmp + "' ";
		this.groupHash.put(groupId, rt);
		return rt;
	}

	public String notlike(String groupId, String field, String value,
			String code) throws SysException {
		String tmp = getValue(field, value, code);
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		if (tmp.indexOf("%") == -1)
			tmp = "%" + tmp + "%";
		String rt = field + " not like '" + tmp + "' ";
		this.groupHash.put(groupId, rt);
		return rt;
	}

	public String exist(String groupId, String field, String value, String code)
			throws SysException {
		String tmp = getValue(field, value, code);

		if ((field == null) || (field.length() != 7))
			return null;
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		String rt = field.substring(0, 4) + "." + this.pk
				+ " in (select distinct " + this.pk + " from "
				+ field.substring(0, 4) + " where " + field + " = '" + tmp
				+ "') ";
		this.groupHash.put(groupId, rt);
		return rt;
	}

	public String notexist(String groupId, String field, String value,
			String code) throws SysException {
		String tmp = getValue(field, value, code);

		if ((field == null) || (field.length() != 7))
			return null;
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		String rt = field.substring(0, 4) + "." + this.pk
				+ " not in (select distinct " + this.pk + " from "
				+ field.substring(0, 4) + " where " + field + " = '" + tmp
				+ "') ";
		this.groupHash.put(groupId, rt);
		return rt;
	}

	public String isnull(String groupId, String field, String value, String code)
			throws SysException {
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		StringBuffer sb = new StringBuffer();
		sb.append("(").append(field).append(" is null or ");
		sb.append(field).append(" = '' )");
		String rt = sb.toString();
		this.groupHash.put(groupId, rt);
		return rt;
	}

	public String notisnull(String groupId, String field, String value,
			String code) throws SysException {
		this.queryTableHash.put(field.substring(0, 4), field.substring(0, 4));
		StringBuffer sb = new StringBuffer();
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			sb.append(" ").append(field).append(" is not null ");
		} else {
			sb.append("(").append(field).append(" is not null and ");
			sb.append(field).append(" <> '' )");
		}
		String rt = sb.toString();
		this.groupHash.put(groupId, rt);
		return rt;
	}

	/** @deprecated */
	public String getJoinCondition() throws SysException {
		return null;
	}

	public String getJoinTable(String[] showItemIds, String scaleTable)
			throws SysException {
		try {
			if (showItemIds != null) {
				for (int i = 0; i < showItemIds.length; i++) {
					if ((showItemIds[i] != null)
							&& (showItemIds[i].length() == 7))
						this.queryTableHash.put(showItemIds[i].substring(0, 4),
								showItemIds[i].substring(0, 4));
				}
			}
			if ((scaleTable != null) && (!"".equals(scaleTable)))
				this.queryTableHash.put(scaleTable, scaleTable);
			Iterator it = this.queryTableHash.values().iterator();

			String firstTable = (String) it.next();

			StringBuffer rt = new StringBuffer();
			rt.append(firstTable);
			InfoSetBO firstSet = SysCacheTool.findInfoSet(firstTable.substring(
					0, 4));
			String pk = firstSet.getSetPk();
			while (it.hasNext()) {
				String joinTable = (String) it.next();
				InfoSetBO joinSet = SysCacheTool.findInfoSet(joinTable
						.substring(0, 4));
				if (joinSet == null) {
					CommonFuns.DebugLog(joinSet + "不存在!");
				}
				rt.append(" left join ").append(joinTable).append(" on ")
						.append(firstTable).append(".").append(pk)
						.append(" = ").append(joinTable).append(".").append(pk)
						.append(" ");
				if ((InfoSetBO.RS_TYPE_MANY.equals(joinSet.getSet_rsType()))
						&& (!CommonFuns.filterNull(this.historyTable)
								.equalsIgnoreCase(joinTable))) {
					rt.append("and ").append(joinTable).append("000 = '")
							.append("00901").append("' ");
				}
			}
			return rt.toString();
		} catch (Exception e) {
			throw new RollbackableException("解析表间关联关系", "解析表间关联错误，无法继续", e,
					getClass());
		}
	}

	public String getJoinTable(String[] showItemIds, String scaleTable,
			String setId) throws SysException {
		try {
			if (showItemIds != null) {
				for (int i = 0; i < showItemIds.length; i++) {
					if ((showItemIds[i] != null)
							&& (showItemIds[i].length() == 7))
						this.queryTableHash.put(showItemIds[i].substring(0, 4),
								showItemIds[i].substring(0, 4));
				}
			}
			if ((scaleTable != null) && (!"".equals(scaleTable)))
				this.queryTableHash.put(scaleTable, scaleTable);
			Iterator it = this.queryTableHash.values().iterator();

			String firstTable = (String) it.next();

			StringBuffer rt = new StringBuffer();
			rt.append(firstTable);
			InfoSetBO firstSet = SysCacheTool.findInfoSet(firstTable.substring(
					0, 4));
			String pk = firstSet.getSetPk();
			while (it.hasNext()) {
				String joinTable = (String) it.next();
				InfoSetBO joinSet = SysCacheTool.findInfoSet(joinTable
						.substring(0, 4));
				if (joinSet == null) {
					CommonFuns.DebugLog("getJoinTable 中:" + joinTable + "不存在!");
				}
				rt.append(" left join ").append(joinTable).append(" on ")
						.append(firstTable).append(".").append(pk)
						.append(" = ").append(joinTable).append(".").append(pk)
						.append(" ");
				if ((InfoSetBO.RS_TYPE_MANY.equals(joinSet.getSet_rsType()))
						&& (!CommonFuns.filterNull(this.historyTable)
								.equalsIgnoreCase(joinTable))
						&& (!joinSet.getSetId().equals(setId))) {
					rt.append("and ").append(joinTable).append("000 = '")
							.append("00901").append("' ");
				}
			}

			return rt.toString();
		} catch (Exception e) {
			throw new RollbackableException("解析表间关联", "解析表间关联错误，无法继续", e,
					getClass());
		}
	}

	public String getJoinTable(String[] showItemIds, String scaleTable,
			String setId, String beginDate, String endDate) throws SysException {
		if (showItemIds != null) {
			for (int i = 0; i < showItemIds.length; i++) {
				if ((showItemIds[i] != null) && (showItemIds[i].length() == 7))
					this.queryTableHash.put(showItemIds[i].substring(0, 4),
							showItemIds[i].substring(0, 4));
			}
		}
		if ((scaleTable != null) && (!"".equals(scaleTable)))
			this.queryTableHash.put(scaleTable, scaleTable);
		Iterator it = this.queryTableHash.values().iterator();
		String firstTable = (String) it.next();
		StringBuffer rt = new StringBuffer();
		rt.append(firstTable);
		InfoSetBO firstSet = SysCacheTool.findInfoSet(firstTable
				.substring(0, 4));
		String pk = firstSet.getSetPk();

		while (it.hasNext()) {
			String joinTable = (String) it.next();
			InfoSetBO joinSet = SysCacheTool.findInfoSet(joinTable.substring(0,
					4));
			if (joinSet == null)
				CommonFuns.DebugLog("getJoinTable 中:" + joinTable + "不存在!");
			rt.append(" right join ").append(joinTable).append(" on ")
					.append(firstTable).append(".").append(pk).append(" = ")
					.append(joinTable).append(".").append(pk).append(" ");
			if ((InfoSetBO.RS_TYPE_MANY.equals(joinSet.getSet_rsType()))
					&& (!CommonFuns.filterNull(this.historyTable)
							.equalsIgnoreCase(joinTable))
					&& (!joinSet.getSetId().equals(setId)))
				rt.append("and (").append(joinTable).append("000 = '")
						.append("00900").append("' OR  ").append(joinTable)
						.append("000 = '").append("00901").append("') and    ")
						.append(joinTable).append("700>='").append(beginDate)
						.append("' and  ").append(joinTable).append("700<='")
						.append(endDate).append("'");
		}
		return rt.toString();
	}

	public String getCondition() throws SysException {
		try {
			Enumeration en = this.groupHash.keys();
			if (this.groupDef == null)
				return null;
			String rt = this.groupDef;
			rt = "(" + rt + ")";
			rt = rt.replaceAll("\\)", " )");
			if (!en.hasMoreElements()) {
				return null;
			}
			while (en.hasMoreElements()) {
				String key = (String) en.nextElement();
				rt = rt.replaceAll(key + " ", this.groupHash.get(key) + " ");
			}
			rt = rt.replaceAll("与", "and");
			rt = rt.replaceAll("或", "or");
			return rt;
		} catch (Exception e) {
			throw new RollbackableException("拼装条件错误", "拼装条件错误，无法继续", e,
					getClass());
		}
	}

	public String addDefaultCondition(String condition) throws SysException {
		try {
			condition = CommonFuns.filterNull(condition);
			String a = "";
			String b = "";
			String c = "";

			if ("A".equals(this.setType)) {
				if (condition.indexOf("A001730") == -1)
					c = "A001730 = '00900'";
				if (condition.indexOf("A001753") == -1) {
					if (c.length() > 0)
						c = c + " and A001753 = '00900'";
					else
						c = "A001753 = '00900'";
				}
				if (c.length() > 0)
					c = " ( " + c + " ) ";
			} else if ("B".equals(this.setType)) {
				if (condition.indexOf("B001730") == -1)
					c = "B001730= '00900'";
			} else if (("C".equals(this.setType))
					&& (condition.indexOf("C001730") == -1)) {
				c = "C001730= '00900'";
			}

			if ((condition.length() != 0) && (c.length() != 0))
				condition = c + " and " + condition;
			else {
				condition = c + condition;
			}
			return condition;
		} catch (Exception e) {
			throw new SysException("添加默认查询条件", "添加默认查询条件失败", e, getClass());
		}
	}
}