package com.hr319wg.insurace.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.http.HttpSession;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.insurace.pojo.bo.InsDeptPowerBO;
import com.hr319wg.insurace.ucc.IBaseSetUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.ListMap;
import com.hr319wg.wage.pojo.bo.WageDeptBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.ucc.IWageDeptUCC;
import com.hr319wg.wage.ucc.IWageItemPowerUCC;
import com.hr319wg.wage.ucc.IWagePersonQueryUCC;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;
import com.hr319wg.wage.ucc.IWageUnitUCC;

public class BaseInfoBackingBean extends BaseBackingBean {
	private IBaseSetUCC basesetucc;
	private final String OperID = "1414";
	private String setId;
	private String setName;
	private String unitId;
	private String unitName;
	private List reportList;
	private String calcSet;
	private String dept;
	private String deptpower;
	private WageUnitBO wset;
	private IUserReportUCC userreportucc;
	private IWageUnitUCC wageunitucc;
	private WageAPI wageapi;
	private IQueryUCC queryucc;
	private IWageSetPersonUCC wagesetpersonucc;
	private IWagePersonQueryUCC wagepersonqueryucc;
	private IWageSetUCC wagesetucc;
	private IWageDeptUCC wagedeptucc;
	private IWageItemPowerUCC wagepowerucc;
	private String precise;
	private String personCount;
	private String groupLevel;
	private List perSetItemList;
	private List setList;
	private List deptList;
	private boolean autoCalc;
	private List inputList;
	private List yearList;
	private String inputField;
	private boolean operApply;
	private String[] selectSet;
	private String calcSetString;
	private UploadedFile excelFile;
	private QueryAPI queryapi;
	private UserAPI userapi;
	private String personType;
	private String personTypeValue;
	private String searchStr;
	private String yearStr;
	
	
	public String getYearStr() {
		return yearStr;
	}

	public void setYearStr(String yearStr) {
		this.yearStr = yearStr;
	}

	public String getSearchStr() {
		return searchStr;
	}

	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
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

	public List getYearList() {
		return yearList;
	}

