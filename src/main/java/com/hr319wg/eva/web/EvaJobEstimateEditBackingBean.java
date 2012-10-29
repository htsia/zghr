package com.hr319wg.eva.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaJobContentBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.eva.ucc.impl.jobEstimateUCC;
import com.hr319wg.util.CommonFuns;
/**
 * 
 * @author qiaolei
 *
 */
public class EvaJobEstimateEditBackingBean extends BaseBackingBean {
	private String pageInit;
	private String taskID;
	private IjobEstimateUCC jobestimateucc;
	private EvaJobContentBO evaJobContentBO = new EvaJobContentBO();

	public IjobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}

	public void setJobestimateucc(IjobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}

	public EvaJobContentBO getEvaJobContentBO() {
		return evaJobContentBO;
	}

	public void setEvaJobContentBO(EvaJobContentBO evaJobContentBO) {
		this.evaJobContentBO = evaJobContentBO;
	}

	public String getTaskID() {
		return taskID;
	}

	public void setTaskID(String taskID) {
		this.taskID = taskID;
	}


	public void setJobestimateucc(jobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}

	public String getPageInit() {
		try {
			if (super.getRequestParameter("taskID") == null) {// ÐÂÔö
				evaJobContentBO.cleanBO();
				evaJobContentBO.setItemID((String)super.getHttpSession().getAttribute("itemId"));
				evaJobContentBO.setSeq((String)super.getHttpSession().getAttribute("seq"));
				EvaJobEstimateBO jobBo=jobestimateucc.findJobEstimate(null, (String)super.getHttpSession().getAttribute("itemId"));
				jobBo.setStatus("6");
				JobEstimateLogBO bo1=new JobEstimateLogBO();
	            bo1.setAction("6");
	            bo1.setItemID(jobBo.getItemID());
	            bo1.setOperateID(jobBo.getPersonID());
	            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	            jobestimateucc.saveJobEstimateLogBO(bo1);
			} else if (super.getRequestParameter("taskID") != null) {// ÐÞ¸Ä
				taskID = super.getRequestParameter("taskID");
				evaJobContentBO = jobestimateucc.findJobPlanById(taskID);
				EvaJobEstimateBO jobBo=jobestimateucc.findJobEstimate(null, (String)super.getHttpSession().getAttribute("itemId"));
				jobBo.setStatus("6");
				JobEstimateLogBO bo1=new JobEstimateLogBO();
	            bo1.setAction("6");
	            bo1.setItemID(jobBo.getItemID());
	            bo1.setOperateID(jobBo.getPersonID());
	            bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	            jobestimateucc.saveJobEstimateLogBO(bo1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String updateJobPlan() throws SysException {
		jobestimateucc.updateJobPlan(evaJobContentBO);
		return "success";
	}

	public void deleteJobPlan(String taskID) throws SysException {
		jobestimateucc.deleteJobPlan(taskID);
	}

	
}
