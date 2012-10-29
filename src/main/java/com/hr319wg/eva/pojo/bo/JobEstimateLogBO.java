package com.hr319wg.eva.pojo.bo;

public class JobEstimateLogBO {
	private String logID;
	private String itemID;
	private String operateID;
	private String action;
	private String actionDate;
	private String actionDes;
	
	public String getActionDes() {
		if("0".equals(action)){
			actionDes="起草";
		}else if("1".equals(action)){
			actionDes="报批";
		}else if("2".equals(action)){
			actionDes="批准";
		}else if("3".equals(action)){
			actionDes="申请修改";
		}else if("4".equals(action)){
			actionDes="修改";
		}else if("5".equals(action)){
			actionDes="申请修改内容";
		}else if("6".equals(action)){
			actionDes="同意修改内容";
		}else if("7".equals(action)){
			actionDes="打分";
		}else if("8".equals(action)){
			actionDes="打分结束";
		}
		return actionDes;
	}
	public void setActionDes(String actionDes) {
		this.actionDes = actionDes;
	}
	public String getLogID() {
		return logID;
	}
	public void setLogID(String logID) {
		this.logID = logID;
	}
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	public String getOperateID() {
		return operateID;
	}
	public void setOperateID(String operateID) {
		this.operateID = operateID;
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
}
