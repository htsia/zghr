package com.hr319wg.eva.ucc.impl;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.eva.pojo.bo.*;
import com.hr319wg.eva.service.EvaPlanService;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.service.ActivePageService;
import com.hr319wg.util.CommonFuns;

import java.util.List;

/**
 * 考核计划UCC-接口类 涉及到考核计划管理的逻辑处理接口.
 */
public class EvaPlanUCC implements IEvaPlanUCC {
	private EvaPlanService evaplanservice;
	private ActivePageService actionPageServie;

	public ActivePageService getActionPageServie() {
		return actionPageServie;
	}

	public void setActionPageServie(ActivePageService actionPageServie) {
		this.actionPageServie = actionPageServie;
	}

	public List findByStatus(String status) throws SysException {
		return evaplanservice.findByStatus(status);
	}

	/**
	 * 新增一条考核计划
	 */
	public String createPlan(EvaPlanBO evaPlanBO) throws RollbackableException {
		String planId = null;

		try {
			planId = this.evaplanservice.createPlan(evaPlanBO);
		} catch (Exception e) {
			throw (new RollbackableException("信息提示", "新增考核计划出错", e, this
					.getClass()));
		}

		return planId;
	}

	/**
	 * 更新一条考核计划
	 */
	public void updatePlan(EvaPlanBO evaPlanBO) throws RollbackableException {
		try {
			this.evaplanservice.updatePlan(evaPlanBO);
		} catch (Exception e) {
			throw (new RollbackableException("信息提示", "更新考核计划出错", null, null));
		}
	}

	/**
	 * 删除考核计划
	 */
	public void deletePlan(String planId) throws RollbackableException {
		try {
			// 删除考核计划记录
			this.evaplanservice.deletePlanById(planId);
		} catch (Exception e) {
			throw (new RollbackableException("信息提示", "删除考核计划出错", e, this
					.getClass()));
		}
	}

	public EvaPlanBO findPlanById(String planId) throws SysException {
		return evaplanservice.findPlanById(planId);
	}

	public EvaPlanService getEvaplanservice() {
		return evaplanservice;
	}

	public void setEvaplanservice(EvaPlanService evaplanservice) {
		this.evaplanservice = evaplanservice;
	}


	public List findPublishPlan(String status, String orgid)
			throws SysException {
		return evaplanservice.findPublishPlan(status, orgid);
	}

	public void saveEvaInfo(EvaInfoBO bo,User user) throws SysException {
		 String sql="select subid from A746 where A746702='"+bo.getPlanId()+"' and id='"+bo.getId()+"'";
		 String pk=this.actionPageServie.queryForString(sql);
		 if(pk!=null&&!pk.equals("")){
			 String[] infoItems = new String[]{"A746701", "A746702", "A746703", "A746705", "A746710","A746715","A746720","A746735","A746730","A746750"};
				String[] itemValues =new String []{CommonFuns.filterNull(bo.getPlanName()),CommonFuns.filterNull(bo.getPlanId()),CommonFuns.filterNull(bo.getOrgID()),
						CommonFuns.filterNull(bo.getPlanType()),CommonFuns.filterNull(bo.getBeginDate()),CommonFuns.filterNull(bo.getEndDate()),CommonFuns.filterNull(bo.getOrgName()),
						CommonFuns.filterNull(bo.getPlanGradeName()),CommonFuns.filterNull(bo.getResultAuditExplain()),CommonFuns.filterNull(bo.getScoreIndex())};
				this.actionPageServie.updatePageInfo("A746", user, pk, bo.getId(), false, null, null, infoItems, itemValues);
		 }else{
			 String[] infoItems = new String[]{"A746701", "A746702", "A746703", "A746705", "A746710","A746715","A746720","A746735","A746730","A746750"};
				String[] itemValues =new String []{CommonFuns.filterNull(bo.getPlanName()),CommonFuns.filterNull(bo.getPlanId()),CommonFuns.filterNull(bo.getOrgID()),
						CommonFuns.filterNull(bo.getPlanType()),CommonFuns.filterNull(bo.getBeginDate()),CommonFuns.filterNull(bo.getEndDate()),CommonFuns.filterNull(bo.getOrgName()),
						CommonFuns.filterNull(bo.getPlanGradeName()),CommonFuns.filterNull(bo.getResultAuditExplain()),CommonFuns.filterNull(bo.getScoreIndex())};
				this.actionPageServie.addPageInfo("A746", user, null, bo.getId(), false, infoItems, itemValues);
		 }
	}

