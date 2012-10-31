package com.hr319wg.custom.wage.pojo.bo;

public class WageDataSetBO {
	private String ID;
	private String name;
	private String createDate;
	private String itemType;
	private float totalmoney=0;
	private String beginDate;
	private String endDate;
	private String applyDate;
	private String excludeDate;
	private String usedMonth;
	private String usedMoney;
	private String createUserID;
	private String createUserName;
	private String status="0"; //0编辑中,1分发中,1分发结束
	private String statusDesc;
	private String desc;
	private String selfstatus;

	public String getSelfstatus() {
		return selfstatus;
	}
	public void setSelfstatus(String selfstatus) {
		this.selfstatus = selfstatus;
	}
	public String getUsedMonth() {
		return usedMonth;
	}
	public void setUsedMonth(String usedMonth) {
		this.usedMonth = usedMonth;
	}
	public String getUsedMoney() {
		return usedMoney;
	}
	public void setUsedMoney(String usedMoney) {
		this.usedMoney = usedMoney;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getStatusDesc() {
		return statusDesc;
	}
	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
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
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
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
