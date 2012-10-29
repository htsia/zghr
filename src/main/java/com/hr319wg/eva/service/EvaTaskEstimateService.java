package com.hr319wg.eva.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.dao.EvaTaskEstimateDAO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateLogBO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.eva.pojo.bo.EvaTaskProcessBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;

public class EvaTaskEstimateService {
	private EvaTaskEstimateDAO taskdao;
	private ActivePageAPI activePageAPI;
	
	public List getAllEvaTaskMasterBO(String planId)throws SysException{
		return taskdao.getAllEvaTaskMasterBO(planId);
	}
	public List getEvaTaskMasterBOByOrgId(PageVO pagevo, String planID, String orgId)throws SysException{
		return taskdao.getEvaTaskMasterBOByOrgId(pagevo, planID, orgId);
	}
	public List getNotEvaTaskMasterBOPeson(PageVO pagevo, String planID, String orgId)throws SysException{
		return taskdao.getNotEvaTaskMasterBOPeson(pagevo, planID, orgId);
	}
	public EvaTaskMasterBO findEvaTaskMasterBO(String mastrid)throws SysException{
		return (EvaTaskMasterBO)taskdao.findBoById(EvaTaskMasterBO.class, mastrid);
	}
	public void saveEvaTaskMasterBO(EvaTaskMasterBO bo)throws SysException{
		taskdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaTaskMasterBO(String masterid)throws SysException{
		taskdao.deleteBo(EvaTaskMasterBO.class, masterid);
	}
	public EvaTaskMasterBO findEvaTaskMasterBOByPid(String planId,String personId)throws SysException{
		return taskdao.findEvaTaskMasterBOByPid(planId, personId);
	}
	public List findEvaTaskEstimateBOByMasterId(String masterId)throws SysException{
		return taskdao.findEvaTaskEstimateBOByMasterId(masterId);
	}
	public EvaTaskEstimateBO findEvaTaskEstimateBO(String itemId)throws SysException{
		return (EvaTaskEstimateBO)taskdao.findBoById(EvaTaskEstimateBO.class, itemId);
	}
	public void saveEvaTaskEstimateBO(EvaTaskEstimateBO bo)throws SysException{
		taskdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaTaskEstimateBO(String itemId)throws SysException{
		taskdao.deleteBo(EvaTaskEstimateBO.class, itemId);
	}
	public List getManagePersons(String planID,String postID) throws SysException{
        String sql="select master_id,a001001 from EVA_TASK_MASTER left join a001 on EVA_TASK_MASTER.PERSON_ID=a001.id where PLAN_ID='"+planID+"' and A001715 in (select postid from c001 where c001015='"+postID+"')";
        
		CellVO[] cv=new CellVO[2];
        cv[0]=new CellVO();
        cv[0].setItemId("master_id");

        cv[1]=new CellVO();
        cv[1].setItemId("a001001");

        Vector rs=activePageAPI.getDataListBySql(cv,sql);
        List result=new ArrayList();
        for(int i=0;i<rs.size();i++){
           CellVO row[]=(CellVO[])rs.get(i);
           SelectItem si=new SelectItem();
           si.setValue(row[0].getValue());
           si.setLabel(row[1].getValue());
           result.add(si);
        }
        return result;
    }
	public List getAllEvaTaskMasterBOforPage(PageVO pagevo,String planId)throws SysException{
		return this.taskdao.getAllEvaTaskMasterBOforPage(pagevo, planId);
	}
	public List findTaskResultScore( String planID, String orgId)throws SysException{
		return this.taskdao.findTaskResultScore(planID, orgId);
	}
	public List getAllLogByMasterId(String masterId)throws SysException{
		return this.taskdao.getAllLogByMasterId(masterId);
	}
	public void saveEvaTaskEstimateLogBO(EvaTaskEstimateLogBO bo)throws SysException{
		this.taskdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaTaskEstimateLogBO(String logId)throws SysException{
		this.taskdao.deleteBo(EvaTaskEstimateLogBO.class, logId);
	}
	public List getAllProcessByItemId(String itemId)throws SysException{
		return taskdao.getAllProcessByItemId(itemId);
	}
	public EvaTaskProcessBO findEvaTaskProcessBOById(String processId)throws SysException{
		return (EvaTaskProcessBO)taskdao.findBoById(EvaTaskProcessBO.class, processId);
	}
	public void saveEvaTaskProcessBO(EvaTaskProcessBO bo)throws SysException{
		taskdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaTaskProcessBO(String processId)throws SysException{
		taskdao.deleteBo(EvaTaskProcessBO.class, processId);
	}
	public List getTaskResultScore(PageVO pagevo,String planID, String orgId)throws SysException{
		return this.taskdao.getTaskResultScore(pagevo, planID, orgId);
	}
	public EvaTaskEstimateDAO getTaskdao() {
		return taskdao;
	}

	public void setTaskdao(EvaTaskEstimateDAO taskdao) {
		this.taskdao = taskdao;
	}
	public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}
	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}
}
