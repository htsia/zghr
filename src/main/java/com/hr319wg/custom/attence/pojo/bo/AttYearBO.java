package com.hr319wg.custom.attence.pojo.bo;

public class AttYearBO {
	private String subid;
	private String personId; //��Աid
	private String personCode;
	private String flag;//�Ƿ�����ʾ
	private String year; //��;
	private String shouldDays; //Ӧ����
	private String realDays;  //ʵ�ʳ���
	private String attRate;  //������
	private String attBonus;  //���ڽ���
	
	private String name;//����
	private String deptName;//��������
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
