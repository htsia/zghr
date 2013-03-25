package com.hr319wg.rpt.pojo.bo;

public class RptSetUserBO {
	private String setId;
	private String setName;
	private String itemId;
	private String roleID;

	public String getRoleID() {
		return roleID;
	}

	public void setRoleID(String roleID) {
		this.roleID = roleID;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}

	public String getSetName() {
		return this.setName;
	}

	public void setSetName(String setName) {
		this.setName = setName;
	}

	public String getItemId() {
		return this.itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public void initPara() {
		this.itemId = null;
		this.setId = null;
		this.setName = null;
		this.roleID = null;
	}
}