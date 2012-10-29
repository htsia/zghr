package com.hr319wg.custom.attence.pojo.bo;

public class AttMachineBO {
	
	private String machineID;
	private String machineName;
	private String machineIP;
	private String machinePlace;
	private String machineType="1";
	private String machineTypeName;
	private String log;
	private String manager;
	private String user;
	private String finger;
	private String password;
	private String status;
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLog() {
		return log;
	}
	public void setLog(String log) {
		this.log = log;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getFinger() {
		return finger;
	}
	public void setFinger(String finger) {
		this.finger = finger;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMachineTypeName() {
		if("0".equals(this.machineType)){
			return "ÊÇ";
		}
		return "·ñ";			
	}
	public void setMachineTypeName(String machineTypeName) {
		this.machineTypeName = machineTypeName;
	}
	public String getMachineID() {
		return machineID;
	}
	public void setMachineID(String machineID) {
		this.machineID = machineID;
	}
	public String getMachineName() {
		return machineName;
	}
	public void setMachineName(String machineName) {
		this.machineName = machineName;
	}
	public String getMachineIP() {
		return machineIP;
	}
	public void setMachineIP(String machineIP) {
		this.machineIP = machineIP;
	}
	public String getMachinePlace() {
		return machinePlace;
	}
	public void setMachinePlace(String machinePlace) {
		this.machinePlace = machinePlace;
	}
	public String getMachineType() {
		return machineType;
	}
	public void setMachineType(String machineType) {
		this.machineType = machineType;
	}
	
	
}
