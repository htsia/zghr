package com.hr319wg.user.pojo.bo;

public class UserRptBO {
	private String contEntid;
	private String personID;
	private String operateID;
	private String rptCode;
	private String rptCodeName;
	private String showQue;
	private String wageset;
	private String wagesetdes;
	private String roleID;

	public String getRoleID() {
		return roleID;
	}

	public void setRoleID(String roleID) {
		this.roleID = roleID;
	}

	public String getWagesetdes() {
		return this.wagesetdes;
	}

	public void setWagesetdes(String wagesetdes) {
		this.wagesetdes = wagesetdes;
	}

	public String getWageset() {
		return this.wageset;
	}

	public void setWageset(String wageset) {
		this.wageset = wageset;
	}

	public String getContEntid() {
		return this.contEntid;
	}

	public void setContEntid(String contEntid) {
		this.contEntid = contEntid;
	}

	public String getPersonID() {
		return this.personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
	}

	public String getOperateID() {
		return this.operateID;
	}

	public void setOperateID(String operateID) {
		this.operateID = operateID;
	}

	public String getRptCode() {
		return this.rptCode;
	}

	public void setRptCode(String rptCode) {
		this.rptCode = rptCode;
	}

	public String getRptCodeName() {
		return this.rptCodeName;
	}

	public void setRptCodeName(String rptCodeName) {
		this.rptCodeName = rptCodeName;
	}

	public String getShowQue() {
		return this.showQue;
	}

	public void setShowQue(String showQue) {
		this.showQue = showQue;
	}
}