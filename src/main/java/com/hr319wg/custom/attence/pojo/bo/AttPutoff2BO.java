package com.hr319wg.custom.attence.pojo.bo;

public class AttPutoff2BO {
	private String id;
	private String putoffDays;
	private String leaveDays;
	private String bingjia;
	private String hunjia;
	private String sangjia;
	private String chanjia;
	private String nanchanjia;
	private String daixinjia;
	private String name;
	private String deptName;
	private String secDeptName;
	private String yearAttence; // 应出勤天数
	private String yearRealAttence;// 实际出勤天数
	private String attenceRate; // 年出勤率
	private String overtimeHours;// 加班小时数

	public String getSecDeptName() {
		return secDeptName;
	}

	public void setSecDeptName(String secDeptName) {
		this.secDeptName = secDeptName;
	}

	public String getOvertimeHours() {
		return overtimeHours;
	}

	public void setOvertimeHours(String overtimeHours) {
		this.overtimeHours = overtimeHours;
	}

	public String getYearRealAttence() {
		return yearRealAttence;
	}

	public void setYearRealAttence(String yearRealAttence) {
		this.yearRealAttence = yearRealAttence;
	}

	public String getAttenceRate() {
		return attenceRate;
	}

	public void setAttenceRate(String attenceRate) {
		this.attenceRate = attenceRate;
	}

	public String getYearAttence() {
		return yearAttence;
	}

	public void setYearAttence(String yearAttence) {
		this.yearAttence = yearAttence;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPutoffDays() {
		return putoffDays;
	}

	public void setPutoffDays(String putoffDays) {
		this.putoffDays = putoffDays;
	}

	public String getLeaveDays() {
		return leaveDays;
	}

	public void setLeaveDays(String leaveDays) {
		this.leaveDays = leaveDays;
	}

	public String getBingjia() {
		return bingjia;
	}

	public void setBingjia(String bingjia) {
		this.bingjia = bingjia;
	}

	public String getHunjia() {
		return hunjia;
	}

	public void setHunjia(String hunjia) {
		this.hunjia = hunjia;
	}

	public String getSangjia() {
		return sangjia;
	}

	public void setSangjia(String sangjia) {
		this.sangjia = sangjia;
	}

	public String getChanjia() {
		return chanjia;
	}

	public void setChanjia(String chanjia) {
		this.chanjia = chanjia;
	}

	public String getNanchanjia() {
		return nanchanjia;
	}

	public void setNanchanjia(String nanchanjia) {
		this.nanchanjia = nanchanjia;
	}

	public String getDaixinjia() {
		return daixinjia;
	}

	public void setDaixinjia(String daixinjia) {
		this.daixinjia = daixinjia;
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

}
