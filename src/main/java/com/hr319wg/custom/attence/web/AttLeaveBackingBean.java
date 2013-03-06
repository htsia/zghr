package com.hr319wg.custom.attence.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttLeaveBO;
import com.hr319wg.custom.attence.pojo.bo.AttLogBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.attence.util.AttConstants;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;
import com.hr319wg.xys.workflow.service.SelPersonsToolService;

public class AttLeaveBackingBean extends BaseBackingBean {
	private User user =super.getUserInfo();
	// 浏览申请
	private String pageInit;
	private List list;
	private PageVO mypage = new PageVO();
	private boolean selApply = true;
	private boolean selAuditing = true;
	private boolean selAudited;
	private boolean selRefuse = true;
	private boolean selLeave1 = true;
	private boolean selLeave2 = true;
	private boolean selLeave3 = true;
	private boolean selLeave4 = true;
	private boolean selLeave5 = true;
	private boolean selLeave6 = true;
	private boolean selLeave7 = true;
	private boolean selLeave8 = true;
	private boolean selLeave9 = true;
	private List leaveTypeList;
	private List leaveTypeList1;
	private String leaveId;
	private ActivitiToolsService activitiToolService;
	private SelPersonsToolService selPersonsTool;
	private String queryInit;
	private boolean querySelf = true;
	private String beginDate;
	private String endDate;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private String orgID;
	private UserAPI userapi;
	private String inputInit;
	private String createType;
	private String inputEditLeaveType;
	private String selectedUserIds;
	private String selectPersonNames;
	private String inputEditBeginDate;
	private String inputEditEndDate;
	private String inputEditReason;
	private String inputEditApplyDays;
	private String inputEditInit;
	private String operItemID;
	private IAttBusiService attBusiService;
	private List<UserBO> currApproverList = new ArrayList();
	private Map<String, Object> days;//表示各个带薪假的剩余天数
	private Map<String, Object> undoneDays;//表示未审批的假条中，各个带薪假的天数
	private String leaveBackDate;
	private String leaveBackInit;
	private String inself;
	private String ismanager;
	private List<UserBO> approverList=new ArrayList();
	private String toLeave="";
	private String userId;
	private boolean selMyAtt;
	private String inputPopEditInit;
	private String selectPersonId;
	
