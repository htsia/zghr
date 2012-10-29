package com.hr319wg.xys.eva.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.EvaExcPostBO;
import com.hr319wg.xys.eva.pojo.bo.XysBeginGradeErrorBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaModeSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysLevelWeightSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysScoreCtrBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightExcPersBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;
import com.hr319wg.xys.eva.service.XysEvaPlanService;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

import java.util.Hashtable;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-27
 * Time: ÉÏÎç10:02
 * To change this template use File | Settings | File Templates.
 */
public class XysEvaPlanUCC implements IXysEvaPlanUCC{
    private XysEvaPlanService xysEvaPlanService;
    public List getXysEvaPlanBO(PageVO pagevo,String createOrg,String[] status) throws SysException{
         return this.xysEvaPlanService.getXysEvaPlanBO(pagevo,createOrg,status);
    }
    public List getAllXysEvaPlanBO()throws SysException{
    	return this.xysEvaPlanService.getAllXysEvaPlanBO();
    }
    public XysEvaPlanBO findXysEvaPlanBOById(String planId)throws SysException{
         return this.xysEvaPlanService.findXysEvaPlanBOById(planId);
    }
    public void saveXysEvaPlanBO(XysEvaPlanBO bo)throws SysException{
         this.xysEvaPlanService.saveXysEvaPlanBO(bo);
    }
    public void deleteXysEvaPlanBO(String planId)throws SysException{
         this.xysEvaPlanService.deleteXysEvaPlanBO(planId);
    }

    public EvaExcPostBO findEqualsEvaExcPostBO(String planId,String postId)throws SysException{
          return this.xysEvaPlanService.findEqualsEvaExcPostBO(planId,postId);
    }
    public void saveEvaExcPostBO(EvaExcPostBO bo)throws SysException{
          this.xysEvaPlanService.saveEvaExcPostBO(bo);
    }
    public void deleteEvaExcPostBO(String excId)throws SysException{
          this.xysEvaPlanService.deleteEvaExcPostBO(excId);
    }
    public List getEvaPostBOByPlanId(PageVO pagevo,String orgId,String planId,String showMode)throws SysException{
        return this.xysEvaPlanService.getEvaPostBOByPlanId(pagevo,orgId,planId,showMode);
    }

    public XysEvaModeSetBO getXysEvaModeSetBO(String planId,String postId)throws SysException{
         return this.xysEvaPlanService.getXysEvaModeSetBO(planId,postId);
    }
    public Hashtable getXysEvaModeSetBOByPlanForMap(String planId)throws SysException{
    	 return this.xysEvaPlanService.getXysEvaModeSetBOByPlanForMap(planId);
    }
    public XysEvaModeSetBO findXysEvaModeSetBOById(String setId)throws SysException{
         return this.xysEvaPlanService.findXysEvaModeSetBOById(setId);
    }
    public void saveXysEvaModeSetBO(XysEvaModeSetBO bo)throws SysException{
         this.xysEvaPlanService.saveXysEvaModeSetBO(bo);
    }
    public void deleteXysEvaModeSetBO(String setId)throws SysException{
         this.xysEvaPlanService.deleteXysEvaModeSetBO(setId);
    }


    public List getXysWeightSetBO(String planId,String postId,String type)throws SysException{
         return this.xysEvaPlanService.getXysWeightSetBO(planId,postId,type);
    }
    public XysWeightSetBO findXysWeightSetBOById(String setId)throws SysException{
         return this.xysEvaPlanService.findXysWeightSetBOById(setId);
    }
    public void saveXysWeightSetBO(XysWeightSetBO bo)throws SysException{
         this.xysEvaPlanService.saveXysWeightSetBO(bo);
    }
    public void deleteXysWeightSetBO(String setId)throws SysException{
         this.xysEvaPlanService.deleteXysWeightSetBO(setId);
    }
    public XysWeightSetBO findEqualsXysWeightSetBO(String planId,String postId,String evaPost,String type)throws SysException{
        return this.xysEvaPlanService.findEqualsXysWeightSetBO(planId,postId,evaPost,type);
    }
    
