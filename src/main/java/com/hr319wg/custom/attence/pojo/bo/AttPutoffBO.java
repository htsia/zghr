package com.hr319wg.custom.attence.pojo.bo;

public class AttPutoffBO {
	
	private String ID;
	private String name;
	private String personCode;
	private String personTypeName;
	private String deptName;
	private String totalTime;
	private String applyYear;
	private String addToWage;
	
	public String getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}
	public String getAddToWage() {
		return addToWage;
	}
	public void setAddToWage(String addToWage) {
		this.addToWage = addToWage;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPersonCode() {
		return personCode;
	}
	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}
	public String getPersonTypeName() {
		return personTypeName;
	}
	public void setPersonTypeName(String personTypeName) {
		this.personTypeName = personTypeName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getApplyYear() {
		return applyYear;
	}
	public void setApplyYear(String applyYear) {
		this.applyYear = applyYear;
	}
}