	public void setYearList(List yearList) {
		this.yearList = yearList;
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

	public BaseInfoBackingBean() {
		this.dept = "-1";

		this.wset = new WageUnitBO();

		this.autoCalc = false;

		this.operApply = true;
	}

	public String[] getSelectSet() {
		return this.selectSet;
	}

	public void setSelectSet(String[] selectSet) {
		this.selectSet = selectSet;
	}

	public String getCalcSetString() {
		return this.calcSetString;
	}

	public void setCalcSetString(String calcSetString) {
		this.calcSetString = calcSetString;
	}

	public boolean isOperApply() {
		this.operApply = UserAPI.checkButtonOperate(super.getUserInfo(),
				"141406");
		return this.operApply;
	}

	public void setOperApply(boolean b) {
		this.operApply = b;
	}

	public List getInputList() {
		if (this.inputList == null)
			try {
				String select = this.wagepowerucc.getInsuraceBaseFields(super
						.getUserInfo().getUserId(), this.setId);
				String[] selectFields = select.split(",");
				this.inputList = new ArrayList();
				SelectItem si0 = new SelectItem();
				si0.setLabel("--全部项目--");
				si0.setValue("-1");
				this.inputList.add(si0);

				for (int i = 0; i < selectFields.length; i++) {
					if (selectFields[i].startsWith("A001"))
						break;
					InfoItemBO ib = SysCacheTool.findInfoItem("",
							selectFields[i]);
					SelectItem si = new SelectItem();
					si.setLabel(ib.getItemName());
					si.setValue(ib.getItemId());
					this.inputList.add(si);
				}
			} catch (Exception e) {
			}
		return this.inputList;
	}

	public void setInputList(List list) {
		this.inputList = list;
	}

	public String getInputField() {
		return this.inputField;
	}

	public void setInputField(String field) {
		this.inputField = field;
	}

	public boolean getAutoCalc() {
		return this.autoCalc;
	}

	public void setAutoCalc(boolean b) {
		this.autoCalc = b;
	}

	public String uploadFile() {
		String retval = null;

		return retval;
	}

	private String getDeptPowerString() {
		String Power = "";
		try {
			if (super.getHttpSession().getAttribute("Power") != null) {
				Power = (String) super.getHttpSession().getAttribute("Power");
			} else {
				Power = this.wagedeptucc.getInsPowerSQLByPerson(super
						.getUserInfo().getUserId(), this.setId);
				super.getHttpSession().setAttribute("Power", Power);
			}
		} catch (Exception e) {
		}
		return Power;
	}

	public String getDeptpower() {
		try {
			if ((this.deptpower == null) || ("".equals(this.deptpower)))
				this.deptpower = this.wagedeptucc.getInsPowerSQLByPerson(super
						.getUserInfo().getUserId(), this.setId);
		} catch (Exception e) {
			this.deptpower = " 1=1";
		}
		super.getHttpSession()
				.setAttribute("RosterAddConditon", this.deptpower);
		return this.deptpower;
	}

	public void setDeptpower(String str) {
		this.deptpower = str;
	}

	private String getDeptPowerSQL() {
		String whereStr = "";

		if (this.dept.equals("-1")) {
			String Power = getDeptpower();
			if (!("".equals(Power))) {
				whereStr = Power;
			} else
				whereStr = "1=1";

		} else if (this.dept.equals("-2")) {
			whereStr = "A001743 is null";
		} else if ("DEPT_NAME".equals(this.groupLevel)) {
			whereStr = "A001743='" + this.dept + "'";
		} else {
			whereStr = "A001743 in (select dept_name from wage_dept where set_id='"
					+ this.setId
					+ "' and "
					+ this.groupLevel
					+ "='"
					+ this.dept + "')";
			String power = getDeptPowerString();
			if (!("".equals(power)))
				whereStr = whereStr + " and " + power;
		}

		return whereStr;
	}

	public String changeLevel() {
		if (this.deptList != null) {
			this.deptList.clear();
			this.deptList = null;
			getDeptList();
		}
		return "";
	}

	public String getDept() {
		return this.dept;
	}

	public void setDept(String ID) {
		this.dept = ID;
	}

	public List getSetList() {
		return this.setList;
	}

	public void setSetList(List setList) {
		this.setList = setList;
	}

	public UploadedFile getExcelFile() {
		return this.excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public List getPerSetItemList() {
		InfoItemBO ib;
		SelectItem si;
		if (this.perSetItemList != null)
			return this.perSetItemList;
		this.perSetItemList = new ArrayList();

		List list = SysCacheTool.queryInfoItemBySetId("A755");
		for (int i = 0; i < list.size(); i++) {
			ib = (InfoItemBO) list.get(i);
			if ((!(InfoItemBO.PROPERTY_CONTROL_HIDE
					.equals(ib.getItemProperty())))
					&& (!("A755701".equals(ib.getItemId())))) {
				si = new SelectItem();
				si.setLabel(ib.getItemNameEx());
				si.setValue(ib.getItemId());
				this.perSetItemList.add(si);
			}
		}

		list = SysCacheTool.queryInfoItemBySetId("A760");
		for (int i = 0; i < list.size(); i++) {
			ib = (InfoItemBO) list.get(i);
			if ((!(InfoItemBO.PROPERTY_CONTROL_HIDE
					.equals(ib.getItemProperty())))
					&& (!("A760701".equals(ib.getItemId())))) {
				si = new SelectItem();
				si.setLabel(ib.getItemNameEx());
				si.setValue(ib.getItemId());
				this.perSetItemList.add(si);
			}
		}

		list = SysCacheTool.queryInfoItemBySetId("A765");
		for (int i = 0; i < list.size(); i++) {
			ib = (InfoItemBO) list.get(i);
			if ((!(InfoItemBO.PROPERTY_CONTROL_HIDE
					.equals(ib.getItemProperty())))
					&& (!("A765701".equals(ib.getItemId())))) {
				si = new SelectItem();
				si.setLabel(ib.getItemNameEx());
				si.setValue(ib.getItemId());
				this.perSetItemList.add(si);
			}
		}

		list = SysCacheTool.queryInfoItemBySetId("A770");
		for (int i = 0; i < list.size(); i++) {
			ib = (InfoItemBO) list.get(i);
			if ((!(InfoItemBO.PROPERTY_CONTROL_HIDE
					.equals(ib.getItemProperty())))
					&& (!("A770701".equals(ib.getItemId())))) {
				si = new SelectItem();
				si.setLabel(ib.getItemNameEx());
				si.setValue(ib.getItemId());
				this.perSetItemList.add(si);
			}
		}

		list = SysCacheTool.queryInfoItemBySetId("A775");
		for (int i = 0; i < list.size(); i++) {
			ib = (InfoItemBO) list.get(i);
			if ((!(InfoItemBO.PROPERTY_CONTROL_HIDE
					.equals(ib.getItemProperty())))
					&& (!("775701".equals(ib.getItemId())))) {
				si = new SelectItem();
				si.setLabel(ib.getItemNameEx());
				si.setValue(ib.getItemId());
				this.perSetItemList.add(si);
			}
		}

		list = SysCacheTool.queryInfoItemBySetId("A780");
		for (int i = 0; i < list.size(); i++) {
			ib = (InfoItemBO) list.get(i);
			if ((!(InfoItemBO.PROPERTY_CONTROL_HIDE
					.equals(ib.getItemProperty())))
					&& (!("A780701".equals(ib.getItemId())))) {
				si = new SelectItem();
				si.setLabel(ib.getItemNameEx());
				si.setValue(ib.getItemId());
				this.perSetItemList.add(si);
			}
		}
		return this.perSetItemList;
	}

	public void setPerSetItemList(List perSetItemList) {
		this.perSetItemList = perSetItemList;
	}

	public List getDeptList() {
		if (this.deptList != null)
			return this.deptList;
		this.deptList = new ArrayList();
		SelectItem s0 = new SelectItem();
		s0.setLabel("--全部部门--");
		s0.setValue("-1");
		this.deptList.add(s0);

		SelectItem s1 = new SelectItem();
		s1.setLabel("没有部门人员");
		s1.setValue("-2");
		this.deptList.add(s1);
		try {
			String[] depstr = null;
			List powerList = this.wagedeptucc.getAllInsPowerByPerson(super
					.getUserInfo().getUserId(), this.setId);
			if ((powerList == null) || (powerList.size() == 0)) {
				depstr = this.wagepersonqueryucc.getDeptList(this.setId);
			} else {
				depstr = new String[powerList.size()];
				for (int i = 0; i < powerList.size(); i++) {
					InsDeptPowerBO wpo = (InsDeptPowerBO) powerList.get(i);
					WageDeptBO wdo = this.wagedeptucc.getDeptBOByID(wpo
							.getDeptID());
					depstr[i] = wdo.getName();
				}

			}

			depstr = this.wagedeptucc.getDeptsByLevel(this.setId, depstr,
					this.groupLevel);
			int len = Integer.parseInt(Constants.WAGE_DEPT_CODELEN);
			if (depstr != null)
				for (int i = 0; i < depstr.length; i++) {
					if ("".equals(depstr[i]))
						break;
					SelectItem s2 = new SelectItem();
					if ((depstr[i] != null) && (depstr[i].length() > len)) {
						s2.setLabel(depstr[i].substring(len));
					} else
						s2.setLabel(depstr[i]);

					s2.setValue(depstr[i]);
					this.deptList.add(s2);
				}
		} catch (Exception e) {
		}

		return this.deptList;
	}

	public void setDeptList(List dept) {
		this.deptList = dept;
	}

	public IWageSetPersonUCC getWagesetpersonucc() {
		return this.wagesetpersonucc;
	}

	public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
		this.wagesetpersonucc = wagesetpersonucc;
	}

	public IWagePersonQueryUCC getWagepersonqueryucc() {
		return this.wagepersonqueryucc;
	}

	public void setWagepersonqueryucc(IWagePersonQueryUCC wagepersonqueryucc) {
		this.wagepersonqueryucc = wagepersonqueryucc;
	}

	public String savePersonBase() {
		String[] persId;
		try {
			persId = (String[]) (String[]) super.getHttpSession().getAttribute(
					"persId");
			String[] inputField = (String[]) (String[]) super.getHttpSession()
					.getAttribute("field");
			ListMap hash = new ListMap();
			int col = inputField.length;
			int row = persId.length;
			for (int i = 0; i < row; i++)
				for (int j = 0; j < col; ++j)
					hash.put(persId[i] + "|" + inputField[j], CommonFuns
							.filterNullToZero(super
									.getRequestParameter(persId[i] + "|"
											+ inputField[j])));

			this.wagesetpersonucc.updateBaseInfo(persId, inputField, hash);
		} catch (SysException e) {
			super.showMessageDetail("错误:" + e.getMessage());
		}
		return "success";
	}

	public String getPersonCount() {
		try {
			if (this.personCount == null)
				this.personCount = String.valueOf(this.wageapi
						.getCountbySetID(this.setId));
		} catch (Exception e) {
		}

		return this.personCount;
	}

	public void setpersonCount(String pre) {
		this.personCount = pre;
	}

	public String getPrecise() {
		return this.precise;
	}

	public void setPrecise(String pre) {
		this.precise = pre;
	}

	public WageUnitBO getWset() {
		return this.wset;
	}

	public void setWset(WageUnitBO set) {
		this.wset = set;
	}

	public String getCalcSet() {
		try {
			if (super.getRequestParameter("setId") != null) {
				this.setId = super.getRequestParameter("setId");
				this.unitId = super.getRequestParameter("unitId");
				this.wset = this.wageunitucc.findUnitByID(this.unitId);
			}
		} catch (Exception e) {
		}
		return this.calcSet;
	}

	public void setCalcSet(String set) {
		this.calcSet = set;
	}

	public String getPageInit() {
		this.yearList = new ArrayList();
		SelectItem item0 = new SelectItem();
		item0.setLabel("全部年份");
		item0.setValue("-1");
		this.yearList.add(item0);
		for(int i=2010;i<2031;i++){
			SelectItem item = new SelectItem();
			item.setLabel(i+"年");
			item.setValue(i);
			this.yearList.add(item);			
		}
		
		try {
			if(this.personType==null || "".equals(this.personType)){
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			}
		} catch (SysException e1) {
			e1.printStackTrace();
		}
		
		try {
			String useid = super.getUserInfo().getUserId();
			this.reportList = this.userreportucc.queryUserRptToWeb(useid,"1414");
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		
		String pageFlag = super.getServletRequest().getParameter("pageFlag");
		if ("1".equals(pageFlag)){
			turnPageQuery(null, null, 0, 0);
		}

		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			String orgId = super.getServletRequest().getParameter("unitId");
	    	if(orgId!=null){
	    		OrgBO org = SysCacheTool.findOrgById(orgId);
	    		if(!"-1".equals(org.getSuperId())){    			
	    			orgId=org.getOrgId();
	    		}else{
	    			orgId=null;
	    		}		
	    	}
	    	commonInfoQuery(orgId);
		}
		return "";
	}
	
	public String turnPageQuery() {
		return turnPageQuery(null, null, 0, 0);
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
			table = this.queryucc.executeQuery(null, table.getHeader(), sql, true, pageNum, rowNum);

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

	public void changeSetId(ValueChangeEvent event) {
		this.setId = event.getNewValue().toString();
		commonInfoQuery(null);
	}

	public String commonInfoQuery(String orgId) {
		try {
			super.getHttpSession().removeAttribute("OBJECT");
			super.getHttpSession().removeAttribute("activeSql");
			super.getHttpSession().removeAttribute("pageNum");
			super.getHttpSession().removeAttribute("rowNum");

			TableVO tablevo = new TableVO();
			CellVO[] headerItem =  this.queryapi.queryInfoItem("144");
	        tablevo.setHeader(headerItem);
			//查询语句
			Hashtable hash = this.queryapi.getQuerySqlHash(null, "144");
	        String select = (String)hash.get("SQL_SELECT_PART");
	        String from = CommonFuns.filterNull((String)hash.get("SQL_FROM_PART")).toUpperCase();
	        String order = CommonFuns.filterNull((String)hash.get("SQL_ORDER_PART"));

	        String sql="select "+select+" from "+from +" where 1=1 ";
	        if(orgId!=null){
	        	OrgBO org = SysCacheTool.findOrgById(orgId);
				sql += " and a001738 like '"+org.getTreeId()+"%' ";
	        }
	        String searchStr1 ="%";
	        String yearStr1 ="%";
	        if(this.searchStr!=null){
	        	searchStr1=this.searchStr;
	        }
	        if(this.yearStr!=null && !"".equals(this.yearStr)){
	        	yearStr1=this.yearStr;
	        }
	        
	        sql+=" and (a001001 like '%"+searchStr1+"%' or a001735 like '%"+searchStr1+"%' ) ";
	        sql += " and "+CommonFuns.splitInSql(this.personType.split(","), "a001054");
	        if(!"".equals(order)){
	        	sql+="order by "+order;
	        }

			turnPageQuery(tablevo, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return "personList";
	}

	public String queryAdvance() {
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
			super.showMessageDetail("错误:" + e.getMessage());
		}
		return "personList";
	}

	public String calc() {
		try {			
			this.queryapi.executeSql("BEGIN proc_ins_calc('"+this.calcSetString+"'); END;");
			commonInfoQuery(null);
			super.showMessageDetail("计算完成！");
		} catch (Exception e) {
			super.showMessageDetail("计算失败:" + e.getMessage());
		}
		return "success";
	}

	public String queryPersonByNameStr() {
		String nameStr = super.getRequestParameter("form1:nameStr");
		commonInfoQuery(null);
		return null;
	}

	public String queryPersonByYearStr() {
		String yearStr = super.getRequestParameter("form1:yearStr");
		if("-1".equals(yearStr)){
			yearStr="%";
		}
		commonInfoQuery(null);
		return null;
	}

	public List getReportList() {
		return this.reportList;
	}

	public void setReportList(List list) {
		this.reportList = list;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}

	public String getGroupLevel() {
		if ((this.groupLevel == null) || ("".equals(this.groupLevel)))
			this.groupLevel = "DEPT_NAME";

		return this.groupLevel;
	}

	public void setGroupLevel(String level) {
		this.groupLevel = level;
	}

	public String getSetName() {
		try {
			this.setName = this.wagesetucc.findSetBySetId(this.setId).getName();
		} catch (Exception e) {
			this.setName = null;
		}
		return this.setName;
	}

	public void setSetName(String setName) {
		this.setName = setName;
	}

	public String getUnitId() {
		return this.unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getUnitName() {
		return this.unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public WageAPI getWageapi() {
		return this.wageapi;
	}

	public void setWageapi(WageAPI api) {
		this.wageapi = api;
	}

	public IWageItemPowerUCC getWagepowerucc() {
		return this.wagepowerucc;
	}

	public void setWagepowerucc(IWageItemPowerUCC ucc) {
		this.wagepowerucc = ucc;
	}

	public IWageUnitUCC getWageunitucc() {
		return this.wageunitucc;
	}

	public void setWageunitucc(IWageUnitUCC ucc) {
		this.wageunitucc = ucc;
	}

	public IQueryUCC getQueryucc() {
		return this.queryucc;
	}

	public void setQueryucc(IQueryUCC queryucc) {
		this.queryucc = queryucc;
	}

	public IWageSetUCC getWagesetucc() {
		return this.wagesetucc;
	}

	public void setWagesetucc(IWageSetUCC wagesetucc) {
		this.wagesetucc = wagesetucc;
	}

	public void setUserreportucc(IUserReportUCC iur) {
		this.userreportucc = iur;
	}

	public IUserReportUCC getUserreportucc() {
		return this.userreportucc;
	}

	public IWageDeptUCC getWagedeptucc() {
		return this.wagedeptucc;
	}

	public void setWagedeptucc(IWageDeptUCC ucc) {
		this.wagedeptucc = ucc;
	}

	public IBaseSetUCC getBasesetucc() {
		return this.basesetucc;
	}

	public void setBasesetucc(IBaseSetUCC basesetucc) {
		this.basesetucc = basesetucc;
	}
}