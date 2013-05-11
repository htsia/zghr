package com.hr319wg.custom.emp.pojo.bo;

public class EmpPersonTypeChangeBO {
	private String typeChangeID;
	private String personID;
	private String applyPersonID;
	private String applyPersonName;
	private String personCode;
	private String name;
	private String orgName;
	private String deptName;
	private String oldType;
	private String newType;
	private String oldTypeDes;
	private String newTypeDes;
	private String changeDate;
	private String changedDate;
	private String status;
	private String statusDes;
	private String linkAdjustID;
	
	public String getApplyPersonID() {
		return applyPersonID;
	}
	public void setApplyPersonID(String applyPersonID) {
		this.applyPersonID = applyPersonID;
	}
	public String getApplyPersonName() {
		return applyPersonName;
	}
	public void setApplyPersonName(String applyPersonName) {
		this.applyPersonName = applyPersonName;
	}
	public String getLinkAdjustID() {
		return linkAdjustID;
	}
	public void setLinkAdjustID(String linkAdjustID) {
		this.linkAdjustID = linkAdjustID;
	}
	public String getOldTypeDes() {
		return oldTypeDes;
	}
	public void setOldTypeDes(String oldTypeDes) {
		this.oldTypeDes = oldTypeDes;
	}
	public String getNewTypeDes() {
		return newTypeDes;
	}
	public void setNewTypeDes(String newTypeDes) {
		this.newTypeDes = newTypeDes;
	}
	public String getChangedDate() {
		return changedDate;
	}
	public void setChangedDate(String changedDate) {
		this.changedDate = changedDate;
	}
	public String getStatusDes() {
		if("0".equals(this.status)){
			return "…Í«Î";
		}else{
			return "“—…˙–ß";			
		}
	}
	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}
	public String getPersonCode() {
		return personCode;
	}
	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getTypeChangeID() {
		return typeChangeID;
	}
	public void setTypeChangeID(String typeChangeID) {
		this.typeChangeID = typeChangeID;
	}
	public String getPersonID() {
		return personID;
	}
	public void setPersonID(String personID) {
		this.personID = personID;
	}
	public String getOldType() {
		return oldType;
	}
	public void setOldType(String oldType) {
		this.oldType = oldType;
	}
	public String getNewType() {
		return newType;
	}
	public void setNewType(String newType) {
		this.newType = newType;
	}
	public String getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
