package com.hr319wg.attence.pojo.bo;

public class AttMimicReportRecBO {
    public static final String  APPROVING="0";
    public static final String  APPROVED="1";
    public static final String  REFUSED="2";

	private String mimicReportNO; // 标示
	private String personID; // 请假人
	private String personName;
	private String orgID;
	private String mrYear; // 拟定休假年度 如：2011
	private String mrMonth; // 拟定休假时间 如：2011-01,2011-02
	private String applyDate; // 申请时间
	private String dest; // 目的地
	private String lastDate; //应享受年休假（天）
	private String deptAuditResult; // 部门意见
	private String deptAuditOper; // 部门审批人
	private String deptAuditDate; // 部门审批时间
	private String deptAuditCause; // 部门审批说明
	private String deptAuditCausevalue;
	private String leaderAuditResult; // 主管领导意见
	private String leaderAuditOper; // 主管审批人
	private String leaderAuditDate; // 主管审批日期
	private String leaderAuditCause; // 主管审批说明
	private String leaderAuditCausevalue;
	private String hrAuditResult; // HR人力资源考勤员意见
	private String hrAuditOper; // HR人力资源考勤员审批人
	private String hrAuditDate; // HR人力资源考勤员审批时间
	private String hrAuditCause; // HR人力资源考勤员审批说明
	private String hrAuditResultvalue;
	private String hrDeptAuditResult; // HR人力资源部门意见
	private String hrDeptAuditOper; // HR人力资源部门审批人
	private String hrDeptAuditDate; // HR人力资源部门审批时间
	private String hrDeptAuditCause; // HR人力资源部门审批说明
	private String hrDeptAuditCausevalue;
	private String hrLeaderAuditResult; // HR人力资源主管领导意见
	private String hrLeaderAuditOper; // HR人力资源主管审批人
	private String hrLeaderAuditDate; // HR人力资源主管审批日期
	private String hrLeaderAuditCause; // HR人力资源主管审批说明
	private String hrLeaderAuditCausevalue;
	private String manAuditResult; // 总经理意见
	private String manAuditOper; // 总经理审批人
	private String manAuditDate; // 总经理审批时间
	private String manAuditCause; // 总经理审批说明
	private String manAuditResultvalue;
	private String statusValue; //审批状态值 0报批 1审批通过 2退回
	private String flagvalue;

    private String statusDes;

    public String getStatusDes() {
        if(APPROVING.equals(statusValue)){
             statusDes="报批";
        }else if(APPROVED.equals(statusValue)){
             statusDes="批准";
        }else if(REFUSED.equals(statusValue)){
             statusDes="退回";
        }else{
             statusDes="拟定";
        }
        return statusDes;
    }

    public void setStatusDes(String statusDes) {
        this.statusDes = statusDes;
    }

    public String getMimicReportNO() {
		return mimicReportNO;
	}
	public void setMimicReportNO(String mimicReportNO) {
		this.mimicReportNO = mimicReportNO;
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
	public String getMrYear() {
		return mrYear;
	}
	public void setMrYear(String mrYear) {
		this.mrYear = mrYear;
	}
	public String getMrMonth() {
		return mrMonth;
	}
	public void setMrMonth(String mrMonth) {
		this.mrMonth = mrMonth;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getDest() {
		return dest;
	}
	public void setDest(String dest) {
		this.dest = dest;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
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
	public String getHrDeptAuditResult() {
		return hrDeptAuditResult;
	}
	public void setHrDeptAuditResult(String hrDeptAuditResult) {
		this.hrDeptAuditResult = hrDeptAuditResult;
	}
	public String getHrDeptAuditOper() {
		return hrDeptAuditOper;
	}
	public void setHrDeptAuditOper(String hrDeptAuditOper) {
		this.hrDeptAuditOper = hrDeptAuditOper;
	}
	public String getHrDeptAuditDate() {
		return hrDeptAuditDate;
	}
	public void setHrDeptAuditDate(String hrDeptAuditDate) {
		this.hrDeptAuditDate = hrDeptAuditDate;
	}
	public String getHrDeptAuditCause() {
		return hrDeptAuditCause;
	}
	public void setHrDeptAuditCause(String hrDeptAuditCause) {
		this.hrDeptAuditCause = hrDeptAuditCause;
	}
	public String getHrDeptAuditCausevalue() {
		return hrDeptAuditCausevalue;
	}
	public void setHrDeptAuditCausevalue(String hrDeptAuditCausevalue) {
		this.hrDeptAuditCausevalue = hrDeptAuditCausevalue;
	}
	public String getHrLeaderAuditResult() {
		return hrLeaderAuditResult;
	}
	public void setHrLeaderAuditResult(String hrLeaderAuditResult) {
		this.hrLeaderAuditResult = hrLeaderAuditResult;
	}
	public String getHrLeaderAuditOper() {
		return hrLeaderAuditOper;
	}
	public void setHrLeaderAuditOper(String hrLeaderAuditOper) {
		this.hrLeaderAuditOper = hrLeaderAuditOper;
	}
	public String getHrLeaderAuditDate() {
		return hrLeaderAuditDate;
	}
	public void setHrLeaderAuditDate(String hrLeaderAuditDate) {
		this.hrLeaderAuditDate = hrLeaderAuditDate;
	}
	public String getHrLeaderAuditCause() {
		return hrLeaderAuditCause;
	}
	public void setHrLeaderAuditCause(String hrLeaderAuditCause) {
		this.hrLeaderAuditCause = hrLeaderAuditCause;
	}
	public String getHrLeaderAuditCausevalue() {
		return hrLeaderAuditCausevalue;
	}
	public void setHrLeaderAuditCausevalue(String hrLeaderAuditCausevalue) {
		this.hrLeaderAuditCausevalue = hrLeaderAuditCausevalue;
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
	
}
