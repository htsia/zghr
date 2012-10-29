package com.hr319wg.eva.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaJobContentBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;
import com.hr319wg.eva.service.jobEstimateService;
import com.hr319wg.eva.ucc.IjobEstimateUCC;

public class jobEstimateUCC implements IjobEstimateUCC {
	private jobEstimateService jobestimateservice;

	public void setJobestimateservice(jobEstimateService jobestimateservice) {
		this.jobestimateservice = jobestimateservice;
	}

	// 第一次进入时插入新数据
	public void saveDuty(EvaJobEstimateBO evaJobEstimateBO) throws SysException {
		jobestimateservice.saveDuty(evaJobEstimateBO);
	}

	public void insertDuty(String postId, String personId, String planId)
			throws SysException {
		jobestimateservice.insertDuty(postId, personId, planId);
	}

	public List findJobContent(String itemId, String seq) throws SysException {
		return jobestimateservice.findJobContent(itemId, seq);
	}

	public jobEstimateService getJobestimateservice() {
		return jobestimateservice;
	}

	public void deleteJobPlan(String taskID) throws SysException {
		jobestimateservice.deleteJobPlan(taskID);
	}

	public void updateJobPlan(EvaJobContentBO bo) throws SysException {
		jobestimateservice.updateJobPlan(bo);
	}

	public EvaJobContentBO findJobPlanById(String taskID) throws SysException {
		return (EvaJobContentBO) jobestimateservice.findJobPlanById(taskID);
	}

	public void updateJobContent(EvaJobContentBO bo) throws SysException {
		jobestimateservice.updateJobContent(bo);
	}
	//得到下属岗位的人
	public List getManagePersons(String planID, String postID)
			throws SysException {
		return jobestimateservice.getManagePersons(planID, postID);
	}

	public EvaJobEstimateBO findSelfJobEstimateBO(String planID, String personID)
			throws SysException {
		return jobestimateservice.findSelfJobEstimateBO(planID, personID);
	}
	public EvaJobEstimateBO findJobEstimate(String planID, String itemID)
			throws SysException {
		return jobestimateservice.findJobEstimate(planID, itemID);
	}

	// 职责考核结果查询
	public List findJobEstimateScore(PageVO pagevo, String planID)
			throws SysException {
		return jobestimateservice.findJobEstimateScore(pagevo, planID);
	}
	//fangxia职责考核
	public List findResultScore(PageVO pagevo, String planID, String orgId)
			throws SysException {
		
		return jobestimateservice.findResultScore(pagevo, planID, orgId);
	}
	public List findHaveCheckInPerson(PageVO pagevo,String planID,String orgid)throws SysException{
		return jobestimateservice.findHaveCheckInPerson(pagevo, planID,orgid);
	}
	public List findHaveNotCheckPerson(PageVO pagevo,String planID,String orgid)throws SysException{
		return jobestimateservice.findHaveNotCheckPerson(pagevo, planID,orgid);
	}
	//更新eva_job_estimate表中的数据
	public void updateEstimate(EvaJobEstimateBO bo) throws SysException{
		jobestimateservice.updateEstimate(bo);
	}
	
	public void deleteJobEstimatByID(String itemid)throws SysException{
		jobestimateservice.deleteJobEstimatByID(itemid);
	}
	//删除content表中指定的内容
	public void deleteJobContent(String itemId,String seq) throws SysException{
		jobestimateservice.deleteJobContent(itemId, seq);
	}
	public void saveJobEstimateLogBO(JobEstimateLogBO bo)throws SysException{
		jobestimateservice.saveJobEstimateLogBO(bo);
	}
	public List getAllJobEstimateLogBO(String itemID)throws SysException{
		return jobestimateservice.getAllJobEstimateLogBO(itemID);
	}
	public void deleteJobEstimateLogBOById(String logid)throws SysException{
		jobestimateservice.deleteJobEstimateLogBOById(logid);
	}
}
