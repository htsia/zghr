package com.hr319wg.xys.eva.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonScoreBO;
import com.hr319wg.xys.eva.service.XysKpiPersonService;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-13
 * Time: ÏÂÎç4:35
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiPersonUCC implements IXysKpiPersonUCC{
    private XysKpiPersonService xysKpiPersonService;

    public List getXysKpiPersonObjBO(PageVO pageVO,String planId,String orgId)throws SysException{
        return xysKpiPersonService.getXysKpiPersonObjBO(pageVO,planId,orgId);
    }
    public List getXysKpiPersonObjBOByQueryValue(PageVO pageVO,String planId,String where)throws SysException{
    	return this.xysKpiPersonService.getXysKpiPersonObjBOByQueryValue(pageVO, planId, where);
    }
    public List getXysKpiPersonObjBOForSelf(String deptId,String where)throws SysException{
        return xysKpiPersonService.getXysKpiPersonObjBOForSelf(deptId,where);
    }
    public List getSelfXysKpiPersonObjBO(String personId,String where)throws SysException{
    	return this.xysKpiPersonService.getSelfXysKpiPersonObjBO(personId, where);
    }
    public XysKpiPersonObjBO findEqualsXysKpiPersonObjBO(String planId,String personId)throws SysException{
        return xysKpiPersonService.findEqualsXysKpiPersonObjBO(planId,personId);
    }
    public XysKpiPersonObjBO findXysKpiPersonObjBOById(String objId)throws SysException{
         return xysKpiPersonService.findXysKpiPersonObjBOById(objId);
    }
    public void saveXysKpiPersonObjBO(XysKpiPersonObjBO bo)throws SysException{
         xysKpiPersonService.saveXysKpiPersonObjBO(bo);
    }
    public void deleteXysKpiPersonObjBO(String objId)throws SysException{
         xysKpiPersonService.deleteXysKpiPersonObjBO(objId);
    }
    public List getAuditXysKpiPersonObjBOByPersonId(String personId)throws SysException{
    	return this.xysKpiPersonService.getAuditXysKpiPersonObjBOByPersonId(personId);
    }
    

    public List getXysKpiPersonSbjBOByObjId(String objId)throws SysException{
         return xysKpiPersonService.getXysKpiPersonSbjBOByObjId(objId);
    }
    public XysKpiPersonSbjBO findEqualsXysKpiPersonSbjBO(String objId,String personId)throws SysException{
         return xysKpiPersonService.findEqualsXysKpiPersonSbjBO(objId,personId);
    }
    public XysKpiPersonSbjBO findXysKpiPersonSbjBOById(String sbjId)throws SysException{
         return xysKpiPersonService.findXysKpiPersonSbjBOById(sbjId);
    }
    public void saveXysKpiPersonSbjBO(XysKpiPersonSbjBO bo)throws SysException{
         xysKpiPersonService.saveXysKpiPersonSbjBO(bo);
    }
    public void deleteXysKpiPersonSbjBO(String sbjId)throws SysException{
         xysKpiPersonService.deleteXysKpiPersonSbjBO(sbjId);
    }

    public List  getXysKpiPersonScoreBOBySbjId(String sbjId)throws SysException{
         return xysKpiPersonService.getXysKpiPersonScoreBOBySbjId(sbjId);
    }
    public XysKpiPersonScoreBO findXysKpiPersonScoreBOById(String scoreId)throws SysException{
         return xysKpiPersonService.findXysKpiPersonScoreBOById(scoreId);
    }
    public void saveXysKpiPersonScoreBO(XysKpiPersonScoreBO bo)throws SysException{
         xysKpiPersonService.saveXysKpiPersonScoreBO(bo);
    }
    public void deleteXysKpiPersonScoreBO(String scoreId)throws SysException{
         xysKpiPersonService.deleteXysKpiPersonScoreBO(scoreId);
    }
    public XysKpiPersonScoreBO findEqualsXysKpiPersonScoreBO(String sbjId,String key)throws SysException{
    	return this.xysKpiPersonService.findEqualsXysKpiPersonScoreBO(sbjId, key);
    }
    
    
    public List getXysKpiPersonSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException{
    	return this.xysKpiPersonService.getXysKpiPersonSbjBOForGrade(planId, personId, gradeItem,sbjId);
    }
    
    public String beginGradeByPlanId(String planId)throws SysException{
    	return this.xysKpiPersonService.beginGradeByPlanId(planId);
    }
    
    public List getXysKpiPersonObjVO(PageVO pagevo,String planId,String orgId)throws SysException{
    	return this.xysKpiPersonService.getXysKpiPersonObjVO(pagevo, planId, orgId);
    }
    public List getXysKpiPersonObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
    	return this.xysKpiPersonService.getXysKpiPersonObjVOByQueryValue(pagevo, planId, where);
    }
    public List checkSbjGradeData(String objId,String level)throws SysException{
    	return this.xysKpiPersonService.checkSbjGradeData(objId,level);
    }
    public void caclPersonKpiByPlanId(String planId)throws SysException{
    	this.xysKpiPersonService.caclPersonKpiByPlanId(planId);
    }
    public void exportPersonKpiByPlanId(String planId)throws SysException{
    	this.xysKpiPersonService.exportPersonKpiByPlanId(planId);
    }

    
    public void deleteAll(List list)throws SysException{
    	this.xysKpiPersonService.deleteAll(list);
    }
    public List getXysPersonKPIExportVOByPlanId(String planId)throws SysException{
    	return this.xysKpiPersonService.getXysPersonKPIExportVOByPlanId(planId);
    }
    public void loadPersonKpiObjByPlanId(final String planId)throws SysException{
    	this.xysKpiPersonService.loadPersonKpiObjByPlanId(planId);
    }
    
    
    
    
    public XysKpiPersonService getXysKpiPersonService() {
        return xysKpiPersonService;
    }

    public void setXysKpiPersonService(XysKpiPersonService xysKpiPersonService) {
        this.xysKpiPersonService = xysKpiPersonService;
    }
}
