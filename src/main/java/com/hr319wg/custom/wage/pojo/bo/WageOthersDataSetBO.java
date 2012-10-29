package com.hr319wg.custom.wage.pojo.bo;


public class WageOthersDataSetBO {
	private String ID;
	private String name;
	private String createDate;
	private float totalmoney;
	private String beginDate;
	private String endDate;
	private String excludeDate;
	private String createUserID;
	private String createUserName;
	private String status; //0编辑中，1审核中，2通过
	private String desc;
	private String targetData;//目标字段
	
	
	public String getTargetData() {
		return targetData;
	}
	public void setTargetData(String targetData) {
		this.targetData = targetData;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getExcludeDate() {
		return excludeDate;
	}
	public void setExcludeDate(String excludeDate) {
		this.excludeDate = excludeDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getCreateUserName() {
		return createUserName;
	}
	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public float getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(float totalmoney) {
		this.totalmoney = totalmoney;
	}

	public String getCreateUserID() {
		return createUserID;
	}
	public void setCreateUserID(String createUserID) {
		this.createUserID = createUserID;
	}
}

