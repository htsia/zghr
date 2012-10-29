package com.hr319wg.custom.attence.pojo.bo;

public class AttLogBO {
	private String logId;
	private String leaveId;
	private String personId;
	private String auditResult;
	private String auditTime;
	private String auditxplan;
	
	public String getAuditxplan() {
		return auditxplan;
	}
	public void setAuditxplan(String auditxplan) {
		this.auditxplan = auditxplan;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
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
	public String getAuditResult() {
		return auditResult;
	}
	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}
	
	public String getAuditTime() {
		return auditTime;
	}
	public void setAuditTime(String auditTime) {
		this.auditTime = auditTime;
	}
	
}
