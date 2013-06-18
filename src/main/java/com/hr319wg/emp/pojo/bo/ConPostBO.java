package com.hr319wg.emp.pojo.bo;

import com.hr319wg.common.pojo.bo.CloneablePO;

public class ConPostBO extends CloneablePO {
	private String conPostID;
	private String personID;
	private String conDate;

	public String getConPostID() {
		return conPostID;
	}

	public void setConPostID(String conPostID) {
		this.conPostID = conPostID;
	}

	public String getPersonID() {
		return personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
	}

	public String getConDate() {
		return conDate;
	}

	public void setConDate(String conDate) {
		this.conDate = conDate;
	}

}