    public XysWeightExcPersBO findEqualsXysWeightExcPersBO(String setId,String personId)throws SysException{
    	return this.xysEvaPlanService.findEqualsXysWeightExcPersBO(setId, personId);
    }
    public void saveXysWeightExcPersBO(XysWeightExcPersBO bo)throws SysException{
    	this.xysEvaPlanService.saveXysWeightExcPersBO(bo);
    }
    public void deleteXysWeightExcPersBO(String excId)throws SysException{
    	this.xysEvaPlanService.deleteXysWeightExcPersBO(excId);
    }
    
    public List getXysScoreCtrBOByPlanId(String planId,String type)throws SysException{
    	return this.xysEvaPlanService.getXysScoreCtrBOByPlanId(planId, type);
    }
    public XysScoreCtrBO findXysScoreCtrBOById(String ctrId)throws SysException{
    	return this.xysEvaPlanService.findXysScoreCtrBOById(ctrId);
    }
    public void saveXysScoreCtrBO(XysScoreCtrBO bo)throws SysException{
    	this.xysEvaPlanService.saveXysScoreCtrBO(bo);
    }
    public void deleteXysScoreCtrBO(String ctrId)throws SysException{
    	this.xysEvaPlanService.deleteXysScoreCtrBO(ctrId);
    }

    public void deleteAll(List list)throws SysException{
         this.xysEvaPlanService.deleteAll(list);
    }
    public XysScoreCtrBO findEqualsXysScoreCtrBO(String planId,String type,String gradItem)throws SysException{
    	return this.xysEvaPlanService.findEqualsXysScoreCtrBO(planId, type, gradItem);
    }
    

    public List getPersonBOByWeightSetId(String setId)throws SysException{
    	return this.xysEvaPlanService.getPersonBOByWeightSetId(setId);
    }
    
    public List getEqualsPostBOByPlanId(String planId)throws SysException{
    	return this.xysEvaPlanService.getEqualsPostBOByPlanId(planId);
    }
    
    
    public List getXysBeginGradeErrorBO(PageVO pagevo,String planId,String objType)throws SysException{
    	return this.xysEvaPlanService.getXysBeginGradeErrorBO(pagevo,planId, objType);
    }
    public XysBeginGradeErrorBO findXysBeginGradeErrorBO(String errorId)throws SysException{
    	return this.xysEvaPlanService.findXysBeginGradeErrorBO(errorId);
    }
    public void saveXysBeginGradeErrorBO(XysBeginGradeErrorBO bo)throws SysException{
    	this.xysEvaPlanService.saveXysBeginGradeErrorBO(bo);
    }
    public void deleteXysBeginGradeErrorBO(String errorId)throws SysException{
    	this.xysEvaPlanService.deleteXysBeginGradeErrorBO(errorId);
    }
    
    public XysLevelWeightSetBO findEqualsXysLevelWeightSetBO(String planId,String postId,String type)throws SysException{
    	return this.xysEvaPlanService.findEqualsXysLevelWeightSetBO(planId, postId, type);
    }
    public void saveXysLevelWeightSetBO(XysLevelWeightSetBO bo)throws SysException{
    	this.xysEvaPlanService.saveXysLevelWeightSetBO(bo);
    }
    public Hashtable getIllegalPostBOByPlanIdForMap(String planId)throws SysException{
    	return this.xysEvaPlanService.getIllegalPostBOByPlanIdForMap(planId);
    }
    public List getXysExportTempBOByPlanId(String planId)throws SysException{
    	return this.xysEvaPlanService.getXysExportTempBOByPlanId(planId);
    }
    
    public XysEvaPlanService getXysEvaPlanService() {
        return xysEvaPlanService;
    }

    public void setXysEvaPlanService(XysEvaPlanService xysEvaPlanService) {
        this.xysEvaPlanService = xysEvaPlanService;
    }
}
