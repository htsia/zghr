package com.hr319wg.custom.attence.pojo.bo;

public class AttOvertimePayBO {
	private String id; //��Աid
	private String yearMonth; //����;
	private String overtimeHours; //�Ӱ�Сʱ��
	private String overtimePay;  //�Ӱ��
	private String name;//����
	private String deptName;//��������
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
	
	
	
	
}
