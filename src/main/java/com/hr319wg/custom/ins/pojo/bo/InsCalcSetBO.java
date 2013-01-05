package com.hr319wg.custom.ins.pojo.bo;

import com.hr319wg.util.CommonFuns;

public class InsCalcSetBO {

	private String ID;
	private String createUserID;
	private String createUserName;
	private String createOrgID;
	private String createDate=CommonFuns.getSysDate("yyyy-MM-dd");
	private String wageDate=CommonFuns.getSysDate("yyyy-MM");
	private String status="0";
	private String statusDesc;
	private String remark;
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCreateUserName() {
		return createUserName;
	}
	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}
	public String getStatusDesc() {
		if("0".equals(this.status)){
			return "²Ý¸å";
		}else{
			return "¹éµµ";
		}
	}
	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getCreateUserID() {
		return createUserID;
	}
	public void setCreateUserID(String createUserID) {
		this.createUserID = createUserID;
	}
	public String getCreateOrgID() {
		return createOrgID;
	}
	public void setCreateOrgID(String createOrgID) {
		this.createOrgID = createOrgID;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getWageDate() {
		return wageDate;
	}
	public void setWageDate(String wageDate) {
		this.wageDate = wageDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
