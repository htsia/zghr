package com.hr319wg.custom.attence.pojo.bo;

public class AttYearBO {
	private String id; //��Աid
	private String flag;//�Ƿ�����ʾ
	private String year; //��;
	private String shouldDays; //Ӧ����
	private String realDays;  //ʵ�ʳ���
	private String attRate;  //������
	private String attBonus;  //���ڽ���
	
	private String name;//����
	private String deptName;//��������
	private String secDeptName;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
}
