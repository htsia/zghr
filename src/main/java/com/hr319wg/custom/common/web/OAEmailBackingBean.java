package com.hr319wg.custom.common.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.sys.api.ActivePageAPI;

public class OAEmailBackingBean extends BaseBackingBean{

	private String userID;
	private String password;
	private String toOAUserID;
	private boolean onoff;
	private String pageInit;
	private IWageDataService dataService;
	private ActivePageAPI pageAPI;
	
	public ActivePageAPI getPageAPI() {
		return pageAPI;
	}
	public void setPageAPI(ActivePageAPI pageAPI) {
		this.pageAPI = pageAPI;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public IWageDataService getDataService() {
		return dataService;
	}
	public void setDataService(IWageDataService dataService) {
		this.dataService = dataService;
	}
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getToOAUserID() {
		return toOAUserID;
	}
	public void setToOAUserID(String toOAUserID) {
		this.toOAUserID = toOAUserID;
	}
	public boolean isOnoff() {
		return onoff;
	}
	public void setOnoff(boolean onoff) {
		this.onoff = onoff;
	}
	public String getPageInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			String sql="select t.userid ||','||t.password||','||t.tooauserid||','||t.onoff info from SYS_OA_EMAIL t";
			try {
				String info=this.pageAPI.queryForString(sql);
				if(info!=null && !"".equals(info)){
					String[]infos=info.split(",");
					this.userID=infos[0];
					this.password=infos[1];
					this.toOAUserID=infos[2];
					this.onoff="1".equals(infos[3])?true:false;
				}
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		
		return pageInit;
	}
	
	public void save(){
		try {
			this.dataService.setOAEmail(userID, password, toOAUserID, onoff?"1":"0");
			super.showMessageDetail("保存完成");
		} catch (SysException e) {
			super.showMessageDetail("保存失败");
			e.printStackTrace();
		}
	}
}