	public boolean isSelLeave8() {
		return selLeave8;
	}
	public void setSelLeave8(boolean selLeave8) {
		this.selLeave8 = selLeave8;
	}
	public boolean isSelLeave9() {
		return selLeave9;
	}
	public void setSelLeave9(boolean selLeave9) {
		this.selLeave9 = selLeave9;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List getLeaveTypeList1() {
		return leaveTypeList1;
	}
	public void setLeaveTypeList1(List leaveTypeList1) {
		this.leaveTypeList1 = leaveTypeList1;
	}
	public boolean isSelLeave1() {
		return selLeave1;
	}
	public void setSelLeave1(boolean selLeave1) {
		this.selLeave1 = selLeave1;
	}
	public boolean isSelLeave2() {
		return selLeave2;
	}
	public void setSelLeave2(boolean selLeave2) {
		this.selLeave2 = selLeave2;
	}
	public boolean isSelLeave3() {
		return selLeave3;
	}
	public void setSelLeave3(boolean selLeave3) {
		this.selLeave3 = selLeave3;
	}
	public boolean isSelLeave4() {
		return selLeave4;
	}
	public void setSelLeave4(boolean selLeave4) {
		this.selLeave4 = selLeave4;
	}
	public boolean isSelLeave5() {
		return selLeave5;
	}
	public void setSelLeave5(boolean selLeave5) {
		this.selLeave5 = selLeave5;
	}
	public boolean isSelLeave6() {
		return selLeave6;
	}
	public void setSelLeave6(boolean selLeave6) {
		this.selLeave6 = selLeave6;
	}
	public boolean isSelLeave7() {
		return selLeave7;
	}
	public void setSelLeave7(boolean selLeave7) {
		this.selLeave7 = selLeave7;
	}
	public void setInputPopEditInit(String inputPopEditInit) {
		this.inputPopEditInit = inputPopEditInit;
	}
	public String getInputPopEditInit() {
		try {
			if (super.getRequestParameter("new") != null) {
				leaveBo = new AttLeaveBO();
			} else if (super.getRequestParameter("leaveId") != null) {
				leaveId = super.getRequestParameter("leaveId");
				leaveBo = this.attBusiService.findAttLeaveBOById(leaveId);
			}
			if(leaveBo==null){
				leaveBo = new AttLeaveBO();
			}
			
			if (leaveBo.getPersonId() != null
					&& !leaveBo.getPersonId().equals("")) {
				personId = leaveBo.getPersonId();
				personName = SysCacheTool.findPersonById(leaveBo.getPersonId())
						.getName();
			} else {
				personId = user.getUserId();
				personName = user.getName();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 获得带薪假存休子集的数据
		try {
			if(selectedUserIds!=null&&!"".equals(selectedUserIds)){
				selectPersonId=selectedUserIds.split(",")[0];
			}			
			if(selectPersonId==null||"".equals(selectPersonId)){
				selectPersonId=user.getUserId();
			}
			List list = this.attBusiService.getDays(selectPersonId);
			this.undoneDays=this.attBusiService.getUndoneDays(selectPersonId);
			Map<String, Object> map = (Map<String, Object>) list.get(0);
			this.days = map;
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return inputPopEditInit;
	}
	public boolean isSelMyAtt() {
		return selMyAtt;
	}

	public void setSelMyAtt(boolean selMyAtt) {
		this.selMyAtt = selMyAtt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getToLeave() {
		return toLeave;
	}

	public void setToLeave(String toLeave) {
		this.toLeave = toLeave;
	}

	public Map<String, Object> getUndoneDays() {
		return undoneDays;
	}

	public void setUndoneDays(Map<String, Object> undoneDays) {
		this.undoneDays = undoneDays;
	}

	public List<UserBO> getApproverList() {
		return approverList;
	}

	public void setApproverList(List<UserBO> approverList) {
		this.approverList = approverList;
	}

	public String getIsmanager() {
		return ismanager;
	}

	public void setIsmanager(String ismanager) {
		this.ismanager = ismanager;
	}

	public String getInself() {
		return inself;
	}

	public void setInself(String inself) {
		this.inself = inself;
	}

	public String getLeaveBackInit() {
		if (super.getRequestParameter("leaveId") != null) {
			this.leaveId = super.getRequestParameter("leaveId");
		}
		return leaveBackInit;
	}

	public void setLeaveBackInit(String leaveBackInit) {
		this.leaveBackInit = leaveBackInit;
	}

	public String getLeaveBackDate() {
		return leaveBackDate;
	}

	public void setLeaveBackDate(String leaveBackDate) {
		this.leaveBackDate = leaveBackDate;
	}

	public Map<String, Object> getDays() {
		return days;
	}

	public void setDays(Map<String, Object> days) {
		this.days = days;
	}

	public List<UserBO> getCurrApproverList() {
		return currApproverList;
	}

	public void setCurrApproverList(List<UserBO> currApproverList) {
		this.currApproverList = currApproverList;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

	public String getInputEditLeaveType() {
		return inputEditLeaveType;
	}

	public void setInputEditLeaveType(String inputEditLeaveType) {
		this.inputEditLeaveType = inputEditLeaveType;
	}

	public String getOperItemID() {
		return operItemID;
	}

	public void setOperItemID(String operItemID) {
		this.operItemID = operItemID;
	}

	public String getSelectPersonNames() {
		return selectPersonNames;
	}

	public void setSelectPersonNames(String selectPersonNames) {
		this.selectPersonNames = selectPersonNames;
	}

	public String getInputEditBeginDate() {
		return inputEditBeginDate;
	}

	public void setInputEditBeginDate(String inputEditBeginDate) {
		this.inputEditBeginDate = inputEditBeginDate;
	}

	public String getInputEditEndDate() {
		return inputEditEndDate;
	}

	public void setInputEditEndDate(String inputEditEndDate) {
		this.inputEditEndDate = inputEditEndDate;
	}

	public String getInputEditReason() {
		return inputEditReason;
	}

	public void setInputEditReason(String inputEditReason) {
		this.inputEditReason = inputEditReason;
	}

	public String getInputEditApplyDays() {
		return inputEditApplyDays;
	}

	public void setInputEditApplyDays(String inputEditApplyDays) {
		this.inputEditApplyDays = inputEditApplyDays;
	}

	public void setInputInit(String inputInit) {
		this.inputInit = inputInit;
	}

	public void setInputEditInit(String inputEditInit) {
		this.inputEditInit = inputEditInit;
	}

	public String getSelectedUserIds() {
		return selectedUserIds;
	}

	public void setSelectedUserIds(String selectedUserIds) {
		this.selectedUserIds = selectedUserIds;
	}

	public String getInputEditInit() {
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			this.selectedUserIds = null;
			this.selectPersonNames = null;
			this.inputEditBeginDate = null;
			this.inputEditEndDate = null;
			this.inputEditApplyDays = null;
			this.inputEditApplyDays = null;
		}
		this.createType = "1";
		doQuery();
		return null;
	}

	public void selPerson() {
		if (this.selectedUserIds != null && !"".equals(this.selectedUserIds)) {
			String[] userIDs = this.selectedUserIds.split(",");
			for (int i = 0; i < userIDs.length; i++) {
				PersonBO p = SysCacheTool.findPersonById(userIDs[i]);
				this.selectPersonNames = p.getName();
				if (i != userIDs.length) {
					this.selectPersonNames += ",";
				}
			}
		}
	}

	public String saveInput() {
		if (this.selectedUserIds != null && !"".equals(this.selectedUserIds)) {
			String[] userIDs = this.selectedUserIds.split(",");
			for (int i = 0; i < userIDs.length; i++) {				
				leaveBo.setPersonId(userIDs[i]);
				leaveBo.setApplyTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
				leaveBo.setCreateType("1");
				leaveBo.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
				try {
					AttLeaveBO bo = new AttLeaveBO();
					bo.setPersonId(userIDs[i]);
					bo.setBeginTime(leaveBo.getBeginTime());
					bo.setEndTime(leaveBo.getEndTime());
					bo.setApplyDays(Double.valueOf(leaveBo.getApplyDays()));
					bo.setApplyTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
					bo.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
					bo.setReason(leaveBo.getReason());
					bo.setCreateType("1");
					bo.setLeaveType(leaveBo.getLeaveType());
					
					if("2".equals(bo.getLeaveType())){
						this.attBusiService.saveBingjia(bo);
					}else{
						this.attBusiService.updateLeaveDays(leaveBo.getLeaveType(), String.valueOf(leaveBo.getApplyDays()), userIDs[i]);
						attBusiService.saveAttLeaveBO(bo);
					}
				} catch (SysException e) {
					e.printStackTrace();
				}			
			}
		}
		return "success";
	}
	
	public void deleteInput() {
		try {
			this.attBusiService.deleteInputLeave(this.operItemID);
			
		} catch (SysException e) {
			super.showMessageDetail("删除失败");
			e.printStackTrace();
		}
	}

	public String getCreateType() {
		return createType;
	}

	public void setCreateType(String createType) {
		this.createType = createType;
	}

	// 补录
	public String getInputInit() {
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			this.orgID = null;
			this.nameStr = null;
			this.personType = null;
			this.beginDate = null;
			this.endDate = null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if (orgID1 != null && !"".equals(orgID1)) {
			this.orgID = orgID1;
		}
		this.querySelf = false;
		this.selAudited = true;
		this.createType = "1";
		doQuery();
		return inputInit;
	}

	// 查询
	public String getQueryInit() {
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			this.orgID = null;
			this.nameStr = null;
			this.personType = null;
			this.beginDate = null;
			this.endDate = null;
			this.selMyAtt=false;
			this.selApply = true;
			this.selAuditing = true;
			this.selAudited = true;
			this.selRefuse = true;
			this.inself=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if (orgID1 != null && !"".equals(orgID1)) {
			this.orgID = orgID1;
		}
		String inself1 = super.getRequestParameter("inself");
		if(inself1!=null && !"".equals(inself1)){
			this.inself=inself1;
		}
		this.querySelf = false;
		try {
			int role = CommonUtil.getRoleCount("07", user.getUserId());
			if(role>0){
				this.ismanager="1";
			}else{
				this.ismanager=null;
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		doQuery();
		this.userId=user.getUserId();
		return queryInit;
	}

	public UserAPI getUserapi() {
		return userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}

	public void setQueryInit(String queryInit) {
		this.queryInit = queryInit;
	}

	public boolean isQuerySelf() {
		return querySelf;
	}

	public void setQuerySelf(boolean querySelf) {
		this.querySelf = querySelf;
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

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getNameStr() {
		return nameStr;
	}

	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public SelPersonsToolService getSelPersonsTool() {
		return selPersonsTool;
	}

	public void setSelPersonsTool(SelPersonsToolService selPersonsTool) {
		this.selPersonsTool = selPersonsTool;
	}

	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}

	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}

	public void deleteLeave() {
		try {
			this.attBusiService.deleteLeave(leaveId);
			super.showMessageDetail("操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
	}

	/**
	 * 重新报批
	 */
	public void applyLeave() {
		try {
			AttLeaveBO bo = this.attBusiService.findAttLeaveBOById(this.leaveId);
			this.attBusiService.deleteBO(AttLeaveBO.class, bo.getId());
			String keyId = "";// 流程key
			String postLevel = this.selPersonsTool.getPostLevel(bo.getPersonId());// 岗位级别
			if (postLevel != null && !postLevel.equals("")) {
				keyId = AttConstants.getAttFlowKey(postLevel);// 流程KEY
				if (keyId != null && !keyId.equals("")) {

					// 为流程配置参数
					int leaderType = this.selPersonsTool.getLeaderType(bo.getPersonId());
					Map map = new HashMap();
					map.put("proposerId", bo.getPersonId());
					map.put("currPersonId", bo.getPersonId());
					map.put("leaderType", leaderType);
					map.put("leaveDays", bo.getApplyDays());
					bo.setStatus(AttConstants.STATUS_AUDIT);
					bo.setId(null);
					this.attBusiService.saveOrUpdateBO(bo);
					// 启动流程
					String instanceId = this.activitiToolService.startProcessInstance(keyId, bo.getId(), map);
					bo.setProcessId(instanceId);
					this.attBusiService.saveAttLeaveBO(bo);
				} else {
					super.showMessageDetail("岗位等级未设置流程！");
				}
			} else {
				   super.showMessageDetail("没有岗位等级，无法进入请假流程！");
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败" + e.getMessage());
		}
		super.showMessageDetail("重新报批完成");
	}

	public String getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(String leaveId) {
		this.leaveId = leaveId;
	}

	public List getLeaveTypeList() {
		return AttConstants.getLeaveType();
	}

	public void setLeaveTypeList(List leaveTypeList) {
		this.leaveTypeList = leaveTypeList;
	}

	public void qryMyAtt(ValueChangeEvent event) {
		selMyAtt = event.getNewValue().toString().equals("true");
	}
	
	public void qryApply(ValueChangeEvent event) {
		selApply = event.getNewValue().toString().equals("true");
	}

	public void qryAuditing(ValueChangeEvent event) {
		selAuditing = event.getNewValue().toString().equals("true");
	}

	public void qryAudited(ValueChangeEvent event) {
		selAudited = event.getNewValue().toString().equals("true");
	}

	public void qryRefuse(ValueChangeEvent event) {
		selRefuse = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave1(ValueChangeEvent event) {
		this.selLeave1 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave2(ValueChangeEvent event) {
		this.selLeave2 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave3(ValueChangeEvent event) {
		this.selLeave3 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave4(ValueChangeEvent event) {
		this.selLeave4 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave5(ValueChangeEvent event) {
		this.selLeave5 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave6(ValueChangeEvent event) {
		this.selLeave6 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave7(ValueChangeEvent event) {
		this.selLeave7 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave8(ValueChangeEvent event) {
		this.selLeave8 = event.getNewValue().toString().equals("true");
	}
	
	public void qryLeave9(ValueChangeEvent event) {
		this.selLeave9 = event.getNewValue().toString().equals("true");
	}

	public boolean getSelApply() {
		return selApply;
	}

	public void setSelApply(boolean selApply) {
		this.selApply = selApply;
	}

	public boolean getSelAuditing() {
		return selAuditing;
	}

	public void setSelAuditing(boolean selAuditing) {
		this.selAuditing = selAuditing;
	}

	public boolean getSelAudited() {
		return selAudited;
	}

	public void setSelAudited(boolean selAudited) {
		this.selAudited = selAudited;
	}

	public boolean getSelRefuse() {
		return selRefuse;
	}

	public void setSelRefuse(boolean selRefuse) {
		this.selRefuse = selRefuse;
	}

	public String first() {
		mypage.setCurrentPage(1);
		return null;
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return null;
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return null;
	}

	public void doQuery() {
		try {
			List sList = new ArrayList();
			if (selAuditing) {
				sList.add(AttConstants.STATUS_AUDIT);
			}
			if (selAudited) {
				sList.add(AttConstants.STATUS_AUDIT_SUCCES);
			}
			if (selRefuse) {
				sList.add(AttConstants.STATUS_AUDIT_LOSE);
			}
			String[] status = new String[sList.size()];
			if (sList != null && sList.size() > 0) {
				for (int i = 0; i < sList.size(); i++) {
					status[i] = (String) sList.get(i);
				}
			}
			
			List lList = new ArrayList();
			if (this.selLeave1) {
				lList.add("1");
			}
			if (this.selLeave2) {
				lList.add("2");
			}
			if (this.selLeave3) {
				lList.add("3");
			}
			if (this.selLeave4) {
				lList.add("4");
			}
			if (this.selLeave5) {
				lList.add("5");
			}
			if (this.selLeave6) {
				lList.add("6");
			}
			if (this.selLeave7) {
				lList.add("7");
			}
			if (this.selLeave8) {
				lList.add("8");
			}
			if (this.selLeave9) {
				lList.add("9");
			}
			String[] lTypes = new String[lList.size()];
			if (lList != null && lList.size() > 0) {
				for (int i = 0; i < lList.size(); i++) {
					lTypes[i] = (String) lList.get(i);
				}
			}

			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (this.personType == null || "".equals(this.personType)) {
				this.personType=CommonUtil.getAllPersonTypes(user);
			}
			String userID = null;
			if (querySelf) {
				userID = user.getUserId();
			}
			list = attBusiService.getAttLeaveBO(mypage, userID, status,
					beginDate, endDate, orgID, personType, nameStr, createType, this.inself, this.ismanager, user.getUserId(), this.selMyAtt, lTypes);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					AttLeaveBO bo = (AttLeaveBO) list.get(i);
					PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
					bo.setPersonName(p.getName());
					bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
							p.getDeptId()));
					bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
					bo.setPersonCode(p.getPersonCode());
					int count = CommonUtil.getAttLogCount(bo.getId());
					if(count>0){
						bo.setAppro(true);
					}
					list.set(i, bo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	// 请假申请
	private String initEdit;
	private AttLeaveBO leaveBo;
	private String personName;
	private String personId;

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String saveLeave() {
		try {
			leaveBo.setPersonId(personId);
			leaveBo.setApplyTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			if ("1".equals(createType)) {
				leaveBo.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
			} else if (leaveBo.getStatus() == null
					|| leaveBo.getStatus().equals("")) {
				leaveBo.setStatus(AttConstants.STATUS_APPLY);
			}
			attBusiService.saveAttLeaveBO(leaveBo);
			this.leaveId=leaveBo.getId();
			this.attBusiService.applyLeave(user.getUserId(),this.leaveId);
			this.leaveBo=null;
			this.toLeave="1";
			return "successleave";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("new") != null) {
				leaveBo = new AttLeaveBO();
			} else if (super.getRequestParameter("leaveId") != null) {
				leaveId = super.getRequestParameter("leaveId");
				leaveBo = this.attBusiService.findAttLeaveBOById(leaveId);
			}
			if(leaveBo==null){
				leaveBo = new AttLeaveBO();
			}
			
			if (leaveBo.getPersonId() != null
					&& !leaveBo.getPersonId().equals("")) {
				personId = leaveBo.getPersonId();
				personName = SysCacheTool.findPersonById(leaveBo.getPersonId())
						.getName();
			} else {
				personId = user.getUserId();
				personName = user.getName();
			}
			
			// 获得带薪假存休子集的数据
			List list = this.attBusiService.getDays(personId);
			this.undoneDays=this.attBusiService.getUndoneDays(personId);
			Map<String, Object> map = (Map<String, Object>) list.get(0);
			this.days = map;
			
			//设置请假类型
			this.leaveTypeList1=new ArrayList();
			SelectItem si1=new SelectItem();
			si1.setLabel("正常请假");
			si1.setValue("1");
			SelectItem si2=new SelectItem();
			si2.setLabel("病假");
			si2.setValue("2");
			SelectItem si3=new SelectItem();
			si3.setLabel("婚假");
			si3.setValue("3");
			SelectItem si4=new SelectItem();
			si4.setLabel("丧假");
			si4.setValue("4");
			SelectItem si7=new SelectItem();
			si7.setLabel("带薪事假");
			si7.setValue("7");
			this.leaveTypeList1.add(si1);
			this.leaveTypeList1.add(si2);
			this.leaveTypeList1.add(si3);
			this.leaveTypeList1.add(si4);
			this.leaveTypeList1.add(si7);
			if("01002".equals(user.getSex())){
				SelectItem si5=new SelectItem();
				si5.setLabel("产假");
				si5.setValue("5");
				SelectItem si6=new SelectItem();
				si6.setLabel("难产产假");
				si6.setValue("6");
				SelectItem si8=new SelectItem();
				si8.setLabel("流产产假");
				si8.setValue("8");
				SelectItem si9=new SelectItem();
				si9.setLabel("双胞胎产假");
				si9.setValue("9");
				this.leaveTypeList1.add(si5);
				this.leaveTypeList1.add(si6);
//				this.leaveTypeList1.add(si8);
//				this.leaveTypeList1.add(si9);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public AttLeaveBO getLeaveBo() {
		return leaveBo;
	}

	public void setLeaveBo(AttLeaveBO leaveBo) {
		this.leaveBo = leaveBo;
	}

	// 查看审批流程
	private String initLog;
	private List logList;

	public void queryLog() {
		try {
			String distanceId = "";
			AttLeaveBO lbo = this.attBusiService.findAttLeaveBOById(leaveId);
			if (lbo.getProcessId() != null && !lbo.getProcessId().equals("")) {
				distanceId = lbo.getProcessId();
			}
			super.getHttpSession().setAttribute("distanceId", distanceId);
			logList = attBusiService.getAttLogBOById(leaveId);
			if (logList != null && logList.size() > 0) {
				for (int i = 0; i < logList.size(); i++) {
					AttLogBO log = (AttLogBO) logList.get(i);
					log.setPersonId(SysCacheTool.findPersonById(
							log.getPersonId()).getName());
					logList.set(i, log);
				}
			}
			if(!"4".equals(lbo.getStatus())){
				List<String> userIDs = this.activitiToolService
						.getOwners(distanceId);
				if (userIDs != null && userIDs.size() > 0) {
					String[] userIDs2 = new String[userIDs.size()];
					for (int i = 0; i < userIDs.size(); i++) {
						userIDs2[i] = userIDs.get(i);
					}
					this.currApproverList = this.attBusiService
							.getAllCurrApprover(userIDs2);
					if (this.currApproverList != null) {
						for (UserBO bo : currApproverList) {
							PersonBO p = SysCacheTool
									.findPersonById(bo.getUserID());
							bo.setSecondDeptName(CodeUtil.interpertCode(bo.getSecDeptID()));
							bo.setDeptName(CodeUtil.interpertCode(
									CodeUtil.TYPE_ORG, p.getDeptId()));
							bo.setPersonType(CodeUtil.interpertCode(p
									.getPersonType()));
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitLog() {
		this.currApproverList=new ArrayList();
		if (super.getRequestParameter("leaveId") != null) {
			leaveId = super.getRequestParameter("leaveId");
		}
		queryLog();
		return initLog;
	}

	public void setInitLog(String initLog) {
		this.initLog = initLog;
	}

	public List getLogList() {
		return logList;
	}

	public void setLogList(List logList) {
		this.logList = logList;
	}

	public String leaveBack() {
		try {
			this.attBusiService
					.updateLeaveBackDate(this.leaveId, leaveBackDate);
		} catch (SysException e) {
			
			e.printStackTrace();
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
		super.showMessageDetail("操作成功");
		return "success";
	}
	public String getSelectPersonId() {
		return selectPersonId;
	}
	public void setSelectPersonId(String selectPersonId) {
		this.selectPersonId = selectPersonId;
	}
	
}
