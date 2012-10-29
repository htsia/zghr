package com.hr319wg.xys.eva.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.*;
import com.hr319wg.xys.eva.service.XysKpiDeptService;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: ÏÂÎç1:40
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiDeptUCC implements IXysKpiDeptUCC{
    private XysKpiDeptService xysKpiDeptService;

    public List getXysKpiDeptObjBO(PageVO pageVO,String planId,String orgId)throws SysException{
         return xysKpiDeptService.getXysKpiDeptObjBO(pageVO,planId,orgId);
    }
    public List getXysKpiDeptObjBO(String planId,String gradeItem)throws SysException{
    	return this.xysKpiDeptService.getXysKpiDeptObjBO(planId, gradeItem);
    }
    public XysKpiDeptObjBO findEqualsXysKpiDeptObjBO(String planId,String personId)throws SysException{
         return xysKpiDeptService.findEqualsXysKpiDeptObjBO(planId,personId);
    }
    public List getXysKpiDeptObjBOInSelf(String personId,String where)throws SysException{
        return xysKpiDeptService.getXysKpiDeptObjBOInSelf(personId,where);
    }
    public XysKpiDeptObjBO findXysKpiDeptObjBOById(String objId)throws SysException{
         return xysKpiDeptService.findXysKpiDeptObjBOById(objId);
    }
    public void saveXysKpiDeptObjBO(XysKpiDeptObjBO bo)throws SysException{
         xysKpiDeptService.saveXysKpiDeptObjBO(bo);
    }
    public void deleteXysKpiDeptObjBO(String objId)throws SysException{
         xysKpiDeptService.deleteXysKpiDeptObjBO(objId);
    }

    public List getXysKpiObjLibBOByObjId(String objId)throws SysException{
         return xysKpiDeptService.getXysKpiObjLibBOByObjId(objId);
    }
    public XysKpiObjLibBO findXysKpiObjLibBOById(String lobId)throws SysException{
         return xysKpiDeptService.findXysKpiObjLibBOById(lobId);
    }
    public void saveXysKpiObjLibBO(XysKpiObjLibBO bo)throws SysException{
         xysKpiDeptService.saveXysKpiObjLibBO(bo);
    }
    public void deleteXysKpiObjLibBO(String libId)throws SysException{
         xysKpiDeptService.deleteXysKpiObjLibBO(libId);
    }

    public List getXysKpiObjKeyBOByLibId(String libId)throws SysException{
         return xysKpiDeptService.getXysKpiObjKeyBOByLibId(libId);
    }
    public List getXysKpiObjKeyBOByObjId(String objId)throws SysException{
         return xysKpiDeptService.getXysKpiObjKeyBOByObjId(objId);
    }
    public XysKpiObjKeyBO findXysKpiObjKeyBOById(String keyId)throws SysException{
         return xysKpiDeptService.findXysKpiObjKeyBOById(keyId);
    }
    public void saveXysKpiObjKeyBO(XysKpiObjKeyBO bo)throws SysException{
        xysKpiDeptService.saveXysKpiObjKeyBO(bo);
    }
    public void deleteXysKpiObjKeyBO(String keyId)throws SysException{
        xysKpiDeptService.deleteXysKpiObjKeyBO(keyId);
    }


    public List getXysKpiDeptSbjBOByObjId(String objId)throws SysException{
         return xysKpiDeptService.getXysKpiDeptSbjBOByObjId(objId);
    }
    public XysKpiDeptSbjBO findEqualsXysKpiDeptSbjBO(String objId,String personId)throws SysException{
         return xysKpiDeptService.findEqualsXysKpiDeptSbjBO(objId,personId);
    }
    public XysKpiDeptSbjBO findXysKpiDeptSbjBOById(String sbjId)throws SysException{
         return xysKpiDeptService.findXysKpiDeptSbjBOById(sbjId);
    }
    public void saveXysKpiDeptSbjBO(XysKpiDeptSbjBO bo)throws SysException{
         xysKpiDeptService.saveXysKpiDeptSbjBO(bo);
    }
    public void deleteXysKpiDeptSbjBO(String sbjId)throws SysException{
         xysKpiDeptService.deleteXysKpiDeptSbjBO(sbjId);
    }


    public List  getXysKpiDeptObjScoreBOBySbjId(String sbjId)throws SysException{
         return xysKpiDeptService.getXysKpiDeptObjScoreBOBySbjId(sbjId);
    }
    public XysKpiDeptObjScoreBO findXysKpiDeptObjScoreBOById(String scoreId)throws SysException{
         return xysKpiDeptService.findXysKpiDeptObjScoreBOById(scoreId);
    }
    public void saveXysKpiDeptObjScoreBO(XysKpiDeptObjScoreBO bo)throws SysException{
         xysKpiDeptService.saveXysKpiDeptObjScoreBO(bo);
    }
    public void deleteXysKpiDeptObjScoreBO(String scoreId)throws SysException{
         xysKpiDeptService.deleteXysKpiDeptObjScoreBO(scoreId);
    }
    public XysKpiDeptObjScoreBO findEqualsXysKpiDeptObjScoreBO(String sbjId,String key)throws SysException{
    	return this.xysKpiDeptService.findEqualsXysKpiDeptObjScoreBO(sbjId, key);
    }
    

    public String getAuditDeptIdByPersonId(String personId)throws SysException{
         return xysKpiDeptService.getAuditDeptIdByPersonId(personId);
    }
    public List getPersonIdsByPostId(String postId) throws SysException{
         return xysKpiDeptService.getPersonIdsByPostId(postId);
    }
    
    public List getAuditXysKpiDeptObjBOByPersonId(String personId)throws SysException{
    	return this.xysKpiDeptService.getAuditXysKpiDeptObjBOByPersonId(personId);
    }
    
    public List getXysKpiDeptSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException{
    	return this.xysKpiDeptService.getXysKpiDeptSbjBOForGrade(planId, personId, gradeItem,sbjId);
    }
    
    public String beginGradeByPlanId(final String planId)throws SysException{
    	return this.xysKpiDeptService.beginGradeByPlanId(planId);
    }
    
    
    public List getXysKpiDeptObjVO(PageVO pageVO,String planId)throws SysException{
    	return this.xysKpiDeptService.getXysKpiDeptObjVO(pageVO, planId);
    }
    public List checkSbjGradeData(String objId,String level)throws SysException{
    	return this.xysKpiDeptService.checkSbjGradeData(objId,level);
    }
    public void caclDeptKpiByPlanId(String planId)throws SysException{
    	this.xysKpiDeptService.caclDeptKpiByPlanId(planId);
    }
    
    public List getXysDeptKpiDivBOByObjId(String objId)throws SysException{
    	return this.xysKpiDeptService.getXysDeptKpiDivBOByObjId(objId);
    }
    public XysDeptKpiDivBO findXysDeptKpiDivBOById(String divId)throws SysException{
    	return this.xysKpiDeptService.findXysDeptKpiDivBOById(divId);
    }
    public XysDeptKpiDivBO findEqualsXysDeptKpiDivBO(String planId,String personId)throws SysException{
    	return this.xysKpiDeptService.findEqualsXysDeptKpiDivBO(planId, personId);
    }
    public void saveXysDeptKpiDivBO(XysDeptKpiDivBO bo)throws SysException{
    	this.xysKpiDeptService.saveXysDeptKpiDivBO(bo);
    }
    public void deleteXysDeptKpiDivBO(String divId)throws SysException{
    	this.xysKpiDeptService.deleteXysDeptKpiDivBO(divId);
    }
    
    public List getXysDeptObjExportVOByPlanId(String planId)throws SysException{
    	return this.xysKpiDeptService.getXysDeptObjExportVOByPlanId(planId);
    }
    
    public XysKpiDeptService getXysKpiDeptService() {
        return xysKpiDeptService;
    }

    public void setXysKpiDeptService(XysKpiDeptService xysKpiDeptService) {
        this.xysKpiDeptService = xysKpiDeptService;
    }
}
