package com.hr319wg.attence.pojo.bo;

public class AttenceLogBO {
	private String personId;
	private String personSeq;
	private String personName;
	private String attCard;
	private String subID;
	private String record;
	private String cardNO;
	private String cardDate;
	private String cardTime;
	private String machineName;
	private String orgName;
	private String deptName;
	private String registerCard="0";

	public String getCardNO() {
		return cardNO;
	}

	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getPersonSeq() {
		return personSeq;
	}

	public void setPersonSeq(String personSeq) {
		this.personSeq = personSeq;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getSubID() {
		return subID;
	}

	public void setSubID(String subID) {
		this.subID = subID;
	}

	public String getRecord() {
		return record;
	}

	public void setRecord(String record) {
		this.record = record;
	}

	public String getCardDate() {
		return cardDate;
	}

	public void setCardDate(String cardDate) {
		this.cardDate = cardDate;
	}

	public String getCardTime() {
		return cardTime;
	}

	public void setCardTime(String cardTime) {
		this.cardTime = cardTime;
	}

	public String getMachineName() {
		return machineName;
	}

	public void setMachineName(String machineName) {
		this.machineName = machineName;
	}

	public String getAttCard() {
		return attCard;
	}

	public void setAttCard(String attCard) {
		this.attCard = attCard;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getRegisterCard() {
		return registerCard;
	}

	public void setRegisterCard(String registerCard) {
		this.registerCard = registerCard;
	}

}
