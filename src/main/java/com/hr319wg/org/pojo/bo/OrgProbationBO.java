package com.hr319wg.org.pojo.bo;

public class OrgProbationBO {
	private String orgUid;
	private String probation;
	private String jianxi;
	private String orgName;
	private String wageItems;
	private String normailType;

	public String getNormailType() {
		return normailType;
	}

	public void setNormailType(String normailType) {
		this.normailType = normailType;
	}

	public String getJianxi() {
		return jianxi;
	}

	public void setJianxi(String jianxi) {
		this.jianxi = jianxi;
	}

	public String getWageItems() {
		return this.wageItems;
	}

	public void setWageItems(String wageItems) {
		this.wageItems = wageItems;
	}

	public String getOrgName() {
		return this.orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getOrgUid() {
		return this.orgUid;
	}

	public void setOrgUid(String orgUid) {
		this.orgUid = orgUid;
	}

	public String getProbation() {
		return this.probation;
	}

	public void setProbation(String probation) {
		this.probation = probation;
	}
}