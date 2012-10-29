package com.hr319wg.emp.pojo.bo;

public class EmpEduChangeBO {
	private String eduChageId;
	private String personName;
	private String personCode;
	private String deptName;
	private String personId;
	private String oldEdu;
	private String newEdu;
	private String xuewei;
	private String zhuanyeName;
	private String ruxueDate;
	private String learnType;
	private String xuezhi;
	private String eduDate;
	private String eduUni;
	private String status;
	private String statusDes;

	public String getPersonCode() {
		return personCode;
	}

	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getXuewei() {
		return xuewei;
	}

	public void setXuewei(String xuewei) {
		this.xuewei = xuewei;
	}

	public String getZhuanyeName() {
		return zhuanyeName;
	}

	public void setZhuanyeName(String zhuanyeName) {
		this.zhuanyeName = zhuanyeName;
	}

	public String getRuxueDate() {
		return ruxueDate;
	}

	public void setRuxueDate(String ruxueDate) {
		this.ruxueDate = ruxueDate;
	}

	public String getLearnType() {
		return learnType;
	}

	public void setLearnType(String learnType) {
		this.learnType = learnType;
	}

	public String getXuezhi() {
		return xuezhi;
	}

	public void setXuezhi(String xuezhi) {
		this.xuezhi = xuezhi;
	}

	public String getPersonName() {
		return this.personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getEduDate() {
		return this.eduDate;
	}

	public void setEduDate(String eduDate) {
		this.eduDate = eduDate;
	}

	public String getEduUni() {
		return this.eduUni;
	}

	public void setEduUni(String eduUni) {
		this.eduUni = eduUni;
	}

	public String getStatusDes() {
		if (this.status.equals("0"))
			this.statusDes = "≥ı º";
		else if (this.status.equals("1")) {
			this.statusDes = "…˙–ß";
		}
		return this.statusDes;
	}

	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}

	public String getEduChageId() {
		return this.eduChageId;
	}

	public void setEduChageId(String eduChageId) {
		this.eduChageId = eduChageId;
	}

	public String getPersonId() {
		return this.personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOldEdu() {
		return this.oldEdu;
	}

	public void setOldEdu(String oldEdu) {
		this.oldEdu = oldEdu;
	}

	public String getNewEdu() {
		return this.newEdu;
	}

	public void setNewEdu(String newEdu) {
		this.newEdu = newEdu;
	}
}