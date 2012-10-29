package com.hr319wg.attence.pojo.bo;

public class AttSignDetailBO {
	
	private String ID;
	private String createOrgID;
	private String userID;
	private String signCase;
	private String day;
	private String apm;
	private String classID;
	private String classType;
	
	public String getClassID() {
		return classID;
	}
	public void setClassID(String classID) {
		this.classID = classID;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getApm() {
		return apm;
	}
	public void setApm(String apm) {
		this.apm = apm;
	}
	public String getClassType() {
		return classType;
	}
	public void setClassType(String classType) {
		this.classType = classType;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getCreateOrgID() {
		return createOrgID;
	}
	public void setCreateOrgID(String createOrgID) {
		this.createOrgID = createOrgID;
	}

	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getSignCase() {
		return signCase;
	}
	public void setSignCase(String signCase) {
		this.signCase = signCase;
	}
	
}
