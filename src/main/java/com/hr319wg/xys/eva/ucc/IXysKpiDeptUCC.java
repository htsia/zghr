package com.hr319wg.xys.eva.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.*;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: ÏÂÎç1:38
 * To change this template use File | Settings | File Templates.
 */
public interface IXysKpiDeptUCC {
    public List getXysKpiDeptObjBO(PageVO pageVO,String planId,String orgId)throws SysException;
    public List getXysKpiDeptObjBO(String planId,String gradeItem)throws SysException;
    public XysKpiDeptObjBO findEqualsXysKpiDeptObjBO(String planId,String personId)throws SysException;
    public List getXysKpiDeptObjBOInSelf(String personId,String where)throws SysException;
    public XysKpiDeptObjBO findXysKpiDeptObjBOById(String objId)throws SysException;
    public void saveXysKpiDeptObjBO(XysKpiDeptObjBO bo)throws SysException;
    public void deleteXysKpiDeptObjBO(String objId)throws SysException;

    public List getXysKpiObjLibBOByObjId(String objId)throws SysException;
    public XysKpiObjLibBO findXysKpiObjLibBOById(String lobId)throws SysException;
    public void saveXysKpiObjLibBO(XysKpiObjLibBO bo)throws SysException;
    public void deleteXysKpiObjLibBO(String libId)throws SysException;

    public List getXysKpiObjKeyBOByLibId(String libId)throws SysException;
    public List getXysKpiObjKeyBOByObjId(String objId)throws SysException;
    public XysKpiObjKeyBO findXysKpiObjKeyBOById(String keyId)throws SysException;
    public void saveXysKpiObjKeyBO(XysKpiObjKeyBO bo)throws SysException;
    public void deleteXysKpiObjKeyBO(String keyId)throws SysException;


    public List getXysKpiDeptSbjBOByObjId(String objId)throws SysException;
    public XysKpiDeptSbjBO findEqualsXysKpiDeptSbjBO(String objId,String personId)throws SysException;
    public XysKpiDeptSbjBO findXysKpiDeptSbjBOById(String sbjId)throws SysException;
    public void saveXysKpiDeptSbjBO(XysKpiDeptSbjBO bo)throws SysException;
    public void deleteXysKpiDeptSbjBO(String sbjId)throws SysException;


    public List  getXysKpiDeptObjScoreBOBySbjId(String sbjId)throws SysException;
    public XysKpiDeptObjScoreBO findXysKpiDeptObjScoreBOById(String scoreId)throws SysException;
    public void saveXysKpiDeptObjScoreBO(XysKpiDeptObjScoreBO bo)throws SysException;
    public void deleteXysKpiDeptObjScoreBO(String scoreId)throws SysException;
    public XysKpiDeptObjScoreBO findEqualsXysKpiDeptObjScoreBO(String sbjId,String key)throws SysException;

    public String getAuditDeptIdByPersonId(String personId)throws SysException;
    public List getPersonIdsByPostId(String postId) throws SysException;
    
    public List getAuditXysKpiDeptObjBOByPersonId(String personId)throws SysException;
    public List getXysKpiDeptSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException;
    public String beginGradeByPlanId(final String planId)throws SysException;
    
    public List getXysKpiDeptObjVO(PageVO pageVO,String planId)throws SysException;
    public List checkSbjGradeData(String objId,String level)throws SysException;
    public void caclDeptKpiByPlanId(String planId)throws SysException;
    
    
    public List getXysDeptKpiDivBOByObjId(String objId)throws SysException;
    public XysDeptKpiDivBO findXysDeptKpiDivBOById(String divId)throws SysException;
    public XysDeptKpiDivBO findEqualsXysDeptKpiDivBO(String planId,String personId)throws SysException;
    public void saveXysDeptKpiDivBO(XysDeptKpiDivBO bo)throws SysException;
    public void deleteXysDeptKpiDivBO(String divId)throws SysException;
    
    public List getXysDeptObjExportVOByPlanId(String planId)throws SysException;
}
