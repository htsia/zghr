package com.hr319wg.emp.pojo.bo;

public class EmpTitleChangeBO {
	private String titleChangeId;
	private String personId;
	private String oldLevel;
	private String applyLevel;
	private String oldMajor;
	private String applyMajor;
	private String oldTitle;
	private String applyTitle;
	private String status;
	private String statusDes;
	private String personName;
	private String personCode;
	private String deptName;
	private String zhicheng;
	private String isMost;
	private String isPinren;
	private String pinrenNum;
	private String pinrenDate;
	private String remark;

	public String getZhicheng() {
		return zhicheng;
	}

	public void setZhicheng(String zhicheng) {
		this.zhicheng = zhicheng;
	}

	public String getPersonCode() {
		return personCode;
	}

	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getIsMost() {
		return isMost;
	}

	public void setIsMost(String isMost) {
		this.isMost = isMost;
	}

	public String getIsPinren() {
		return isPinren;
	}

	public void setIsPinren(String isPinren) {
		this.isPinren = isPinren;
	}

	public String getPinrenNum() {
		return pinrenNum;
	}

	public void setPinrenNum(String pinrenNum) {
		this.pinrenNum = pinrenNum;
	}

	public String getPinrenDate() {
		return pinrenDate;
	}

	public void setPinrenDate(String pinrenDate) {
		this.pinrenDate = pinrenDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPersonName() {
		return this.personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getStatusDes() {
		if (this.status.equals("0"))
			this.statusDes = "≥ı º";
		else if (this.status.equals("1")) {
			this.statusDes = "…˙–ß";
		}
		return this.statusDes;
	}

	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}

	public String getTitleChangeId() {
		return this.titleChangeId;
	}

	public void setTitleChangeId(String titleChangeId) {
		this.titleChangeId = titleChangeId;
	}

	public String getPersonId() {
		return this.personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getOldLevel() {
		return this.oldLevel;
	}

	public void setOldLevel(String oldLevel) {
		this.oldLevel = oldLevel;
	}

	public String getApplyLevel() {
		return this.applyLevel;
	}

	public void setApplyLevel(String applyLevel) {
		this.applyLevel = applyLevel;
	}

	public String getOldMajor() {
		return this.oldMajor;
	}

	public void setOldMajor(String oldMajor) {
		this.oldMajor = oldMajor;
	}

	public String getApplyMajor() {
		return this.applyMajor;
	}

	public void setApplyMajor(String applyMajor) {
		this.applyMajor = applyMajor;
	}

	public String getOldTitle() {
		return this.oldTitle;
	}

	public void setOldTitle(String oldTitle) {
		this.oldTitle = oldTitle;
	}

	public String getApplyTitle() {
		return this.applyTitle;
	}

	public void setApplyTitle(String applyTitle) {
		this.applyTitle = applyTitle;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}