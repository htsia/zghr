package com.hr319wg.xys.eva.ucc;

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

import java.util.Hashtable;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-27
 * Time: ÉÏÎç10:00
 * To change this template use File | Settings | File Templates.
 */
public interface IXysEvaPlanUCC {
    public List getXysEvaPlanBO(PageVO pagevo,String createOrg,String[] status) throws SysException;
    public List getAllXysEvaPlanBO()throws SysException;
    public XysEvaPlanBO findXysEvaPlanBOById(String planId)throws SysException;
    public void saveXysEvaPlanBO(XysEvaPlanBO bo)throws SysException;
    public void deleteXysEvaPlanBO(String planId)throws SysException;

    public EvaExcPostBO findEqualsEvaExcPostBO(String planId,String postId)throws SysException;
    public void saveEvaExcPostBO(EvaExcPostBO bo)throws SysException;
    public void deleteEvaExcPostBO(String excId)throws SysException;
    public List getEvaPostBOByPlanId(PageVO pagevo,String orgId,String planId,String showMode)throws SysException;

    public XysEvaModeSetBO getXysEvaModeSetBO(String planId,String postId)throws SysException;
    public Hashtable getXysEvaModeSetBOByPlanForMap(String planId)throws SysException;
    public XysEvaModeSetBO findXysEvaModeSetBOById(String setId)throws SysException;
    public void saveXysEvaModeSetBO(XysEvaModeSetBO bo)throws SysException;
    public void deleteXysEvaModeSetBO(String setId)throws SysException;

    public List getXysWeightSetBO(String planId,String postId,String type)throws SysException;
    public XysWeightSetBO findXysWeightSetBOById(String setId)throws SysException;
    public void saveXysWeightSetBO(XysWeightSetBO bo)throws SysException;
    public void deleteXysWeightSetBO(String setId)throws SysException;
    public XysWeightSetBO findEqualsXysWeightSetBO(String planId,String postId,String evaPost,String type)throws SysException;

    public XysWeightExcPersBO findEqualsXysWeightExcPersBO(String setId,String personId)throws SysException;
    public void saveXysWeightExcPersBO(XysWeightExcPersBO bo)throws SysException;
    public void deleteXysWeightExcPersBO(String excId)throws SysException;
    
    
    public List getXysScoreCtrBOByPlanId(String planId,String type)throws SysException;
    public XysScoreCtrBO findXysScoreCtrBOById(String ctrId)throws SysException;
    public void saveXysScoreCtrBO(XysScoreCtrBO bo)throws SysException;
    public void deleteXysScoreCtrBO(String ctrId)throws SysException;
    public XysScoreCtrBO findEqualsXysScoreCtrBO(String planId,String type,String gradItem)throws SysException;
    
    public void deleteAll(List list)throws SysException;
    public List getPersonBOByWeightSetId(String setId)throws SysException;
    public List getEqualsPostBOByPlanId(String planId)throws SysException;
    
    public List getXysBeginGradeErrorBO(PageVO pagevo,String planId,String objType)throws SysException;
    public XysBeginGradeErrorBO findXysBeginGradeErrorBO(String errorId)throws SysException;
    public void saveXysBeginGradeErrorBO(XysBeginGradeErrorBO bo)throws SysException;
    public void deleteXysBeginGradeErrorBO(String errorId)throws SysException;
    
    public XysLevelWeightSetBO findEqualsXysLevelWeightSetBO(String planId,String postId,String type)throws SysException;
    public void saveXysLevelWeightSetBO(XysLevelWeightSetBO bo)throws SysException;
    
    public Hashtable getIllegalPostBOByPlanIdForMap(String planId)throws SysException;
    
    public List getXysExportTempBOByPlanId(String planId)throws SysException;
}
