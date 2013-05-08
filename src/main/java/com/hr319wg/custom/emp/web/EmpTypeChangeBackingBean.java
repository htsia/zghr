package com.hr319wg.custom.emp.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class EmpTypeChangeBackingBean extends BaseBackingBean{

	private String pageInit;
	private String newType;
	private String selectedUserIDs="";
	private String selectedUserNames="";
	private ICommonService commonService;
	
	public String getSelectedUserIDs() {
		return selectedUserIDs;
	}
	public void setSelectedUserIDs(String selectedUserIDs) {
		this.selectedUserIDs = selectedUserIDs;
	}
	public String getNewType() {
		return newType;
	}
	public void setNewType(String newType) {
		this.newType = newType;
	}
	public ICommonService getCommonService() {
		return commonService;
	}
	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}
	public String getPageInit() {
		this.selectedUserNames="";
		String userIDs=super.getRequestParameter("userIDs");
		if(userIDs!=null && !"".equals(userIDs)){
			this.selectedUserIDs=userIDs;
			String[]userIDs2=userIDs.split(",");
			for(int i=0;i<userIDs2.length;i++){
				PersonBO p=SysCacheTool.findPersonById(userIDs2[i]);
				if(p!=null){
					this.selectedUserNames+=p.getName()+",";
				}
			}			
		}
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public String getSelectedUserNames() {
		return selectedUserNames;
	}
	public void setSelectedUserNames(String selectedUserNames) {
		this.selectedUserNames = selectedUserNames;
	}
	
	public String saveType(){
		try {
			this.commonService.saveType(this.selectedUserIDs, this.newType);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
}
