package com.hr319wg.custom.attence.pojo.bo;

public class AttTempDataBO{
	private String subid;
	private String personId;
	private String personCode;
	private String name;//姓名
	private String deptName;//部门名称
	private String secDeptName;
	private String tempBeginDate;
	private String tempEndDate;
	private String attDetail;//考勤详情
	
	
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
	public String getTempBeginDate() {
		return tempBeginDate;
	}
	public void setTempBeginDate(String tempBeginDate) {
		this.tempBeginDate = tempBeginDate;
	}
	public String getTempEndDate() {
		return tempEndDate;
	}
	public void setTempEndDate(String tempEndDate) {
		this.tempEndDate = tempEndDate;
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
	public String getAttDetail() {
		return attDetail;
	}
	public void setAttDetail(String attDetail) {
		this.attDetail = attDetail;
	}
	
}
