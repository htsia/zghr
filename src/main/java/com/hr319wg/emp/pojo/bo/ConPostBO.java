package com.hr319wg.emp.pojo.bo;

import com.hr319wg.common.pojo.bo.CloneablePO;

public class ConPostBO extends CloneablePO {
	private String conPostID;
	private String personID;
	private String mainOrguid;
	private String conOrguid1;
	private String conOrguid2;
	private String conPostID1;
	private String conPostID2;

	public String getConPostID1() {
		return conPostID1;
	}

	public void setConPostID1(String conPostID1) {
		this.conPostID1 = conPostID1;
	}

	public String getConPostID2() {
		return conPostID2;
	}

	public void setConPostID2(String conPostID2) {
		this.conPostID2 = conPostID2;
	}

	public String getConPostID() {
		return this.conPostID;
	}

	public void setConPostID(String id) {
		this.conPostID = id;
	}

	public String getPersonID() {
		return this.personID;
	}

	public void setPersonID(String id) {
		this.personID = id;
	}

	public String getMainOrguid() {
		return this.mainOrguid;
	}

	public void setMainOrguid(String id) {
		this.mainOrguid = id;
	}

	public String getConOrguid1() {
		return this.conOrguid1;
	}

	public void setConOrguid1(String id) {
		this.conOrguid1 = id;
	}

	public String getConOrguid2() {
		return this.conOrguid2;
	}

	public void setConOrguid2(String name) {
		this.conOrguid2 = name;
	}
}