package com.hr319wg.xys.eva.pojo.bo;

public class XysEvaRoleBO {
	private String roleId;
	private String roleName;
	private String template360;
	private String createOrg;
	private String createPid;
	private String createTime;
	private String weightKpi;
    private String weight360;
    private String weightXspj; 
	
	public void initRow(){
		this.roleId=null;
		this.roleName="";
		this.template360="";
		this.createOrg="";
		this.createPid="";
		this.createTime="";
		this.weightKpi="";
		this.weight360="";
		this.weightXspj="";
	}
	
	
	public String getWeightKpi() {
		return weightKpi;
	}


	public void setWeightKpi(String weightKpi) {
		this.weightKpi = weightKpi;
	}


	public String getWeight360() {
		return weight360;
	}


	public void setWeight360(String weight360) {
		this.weight360 = weight360;
	}


	public String getWeightXspj() {
		return weightXspj;
	}


	public void setWeightXspj(String weightXspj) {
		this.weightXspj = weightXspj;
	}


	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getTemplate360() {
		return template360;
	}
	public void setTemplate360(String template360) {
		this.template360 = template360;
	}
	public String getCreateOrg() {
		return createOrg;
	}
	public void setCreateOrg(String createOrg) {
		this.createOrg = createOrg;
	}
	public String getCreatePid() {
		return createPid;
	}
	public void setCreatePid(String createPid) {
		this.createPid = createPid;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
}
