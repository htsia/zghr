package com.hr319wg.eva.pojo.bo;

public class EvaAGItemBO {
	private String itemId;
	private String groupId;
	private String personId;
	private String masterType;
	private String purview;
	private String personName;
	
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getMasterType() {
		return masterType;
	}
	public void setMasterType(String masterType) {
		this.masterType = masterType;
	}
	public String getPurview() {
		return purview;
	}
	public void setPurview(String purview) {
		this.purview = purview;
	}
}
