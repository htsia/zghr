package com.hr319wg.eva.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.eva.dao.EvaPlanDAO;
import com.hr319wg.eva.pojo.bo.*;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.util.SequenceGenerator;

import java.util.List;

/**
 * 考核计划Service
 * 
 * 对考核计划的增删改查处理.
 */
public class EvaPlanService {
	private EvaPlanDAO evaplandao;

	public List findByStatus(String status) throws SysException {
		return evaplandao.findByStatus(status);
	}

	/**
	 * 新增一条考核计划
	 */
	public String createPlan(EvaPlanBO evaPlanBO) throws RollbackableException {
		String id = null;
		try {
			id = this.evaplandao.createBo(evaPlanBO);
		} catch (Exception e) {
			throw (new RollbackableException("信息提示", "创建考核计划出错", e, this
					.getClass()));
		}
		return id;
	}

	/**
	 * 更新一条考核计划
	 * 
	 */
	public void updatePlan(EvaPlanBO evaPlanBO) throws RollbackableException {
		try {
			this.evaplandao.getHibernatetemplate().update(evaPlanBO);
		} catch (Exception e) {
			throw (new RollbackableException("信息提示", "更新考核计划出错", e, this
					.getClass()));
		}
	}

	/**
	 * 删除一条考核计划
	 * 
	 */
	public void deletePlanById(String planId) throws RollbackableException {
		try {
			this.evaplandao.deleteBo(EvaPlanBO.class, planId);
		} catch (Exception e) {
			throw (new RollbackableException("信息提示", "删除考核计划出错", e, this
					.getClass()));
		}
	}

	public EvaPlanBO findPlanById(String planId) throws SysException {
		return (EvaPlanBO) evaplandao.findBoById(EvaPlanBO.class, planId);
	}

	public EvaPlanDAO getEvaplandao() {
		return evaplandao;
	}

	public void setEvaplandao(EvaPlanDAO evaplandao) {
		this.evaplandao = evaplandao;
	}

	public List findPublishPlan(String status, String orgid)
			throws SysException {
		return evaplandao.findPublishPlan(status, orgid);
	}
	// qiaolei
	public List findPlanByPersonID(String personid, String status, String model)
			throws SysException {
		return evaplandao.findPlanByPersonID(personid, status, model);
	}
	public List findByOrgId(String orgId, String status, String model)
	throws SysException{
		return evaplandao.findByOrgId(orgId, status, model);
	}
	public List findByModel(String model) throws SysException {
		return evaplandao.findByModel(model);
	}

    public List findByOrgAndStatus(String[] status,String orgId) throws SysException 
    {
    	return evaplandao.findByOrgAndStatus(status,orgId);
    }
    public List getAllTableModeEvaPlanBOByPersonId(String personId)throws SysException{
    	return this.evaplandao.getAllTableModeEvaPlanBOByPersonId(personId);
    }
    public List getAllEvaPlanBOByOrgId(String orgId)throws SysException{
    	return this.evaplandao.getAllEvaPlanBOByOrgId(orgId);
    }
    public List getAllEvaPlanControlBOByPlanIdAndTemId(String planId,String temId)throws SysException{
    	return this.evaplandao.getAllEvaPlanControlBOByPlanIdAndTemId(planId,temId);
    }
    public EvaPlanControlBO findTheSuitEvaPlanControlBO(String planId,String temId,String gradeId)throws SysException{
    	return this.evaplandao.findTheSuitEvaPlanControlBO(planId, temId, gradeId);
    }
    public EvaPlanControlBO findEvaPlanControlBOById(String itemId)throws SysException{
    	return (EvaPlanControlBO)this.evaplandao.findBoById(EvaPlanControlBO.class, itemId);
    }
    public void saveEvaPlanControlBO(EvaPlanControlBO bo)throws SysException{
    	this.evaplandao.saveOrUpdateBo(bo);
    }
    public void deleteEvaPlanControlBO(String itemId)throws SysException{
    	this.evaplandao.deleteBo(EvaPlanControlBO.class, itemId);
    }
    public List getAllEvaPlanBObyMaster(String personId)throws SysException{
    	return this.evaplandao.getAllEvaPlanBObyMaster(personId);
    }
    public List getAllEvaPlanElectionControlBOByPlanId(String planId)throws SysException{
    	return this.evaplandao.getAllEvaPlanElectionControlBOByPlanId(planId);
    }
    public EvaPlanElectionControlBO findEvaPlanElectionControlBOById(String itemId)throws SysException{
    	return (EvaPlanElectionControlBO)this.evaplandao.findBoById(EvaPlanElectionControlBO.class, itemId);
    }
    public EvaPlanElectionControlBO findTheSuitEvaPlanElectionControlBO(String planId,String masterType,String gradeItem)throws SysException{
    	return this.evaplandao.findTheSuitEvaPlanElectionControlBO(planId, masterType, gradeItem);
    }
    public void saveEvaPlanElectionControlBO(EvaPlanElectionControlBO bo)throws SysException{
    	this.evaplandao.saveOrUpdateBo(bo);
    }
    public void deleteEvaPlanElectionControlBO(String itemId)throws SysException{
    	this.evaplandao.deleteBo(EvaPlanElectionControlBO.class, itemId);
    }
    public List getAllEvaPlanMixBOByPlanId(String planId)throws SysException{
    	return this.evaplandao.getAllEvaPlanMixBOByPlanId(planId);
    }
    public EvaPlanMixBO findEvaPlanMixBOById(String mixId)throws SysException{
    	return (EvaPlanMixBO)this.evaplandao.findBoById(EvaPlanMixBO.class, mixId);
    }
    public void saveEvaPlanMixBO(EvaPlanMixBO bo)throws SysException{
    	this.evaplandao.saveOrUpdateBo(bo);
    }
    public void deleteEvaPlanMixBO(String mixId)throws SysException{
    	this.evaplandao.deleteBo(EvaPlanMixBO.class, mixId);
    }


    public List getAllEvaCaclControlBOByPlanId(String planId)throws SysException{
        return this.evaplandao.getAllEvaCaclControlBOByPlanId(planId);
    }

    public EvaCaclControlBO findEqualsEvaCaclControlBO(String planId,String templateId,String masterType)throws SysException{
        return this.evaplandao.findEqualsEvaCaclControlBO(planId,templateId,masterType);
    }

    public EvaCaclControlBO findEvaCaclControlBOByItemId(String itemId)throws SysException{
        return (EvaCaclControlBO)this.evaplandao.findBoById(EvaCaclControlBO.class,itemId);
    }

    public void saveEvaCaclControlBO(EvaCaclControlBO bo)throws SysException{
        this.evaplandao.saveOrUpdateBo(bo);
    }

    public void deleteEvaCaclControlBO(String itemId)throws SysException{
        this.evaplandao.deleteBo(EvaCaclControlBO.class,itemId);
    }

}
