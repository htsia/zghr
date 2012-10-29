package com.hr319wg.insurace.web;

import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CommonFuns;

public class WageSplitQueryBackingBean extends BaseBackingBean {
	private IUserReportUCC userreportucc;
	private UserAPI userapi;
	private QueryAPI queryapi;
	private IQueryUCC queryucc;
	private ActivePageAPI activeapi;
	
	private List reportList;
	private String searchStr;
	private String personType;
	private String personTypeValue;
	private String rate;
	private String orgID;
	

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		return personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}
	
	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}
	
	
	public String getSearchStr() {
		return searchStr;
	}

	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}

	public IUserReportUCC getUserreportucc() {
		return userreportucc;
	}

	public void setUserreportucc(IUserReportUCC userreportucc) {
		this.userreportucc = userreportucc;
	}

	public UserAPI getUserapi() {
		return userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}

	public QueryAPI getQueryapi() {
		return queryapi;
	}

	public void setQueryapi(QueryAPI queryapi) {
		this.queryapi = queryapi;
	}

	public IQueryUCC getQueryucc() {
		return queryucc;
	}

	public void setQueryucc(IQueryUCC queryucc) {
		this.queryucc = queryucc;
	}

	public void setReportList(List reportList) {
		this.reportList = reportList;
	}

	public String getPageInit() {
		try {
			if(this.personType==null || "".equals(this.personType)){
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			}
		} catch (SysException e1) {
			e1.printStackTrace();
		}
		
		String pageFlag = super.getServletRequest().getParameter("pageFlag");
		if ("1".equals(pageFlag)){
			turnPageQuery(null, null, 0, 0);
		}
		
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			clearPageParameter();
			String orgId = super.getServletRequest().getParameter("unitId");
	    	if(orgId!=null){
	    		this.orgID=orgId;
	    	}
	    	commonInfoQuery();
		}
		return this.pageInit;
	}

	public String queryPersonByName() {
		commonInfoQuery();
		return null;
	}

	private void commonInfoQuery() {
		try {
			TableVO table = new TableVO();
			String qryId = "102";
			CellVO[] headerItem =  this.queryapi.queryInfoItem(qryId);
	        table.setHeader(headerItem);
			//²éÑ¯Óï¾ä
			Hashtable hash = this.queryapi.getQuerySqlHash(null, qryId);
	        String select = (String)hash.get("SQL_SELECT_PART");
	        String from = CommonFuns.filterNull((String)hash.get("SQL_FROM_PART")).toUpperCase();
	        String order = CommonFuns.filterNull((String)hash.get("SQL_ORDER_PART"));
			
		    String sql="select "+select+" from "+from +" where 1=1 ";
	        if(this.orgID!=null){
	    	  OrgBO org = SysCacheTool.findOrgById(this.orgID);
	    	  sql+=" and A001738 like '"+org.getTreeId()+"%' ";
	        }
	        String searchStr1 ="%";
	        String dateStr1 ="%";
	        if(this.searchStr!=null){
	        	searchStr1=this.searchStr;
	        }
	        sql+=" and (a001001 like '%"+searchStr1+"%' or a001735 like '%"+searchStr1+"%' ) ";
	        sql+=" and "+CommonFuns.splitInSql(this.personType.split(","), "a001054");
	        sql+=" and A001.id in (select id from a754 where A754002='02020001') ";
	        if(!"".equals(order)){
	        	sql+="order by "+order;
	        }
			turnPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("´íÎó£º" + e.getMessage());
		}
	}

	public String queryAdvance() {
		this.searchStr=null;
		HttpSession session;
		try {
			session = super.getHttpSession();

			String select = (String) session.getAttribute("SQL_SELECT_PART");
			String from = CommonFuns.filterNull(
					(String) session.getAttribute("SQL_FROM_PART"))
					.toUpperCase();
			String where = CommonFuns.filterNull((String) session
					.getAttribute("SQL_WHERE_PART"));
			String order = CommonFuns.filterNull((String) session
					.getAttribute("SQL_ORDER_PART"));

			TableVO table = (TableVO) session.getAttribute("TABLEOBJECT");

			String sql = "SELECT " + select;
			sql = sql + " FROM " + from;
			sql = sql + " WHERE " + where;
			String deptWhere = this.userapi.getDeptCondition(
					super.getUserInfo(), "");
			sql = sql + " and " + deptWhere;
			if (order.length() > 0)
				sql = sql + " ORDER BY " + order;

			turnPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("´íÎó:" + e.getMessage());
		}
		return "personList";
	}

	private void clearPageParameter() {
		super.getHttpSession().removeAttribute("OBJECT");
		super.getHttpSession().removeAttribute("activeSql");
		super.getHttpSession().removeAttribute("pageNum");
	}

	public String turnPageQuery(TableVO table, String sql, int pageNum,
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
			table = this.queryucc.executeQuery(super.getUserInfo(),
					table.getHeader(), sql, true, pageNum, rowNum);
			super.getHttpSession().setAttribute("activeSql", sql);
			super.getHttpSession().setAttribute("rowNum",
					String.valueOf(rowNum));
			super.getHttpSession().setAttribute("pageNum",
					String.valueOf(pageNum));
			super.getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			super.showMessageDetail("´íÎó£º" + e.getMessage());
		}
		return null;
	}

	public List getReportList() {
		try {
			if (this.reportList == null)
				this.reportList = this.userreportucc.queryUserRptToWeb(super
						.getUserInfo().getUserId(), "0615");
		} catch (Exception e) {
		}

		return this.reportList;
	}
	
	public void updteBase(){
		try {
			String sql = "update a204 a set a204200=null, a204201=null, a204202=null, a204203=null, a204204=null, a204205=null, a204206=null, a204207=null, a204208=null, a204209=null, a204210=null, a204211=null, a204212=null, a204213=null, a204214=null, a204215=null, a204216=null, a204217=null, a204218=null, a204220=null, a204219= (select round(a223206*0.01*"+this.rate+",2) from a223 w where a.id=w.id)";
			this.queryapi.executeSql(sql);
			super.showMessageDetail("²Ù×÷Íê³É");
		} catch (SysException e) {
			super.showMessageDetail("²Ù×÷Ê§°Ü");
			e.printStackTrace();
		}
	}

	public void splitBase(){
		try {
			this.activeapi.executeSql("BEGIN proc_add_paybaseinfo(); END;");
			super.showMessageDetail("²Ù×÷Íê³É");
		} catch (SysException e) {
			super.showMessageDetail("²Ù×÷Ê§°Ü");
			e.printStackTrace();
		}
	}
	
}