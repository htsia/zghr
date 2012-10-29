package com.hr319wg.eva.pojo.bo;

public class EvaTaskEstimateLogBO {
	
	private String logId;
	private String masterId;
	private String operId;
	private String action;
	private String actionDate;
	private String content;
	private String actionDes;
	
	public String getActionDes() {
		if(EvaTaskMasterBO.EVA_TaskMaster_SCRIPT.equals(action)){
			actionDes="起草";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPROVING.equals(action)){
			actionDes="报批";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPROVED.equals(action)){
			actionDes="批准";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPLAYMOD.equals(action)){
			actionDes="申请修改";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPROVEDMOD.equals(action)){
			actionDes="修改";
		}
		return actionDes;
	}
	public void setActionDes(String actionDes) {
		this.actionDes = actionDes;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public String getOperId() {
		return operId;
	}
	public void setOperId(String operId) {
		this.operId = operId;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getActionDate() {
		return actionDate;
	}
	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
