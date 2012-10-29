package com.hr319wg.eva.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateLogBO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.eva.pojo.bo.EvaTaskProcessBO;

public interface IEvaTaskEstimateUcc {
	public List getAllEvaTaskMasterBO(String planId)throws SysException;
	public List getEvaTaskMasterBOByOrgId(PageVO pagevo, String planID, String orgId)throws SysException;
	public List getNotEvaTaskMasterBOPeson(PageVO pagevo, String planID, String orgId)throws SysException;
	public EvaTaskMasterBO findEvaTaskMasterBO(String mastrid)throws SysException;
	public void saveEvaTaskMasterBO(EvaTaskMasterBO bo)throws SysException;
	public void deleteEvaTaskMasterBO(String masterid)throws SysException;
	public EvaTaskMasterBO findEvaTaskMasterBOByPid(String planId,String personId)throws SysException;
	public List findEvaTaskEstimateBOByMasterId(String masterId)throws SysException;
	public EvaTaskEstimateBO findEvaTaskEstimateBO(String itemId)throws SysException;
	public void saveEvaTaskEstimateBO(EvaTaskEstimateBO bo)throws SysException;
	public void deleteEvaTaskEstimateBO(String itemId)throws SysException;
	public List getManagePersons(String planID,String postID) throws SysException;
	public List getAllEvaTaskMasterBOforPage(PageVO pagevo,String planId)throws SysException;
	public List findTaskResultScore( String planID, String orgId)throws SysException;
	public List getAllLogByMasterId(String masterId)throws SysException;
	public void saveEvaTaskEstimateLogBO(EvaTaskEstimateLogBO bo)throws SysException;
	public void deleteEvaTaskEstimateLogBO(String logId)throws SysException;
	public List getAllProcessByItemId(String itemId)throws SysException;
	public EvaTaskProcessBO findEvaTaskProcessBOById(String processId)throws SysException;
	public void saveEvaTaskProcessBO(EvaTaskProcessBO bo)throws SysException;
	public void deleteEvaTaskProcessBO(String processId)throws SysException;
	public List getTaskResultScore(PageVO pagevo,String planID, String orgId)throws SysException;
}
