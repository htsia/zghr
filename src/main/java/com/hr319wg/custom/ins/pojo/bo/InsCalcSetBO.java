package com.hr319wg.custom.ins.pojo.bo;

public class InsCalcSetBO {

	private String ID;
	private String createUserID;
	private String createOrgID;
	private String createDate;
	private String wageDate;
	private String status;
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getCreateUserID() {
		return createUserID;
	}
	public void setCreateUserID(String createUserID) {
		this.createUserID = createUserID;
	}
	public String getCreateOrgID() {
		return createOrgID;
	}
	public void setCreateOrgID(String createOrgID) {
		this.createOrgID = createOrgID;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getWageDate() {
		return wageDate;
	}
	public void setWageDate(String wageDate) {
		this.wageDate = wageDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
