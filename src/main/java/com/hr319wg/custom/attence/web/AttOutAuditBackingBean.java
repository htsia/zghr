package com.hr319wg.custom.attence.web;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.attence.pojo.bo.AttOutBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;

public class AttOutAuditBackingBean extends BaseBackingBean {
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
			list=attBusiService.queryOutAuditTask(super.getUserInfo().getUserId());
			
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
			AttOutBO bo1= (AttOutBO)attBusiService.findBOById(AttOutBO.class, id);
			this.attBusiService.saveOutAudit(result, bo1, reason, taskId,
					super.getUserInfo().getUserId());
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
		return null;
//		try{
//			AttLogBO bo=new AttLogBO();
//			if(result!=null&&!result.equals("")){
//				AttOutBO bo1= (AttOutBO)attBusiService.findBOById(AttOutBO.class, id);
//				Map map=new HashMap();
//				if(result.equals("1")){
//					map.put("doAudit", new Boolean(true));
//				}else{
//					map.put("doAudit", new Boolean(false));
//					bo1.setStatus(AttConstants.STATUS_AUDIT_LOSE);
//				}
//				this.activitiToolService.completeTask(taskId, map);
//				if(this.activitiToolService.checkProcessIsFinish(bo1.getProcessId())){
//					bo1.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
//				}
//				attBusiService.saveOrUpdateBO(bo1);
//				
//				bo.setAuditTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
//				bo.setLeaveId(id);
//				bo.setPersonId(super.getUserInfo().getUserId());
//				bo.setAuditResult(result);
//				bo.setAuditxplan(reason);
//				this.attBusiService.saveAttLeaveLogBO(bo);
//				
//			}
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return "success";
	}
	
	/**
	 * 批量审批
	 * 
	 * @return
	 */
	public void batchOutAudit() {
		try {
			this.attBusiService.batchOutAudit(this.selectedItemIDs, this.result, null, super.getUserInfo().getUserId());
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
