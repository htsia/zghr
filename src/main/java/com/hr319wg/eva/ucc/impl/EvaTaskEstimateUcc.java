package com.hr319wg.eva.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateLogBO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.eva.pojo.bo.EvaTaskProcessBO;
import com.hr319wg.eva.service.EvaTaskEstimateService;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;

public class EvaTaskEstimateUcc implements IEvaTaskEstimateUcc {
	private EvaTaskEstimateService taskservice;
	
	public void deleteEvaTaskMasterBO(String masterid) throws SysException {
		taskservice.deleteEvaTaskMasterBO(masterid);
	}

	public EvaTaskMasterBO findEvaTaskMasterBO(String mastrid)
			throws SysException {
		return taskservice.findEvaTaskMasterBO(mastrid);
	}

	public List getAllEvaTaskMasterBO(String planId) throws SysException {
		return taskservice.getAllEvaTaskMasterBO(planId);
	}

	public List getEvaTaskMasterBOByOrgId(PageVO pagevo, String planID,
			String orgId) throws SysException {
		return taskservice.getEvaTaskMasterBOByOrgId(pagevo, planID, orgId);
	}

	public List getNotEvaTaskMasterBOPeson(PageVO pagevo, String planID,
			String orgId) throws SysException {
		return taskservice.getNotEvaTaskMasterBOPeson(pagevo, planID, orgId);
	}

	public void saveEvaTaskMasterBO(EvaTaskMasterBO bo) throws SysException {
		taskservice.saveEvaTaskMasterBO(bo);
	}
	public EvaTaskMasterBO findEvaTaskMasterBOByPid(String planId,String personId)throws SysException{
		return taskservice.findEvaTaskMasterBOByPid(planId, personId);
	}
	public List findEvaTaskEstimateBOByMasterId(String masterId)throws SysException{
		return taskservice.findEvaTaskEstimateBOByMasterId(masterId);
	}
	public EvaTaskEstimateBO findEvaTaskEstimateBO(String itemId)throws SysException{
		return taskservice.findEvaTaskEstimateBO(itemId);
	}
	public void saveEvaTaskEstimateBO(EvaTaskEstimateBO bo)throws SysException{
		taskservice.saveEvaTaskEstimateBO(bo);
	}
	public void deleteEvaTaskEstimateBO(String itemId)throws SysException{
		taskservice.deleteEvaTaskEstimateBO(itemId);
	}
	public List getManagePersons(String planID,String postID) throws SysException{
		return taskservice.getManagePersons(planID, postID);
	}
	public List getAllEvaTaskMasterBOforPage(PageVO pagevo,String planId)throws SysException{
		return taskservice.getAllEvaTaskMasterBOforPage(pagevo, planId);
	}
	public List findTaskResultScore( String planID, String orgId)throws SysException{
		return taskservice.findTaskResultScore(planID, orgId);
	}
	public List getAllLogByMasterId(String masterId)throws SysException{
		return taskservice.getAllLogByMasterId(masterId);
	}
	public void saveEvaTaskEstimateLogBO(EvaTaskEstimateLogBO bo)throws SysException{
		taskservice.saveEvaTaskEstimateLogBO(bo);
	}
	public void deleteEvaTaskEstimateLogBO(String logId)throws SysException{
		taskservice.deleteEvaTaskEstimateLogBO(logId);
	}
	public List getAllProcessByItemId(String itemId)throws SysException{
		return taskservice.getAllProcessByItemId(itemId);
	}
	public EvaTaskProcessBO findEvaTaskProcessBOById(String processId)throws SysException{
		return taskservice.findEvaTaskProcessBOById(processId);
	}
	public void saveEvaTaskProcessBO(EvaTaskProcessBO bo)throws SysException{
		taskservice.saveEvaTaskProcessBO(bo); 
	}
	public void deleteEvaTaskProcessBO(String processId)throws SysException{
		taskservice.deleteEvaTaskProcessBO(processId);
	}
	public List getTaskResultScore(PageVO pagevo,String planID, String orgId)throws SysException{
		return this.taskservice.getTaskResultScore(pagevo, planID, orgId);
	}
	public EvaTaskEstimateService getTaskservice() {
		return taskservice;
	}

	public void setTaskservice(EvaTaskEstimateService taskservice) {
		this.taskservice = taskservice;
	}
}
