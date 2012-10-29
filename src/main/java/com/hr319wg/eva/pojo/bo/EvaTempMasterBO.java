package com.hr319wg.eva.pojo.bo;

public class EvaTempMasterBO {
	private String masterID;
	private String evaPlanID;
	private String masterName;
	private String password;
	private String is_use;
	private String isUseDesp;
	private String planName;
	private String masterPName;
	
	public String getMasterPName() {
		return masterPName;
	}
	public void setMasterPName(String masterPName) {
		this.masterPName = masterPName;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getIsUseDesp() {
		if("1".equals(is_use)){
			return "∆Ù”√";
		}else{
			return "Œ¥”√";
		}
	}
	public void setIsUseDesp(String isUseDesp) {
		this.isUseDesp = isUseDesp;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMasterID() {
		return masterID;
	}
	public void setMasterID(String masterID) {
		this.masterID = masterID;
	}
	public String getEvaPlanID() {
		return evaPlanID;
	}
	public void setEvaPlanID(String evaPlanID) {
		this.evaPlanID = evaPlanID;
	}
	public String getMasterName() {
		return masterName;
	}
	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}
	
	public String getIs_use() {
		return is_use;
	}
	public void setIs_use(String is_use) {
		this.is_use = is_use;
	}
}
