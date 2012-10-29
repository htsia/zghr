package com.hr319wg.custom.attence.pojo.bo;

import com.hr319wg.custom.attence.util.AttConstants;

public class AttLeaveBO implements Comparable<AttLeaveBO>{
	
	private String leaveId;
	private String personId;
	private String leaveType;
	private String beginTime;
	private String endTime;
	private double applyDays;//请假单包含的实际工作日
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
	private String isBack;//1 已销假 其他 未销假
	private String leaveBackDate;//销假日期B
	private String totalDays;//请假单跨越的日子数
	
    
	
	public String getTotalDays() {
		return totalDays;
	}
	public void setTotalDays(String totalDays) {
		this.totalDays = totalDays;
	}
	public double getApplyDays() {
		return applyDays;
	}
	public void setApplyDays(double applyDays) {
		this.applyDays = applyDays;
	}
	public String getIsBack() {
		return isBack;
	}
	public void setIsBack(String isBack) {
		this.isBack = isBack;
	}
	public String getLeaveBackDate() {
		return leaveBackDate;
	}
	public void setLeaveBackDate(String leaveBackDate) {
		this.leaveBackDate = leaveBackDate;
	}
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
	public String getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(String leaveId) {
		this.leaveId = leaveId;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getLeaveType() {
		return leaveType;
	}
	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
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

	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
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
	@Override
	public int compareTo(AttLeaveBO o) {
		return o.getApplyTime().compareTo(this.applyTime);
	}
	
}