	// qiaolei
	public List findPlanByPersonID(String personid, String status, String model)
			throws SysException {
		return evaplanservice.findPlanByPersonID(personid, status, model);
	}
	public List findByModel(String model) throws SysException{
    	return evaplanservice.findByModel(model);
    }
	public List findByOrgId(String orgId, String status, String model)
	throws SysException{
		return evaplanservice.findByOrgId(orgId, status, model);
	}
	//方霞绩效结果分析
	public List findByOrgAndStatus(String[] status,String orgId) throws SysException{
		
		return evaplanservice.findByOrgAndStatus(status,orgId);
	}
	public List getAllTableModeEvaPlanBOByPersonId(String personId)throws SysException{
		return this.evaplanservice.getAllTableModeEvaPlanBOByPersonId(personId);
	}
	public void saveMessageToA746(EvaInfoBO bo,User user)throws SysException{
		String sql="select subid from A746 where A746702='"+bo.getPlanId()+"' and id='"+bo.getId()+"'";
		String pk=this.actionPageServie.queryForString(sql);
		if(pk!=null&&!pk.equals("")){
			String[] infoItems = new String[]{"A746701", "A746702", "A746703", "A746705", "A746710","A746715","A746720","A746735","A746755"};
			String[] itemValues =new String []{CommonFuns.filterNull(bo.getPlanName()),CommonFuns.filterNull(bo.getPlanId()),CommonFuns.filterNull(bo.getOrgID()),
					CommonFuns.filterNull(bo.getPlanType()),CommonFuns.filterNull(bo.getBeginDate()),CommonFuns.filterNull(bo.getEndDate()),CommonFuns.filterNull(bo.getOrgName()),
					CommonFuns.filterNull(bo.getPlanGradeName()),CommonFuns.filterNull(bo.getWorkSum())};
			this.actionPageServie.updatePageInfo("A746", user, pk, bo.getId(),false, null,null, infoItems, itemValues);
		}else{
			String[] infoItems = new String[]{"A746701", "A746702", "A746703", "A746705", "A746710","A746715","A746720","A746735","A746755"};
			String[] itemValues =new String []{CommonFuns.filterNull(bo.getPlanName()),CommonFuns.filterNull(bo.getPlanId()),CommonFuns.filterNull(bo.getOrgID()),
					CommonFuns.filterNull(bo.getPlanType()),CommonFuns.filterNull(bo.getBeginDate()),CommonFuns.filterNull(bo.getEndDate()),CommonFuns.filterNull(bo.getOrgName()),
					CommonFuns.filterNull(bo.getPlanGradeName()),CommonFuns.filterNull(bo.getWorkSum())};
			this.actionPageServie.addPageInfo("A746", user, null, bo.getId(), false, infoItems, itemValues);
		}
	}
	public List getAllEvaPlanBOByOrgId(String orgId)throws SysException{
		return this.evaplanservice.getAllEvaPlanBOByOrgId(orgId);
	}
	public String getWorkSumByPlanIdAndPid(String planId,String pid)throws SysException{
		String sql="select A746755 from A746 where A746702='"+planId+"' and id='"+pid+"'";
		return this.actionPageServie.queryForString(sql);
	}
	public List getAllEvaPlanControlBOByPlanIdAndTemId(String planId,String temId)throws SysException{
		return this.evaplanservice.getAllEvaPlanControlBOByPlanIdAndTemId(planId, temId);
	}
    public EvaPlanControlBO findTheSuitEvaPlanControlBO(String planId,String temId,String gradeId)throws SysException{
    	return this.evaplanservice.findTheSuitEvaPlanControlBO(planId, temId, gradeId);
    }
    public EvaPlanControlBO findEvaPlanControlBOById(String itemId)throws SysException{
    	return this.evaplanservice.findEvaPlanControlBOById(itemId);
    }
    public void saveEvaPlanControlBO(EvaPlanControlBO bo)throws SysException{
    	this.evaplanservice.saveEvaPlanControlBO(bo);
    }
    public void deleteEvaPlanControlBO(String itemId)throws SysException{
    	this.evaplanservice.deleteEvaPlanControlBO(itemId);
    }
    public List getAllEvaPlanBObyMaster(String personId)throws SysException{
    	return this.evaplanservice.getAllEvaPlanBObyMaster(personId);
    }
    public List getAllEvaPlanElectionControlBOByPlanId(String planId)throws SysException{
    	return this.evaplanservice.getAllEvaPlanElectionControlBOByPlanId(planId);
    }
    public EvaPlanElectionControlBO findEvaPlanElectionControlBOById(String itemId)throws SysException{
    	return this.evaplanservice.findEvaPlanElectionControlBOById(itemId);
    }
    public EvaPlanElectionControlBO findTheSuitEvaPlanElectionControlBO(String planId,String masterType,String gradeItem)throws SysException{
    	return this.evaplanservice.findTheSuitEvaPlanElectionControlBO(planId, masterType, gradeItem);
    }
    public void saveEvaPlanElectionControlBO(EvaPlanElectionControlBO bo)throws SysException{
    	this.evaplanservice.saveEvaPlanElectionControlBO(bo);
    }
    public void deleteEvaPlanElectionControlBO(String itemId)throws SysException{
    	this.evaplanservice.deleteEvaPlanElectionControlBO(itemId);
    }
    
    public List getAllEvaPlanMixBOByPlanId(String planId)throws SysException{
    	return this.evaplanservice.getAllEvaPlanMixBOByPlanId(planId);
    }
    public EvaPlanMixBO findEvaPlanMixBOById(String mixId)throws SysException{
    	return this.evaplanservice.findEvaPlanMixBOById(mixId);
    }
    public void saveEvaPlanMixBO(EvaPlanMixBO bo)throws SysException{
    	this.evaplanservice.saveEvaPlanMixBO(bo);
    }
    public void deleteEvaPlanMixBO(String mixId)throws SysException{
    	this.evaplanservice.deleteEvaPlanMixBO(mixId);
    }

     public List getAllEvaCaclControlBOByPlanId(String planId)throws SysException{
        return this.evaplanservice.getAllEvaCaclControlBOByPlanId(planId);
    }
    public EvaCaclControlBO findEqualsEvaCaclControlBO(String planId,String templateId,String masterType)throws SysException{
        return this.evaplanservice.findEqualsEvaCaclControlBO(planId,templateId,masterType);
    }
    public EvaCaclControlBO findEvaCaclControlBOByItemId(String itemId)throws SysException{
        return this.evaplanservice.findEvaCaclControlBOByItemId(itemId);
    }
    public void saveEvaCaclControlBO(EvaCaclControlBO bo)throws SysException{
        this.evaplanservice.saveEvaCaclControlBO(bo);
    }
    public void deleteEvaCaclControlBO(String itemId)throws SysException{
        this.evaplanservice.deleteEvaCaclControlBO(itemId);
    }
}
