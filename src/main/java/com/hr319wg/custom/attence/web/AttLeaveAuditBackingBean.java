package com.hr319wg.custom.attence.web;

import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.attence.pojo.bo.AttLeaveBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.attence.util.AttConstants;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;

public class AttLeaveAuditBackingBean extends BaseBackingBean {
	private ActivitiToolsService activitiToolService;
	private String initAudit;
	private List leaveList;
	private List leaveTypeList;
	private IAttBusiService attBusiService;

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

	public List getLeaveTypeList() {
		return AttConstants.getLeaveType();
	}

	public void setLeaveTypeList(List leaveTypeList) {
		this.leaveTypeList = leaveTypeList;
	}

	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}

	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}

	public void queryAuditTask() {
		try {
			this.leaveList = attBusiService.queryLeaveAuditTask(super.getUserInfo().getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitAudit() {
		queryAuditTask();
		return null;
	}

	public List getLeaveList() {
		return leaveList;
	}

	public void setLeaveList(List leaveList) {
		this.leaveList = leaveList;
	}

	// 审批
	private String initAuditEdit;
	private String leaveId;
	private String taskId;
	private String result;
	private String reason;

	/**
	 * 请假审批（流程已经启动）
	 * 
	 * @return
	 */
	public String saveAudit() {

		try {
			AttLeaveBO leave=this.attBusiService.findAttLeaveBOById(leaveId);
			this.attBusiService.saveAudit(result, leave, reason, taskId,
					super.getUserInfo().getUserId());
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
		return null;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(String leaveId) {
		this.leaveId = leaveId;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getInitAuditEdit() {
		if (super.getRequestParameter("taskId") != null) {
			taskId = super.getRequestParameter("taskId");
		}
		if (super.getRequestParameter("leaveId") != null) {
			leaveId = super.getRequestParameter("leaveId");
		}
		return null;
	}
	

}
