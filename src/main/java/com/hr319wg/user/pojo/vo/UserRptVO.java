package com.hr319wg.user.pojo.vo;

public class UserRptVO {
	public static String TYPE_TABLE = "0";
	public static String TYPE_REG = "1";
	public static String TYPE_ROSTER = "2";
	private String contentID;
	private String roleID;
	private String operateID;
	private String rptCode;
	private String rptName;
	private String showQue;
	private String rptDir;
	private String rptDirName;
	private String achivesType;
	private String rpttype;
	private String datatype;
	private String wageset;
	private String wagesetdes;

	public String getRoleID() {
		return roleID;
	}

	public void setRoleID(String roleID) {
		this.roleID = roleID;
	}

	public String getWageset() {
		return this.wageset;
	}

	public void setWageset(String wageset) {
		this.wageset = wageset;
	}

	public String getWagesetdes() {
		return this.wagesetdes;
	}

	public void setWagesetdes(String wagesetdes) {
		this.wagesetdes = wagesetdes;
	}

	public String getRpttype() {
		return this.rpttype;
	}

	public void setRpttype(String ID) {
		this.rpttype = ID;
	}

	public String getDatatype() {
		return this.datatype;
	}

	public void setDatatype(String ID) {
		this.datatype = ID;
	}

	public String getAchivesType() {
		return this.achivesType;
	}

	public void setAchivesType(String ID) {
		this.achivesType = ID;
	}

	public String getRptDir() {
		return this.rptDir;
	}

	public void setRptDir(String ID) {
		this.rptDir = ID;
	}

	public String getRptDirName() {
		return this.rptDirName;
	}

	public void setRptDirName(String ID) {
		this.rptDirName = ID;
	}

	public String getShowQue() {
		return this.showQue;
	}

	public void setShowQue(String ID) {
		this.showQue = ID;
	}

	public String getContentID() {
		return this.contentID;
	}

	public void setContentID(String ID) {
		this.contentID = ID;
	}

	public String getRptName() {
		return this.rptName;
	}

	public void setRptName(String ID) {
		this.rptName = ID;
	}

	public String getOperateID() {
		return this.operateID;
	}

	public void setOperateID(String ID) {
		this.operateID = ID;
	}

	public String getRptCode() {
		return this.rptCode;
	}

	public void setRptCode(String Code) {
		this.rptCode = Code;
	}
}