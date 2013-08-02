package com.hr319wg.xys.eva.service;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.dao.XysEvaPlanDAO;
import com.hr319wg.xys.eva.pojo.bo.EvaExcPostBO;
import com.hr319wg.xys.eva.pojo.bo.XysBeginGradeErrorBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaModeSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysLevelWeightSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysScoreCtrBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightExcPersBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-27
 * Time: ÉÏÎç9:47
 * To change this template use File | Settings | File Templates.
 */
public class XysEvaPlanService {
    private XysEvaPlanDAO xysEvaPlanDAO;

    public List getXysEvaPlanBO(PageVO pagevo,String createOrg,String[] status) throws SysException{
        return this.xysEvaPlanDAO.getXysEvaPlanBO(pagevo,createOrg,status);
    }
    public List getAllXysEvaPlanBO()throws SysException{
    	return this.xysEvaPlanDAO.getAllXysEvaPlanBO();
    }
    public XysEvaPlanBO findXysEvaPlanBOById(String planId)throws SysException{
        return (XysEvaPlanBO)this.xysEvaPlanDAO.findBoById(XysEvaPlanBO.class,planId);
    }
    public void saveXysEvaPlanBO(XysEvaPlanBO bo)throws SysException{
        this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysEvaPlanBO(String planId)throws SysException{
        this.xysEvaPlanDAO.deleteBo(XysEvaPlanBO.class,planId);
    }


    public EvaExcPostBO findEqualsEvaExcPostBO(String planId,String postId)throws SysException{
        return this.xysEvaPlanDAO.findEqualsEvaExcPostBO(planId,postId);
    }
    public void saveEvaExcPostBO(EvaExcPostBO bo)throws SysException{
         this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    public void deleteEvaExcPostBO(String excId)throws SysException{
        this.xysEvaPlanDAO.deleteBo(EvaExcPostBO.class,excId);
    }
    public List getEvaPostBOByPlanId(PageVO pagevo,String orgId,String planId,String showMode)throws SysException{
        return this.xysEvaPlanDAO.getEvaPostBOByPlanId(pagevo,orgId,planId,showMode);
    }

    public XysEvaModeSetBO getXysEvaModeSetBO(String planId,String postId)throws SysException{
        return this.xysEvaPlanDAO.getXysEvaModeSetBO(planId,postId);
    }
    public Hashtable getXysEvaModeSetBOByPlanForMap(String planId)throws SysException{
    	return this.xysEvaPlanDAO.getXysEvaModeSetBOByPlanForMap(planId);
    }
    public  XysEvaModeSetBO findXysEvaModeSetBOById(String setId)throws SysException{
        return (XysEvaModeSetBO)this.xysEvaPlanDAO.findBoById(XysEvaModeSetBO.class,setId);
    }
    public void saveXysEvaModeSetBO(XysEvaModeSetBO bo)throws SysException{
        this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysEvaModeSetBO(String setId)throws SysException{
        this.xysEvaPlanDAO.deleteBo(XysEvaModeSetBO.class,setId);
    }


    public List getXysWeightSetBO(String planId,String postId,String type)throws SysException{
        return this.xysEvaPlanDAO.getXysWeightSetBO(planId,postId,type);
    }
    public XysWeightSetBO findXysWeightSetBOById(String setId)throws SysException{
        return (XysWeightSetBO)this.xysEvaPlanDAO.findBoById(XysWeightSetBO.class,setId);
    }
    public void saveXysWeightSetBO(XysWeightSetBO bo)throws SysException{
        this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysWeightSetBO(String setId)throws SysException{
        this.xysEvaPlanDAO.deleteBo(XysWeightSetBO.class,setId);
    }
    public XysWeightSetBO findEqualsXysWeightSetBO(String planId,String postId,String evaPost,String type)throws SysException{
        return this.xysEvaPlanDAO.findEqualsXysWeightSetBO(planId,postId,evaPost,type);
    }

    
    public XysWeightExcPersBO findEqualsXysWeightExcPersBO(String setId,String personId)throws SysException{
    	return this.xysEvaPlanDAO.findEqualsXysWeightExcPersBO(setId, personId);
    }
    public void saveXysWeightExcPersBO(XysWeightExcPersBO bo)throws SysException{
    	this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysWeightExcPersBO(String excId)throws SysException{
    	this.xysEvaPlanDAO.deleteBo(XysWeightExcPersBO.class, excId);
    }
    
    
    
    public List getXysScoreCtrBOByPlanId(String planId,String type)throws SysException{
    	return this.xysEvaPlanDAO.getXysScoreCtrBOByPlanId(planId, type);
    }
    public XysScoreCtrBO findXysScoreCtrBOById(String ctrId)throws SysException{
    	return (XysScoreCtrBO)this.xysEvaPlanDAO.findBoById(XysScoreCtrBO.class, ctrId);
    }
    public void saveXysScoreCtrBO(XysScoreCtrBO bo)throws SysException{
    	this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysScoreCtrBO(String ctrId)throws SysException{
    	this.xysEvaPlanDAO.deleteBo(XysScoreCtrBO.class, ctrId);
    }
    public XysScoreCtrBO findEqualsXysScoreCtrBO(String planId,String type,String gradItem)throws SysException{
    	return this.xysEvaPlanDAO.findEqualsXysScoreCtrBO(planId, type, gradItem);
    }
    
    
    public List getPersonBOByWeightSetId(String setId)throws SysException{
    	return this.xysEvaPlanDAO.getPersonBOByWeightSetId(setId);
    }
    
    
    public void deleteAll(List list)throws SysException{
        this.xysEvaPlanDAO.deleteAll(list);
    }
    
    public List getEqualsPostBOByPlanId(String planId)throws SysException{
    	return this.xysEvaPlanDAO.getEqualsPostBOByPlanId(planId);
    }
    
    
    public List getXysBeginGradeErrorBO(PageVO pagevo,String planId,String objType)throws SysException{
    	return this.xysEvaPlanDAO.getXysBeginGradeErrorBO(pagevo,planId, objType);
    }
    public XysBeginGradeErrorBO findXysBeginGradeErrorBO(String errorId)throws SysException{
    	return (XysBeginGradeErrorBO)this.xysEvaPlanDAO.findBoById(XysBeginGradeErrorBO.class,errorId);
    }
    public void saveXysBeginGradeErrorBO(XysBeginGradeErrorBO bo)throws SysException{
    	this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    
    public void deleteXysBeginGradeErrorBO(String errorId)throws SysException{
    	this.xysEvaPlanDAO.deleteBo(XysBeginGradeErrorBO.class, errorId);
    }
    
    public XysLevelWeightSetBO findEqualsXysLevelWeightSetBO(String planId,String postId,String type)throws SysException{
    	return this.xysEvaPlanDAO.findEqualsXysLevelWeightSetBO(planId, postId, type);
    }
    public void saveXysLevelWeightSetBO(XysLevelWeightSetBO bo)throws SysException{
    	this.xysEvaPlanDAO.saveOrUpdateBo(bo);
    }
    
    public Hashtable getIllegalPostBOByPlanIdForMap(String planId)throws SysException{
    	return this.xysEvaPlanDAO.getIllegalPostBOByPlanIdForMap(planId);
    }
    
    public List getXysExportTempBOByPlanId(String planId)throws SysException{
    	return this.xysEvaPlanDAO.getXysExportTempBOByPlanId(planId);
    }
    

    public XysEvaPlanDAO getXysEvaPlanDAO() {
        return xysEvaPlanDAO;
    }

    public void setXysEvaPlanDAO(XysEvaPlanDAO xysEvaPlanDAO) {
        this.xysEvaPlanDAO = xysEvaPlanDAO;
    }
	public void copyXysEvaPlanBO(String planId) throws SysException {
		this.xysEvaPlanDAO.copyXysEvaPlanBO(planId);
	}
}
