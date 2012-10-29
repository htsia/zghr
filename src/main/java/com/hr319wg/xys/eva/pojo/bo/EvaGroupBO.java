package com.hr319wg.xys.eva.pojo.bo;

public class EvaGroupBO {
	private String groupId;
	private String groupName;
	private String createOrg;
	
	public void initRow(){
		this.groupId=null;
		this.groupName="";
		this.createOrg="";
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getCreateOrg() {
		return createOrg;
	}
	public void setCreateOrg(String createOrg) {
		this.createOrg = createOrg;
	}
	
	
}
