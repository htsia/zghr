package com.hr319wg.custom.emp.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.custom.emp.pojo.bo.EmpQueryItemBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.qry.pojo.bo.QueryConditionBO;
import com.hr319wg.qry.pojo.vo.QueryVO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.pojo.bo.UserQryBO;
import com.hr319wg.user.pojo.vo.UserQryVO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserQryUCC;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class PersonListBackingBean extends BaseBackingBean {
	private User user = super.getUserInfo();
	private String OPER_ID = "0311";
	private IPersonUCC personucc;
	private IUserQryUCC userqryucc;
	private IQueryUCC queryucc;
	private IUserReportUCC userreportucc;
	private UserAPI userApi;
	private List regTableList;
	private String personList = null;
	private List orgBrowModeList;
	private String personType;
	private String personTypeValue;
	private String personTypeDesc;
	private String superId;
	private String superName;
	private String name;
	private String nameStrs;
	private String orgFilter;
	private String orgMode = "1";
	private String type;
	private String defaultQry;
	private List displaySetList;
	private List pids = new ArrayList();
	private String personID;
	private String code;
	private String dept;
	private boolean modiPerson = false;
	private QueryAPI queryAPI;
	private String oper;
	private String fieldID;
	private String fieldValue;
	private List fieldList;
	private boolean showSetItem;
	private boolean cancelQuery;
	private String advanceQuery;
	private CellVO[] tableItem;
	private List<EmpQueryItemBO> queryItemList;
	private ICommonService commonService;
	private String addWhere;

	public String getAdvanceQuery() {
		return advanceQuery;
	}

	public void setAdvanceQuery(String advanceQuery) {
		this.advanceQuery = advanceQuery;
	}

	public boolean isCancelQuery() {
		return cancelQuery;
	}

	public void setCancelQuery(boolean cancelQuery) {
		this.cancelQuery = cancelQuery;
	}

	public String getAddWhere() {
		return addWhere;
	}

	public void setAddWhere(String addWhere) {
		this.addWhere = addWhere;
	}

	public List<EmpQueryItemBO> getQueryItemList() {
		return queryItemList;
	}

	public void setQueryItemList(List<EmpQueryItemBO> queryItemList) {
		this.queryItemList = queryItemList;
	}

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public CellVO[] getTableItem() {
		return tableItem;
	}

	public void setTableItem(CellVO[] tableItem) {
		this.tableItem = tableItem;
	}

	public boolean isShowSetItem() {
		return showSetItem;
	}

	public void setShowSetItem(boolean showSetItem) {
		this.showSetItem = showSetItem;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getOrgFilter() {
		return orgFilter;
	}

	public void setOrgFilter(String orgFilter) {
		this.orgFilter = orgFilter;
	}

	public boolean isModiPerson() {
		return UserAPI.checkButtonOperate(super.getUserInfo(), "031101");
	}

	public void setModiPerson(boolean modiPerson) {
		this.modiPerson = modiPerson;
	}

	public String getOper() {
		return oper;
	}

	public void setOper(String oper) {
		this.oper = oper;
	}

	public String getFieldValue() {
		return fieldValue;
	}

	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}

	public String getFieldID() {
		return fieldID;
	}

	public void setFieldID(String fieldID) {
		this.fieldID = fieldID;
	}

	public List getFieldList() {
		return fieldList;
	}

	public void setFieldList(List fieldList) {
		this.fieldList = fieldList;
	}

	public QueryAPI getQueryAPI() {
		return queryAPI;
	}

	public void setQueryAPI(QueryAPI queryAPI) {
		this.queryAPI = queryAPI;
	}

	public List getOrgBrowModeList() {
		this.orgBrowModeList = new ArrayList();
		SelectItem si = new SelectItem();
		si.setLabel("机构树");
		si.setValue("1");
		this.orgBrowModeList.add(si);

		SelectItem si2 = new SelectItem();
		si2.setLabel("团队");
		si2.setValue("2");
		this.orgBrowModeList.add(si2);

		List list = SysCacheTool.queryCodeItemBySetId("2243");
		if ((list != null) && (list.size() > 0))
			for (int i = 0; i < list.size(); i++) {
				CodeItemBO cb = (CodeItemBO) list.get(i);
				if ("1".equals(cb.getItemStatus())) {
					SelectItem si3 = new SelectItem();
					si3.setLabel(cb.getItemName());
					si3.setValue(cb.getItemId());
					this.orgBrowModeList.add(si3);
				}
			}
		return this.orgBrowModeList;
	}

	public void setOrgBrowModeList(List orgBrowModeList) {
		this.orgBrowModeList = orgBrowModeList;
	}

	public String getOrgMode() {
		return this.orgMode;
	}

	public void setOrgMode(String orgMode) {
		this.orgMode = orgMode;
	}

	public UserAPI getUserApi() {
		return this.userApi;
	}

	public void setUserApi(UserAPI userApi) {
		this.userApi = userApi;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String st) {
		this.type = st;
	}

	public List getRegTableList() {
		try {
			this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), this.OPER_ID, UserRptVO.TYPE_REG);
			if (this.regTableList == null)
				this.regTableList = new ArrayList();
		} catch (Exception e) {
			this.regTableList = new ArrayList();
		}
		return this.regTableList;
	}

	public void setRegTableList(List li) {
		this.regTableList = li;
	}

	public void setPids(List li) {
		this.pids = li;
	}

	public List getPids() {
		return this.pids;
	}

	public String getNameStrs() {
		return this.nameStrs;
	}

	public void setNameStrs(String c) {
		this.nameStrs = c;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String c) {
		this.code = c;
	}

	public String getPersonID() {
		return this.personID;
	}

	public void setPersonID(String setId) {
		this.personID = setId;
	}

	public String getDept() {
		return this.dept;
	}

	public void setDept(String setId) {
		this.dept = setId;
	}

	public String getDefaultQry() {
		return this.defaultQry;
	}

	public void setDefaultQry(String id) {
		this.defaultQry = id;
	}

	public IUserQryUCC getUserqryucc() {
		return this.userqryucc;
	}

	public void setUserqryucc(IUserQryUCC iu) {
		this.userqryucc = iu;
	}

	public IQueryUCC getQueryucc() {
		return this.queryucc;
	}

	public void setQueryucc(IQueryUCC iu) {
		this.queryucc = iu;
	}

	public void setUserreportucc(IUserReportUCC iur) {
		this.userreportucc = iur;
	}

	public IUserReportUCC getUserreportucc() {
		return this.userreportucc;
	}

	public List getDisplaySetList() {
		return this.displaySetList;
	}

	public void setDisplaySetList(List list) {
		this.displaySetList = list;
	}

	public String getPersonTypeDesc() {
		return this.personTypeDesc;
	}

	public void setPersonTypeDesc(String desc) {
		this.personTypeDesc = desc;
	}

	public IPersonUCC getPersonucc() {
		return this.personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	private void InitDisplay() {
		ArrayList setList = new ArrayList();
		SelectItem itemSpace = new SelectItem();
		itemSpace.setLabel("---请选择显示方案---");
		itemSpace.setValue("-1");
		setList.add(itemSpace);
		try {
			QueryVO qv = this.queryucc.findQueryVO("156");
			SelectItem itemDefault = new SelectItem();
			itemDefault.setLabel(qv.getName());
			itemDefault.setValue(qv.getQryId());
			setList.add(itemDefault);
			this.defaultQry = "156";

			List list = this.userqryucc.queryUserQry(super.getUserInfo().getUserId(), this.OPER_ID);
			for (int i = 0; i < list.size(); i++) {
				UserQryVO role = (UserQryVO) list.get(i);
				SelectItem item = new SelectItem();
				item.setLabel(role.getQryName());
				item.setValue(role.getQryID());
				if ((role.getIsCurrent() != null) && (role.getIsCurrent().equals("1"))) {
					this.defaultQry = role.getQryID();
				}
				setList.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.displaySetList = setList;
	}

	public String getPersonList() {
		return this.personList;
	}

	public void setPersonList(String personList) {
		this.personList = personList;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPersonType() {
		return this.personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		this.personTypeValue = "";
		if (this.personType != null) {
			this.personTypeValue = CodeUtil.interpertCode(CodeUtil.TYPE_CODE, this.personType);
		}
		return this.personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public String getSuperName() {
		if ((this.superId != null) && (!"".equals(this.superId))) {
			this.superName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.superId);
		} else {
			this.superName = "";
		}
		return this.superName;
	}

	public void setSuperName(String superId) {
		this.superName = superId;
	}

	public String getSuperId() {
		return this.superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public void changeQuery(ValueChangeEvent event) {
		try {
			this.defaultQry = event.getNewValue().toString();
			this.userqryucc.CancelSelect(super.getUserInfo().getUserId(), this.OPER_ID);

			if (!this.defaultQry.equals("156")) {
				UserQryBO ub = this.userqryucc.getQueryByID(super.getUserInfo().getUserId(), this.defaultQry, this.OPER_ID);
				ub.setIsCurrent("1");
				this.userqryucc.save(ub);
			}
			setItem();
			queryPerson();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			this.orgFilter = null;
		}
		String superId1 = super.getRequestParameter("superId");
		if (superId1 != null && !"-1".equals(superId1)) {
			this.superId = superId1;
		}
		if (this.superId == null || "".equals(this.superId)) {
			this.superId = user.getOrgId();
		}
		String orgMode1 = super.getRequestParameter("orgMode");
		if (orgMode1 != null && !"".equals(orgMode1)) {
			this.orgMode = orgMode1;
		}
		String orgFilter1 = super.getRequestParameter("orgFilter");
		if (orgFilter1 != null && !"".equals(orgFilter1)) {
			this.orgFilter = orgFilter1;
		}
		if (this.personType == null || "".equals(this.personType)) {
			try {
				this.personType = CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		if (this.displaySetList == null) {
			InitDisplay();
		}

		this.fieldList = new ArrayList();
		SelectItem s0 = new SelectItem();
		s0.setLabel("--请选择--");
		s0.setValue("-1");
		this.fieldList.add(s0);

		setItem();

		String pageFlag = getServletRequest().getParameter("pageFlag");
		if ("init".equals(act) || "1".equals(pageFlag)) {
			queryPerson();
		}
		return this.pageInit;
	}

	private void setItem() {
		// 简单查询里下拉框
		try {
			this.tableItem = queryAPI.queryInfoItem(this.defaultQry);
			for (CellVO cell : this.tableItem) {
				String datatype = cell.getItemDataType();
				if (!"ID".equals(cell.getItemId()) && (InfoItemBO.DATA_TYPE_CODE.equals(datatype) || InfoItemBO.DATA_TYPE_STRING.equals(datatype) || InfoItemBO.DATA_TYPE_DATE.equals(datatype) || InfoItemBO.DATA_TYPE_DATE6.equals(datatype) || InfoItemBO.DATA_TYPE_INT.equals(datatype) || InfoItemBO.DATA_TYPE_FLOAT.equals(datatype) || InfoItemBO.DATA_TYPE_POST.equals(datatype))) {
					SelectItem si = new SelectItem();
					si.setLabel(cell.getItemName());
					si.setValue(cell.getItemId());
					this.fieldList.add(si);
				}
			}
			// 设置显示项
			this.showSetItem = false;
			if ("156".equals(this.defaultQry)) {
				super.getHttpSession().setAttribute("tableItem", this.tableItem.clone());
				this.showSetItem = true;
				this.queryItemList = this.commonService.getEmpQueryItem(user.getUserId());
				super.getHttpSession().setAttribute("queryItemList", this.queryItemList);

				// 设置默认查询的默认字段
				if (this.queryItemList != null && this.queryItemList.size() == 1 && this.queryItemList.get(0).getShowItem() != null) {
					String[] showItems = this.queryItemList.get(0).getShowItem().split(",");
					List<CellVO> cellList = new ArrayList<CellVO>();
					InfoItemBO IDItem = SysCacheTool.findInfoItem("A001", "ID");
					CellVO IDCell = new CellVO();
					CommonFuns.copyProperties(IDCell, IDItem);
					cellList.add(IDCell);
					for (int i = 0; i < showItems.length; i++) {
						InfoItemBO infoItem = SysCacheTool.findInfoItem(showItems[i].substring(0, 4), showItems[i]);
						CellVO cell = new CellVO();
						CommonFuns.copyProperties(cell, infoItem);
						cellList.add(cell);
					}
					this.tableItem = cellList.toArray(new CellVO[0]);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	// 查询
	public String queryPerson() {
		String pageFlag = getServletRequest().getParameter("pageFlag");
		// 通过翻页查询
		if ("1".equals(pageFlag)) {
			try {
				String rowNums = getServletRequest().getParameter("rowNum");
				int pageNum = (getServletRequest().getParameter("pageNum") == null) || ("".equals(getServletRequest().getParameter("pageNum"))) ? 1 : Integer.parseInt(getServletRequest().getParameter("pageNum"));

				String sql = (String) getHttpSession().getAttribute("activeSql");

				TableVO table = (TableVO) getHttpSession().getAttribute("OBJECT");
				if (table == null)
					table = new TableVO();
				int rowNum = Constants.ACTIVE_PAGE_SIZE;
				if (rowNums != null) {
					rowNum = Integer.parseInt(rowNums);
				}
				User user = getUserInfo();
				this.personucc.querySql(table, sql, user, pageNum, rowNum);
				getHttpSession().setAttribute("OBJECT", table);
				getHttpSession().setAttribute("activeSql", sql);
				getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
				getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			} catch (Exception e) {
				e.printStackTrace();
				clearSession();
				this.msg.setMainMsg(e, getClass());
			}
			return "inited";
		} else {
			if ("1".equals(this.advanceQuery)) {
				this.advanceQuery = null;
				return null;
			}
			clearSession();
			String nameStr = (this.name == null || "".equals(this.name)) ? this.nameStrs : this.name;
			try {
				TableVO table = new TableVO();
				String rowNums = (String) getHttpSession().getAttribute("rowNum");
				int rowNum = Constants.ACTIVE_PAGE_SIZE;
				if (rowNums != null) {
					rowNum = Integer.parseInt(rowNums);
				}
				String sql = "";
				if ("1".equals(this.orgMode)) {
					String loaddata = super.getRequestParameter("loaddata");
					if (!"0".equals(loaddata) && "1".equals(this.orgFilter) && !cancelQuery) {
						sql = this.commonService.queryPersonList(table, nameStr, this.personType, this.superId, 1, rowNum, "00900", user, this.defaultQry, this.addWhere, this.tableItem, this.queryItemList, this.queryucc);
						this.addWhere = null;
					} else {
						table.setHeader(this.tableItem);
						table.setSetType("A");
					}
				} else {
					String where = " A001.ID in (select PERSON_ID from EMP_TEAM_PERSON where TEAM_ID='" + this.superId + "')";
					sql = this.personucc.queryPersonList(table, nameStr, this.personType, null, 1, rowNum, "00900", null, this.defaultQry, where);
				}
				this.cancelQuery = false;
				this.nameStrs = null;
				getHttpSession().setAttribute("activeSql", sql);
				getHttpSession().setAttribute("pageNum", String.valueOf("1"));
				getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
				getHttpSession().setAttribute("OBJECT", table);
			} catch (Exception e) {
				e.printStackTrace();
				clearSession();
				this.msg.setMainMsg(e, getClass());
			}
		}

		return "inited";
	}

	// 简单查询
	public String queryPerson2() {
		try {
			QueryVO vo = this.queryucc.findQueryVO("queryforemp");
			QueryConditionBO cond = vo.getStatics()[0].getCondi()[0];
			cond.setValue(this.fieldValue);
			cond.setItemId(this.fieldID);
			cond.setOperator(this.oper);
			Map map = this.queryucc.buildQuerySqlHash(null, vo);
			this.addWhere = map.get("SQL_WHERE_PART").toString();

			this.oper = null;
			this.fieldID = null;
			this.fieldValue = null;
			queryPerson();
		} catch (SysException e1) {
			e1.printStackTrace();
		}
		return null;
	}

	public void cancelQuery() {
		this.cancelQuery = true;
		this.name = null;
		queryPerson();
	}

	public String saveItem() {
		String[] showItems = super.getServletRequest().getParameterValues("showItem");
		String[] orderItems = super.getServletRequest().getParameterValues("orderItem");
		try {
			this.commonService.saveQueryItem(user.getUserId(), showItems, orderItems);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}

	private void clearSession() {
		getHttpSession().removeAttribute("OBJECT");
		getHttpSession().removeAttribute("activeSql");
		getHttpSession().removeAttribute("pageNum");
		getHttpSession().removeAttribute("rowNum");
	}
}