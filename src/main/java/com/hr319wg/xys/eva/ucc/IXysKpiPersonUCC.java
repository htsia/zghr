package com.hr319wg.xys.eva.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonScoreBO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-13
 * Time: ÏÂÎç4:32
 * To change this template use File | Settings | File Templates.
 */
public interface IXysKpiPersonUCC {
    public List getXysKpiPersonObjBO(PageVO pageVO,String planId,String orgId)throws SysException;
    public List getXysKpiPersonObjBOByQueryValue(PageVO pageVO,String planId,String where)throws SysException;
    public XysKpiPersonObjBO findEqualsXysKpiPersonObjBO(String planId,String personId)throws SysException;
    public List getXysKpiPersonObjBOForSelf(String deptId,String where)throws SysException;
    public List getSelfXysKpiPersonObjBO(String personId,String where)throws SysException;
    public XysKpiPersonObjBO findXysKpiPersonObjBOById(String objId)throws SysException;
    public void saveXysKpiPersonObjBO(XysKpiPersonObjBO bo)throws SysException;
    public void deleteXysKpiPersonObjBO(String objId)throws SysException;
    public List getAuditXysKpiPersonObjBOByPersonId(String personId)throws SysException;

    public List getXysKpiPersonSbjBOByObjId(String objId)throws SysException;
    public XysKpiPersonSbjBO findEqualsXysKpiPersonSbjBO(String objId,String personId)throws SysException;
    public XysKpiPersonSbjBO findXysKpiPersonSbjBOById(String sbjId)throws SysException;
    public void saveXysKpiPersonSbjBO(XysKpiPersonSbjBO bo)throws SysException;
    public void deleteXysKpiPersonSbjBO(String sbjId)throws SysException;

    public List  getXysKpiPersonScoreBOBySbjId(String sbjId)throws SysException;
    public XysKpiPersonScoreBO findXysKpiPersonScoreBOById(String scoreId)throws SysException;
    public void saveXysKpiPersonScoreBO(XysKpiPersonScoreBO bo)throws SysException;
    public void deleteXysKpiPersonScoreBO(String scoreId)throws SysException;
    public XysKpiPersonScoreBO findEqualsXysKpiPersonScoreBO(String sbjId,String key)throws SysException;
    
    public List getXysKpiPersonSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException;
    public String beginGradeByPlanId(String planId)throws SysException;
    
    public List getXysKpiPersonObjVO(PageVO pagevo,String planId,String orgId)throws SysException;
    public List getXysKpiPersonObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException;
    public List checkSbjGradeData(String objId,String level)throws SysException;
    public void caclPersonKpiByPlanId(String planId)throws SysException;
    public void exportPersonKpiByPlanId(String planId)throws SysException;
    
    public void deleteAll(List list)throws SysException;
    
    public List getXysPersonKPIExportVOByPlanId(String planId)throws SysException;
    
    public void loadPersonKpiObjByPlanId(final String planId)throws SysException;
}
