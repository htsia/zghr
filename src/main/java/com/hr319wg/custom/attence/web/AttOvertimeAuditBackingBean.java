package com.hr319wg.custom.attence.web;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.attence.pojo.bo.AttOvertimeBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;

public class AttOvertimeAuditBackingBean extends BaseBackingBean {
	private IAttBusiService attBusiService;
	private ActivitiToolsService activitiToolService;
	private String initAudit;
	private List list;
	private String selectedItemIDs;
	
	public String getSelectedItemIDs() {
		return selectedItemIDs;
	}

	public void setSelectedItemIDs(String selectedItemIDs) {
		this.selectedItemIDs = selectedItemIDs;
	}
	
	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public void setInitAudit(String initAudit) {
		this.initAudit = initAudit;
	}

	public void setInitAuditEdit(String initAuditEdit) {
		this.initAuditEdit = initAuditEdit;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}
	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}
	public void queryAuditTask(){
		try{
			list= attBusiService.queryOvertimeAuditTask(super.getUserInfo().getUserId());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitAudit() {
		queryAuditTask();
		return null;
	}
	
	//审批
	private String initAuditEdit;
	private String id;
	private String taskId;
	private String result;
	private String reason;
	
	public String saveAudit(){
		try {
			AttOvertimeBO bo1= (AttOvertimeBO)attBusiService.findBOById(AttOvertimeBO.class, id);
			this.attBusiService.saveOvertimeAudit(result, bo1, reason, taskId,
					super.getUserInfo().getUserId());
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
		return null;
	}
	
	/**
	 * 批量审批
	 * 
	 * @return
	 */
	public void batchOvertimeAudit() {
		try {
			this.attBusiService.batchOvertimeAudit(this.selectedItemIDs, this.result, null, super.getUserInfo().getUserId());
			super.showMessageDetail("审批完成");
		} catch (SysException e) {
			super.showMessageDetail("审批失败");
			e.printStackTrace();
		}
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getInitAuditEdit() {
		if(super.getRequestParameter("taskId")!=null){
			taskId=super.getRequestParameter("taskId");
		}
		if(super.getRequestParameter("id")!=null){
			id=super.getRequestParameter("id");
		}
		return null;
	}

}
