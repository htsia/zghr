package com.hr319wg.eva.web;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateLogBO;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.sys.cache.SysCacheTool;

public class taskEstimateLogBackBean extends BaseBackingBean {
	private String masterId;
	private IEvaTaskEstimateUcc taskucc;
	private List logList;
	private String pageInit;
	private String logID;
	
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}
	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}
	public String getLogID() {
		return logID;
	}
	public void setLogID(String logID) {
		this.logID = logID;
	}
	public String getPageInit(){
		try{
			if(super.getRequestParameter("masterId")!=null){
				masterId=super.getRequestParameter("masterId");
				logList=taskucc.getAllLogByMasterId(masterId);
				if(logList!=null&&logList.size()>0){
					for(int i=0;i<logList.size();i++){
						EvaTaskEstimateLogBO bo=(EvaTaskEstimateLogBO)logList.get(i);
						bo.setOperId(SysCacheTool.findPersonById(bo.getOperId()).getName());
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
	
}
