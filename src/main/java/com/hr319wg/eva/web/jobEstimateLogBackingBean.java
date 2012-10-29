package com.hr319wg.eva.web;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.sys.cache.SysCacheTool;

public class jobEstimateLogBackingBean extends BaseBackingBean {
	private String itemid;
	private IjobEstimateUCC jobestimateucc;
	private List logList;
	private String pageInit;
	private String logID;
	public String getLogID() {
		return logID;
	}
	public void setLogID(String logID) {
		this.logID = logID;
	}
	public String delete(){
		try {
			jobestimateucc.deleteJobEstimateLogBOById(logID);
			logList=jobestimateucc.getAllJobEstimateLogBO(itemid);
			if(logList!=null&&logList.size()>0){
				for(int i=0;i<logList.size();i++){
					JobEstimateLogBO bo=(JobEstimateLogBO)logList.get(i);
					bo.setOperateID(SysCacheTool.findPersonById(bo.getOperateID()).getName());
					logList.set(i,bo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	public String getPageInit(){
		try{
			if(super.getRequestParameter("itemId")!=null){
				itemid=super.getRequestParameter("itemId");
				logList=jobestimateucc.getAllJobEstimateLogBO(itemid);
				if(logList!=null&&logList.size()>0){
					for(int i=0;i<logList.size();i++){
						JobEstimateLogBO bo=(JobEstimateLogBO)logList.get(i);
						bo.setOperateID(SysCacheTool.findPersonById(bo.getOperateID()).getName());
						logList.set(i,bo);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public List getLogList() {
		return logList;
	}
	public void setLogList(List logList) {
		this.logList = logList;
	}
	public String getItemid() {
		return itemid;
	}
	public void setItemid(String itemid) {
		this.itemid = itemid;
	}
	public IjobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}
	public void setJobestimateucc(IjobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}
	
}
