package com.hr319wg.wage.web;

import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.ucc.IWagePersonQueryUCC;

public class WagePersonQueryBackingBean extends BaseBackingBean {
	private final String OperID = "0615";
	private IWagePersonQueryUCC wagepersonqueryucc;
	private IUserReportUCC userreportucc;
	private UserAPI userapi;
	private String unitId;
	private String unitName;
	private String setName;
	private String setId;
	private boolean operRight = false;
	private boolean btnRight = true;
	private List reportList;
	private boolean flowFlag = true;
	private String nameStrs;
	private boolean oper061501;
	private boolean oper061502;
	private String personType;
	private String personTypeValue;
	private String personTypeDesc;
	private String insPageInit;
	private String searchStr;
	private String orgID;

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getSearchStr() {
		return searchStr;
	}

	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}

	public String getInsPageInit() {
		try {
			if (this.personType == null || "".equals(this.personType)) {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			}
		} catch (SysException e1) {
			e1.printStackTrace();
		}

		String pageFlag = super.getServletRequest().getParameter("pageFlag");
		if ("1".equals(pageFlag)) {
			trunPageQuery(null, null, 0, 0);
		}

		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			clearPageParameter();
			String orgId1 = super.getServletRequest().getParameter("unitId");
			if (orgId1 != null) {
				this.orgID=orgId1;
			}
			doQuery();
		}
		return this.pageInit;
	}

	public void doQuery() {
		try {
			TableVO table = new TableVO();
			QueryAPI api = (QueryAPI) SysContext.getBean("qry_queryApi");
			CellVO[] headerItem = api.queryInfoItem("141");
			table.setHeader(headerItem);
			// 查询语句
			Hashtable hash = api.getQuerySqlHash(null, "141");
			String select = (String) hash.get("SQL_SELECT_PART");
			String from = CommonFuns.filterNull(
					(String) hash.get("SQL_FROM_PART")).toUpperCase();
			String order = CommonFuns.filterNull((String) hash
					.get("SQL_ORDER_PART"));

			String sql = "select " + select + " from " + from + " where 1=1 ";
			if (this.orgID != null) {
				OrgBO org = SysCacheTool.findOrgById(this.orgID);
				sql += " and a001738 like '"+org.getTreeId()+"%' ";
			}
			String searchStr1 = "%";
			if (this.searchStr != null) {
				searchStr1 = this.searchStr;
			}
			sql += " and (a001001 like '%" + searchStr1
					+ "%' or a001735 like '%" + searchStr1 + "%' )";
			sql += " and "+CommonFuns.splitInSql(this.personType.split(","), "a001054");
			if (!"".equals(order)) {
				sql += "order by " + order;
			}

			trunPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
	}

	public void setInsPageInit(String insPageInit) {
		this.insPageInit = insPageInit;
	}

	public boolean isOper061501() {
		return this.oper061501;
	}

	public void setOper061501(boolean oper061501) {
		this.oper061501 = oper061501;
	}

	public boolean isOper061502() {
		return this.oper061502;
	}

	public void setOper061502(boolean oper061502) {
		this.oper061502 = oper061502;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}

	public String getPersonType() {
		if ((this.personType == null) || ("".equals(this.personType))) {
			this.personType = Constants.IN_SERVICE_TYPE;
			this.personTypeValue = Constants.IN_SERVICE_DES;
		}
		return this.personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		this.personTypeValue = "";
		if (this.personType != null) {
			this.personTypeValue = CodeUtil.interpertCode(CodeUtil.TYPE_CODE,
					this.personType);
		}
		return this.personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public String getPersonTypeDesc() {
		if ((this.personTypeValue == null) || ("".equals(this.personTypeValue))) {
			this.personTypeDesc = "当前人员类别:全部人员";
		} else {
			this.personTypeDesc = ("当前人员类别:" + this.personTypeValue);
		}
		return this.personTypeDesc;
	}

	public void setPersonTypeDesc(String desc) {
		this.personTypeDesc = desc;
	}

	public String getNameStrs() {
		return this.nameStrs;
	}

	public void setNameStrs(String c) {
		this.nameStrs = c;
	}

	public String getPageInit() {
		String pageFlag = super.getServletRequest().getParameter("pageFlag");
		// if (this.unitId == null) {
		// this.unitId =
		// SysCacheTool.findPersonById(super.getUserInfo().getUserId()).getGongZiGX();
		// }
		if ("1".equals(pageFlag)) {
			trunPageQuery(null, null, 0, 0);
		}
		String act = super.getRequestParameter("act");
		if (("init".equals(act)) || ("qryPersNotInSet".equals(act))
				|| ("initSetPers".equals(act))) {
			this.unitId = super.getServletRequest().getParameter("unitId");

			String userUnitId = SysCacheTool.findPersonById(
					super.getUserInfo().getUserId()).getGongZiGX();
			WageUnitBO userUnit = SysCacheTool.findWageUnit(userUnitId);
			if (userUnit == null) {
				super.showMessageDetail("错误：用户没有发薪单位");
				return "";
			}

			if (this.unitId.equals(userUnitId)) {
				this.operRight = true;
				this.btnRight = false;
			} else {
				this.btnRight = true;
			}
			this.unitName = SysCacheTool.interpertCode("WAGE", this.unitId);
			if ("TOMCAT".equals(CommonFuns.getAppType())) {
				HttpServletRequest request = getServletRequest();
				this.setName = CommonFuns.getParaFromURL(
						request.getQueryString(), "setName");
			} else {
				this.setName = CommonFuns.filterNull(super.getServletRequest()
						.getParameter("setName"));
			}
			if (super.getRequestParameter("setID") != null) {
				this.setId = super.getRequestParameter("setID");
			}
			clearPageParameter();
		}
		if ("init".equals(act)) {
			queryPersonByNameStr("%");
		} else if ("initSetPers".equals(act)) {
			String s = super.getRequestParameter("flowFlag");
			if ("00901".equals(s))
				this.flowFlag = true;
			else {
				this.flowFlag = false;
			}
		} else if ("qryPersNotInSet".equals(act)) {
			queryNotInWageSetPerson();
		} else if ("forQuery".equals(act)) {
			clearPageParameter();
		}
		return this.pageInit;
	}

	public boolean isOperRight() {
		return this.operRight;
	}

	public void setOperRight(boolean operRight) {
		this.operRight = operRight;
	}

	public String getUnitName() {
		return this.unitName;
	}

	public String getSetName() {
		return this.setName;
	}

	public IWagePersonQueryUCC getWagepersonqueryucc() {
		return this.wagepersonqueryucc;
	}

	public void setWagepersonqueryucc(IWagePersonQueryUCC wagepersonqueryucc) {
		this.wagepersonqueryucc = wagepersonqueryucc;
	}

	public String getUnitId() {
		return this.unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public boolean isBtnRight() {
		return this.btnRight;
	}

	public void setBtnRight(boolean btnRight) {
		this.btnRight = btnRight;
	}

	public String queryMultPerson() {
		queryPersonByNameStr(this.nameStrs);
		return null;
	}

	public String queryPersonByName() {
		String nameStr = super.getRequestParameter("form1:nameStr");
		queryPersonByNameStr(nameStr);
		return null;
	}

	private String getA001054Where() {
		String[] pers = getPersonType().split(",");
		return CommonFuns.splitInSql(pers, "A001.A001054");
	}

	private void queryPersonByNameStr(String name) {
		try {
			String nameStr = name;
			TableVO table = new TableVO();
			String deptWhere = this.userapi.getDeptCondition(
					super.getUserInfo(), "");
			String sql = this.wagepersonqueryucc.getSQLQueryPersonByName(table,
					this.unitId, nameStr, 0, this.setId, deptWhere);

			trunPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
	}

	public String queryAdvance() {
		try {
			HttpSession session = super.getHttpSession();

			String tableName = "A795";
			String gongziGxFiled = tableName + "." + "A795701";

			String select = (String) session.getAttribute("SQL_SELECT_PART");
			String from = CommonFuns.filterNull(
					(String) session.getAttribute("SQL_FROM_PART"))
					.toUpperCase();
			String where = CommonFuns.filterNull((String) session
					.getAttribute("SQL_WHERE_PART"));
			String order = CommonFuns.filterNull((String) session
					.getAttribute("SQL_ORDER_PART"));

			TableVO table = (TableVO) session.getAttribute("TABLEOBJECT");

			String wageCond = gongziGxFiled + "='" + this.unitId + "'";
			if (from.indexOf(tableName) < 0) {
				from = from + " LEFT JOIN " + tableName + " ON A001.ID = "
						+ tableName + ".ID ";
			}
			if ((where != null) && (where.length() > 0))
				where = where + " AND " + wageCond;
			else {
				where = wageCond;
			}
			String sql = "SELECT " + select;
			sql = sql + " FROM " + from;
			sql = sql + " WHERE " + where;
			String deptWhere = this.userapi.getDeptCondition(
					super.getUserInfo(), "");
			sql = sql + " and " + deptWhere;
			if (order.length() > 0) {
				sql = sql + " ORDER BY " + order;
			}
			trunPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误:" + e.getMessage());
		}
		return "personList";
	}

	public String queryAgentWagePerson() {
		try {
			TableVO table = new TableVO();
			String sql = this.wagepersonqueryucc.getSQLQueryAgentWagePerson(
					table, this.unitId);
			trunPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return null;
	}

	public String queryAgentBenefitPerson() {
		try {
			TableVO table = new TableVO();
			String sql = this.wagepersonqueryucc.getSQLQueryAgentBenefitPerson(
					table, this.unitId);
			trunPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return null;
	}

	public String queryManyHeadPerson() {
		try {
			TableVO table = new TableVO();
			String sql = this.wagepersonqueryucc.getSQLQueryManyHeadPerson(
					table, this.unitId);
			trunPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return null;
	}

	public String queryNotInWageSetPerson() {
		try {
			TableVO table = new TableVO();
			String sql = this.wagepersonqueryucc.getSQLQueryNotInWageSetPerson(
					table, this.unitId);
			trunPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return null;
	}

	private void clearPageParameter() {
		super.getHttpSession().removeAttribute("OBJECT");
		super.getHttpSession().removeAttribute("activeSql");
		super.getHttpSession().removeAttribute("pageNum");
	}

	public String trunPageQuery(TableVO table, String sql, int pageNum,
			int rowNum) {
		try {
			if (pageNum == 0)
				pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super
						.getRequestParameter("pageNum")));
			if (pageNum == 0)
				pageNum = Integer.parseInt(CommonFuns
						.filterNullToZero((String) super.getHttpSession()
								.getAttribute("pageNum")));
			if (pageNum == 0)
				pageNum = 1;
			if (rowNum == 0)
				rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super
						.getRequestParameter("rowNum")));
			if (rowNum == 0)
				rowNum = Integer.parseInt(CommonFuns
						.filterNullToZero((String) super.getHttpSession()
								.getAttribute("rowNum")));
			if (rowNum == 0)
				rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (table == null)
				table = (TableVO) super.getHttpSession().getAttribute("OBJECT");
			if (sql == null)
				sql = (String) super.getHttpSession().getAttribute("activeSql");
			table = this.wagepersonqueryucc.queryPersonBySql(table, sql,
					pageNum, rowNum);
			super.getHttpSession().setAttribute("activeSql", sql);
			super.getHttpSession().setAttribute("rowNum",
					String.valueOf(rowNum));
			super.getHttpSession().setAttribute("pageNum",
					String.valueOf(pageNum));
			super.getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return null;
	}

	public boolean isFlowFlag() {
		return this.flowFlag;
	}

	public void setFlowFlag(boolean flowFlag) {
		this.flowFlag = flowFlag;
	}

	public List getReportList() {
		try {
			if (this.reportList == null) {
				this.reportList = this.userreportucc.queryUserRptToWeb(super
						.getUserInfo().getUserId(), "0615");
			}
		} catch (Exception e) {
		}
		return this.reportList;
	}

	public void setReportList(List list) {
		this.reportList = list;
	}

	public void setUserreportucc(IUserReportUCC iur) {
		this.userreportucc = iur;
	}

	public IUserReportUCC getUserreportucc() {
		return this.userreportucc;
	}

	public UserAPI getUserapi() {
		return this.userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}
}