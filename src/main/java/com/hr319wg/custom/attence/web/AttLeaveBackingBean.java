package com.hr319wg.custom.attence.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import org.activiti.engine.task.Task;

import com.hr319wg.common.exception.SysException;
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
	// 浏览申请
	private String pageInit;
	private List list;
	private PageVO mypage = new PageVO();
	private boolean selApply = true;
	private boolean selAuditing = true;
	private boolean selAudited;
	private boolean selRefuse = true;
	private List leaveTypeList;
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
	private String personSex="male";//默认男性
	private String userId;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPersonSex() {
		return personSex;
	}

	public void setPersonSex(String personSex) {
		this.personSex = personSex;
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
					attBusiService.saveAttLeaveBO(bo);
					
					this.attBusiService.updateLeaveDays(leaveBo.getLeaveType(), String.valueOf(leaveBo.getApplyDays()), userIDs[i]);
				} catch (SysException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}			
			}
		}
		return "success";
	}
	
	public void deleteInput() {
		try {
			this.attBusiService.deleteBO(AttLeaveBO.class, this.operItemID);
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
			int role = CommonUtil.getRoleCount("07", super.getUserInfo().getUserId());
			if(role>0){
				this.ismanager="1";
			}else{
				this.ismanager=null;
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		doQuery();
		this.userId=super.getUserInfo().getUserId();
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
	 * 请假流程启动
	 */
	public void applyLeave() {
		try {
			String keyId = "";// 流程key
			String postLevel = this.selPersonsTool.getPostLevel(super
					.getUserInfo().getUserId());// 岗位级别
			if (postLevel != null && !postLevel.equals("")) {
				keyId = AttConstants.getAttFlowKey(postLevel);// 流程KEY
				if (keyId != null && !keyId.equals("")) {

					// 为流程配置参数
					int leaderType = selPersonsTool.getLeaderType(super
							.getUserInfo().getUserId());
					AttLeaveBO bo = this.attBusiService
							.findAttLeaveBOById(leaveId);
					Map map = new HashMap();
					map.put("proposerId", super.getUserInfo().getUserId());
					map.put("currPersonId", super.getUserInfo().getUserId());
					map.put("leaderType", leaderType);
					map.put("leaveDays", bo.getApplyDays());
					
					
					//启动流程
					String instanceId = this.activitiToolService
							.startProcessInstance(keyId, leaveId, map);
					// 设置请假单状态,关联的流程实例ID
					bo.setStatus(AttConstants.STATUS_AUDIT);
					bo.setProcessId(instanceId);
					attBusiService.saveAttLeaveBO(bo);
				} else {
					super.showMessageDetail("您的岗位等级未设置流程！");
				}
			} else {
				super.showMessageDetail("您没有岗位等级，无法进入请假流程！");
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			super.showMessageDetail("请假天数必须为>0的数字");
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败！" + e.getMessage());
		}
		//return "successleave";
	}

	/**
	 * 重新报批，重点更改流程状态
	 */
	public void applyLeaveAgin() {
		try {
			AttLeaveBO bo = this.attBusiService.findAttLeaveBOById(leaveId);
			Task task = this.activitiToolService.getTaskByInstanceId(bo
					.getProcessId());
			Map map = new HashMap();
			map.put("currPersonId", super.getUserInfo().getUserId());
			activitiToolService.completeTask(task.getId(), map);
			bo.setStatus(AttConstants.STATUS_AUDIT);
			attBusiService.saveAttLeaveBO(bo);
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
	}

	public void cancelApply() {
		try {
			AttLeaveBO bo = this.attBusiService.findAttLeaveBOById(leaveId);
			Task task = this.activitiToolService.getTaskByInstanceId(bo
					.getProcessId());
			Map map = new HashMap();
			map.put("reApplay", new Boolean(true));
			activitiToolService.completeTask(task.getId(), map);
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
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
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return "";
	}

	public void doQuery() {
		try {
			List sList = new ArrayList();
			if (selApply) {
				sList.add(AttConstants.STATUS_APPLY);
			}
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

			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (this.personType == null || "".equals(this.personType)) {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			}
			String userID = null;
			if (querySelf) {
				userID = super.getUserInfo().getUserId();
			}
			list = attBusiService.getAttLeaveBO(mypage, userID, status,
					beginDate, endDate, orgID, personType, nameStr, createType, this.inself, this.ismanager, super.getUserInfo().getUserId());
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

	// 请假编辑
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
			this.attBusiService.applyLeave(super.getUserInfo().getUserId(),this.leaveId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.leaveBo=null;
		this.toLeave="1";
		return "successleave";
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
				personId = super.getUserInfo().getUserId();
				personName = super.getUserInfo().getName();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 获得带薪假存休子集的数据
		try {
			List list = this.attBusiService.getDays(personId);
			this.undoneDays=this.attBusiService.getUndoneDays(personId);
			this.personSex=SysCacheTool.findPersonById(personId).getSex();//获得员工性别
			if("01001".equals(this.personSex)){
				this.personSex="male";//男员工
			}
			if("01002".equals(this.personSex)){
				this.personSex="female";//女员工
			}
			Map<String, Object> map = (Map<String, Object>) list.get(0);
			this.days = map;
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		super.showMessageDetail("操作成功");
		return "success";
	}

}
