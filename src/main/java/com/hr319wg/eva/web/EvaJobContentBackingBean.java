package com.hr319wg.eva.web;

import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaJobContentBO;
import com.hr319wg.eva.ucc.impl.jobEstimateUCC;
/**
 * 
 * @author qiaolei
 *
 */
public class EvaJobContentBackingBean extends BaseBackingBean{
	private jobEstimateUCC jobestimateucc;
	private EvaJobContentBO evaJobContentBO;
    private List jobList;
    private String pageInit;
    private String itemID;
    private String taskID;
    private String seq;
    
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public String getTaskID() {
		return taskID;
	}
	public void setTaskID(String taskID) {
		this.taskID = taskID;
	}
	public List getJobList() {
		return jobList;
	}
	public void setJobList(List jobList) {
		this.jobList = jobList;
	}
	public jobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}
	public void setJobestimateucc(jobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}
	public EvaJobContentBO getEvaJobContentBO() {
		return evaJobContentBO;
	}
	public void setEvaJobContentBO(EvaJobContentBO evaJobContentBO) {
		this.evaJobContentBO = evaJobContentBO;
	}
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	public String getPlanID() {
        return itemID;
    }
    public void setPlanID(String planID) {
        this.itemID = planID;
    }

    public String getPageInit(){
    	if(super.getRequestParameter("seq")!=null){
    		itemID = super.getRequestParameter("seq");
    		seq = super.getRequestParameter("array");
    		this.getHttpSession().setAttribute("seq", seq);
    	}
        queryPlanList();
        return "";
    }
    
    public void queryPlanList(){
        try{
            jobList=jobestimateucc.findJobContent(itemID,seq);
        }
        catch(Exception e){
        	e.printStackTrace();
        }
    }
    
    public String delete(){
        try{
            if (taskID!=null){
                this.jobestimateucc.deleteJobPlan(taskID);
            }
        }
        catch(Exception e){
            super.showMessageDetail("É¾³ýÊ§°Ü!");
        }
        return "";
    }
    }

 
