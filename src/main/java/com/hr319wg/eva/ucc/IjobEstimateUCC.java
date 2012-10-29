package com.hr319wg.eva.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaJobContentBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;

public interface IjobEstimateUCC {
	// qiaolei
	public void saveDuty(EvaJobEstimateBO evaJobEstimateBO) throws SysException;

	public void insertDuty(String postId, String personId, String planId)
			throws SysException;

	public List findJobContent(String itemId, String seq) throws SysException;

	public void updateJobContent(EvaJobContentBO bo) throws SysException;

	public void updateJobPlan(EvaJobContentBO bo) throws SysException;

	public void deleteJobPlan(String taskID) throws SysException;

	public EvaJobContentBO findJobPlanById(String taskID) throws SysException;
	
	public List getManagePersons(String planID,String postID) throws SysException;
	//领导打分
	public EvaJobEstimateBO findJobEstimate(String planID, String itemID)
			throws SysException;
	//自助打分
	public EvaJobEstimateBO findSelfJobEstimateBO(String planID, String personID) throws SysException;
	// 职责考核结果查询
	public List findJobEstimateScore(PageVO pagevo, String planID)throws SysException;
	
	public List findResultScore(PageVO pagevo,String planID,String orgId) throws SysException;
	
	public List findHaveCheckInPerson(PageVO pagevo,String planID,String orgid)throws SysException;
	
	public List findHaveNotCheckPerson(PageVO pagevo,String planID,String orgid)throws SysException;
	
	//更新eva_job_estimate表中的数据
	public void updateEstimate(EvaJobEstimateBO bo) throws SysException;
	
	public void deleteJobEstimatByID(String itemid)throws SysException;
	
	public void deleteJobContent(String itemId,String seq) throws SysException;
	public void saveJobEstimateLogBO(JobEstimateLogBO bo)throws SysException;
	public List getAllJobEstimateLogBO(String itemID)throws SysException;
	public void deleteJobEstimateLogBOById(String logid)throws SysException;
}
