package com.hr319wg.eva.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.dao.jobEstimateDAO;
import com.hr319wg.eva.pojo.bo.EvaJobContentBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;

public class jobEstimateService {
	private jobEstimateDAO jobEstimateDAO;
	private ActivePageAPI activePageAPI;

	public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}

	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}
	
	public void deleteJobEstimatByID(String itemid)throws SysException{
		this.jobEstimateDAO.deleteBo(EvaJobEstimateBO.class, itemid);
	}
	// 职责考核结果
	public List findJobEstimateScore(PageVO pagevo, String planID)
			throws SysException {
		return jobEstimateDAO.findJobEstimateScore(pagevo, planID);
	}

	public List findJobContent(String itemId, String seq) throws SysException {
		return jobEstimateDAO.findJobContent(itemId, seq);
	}

	public void updateJobContent(EvaJobContentBO bo) throws SysException {
		jobEstimateDAO.saveOrUpdateBo(bo);
	}

	public void deleteJobPlan(String taskID) throws SysException {
		jobEstimateDAO.deleteBo(EvaJobContentBO.class, taskID);
	}

	public void updateJobPlan(EvaJobContentBO bo) throws SysException {
		jobEstimateDAO.saveOrUpdateBo(bo);
	}

	public EvaJobContentBO findJobPlanById(String taskID) throws SysException {
		return (EvaJobContentBO) jobEstimateDAO.findBoById(
				EvaJobContentBO.class, taskID);
	}

	public EvaJobEstimateBO findJobEstimate(String planID, String personID)
			throws SysException {
		return jobEstimateDAO.findJobEstimate(planID, personID);
	}

	public void saveDuty(EvaJobEstimateBO evaJobEstimateBO) throws SysException {
		jobEstimateDAO.createBo(evaJobEstimateBO);
	}

	// 第一次进入时将c008表中的数据插入到Eva_Job_Estimate表中
	public void insertDuty(String postId, String personId, String planId)
			throws SysException {
			String[] sql = new String[40];
			sql[0] = "update eva_job_estimate "
					+ "set c008001 = (select c008001 from c008 where postid='"
					+ postId + "') where person_id ='" + personId
					+ "' and plan_id='" + planId + "'";
			sql[1] = "update eva_job_estimate set c008005=(select c008005 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[2] = "update eva_job_estimate set c008010=(select c008010 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[3] = "update eva_job_estimate set c008015=(select c008015 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[4] = "update eva_job_estimate set c008701=(select c008701 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[5] = "update eva_job_estimate set c008702=(select c008702 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[6] = "update eva_job_estimate set c008703=(select c008703 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[7] = "update eva_job_estimate set c008704=(select c008704 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[8] = "update eva_job_estimate set c008705=(select c008705 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[9] = "update eva_job_estimate set c008706=(select c008706 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[10] = "update eva_job_estimate set c008707=(select c008707 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[11] = "update eva_job_estimate set c008708=(select c008708 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[12] = "update eva_job_estimate set c008709=(select c008709 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[13] = "update eva_job_estimate set c008710=(select c008710 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[14] = "update eva_job_estimate set c008711=(select c008711 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[15] = "update eva_job_estimate set c008712=(select c008712 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[16] = "update eva_job_estimate set c008713=(select c008713 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[17] = "update eva_job_estimate set c008714=(select c008714 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[18] = "update eva_job_estimate set c008715=(select c008715 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[19] = "update eva_job_estimate set c008716=(select c008716 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[20] = "update eva_job_estimate set c008717=(select c008717 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[21] = "update eva_job_estimate set c008718=(select c008718 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[22] = "update eva_job_estimate set c008719=(select c008719 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[23] = "update eva_job_estimate set c008720=(select c008720 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[24] = "update eva_job_estimate set c008721=(select c008721 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[25] = "update eva_job_estimate set c008722=(select c008722 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[26] = "update eva_job_estimate set c008723=(select c008723 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[27] = "update eva_job_estimate set c008724=(select c008724 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[28] = "update eva_job_estimate set c008725=(select c008725 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[29] = "update eva_job_estimate set c008726=(select c008726 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[30] = "update eva_job_estimate set c008727=(select c008727 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[31] = "update eva_job_estimate set c008728=(select c008728 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[32] = "update eva_job_estimate set c008729=(select c008729 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[33] = "update eva_job_estimate set c008730=(select c008730 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[34] = "update eva_job_estimate set c008731=(select c008731 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[35] = "update eva_job_estimate set c008732=(select c008732 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[36] = "update eva_job_estimate set c008733=(select c008733 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[37] = "update eva_job_estimate set c008734=(select c008734 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[38] = "update eva_job_estimate set c008735=(select c008735 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			sql[39] = "update eva_job_estimate set c008736=(select c008736 from c008 where postid='"
					+ postId
					+ "') where person_id ='"
					+ personId
					+ "' and plan_id='" + planId + "'";
			activePageAPI.batchExecuteSql(sql);
			
	}
	// 直接上级岗位下的所有人员
	 public List getManagePersons(String planID,String postID) throws SysException{
	        String sql="select item_id,a001001 from eva_job_estimate left join a001 on eva_job_estimate.person_id=a001.id where plan_id='"+planID+"' and A001715 in (select postid from c001 where c001015='"+postID+"')";
	        
			CellVO[] cv=new CellVO[2];
	        cv[0]=new CellVO();
	        cv[0].setItemId("item_id");

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
	//fangxia职责考核
	public List findResultScore(PageVO pagevo,String planID,String orgId) throws SysException {
			return jobEstimateDAO.findResultScore(pagevo, planID, orgId);
	}
	public EvaJobEstimateBO findSelfJobEstimateBO(String planID, String personID) throws SysException{
			return jobEstimateDAO.findSelfJobEstimate(planID, personID);
	}
	public List findHaveCheckInPerson(PageVO pagevo,String planID,String orgid)throws SysException{
		return jobEstimateDAO.findHaveCheckInPerson(pagevo, planID,orgid);
	}
	public List findHaveNotCheckPerson(PageVO pagevo,String planID,String orgid)throws SysException{
		return jobEstimateDAO.findHaveNotCheckPerson(pagevo, planID,orgid);
	}
	
	//更新eva_job_estimate表中的数据
	public void updateEstimate(EvaJobEstimateBO bo) throws SysException{
		jobEstimateDAO.saveOrUpdateBo(bo);
	}
	//删除content表中指定的内容
	public void deleteJobContent(String itemId,String seq) throws SysException{
		String sql="delete from eva_job_content where item_id ='"+itemId+"' and seq ='"+seq+"'";
		activePageAPI.executeSql(sql);
	}
	public void saveJobEstimateLogBO(JobEstimateLogBO bo)throws SysException{
		this.jobEstimateDAO.createBo(bo);
	}
	public List getAllJobEstimateLogBO(String itemID)throws SysException{
		return jobEstimateDAO.getAllJobEstimateLogBO(itemID);
	}
	public void deleteJobEstimateLogBOById(String logid)throws SysException{
		jobEstimateDAO.deleteBo(JobEstimateLogBO.class, logid);
	}
	
	public jobEstimateDAO getJobEstimateDAO() {
		return jobEstimateDAO;
	}

	public void setJobEstimateDAO(jobEstimateDAO jobEstimateDAO) {
		this.jobEstimateDAO = jobEstimateDAO;
	}
	
}
