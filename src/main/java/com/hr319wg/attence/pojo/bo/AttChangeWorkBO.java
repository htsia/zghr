package com.hr319wg.attence.pojo.bo;

public class AttChangeWorkBO {
	private String changeID; // 标示
	private String personID; // 换班人员
	private String personName;
	private String orgID;
	private String applyDate; // 换班日期
	private String oldClass; // 原班组     //状态值  ""未设   1休息  2节假日 3公休日
	private String oldClassName;
	private String newClass; // 新班组    //状态值  ""未设   1休息  2节假日 3公休日
	private String newClassName;
	private String deptAuditResult; // 部门意见
	private String deptAuditOper; // 部门审批人
	private String deptAuditDate; // 部门审批时间
	private String deptAuditCause; // 部门审批说明
	private String deptAuditCausevalue;
	private String hrAuditResult; // HR意见
	private String hrAuditOper; // HR审批人
	private String hrAuditDate; // HR审批时间
	private String hrAuditCause; // HR审批说明
	private String hrAuditResultvalue;
	private String statusValue; //审批状态值 0报批 1审批通过 2退回
	private String flagvalue;
	public String getChangeID() {
		return changeID;
	}
	public void setChangeID(String changeID) {
		this.changeID = changeID;
	}
	public String getPersonID() {
		return personID;
	}
	public void setPersonID(String personID) {
		this.personID = personID;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getOldClass() {
		return oldClass;
	}
	public void setOldClass(String oldClass) {
		this.oldClass = oldClass;
	}
	public String getNewClass() {
		return newClass;
	}
	public void setNewClass(String newClass) {
		this.newClass = newClass;
	}
	public String getDeptAuditResult() {
		return deptAuditResult;
	}
	public void setDeptAuditResult(String deptAuditResult) {
		this.deptAuditResult = deptAuditResult;
	}
	public String getDeptAuditOper() {
		return deptAuditOper;
	}
	public void setDeptAuditOper(String deptAuditOper) {
		this.deptAuditOper = deptAuditOper;
	}
	public String getDeptAuditDate() {
		return deptAuditDate;
	}
	public void setDeptAuditDate(String deptAuditDate) {
		this.deptAuditDate = deptAuditDate;
	}
	public String getDeptAuditCause() {
		return deptAuditCause;
	}
	public void setDeptAuditCause(String deptAuditCause) {
		this.deptAuditCause = deptAuditCause;
	}
	public String getDeptAuditCausevalue() {
		return deptAuditCausevalue;
	}
	public void setDeptAuditCausevalue(String deptAuditCausevalue) {
		this.deptAuditCausevalue = deptAuditCausevalue;
	}
	public String getHrAuditResult() {
		return hrAuditResult;
	}
	public void setHrAuditResult(String hrAuditResult) {
		this.hrAuditResult = hrAuditResult;
	}
	public String getHrAuditOper() {
		return hrAuditOper;
	}
	public void setHrAuditOper(String hrAuditOper) {
		this.hrAuditOper = hrAuditOper;
	}
	public String getHrAuditDate() {
		return hrAuditDate;
	}
	public void setHrAuditDate(String hrAuditDate) {
		this.hrAuditDate = hrAuditDate;
	}
	public String getHrAuditCause() {
		return hrAuditCause;
	}
	public void setHrAuditCause(String hrAuditCause) {
		this.hrAuditCause = hrAuditCause;
	}
	public String getHrAuditResultvalue() {
		return hrAuditResultvalue;
	}
	public void setHrAuditResultvalue(String hrAuditResultvalue) {
		this.hrAuditResultvalue = hrAuditResultvalue;
	}
	public String getStatusValue() {
		return statusValue;
	}
	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}
	public String getFlagvalue() {
		return flagvalue;
	}
	public void setFlagvalue(String flagvalue) {
		this.flagvalue = flagvalue;
	}
	public String getOldClassName() {
		return oldClassName;
	}
	public void setOldClassName(String oldClassName) {
		this.oldClassName = oldClassName;
	}
	public String getNewClassName() {
		return newClassName;
	}
	public void setNewClassName(String newClassName) {
		this.newClassName = newClassName;
	}
	
}
