package com.hr319wg.custom.attence.pojo.bo;

public class AttOvertimePayBO {
	private String subid;
	private String personCode;//人员编号
	private String id; //人员id
	private String yearMonth; //年月;
	private String overtimeHours; //加班小时数
	private String overtimePay;  //加班费
	private String name;//姓名
	private String deptName;//部门名称
	private String secDeptName;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOvertimePay() {
		return overtimePay;
	}
	public void setOvertimePay(String overtimePay) {
		this.overtimePay = overtimePay;
	}
	public String getOvertimeHours() {
		return overtimeHours;
	}
	public void setOvertimeHours(String overtimeHours) {
		this.overtimeHours = overtimeHours;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSecDeptName() {
		return secDeptName;
	}
	public void setSecDeptName(String secDeptName) {
		this.secDeptName = secDeptName;
	}
	public String getPersonCode() {
		return personCode;
	}
	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}
	public String getSubid() {
		return subid;
	}
	public void setSubid(String subid) {
		this.subid = subid;
	}
	
	
	
	
}
