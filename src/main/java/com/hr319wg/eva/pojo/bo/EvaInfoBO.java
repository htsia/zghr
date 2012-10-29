package com.hr319wg.eva.pojo.bo;

import com.hr319wg.emp.pojo.bo.PersonBO;

public class EvaInfoBO {
	private String id;
	private String subID;
	private String planId;
	private String planName;
	private String planType;
	private String beginDate;
	private String endDate;
	private String orgID;
	private String resultAuditExplain;
	private String planGradeName;
	private String scoreIndex; //·ÖÊýµÄÅÅÐòÂë
	private String workSum;
	private String orgName;
	
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getWorkSum() {
		return workSum;
	}
	public void setWorkSum(String workSum) {
		this.workSum = workSum;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getSubID() {
		return subID;
	}
	public void setSubID(String subID) {
		this.subID = subID;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getPlanType() {
		return planType;
	}
	public void setPlanType(String planType) {
		this.planType = planType;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getResultAuditExplain() {
		return resultAuditExplain;
	}
	public void setResultAuditExplain(String resultAuditExplain) {
		this.resultAuditExplain = resultAuditExplain;
	}
	public String getPlanGradeName() {
		return planGradeName;
	}
	public void setPlanGradeName(String planGradeName) {
		this.planGradeName = planGradeName;
	}
	public String getScoreIndex() {
		return scoreIndex;
	}
	public void setScoreIndex(String scoreIndex) {
		this.scoreIndex = scoreIndex;
	}
	
	

}
