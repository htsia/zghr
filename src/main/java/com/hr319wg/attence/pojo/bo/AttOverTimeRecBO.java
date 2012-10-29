package com.hr319wg.attence.pojo.bo;

public class AttOverTimeRecBO {
    //加班类型：1 延时加班 2 双休日加班 3节假日加班
    public static final String OVERTIME_TYPE_ONWORK="1";
    public static final String OVERTIME_TYPE_ONRESTOFWOK="2";
    public static final String OVERTIME_TYPE_ONFEAST="3";

	private String overTimeNO; // 标示
	private String personID; // 加班申请人
	private String personName;
	private String orgID;
	private String applyDate; // 申请时间
	private String beginTime; // 开始时间
	private String endTime; // 结束时间
	private String reason; // 事由
	private String deptAuditResult; // 部门意见
	private String deptAuditOper; // 部门审批人
	private String deptAuditDate; // 部门审批时间
	private String deptAuditCause; // 部门审批说明
	private String deptAuditCausevalue;
	private String leaderAuditResult; // 领导意见
	private String leaderAuditOper; // 审批人
	private String leaderAuditDate; // 审批日期
	private String leaderAuditCause; // 审批说明
	private String leaderAuditCausevalue;
	private String hrAuditResult; // HR意见
	private String hrAuditOper; // HR审批人
	private String hrAuditDate; // HR审批时间
	private String hrAuditCause; // HR审批说明
	private String hrAuditResultvalue;
	private String hileaderAuditResult; // 总监意见
	private String hileaderAuditOper; // 总监审批人
	private String hileaderAuditDate; // 总监审批时间
	private String hileaderAuditCause; // 总监审批说明
	private String hileaderAuditResultvalue;
	private String manAuditResult; // 总经理意见
	private String manAuditOper; // 总经理审批人
	private String manAuditDate; // 总经理审批时间
	private String manAuditCause; // 总经理审批说明
	private String manAuditResultvalue;
	private String lastDate; //加班天数
	private String statusValue; //审批状态值 0报批 1审批通过 2退回
	private String flagvalue;
	private String typeStatus; //1 延时加班 2 双休日加班 3节假日加班
	private String typeStatusName;
    private String superFurloughNo;

    public String getSuperFurloughNo() {
        return superFurloughNo;
    }

    public void setSuperFurloughNo(String superFurloughNo) {
        this.superFurloughNo = superFurloughNo;
    }

	public String getOverTimeNO() {
		return overTimeNO;
	}
	public void setOverTimeNO(String overTimeNO) {
		this.overTimeNO = overTimeNO;
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
	public String getLeaderAuditResult() {
		return leaderAuditResult;
	}
	public void setLeaderAuditResult(String leaderAuditResult) {
		this.leaderAuditResult = leaderAuditResult;
	}
	public String getLeaderAuditOper() {
		return leaderAuditOper;
	}
	public void setLeaderAuditOper(String leaderAuditOper) {
		this.leaderAuditOper = leaderAuditOper;
	}
	public String getLeaderAuditDate() {
		return leaderAuditDate;
	}
	public void setLeaderAuditDate(String leaderAuditDate) {
		this.leaderAuditDate = leaderAuditDate;
	}
	public String getLeaderAuditCause() {
		return leaderAuditCause;
	}
	public void setLeaderAuditCause(String leaderAuditCause) {
		this.leaderAuditCause = leaderAuditCause;
	}
	public String getLeaderAuditCausevalue() {
		return leaderAuditCausevalue;
	}
	public void setLeaderAuditCausevalue(String leaderAuditCausevalue) {
		this.leaderAuditCausevalue = leaderAuditCausevalue;
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
	public String getHileaderAuditResult() {
		return hileaderAuditResult;
	}
	public void setHileaderAuditResult(String hileaderAuditResult) {
		this.hileaderAuditResult = hileaderAuditResult;
	}
	public String getHileaderAuditOper() {
		return hileaderAuditOper;
	}
	public void setHileaderAuditOper(String hileaderAuditOper) {
		this.hileaderAuditOper = hileaderAuditOper;
	}
	public String getHileaderAuditDate() {
		return hileaderAuditDate;
	}
	public void setHileaderAuditDate(String hileaderAuditDate) {
		this.hileaderAuditDate = hileaderAuditDate;
	}
	public String getHileaderAuditCause() {
		return hileaderAuditCause;
	}
	public void setHileaderAuditCause(String hileaderAuditCause) {
		this.hileaderAuditCause = hileaderAuditCause;
	}
	public String getHileaderAuditResultvalue() {
		return hileaderAuditResultvalue;
	}
	public void setHileaderAuditResultvalue(String hileaderAuditResultvalue) {
		this.hileaderAuditResultvalue = hileaderAuditResultvalue;
	}
	public String getManAuditResult() {
		return manAuditResult;
	}
	public void setManAuditResult(String manAuditResult) {
		this.manAuditResult = manAuditResult;
	}
	public String getManAuditOper() {
		return manAuditOper;
	}
	public void setManAuditOper(String manAuditOper) {
		this.manAuditOper = manAuditOper;
	}
	public String getManAuditDate() {
		return manAuditDate;
	}
	public void setManAuditDate(String manAuditDate) {
		this.manAuditDate = manAuditDate;
	}
	public String getManAuditCause() {
		return manAuditCause;
	}
	public void setManAuditCause(String manAuditCause) {
		this.manAuditCause = manAuditCause;
	}
	public String getManAuditResultvalue() {
		return manAuditResultvalue;
	}
	public void setManAuditResultvalue(String manAuditResultvalue) {
		this.manAuditResultvalue = manAuditResultvalue;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
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
	public String getTypeStatus() {
		return typeStatus;
	}
	public void setTypeStatus(String typeStatus) {
		this.typeStatus = typeStatus;
	}
	public String getTypeStatusName() {
		return typeStatusName;
	}
	public void setTypeStatusName(String typeStatusName) {
		this.typeStatusName = typeStatusName;
	}
	
}
