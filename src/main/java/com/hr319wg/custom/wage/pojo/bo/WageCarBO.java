package com.hr319wg.custom.wage.pojo.bo;


public class WageCarBO extends WageLitleBaseBO{
	private String ID;
	private String money;
	private String yearMonth;
	private String status;
	private String statusDesc;
	
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatusDesc() {
		if("1".equals(this.status)){
			return "±à¼­ÖÐ";
		}
		return "¹éµµÈÕÆÚ"+this.yearMonth;
	}
	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}
	
}
