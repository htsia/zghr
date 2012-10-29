package com.hr319wg.custom.attence.pojo.bo;

import com.hr319wg.custom.attence.util.AttConstants;

public class AttRestBO implements Comparable<AttRestBO>{
	
	private String Id;
	private String personId;
	private String beginTime;
	private String endTime;
	private String applyDays;
	private String reason;
	private String applyTime;
	private String status;
	private String processId;
	private String statusDes;
	private String personName;
	private String taskId;
	private String createType="0"; //0申请 1录入
	private String personType;
	private String personCode;
	private String deptName;
	
	public String getPersonCode() {
		return personCode;
	}
	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getCreateType() {
		return createType;
	}
	public void setCreateType(String createType) {
		this.createType = createType;
	}
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getStatusDes() {
		if(AttConstants.STATUS_APPLY.equals(status)){
			statusDes="申请";
		}else if(AttConstants.STATUS_AUDIT.equals(status)){
			statusDes="报批";
		}else if(AttConstants.STATUS_AUDIT_SUCCES.equals(status)){
			statusDes="批准";
		}else if(AttConstants.STATUS_AUDIT_LOSE.equals(status)){
			statusDes="退回";
		}
		return statusDes;
	}
	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}
	
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getApplyDays() {
		return applyDays;
	}
	public void setApplyDays(String applyDays) {
		this.applyDays = applyDays;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getProcessId() {
		return processId;
	}
	public void setProcessId(String processId) {
		this.processId = processId;
	}
	public String getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}
	@Override
	public int compareTo(AttRestBO o) {
		return o.getApplyTime().compareTo(this.applyTime);
	}
	
}
