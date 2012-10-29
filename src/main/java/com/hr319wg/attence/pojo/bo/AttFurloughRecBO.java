package com.hr319wg.attence.pojo.bo;

public class AttFurloughRecBO {
	private String furloughNO; // 标示
	private String personID; // 请假人
	private String personName;
	private String orgID;
	private String applyDate; // 申请时间
	private String beginTime; // 假开始时间
	private String endTime; // 假结束时间
	private String flID; // 假期类型
	private String flName;
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
	
	private String  zjAuditResult; // 总监意见
	private String zjAuditOper; // 总监审批人
	private String zjAuditDate; // 总监审批时间
	private String zjAuditCause; // 总监审批说明
	private String zjAuditResultvalue;
	
	private String  zjlAuditResult; // 总经理意见
	private String zjlAuditOper; // 总经理审批人
	private String zjlAuditDate; // 总经理审批时间
	private String zjlAuditCause; // 总经理审批说明
	private String zjlAuditResultvalue;
	
	
	
	private String lastDate; //请假天数
	//审批状态值：
	//0报批  只适用于起始节点
	//1批准
	//2退回
	//3审批通过  只适用于结束节点  用于标示请假审批通过 
	private String statusValue; 
	private String flagvalue;
	private String superFurloughNo; //原始请假记录ID值
	private String superFlId; //请假类型：1 请假 2补假 3 销假
	private String superFlIdName;
	private String flagValues; //0 显示历史记录 1显示查看流程
	private String furloughCollectNO;
	private String flIdProcess;//处理类别
	private String flIdProcessName;
	private String flIdStatus;//是否提交相关证明材料  0 否 1 是
	private String flIdStatusName;
    private String statusValueName;
    
	public String getFurloughNO() {
		return furloughNO;
	}

	public void setFurloughNO(String furloughNO) {
		this.furloughNO = furloughNO;
	}

	public String getPersonID() {
		return personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
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

	public String getFlID() {
		return flID;
	}

	public void setFlID(String flID) {
		this.flID = flID;
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

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getFlagvalue() {
		return flagvalue;
	}

	public void setFlagvalue(String flagvalue) {
		this.flagvalue = flagvalue;
	}

	public String getFlName() {
		return flName;
	}

	public void setFlName(String flName) {
		this.flName = flName;
	}

	public String getDeptAuditCausevalue() {
		return deptAuditCausevalue;
	}

	public void setDeptAuditCausevalue(String deptAuditCausevalue) {
		this.deptAuditCausevalue = deptAuditCausevalue;
	}

	public String getLeaderAuditCausevalue() {
		return leaderAuditCausevalue;
	}

	public void setLeaderAuditCausevalue(String leaderAuditCausevalue) {
		this.leaderAuditCausevalue = leaderAuditCausevalue;
	}

	public String getHrAuditResultvalue() {
		return hrAuditResultvalue;
	}

	public void setHrAuditResultvalue(String hrAuditResultvalue) {
		this.hrAuditResultvalue = hrAuditResultvalue;
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

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getSuperFurloughNo() {
		return superFurloughNo;
	}

	public void setSuperFurloughNo(String superFurloughNo) {
		this.superFurloughNo = superFurloughNo;
	}

	public String getSuperFlId() {
		return superFlId;
	}

	public void setSuperFlId(String superFlId) {
		this.superFlId = superFlId;
	}

	public String getSuperFlIdName() {
		return superFlIdName;
	}

	public void setSuperFlIdName(String superFlIdName) {
		this.superFlIdName = superFlIdName;
	}

	public String getFlagValues() {
		return flagValues;
	}

	public void setFlagValues(String flagValues) {
		this.flagValues = flagValues;
	}

	public String getFurloughCollectNO() {
		return furloughCollectNO;
	}

	public void setFurloughCollectNO(String furloughCollectNO) {
		this.furloughCollectNO = furloughCollectNO;
	}

	public String getFlIdProcess() {
		return flIdProcess;
	}

	public void setFlIdProcess(String flIdProcess) {
		this.flIdProcess = flIdProcess;
	}

	public String getFlIdStatus() {
		return flIdStatus;
	}

	public void setFlIdStatus(String flIdStatus) {
		this.flIdStatus = flIdStatus;
	}

	public String getFlIdProcessName() {
		return flIdProcessName;
	}

	public void setFlIdProcessName(String flIdProcessName) {
		this.flIdProcessName = flIdProcessName;
	}

	public String getFlIdStatusName() {
		return flIdStatusName;
	}

	public void setFlIdStatusName(String flIdStatusName) {
		this.flIdStatusName = flIdStatusName;
	}

	public String getZjAuditResult() {
		return zjAuditResult;
	}

	public void setZjAuditResult(String zjAuditResult) {
		this.zjAuditResult = zjAuditResult;
	}

	public String getZjAuditOper() {
		return zjAuditOper;
	}

	public void setZjAuditOper(String zjAuditOper) {
		this.zjAuditOper = zjAuditOper;
	}

	public String getZjAuditDate() {
		return zjAuditDate;
	}

	public void setZjAuditDate(String zjAuditDate) {
		this.zjAuditDate = zjAuditDate;
	}

	public String getZjAuditCause() {
		return zjAuditCause;
	}

	public void setZjAuditCause(String zjAuditCause) {
		this.zjAuditCause = zjAuditCause;
	}

	public String getZjAuditResultvalue() {
		return zjAuditResultvalue;
	}

	public void setZjAuditResultvalue(String zjAuditResultvalue) {
		this.zjAuditResultvalue = zjAuditResultvalue;
	}

	public String getZjlAuditResult() {
		return zjlAuditResult;
	}

	public void setZjlAuditResult(String zjlAuditResult) {
		this.zjlAuditResult = zjlAuditResult;
	}

	public String getZjlAuditOper() {
		return zjlAuditOper;
	}

	public void setZjlAuditOper(String zjlAuditOper) {
		this.zjlAuditOper = zjlAuditOper;
	}

	public String getZjlAuditDate() {
		return zjlAuditDate;
	}

	public void setZjlAuditDate(String zjlAuditDate) {
		this.zjlAuditDate = zjlAuditDate;
	}

	public String getZjlAuditCause() {
		return zjlAuditCause;
	}

	public void setZjlAuditCause(String zjlAuditCause) {
		this.zjlAuditCause = zjlAuditCause;
	}

	public String getZjlAuditResultvalue() {
		return zjlAuditResultvalue;
	}

	public void setZjlAuditResultvalue(String zjlAuditResultvalue) {
		this.zjlAuditResultvalue = zjlAuditResultvalue;
	}

	public String getStatusValueName() {
		return statusValueName;
	}

	public void setStatusValueName(String statusValueName) {
		this.statusValueName = statusValueName;
	}




}
