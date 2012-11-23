package com.hr319wg.custom.attence.pojo.bo;

public class AttYearBO {
	private String subid;
	private String personId; //人员id
	private String personCode;
	private String flag;//是否主显示
	private String year; //年;
	private String shouldDays; //应出勤
	private String realDays;  //实际出勤
	private String attRate;  //出勤率
	private String attBonus;  //出勤奖金
	
	private String name;//姓名
	private String deptName;//部门名称
	private String secDeptName;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getShouldDays() {
		return shouldDays;
	}
	public void setShouldDays(String shouldDays) {
		this.shouldDays = shouldDays;
	}
	public String getRealDays() {
		return realDays;
	}
	public void setRealDays(String realDays) {
		this.realDays = realDays;
	}
	public String getAttRate() {
		return attRate;
	}
	public void setAttRate(String attRate) {
		this.attRate = attRate;
	}
	public String getAttBonus() {
		return attBonus;
	}
	public void setAttBonus(String attBonus) {
		this.attBonus = attBonus;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getSecDeptName() {
		return secDeptName;
	}
	public void setSecDeptName(String secDeptName) {
		this.secDeptName = secDeptName;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getSubid() {
		return subid;
	}
	public void setSubid(String subid) {
		this.subid = subid;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getPersonCode() {
		return personCode;
	}
	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}
}
