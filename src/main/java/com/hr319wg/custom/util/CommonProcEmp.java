package com.hr319wg.custom.util;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;

public class CommonProcEmp {

	private ActivePageAPI activeapi;
	
	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public void addEmp(String setID, String userID, String subID){
		modifyEmp(setID, userID, subID ,"ADD_");
	}
	
	public void updateEmp(String setID, String userID, String subID){
		modifyEmp(setID, userID, subID ,"UPDATE_");
	}
	
	public void deleteEmp(String setID, String userID, String subID){
		modifyEmp(setID, userID, subID ,"DELETE_");
	}
	
	private void modifyEmp(String setID, String userID, String subID, String type){
		String sql = "select para_value from sys_parameter where para_key='PROC_"+type+setID+"'";
		try {
			String value=this.activeapi.queryForString(sql);
			if(value!=null && !"".equals(value)){
				this.activeapi.executeSql("BEGIN "+value+"('"+userID+"','"+subID+"'); END;");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
}
