package com.hr319wg.eva.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaAGItemBO;
import com.hr319wg.eva.pojo.bo.EvaAuditGroupBO;
import com.hr319wg.eva.pojo.bo.EvaDefaultLevelBO;
import com.hr319wg.eva.pojo.bo.EvaLevelPurview;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaSelectionResultItemBO;
import com.hr319wg.eva.pojo.bo.EvaSelectionResultSetBO;
import com.hr319wg.eva.pojo.bo.EvaTempMasterBO;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;

import java.util.Hashtable;
import java.util.List;

public interface IEvaObjectsUCC {
    //-----------÷˜ÃÂ…Ë÷√-----------
    public void deleteEvaMasterBO(String itemid) throws SysException;
    public void saveEvaMasterBO(EvaMasterBO bo) throws SysException;
    public List getMasters(String objectID,String queryValue) throws SysException;
    public List getMastersByPersonID(String personID) throws SysException;
    public EvaObjectsVO findEvaObject(String id) throws SysException ;
    public void savaEvaObject(EvaObjectsBO bo) throws SysException ;
    public void deleteEvaObject(String item) throws SysException ;
    public List getEvaObjects(PageVO pagevo,String planID,String orgId,String limit,String conditionValue) throws SysException;
    public List getNotEvaObjects(PageVO pagevo,String planID,String orgId,String limit) throws SysException ;
    public List getMasterByMasterPlanId(String planID,String loginID)throws SysException;
     //fangxia
    public List getObjectByObjId(String objectid) throws SysException;   
    public List getMasterScore(PageVO pagevo,String planId,String templateId,String orgId) throws SysException;
    public List getResultScore(PageVO pagevo,String planId,String queryValue,String objType) throws SysException;
    public EvaObjectsBO findEvaObjectBOById(String objectId)throws SysException;
    public List getTemMasterBOList(String planID)throws SysException;
    public List AddTeamMasterPerson(PageVO pagevo, String planID,String orgid) throws SysException;
    public void saveTempMasterBO(EvaTempMasterBO bo)throws SysException;
    public void deleteTempMasterBO(String masterid)throws SysException;
    public EvaTempMasterBO findEvaTempMasterBOById(String masterid)throws SysException;
    public void updateTempMasterBO(EvaTempMasterBO bo)throws SysException;
    
    public List getfindEvaTempMasterBO(String username) throws SysException;
    public void updateEvaTempMasterBO(EvaTempMasterBO evaTempMasterBO) throws SysException;
    
    public List getPlanByMasterName(String masterName) throws SysException;
    public List getObjectsByPlanId(PageVO pagevo,String planId) throws SysException;
    
    public List getTempMasters(String planId) throws SysException;
    public EvaTempMasterBO getEvaTempMasterBO(String masterId) throws SysException;
    public EvaMasterBO getEvaMasterBOBymasterId(String objectId,String personId) throws SysException;
    public void insertEvaMasterBO(EvaMasterBO bo) throws SysException;
    public List getMasterIdByOIdandPid(String objectId,String personId) throws SysException;
    public User verifyLogon(String loginName, String password) throws Exception;
    
    public List getAllLevelPurviewByObjectId(String objectId)throws SysException;
    public EvaLevelPurview findEvaLevelPurviewById(String levelId)throws SysException;
    public void saveEvaLevelPurview(EvaLevelPurview bo)throws SysException;
    public void updateEvaLevelPurview(EvaLevelPurview bo)throws SysException;
    public void deleteEvaLevelPurview(String levelid)throws SysException;
    public List getMastersByMasterType(String objectID,String masterType) throws SysException;
    public EvaLevelPurview getLevelPurviewByObjectIdAndType(String objectId,String masterType)throws SysException;
    public void updateMasterbo(EvaMasterBO masterbo)throws SysException;
    
    public List getDefaultLevelByPlanId(String planid)throws SysException;
    public EvaDefaultLevelBO findDefaultLevelById(String levelid)throws SysException;
    public List getEvaObjectsVOByPlanIdPersonIdAndTemId(PageVO pagevo,String planId,String personId,String temId,String queryValue)throws SysException;
    public void deleteEvaDefaultLevel(String levelid)throws SysException;
    public void saveEvaDefaultLevel(EvaDefaultLevelBO defaultbo)throws SysException;
    
    public EvaMasterBO findEvaMasterBOById(String mastorid)throws SysException;
    public EvaObjectsBO getEvaObjectsBOByPlanIdAndPersonId(String planId,String pid)throws SysException;
    public List getEvaObjectsBOByPlanIdAndTimId(PageVO pagevo,String planId,String temId)throws SysException;
    
    public List getAllEvaAuditGroupBOByPlanId(String planId)throws SysException;
    public EvaAuditGroupBO findEvaAuditGroupBO(String groupId)throws SysException;
    public void saveEvaAuditGroupBO(EvaAuditGroupBO bo)throws SysException;
    public void deleteEvaAuditGroupBO(String groupId)throws SysException;
    public List getAllEvaAGItemBOByGroupId(String groupId,String queryValue)throws SysException;
    public EvaAGItemBO findEvaAGItemBOByItemId(String itemId)throws SysException;
    public void saveEvaAGItemBO(EvaAGItemBO bo)throws SysException;
    public void deleteEvaAGItemBO(String itemId)throws SysException;
    public EvaAGItemBO findEvaAGItemBOByPersonIdAndGroupId(String groupId,String personId)throws SysException;
    public List getEvaObjectsBOForResutlShow(PageVO pagevo,String planId,String temId,String orgId)throws SysException;
    public List getMasterBO(String planId,String templateId,String personId,String deptId,String gradeId)throws SysException;
    public List getEvaObjectsBOByMasterAndGardeItem(String planId,String personId,String temId,String itemId,String queryValue)throws SysException;
    public List getMasterByMasterPlanIdAndMasterType(String planID, String loginID,String masterType)throws SysException;
    public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String personId,String masterType,String gradeItem,String deptId)throws SysException;
    public Hashtable getMasterByPersonIdAndObjIds(String perosnId,String[] objid)throws SysException;
    public Hashtable getEvaMasterBOByObjectIds(String[] objId)throws SysException;
    public Hashtable getEvaObjectBOByObjectIds(String [] objId)throws SysException;
    public Hashtable getEvaMasterBOByObjectIdsForHash(String[] objId)throws SysException;
    public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String masterPid)throws SysException;
    public List getEvaObjectsVOByPlanIdAndQuery(PageVO pagevo,String planId,String queryValue)throws SysException;
    public List getEvaMasterBOByObjectIdAndGradeId(String objectID,String gradeId)throws SysException;
    public List getObjectsByPlanIdAndOrgId(PageVO pagevo,String planId,String orgId) throws SysException;
    
    public List getEvaSelectionResultSetBOByPlanId(String planId)throws SysException;
    public EvaSelectionResultSetBO findEvaSelectionResultSetBO(String setId)throws SysException;
    public EvaSelectionResultSetBO getEvaSelectionResultSetBOForResult(String planId)throws SysException;
    public void saveEvaSelectionResultSetBO(EvaSelectionResultSetBO bo)throws SysException;
    public void deleteEvaSelectionResultSetBO(String setId)throws SysException;
    public List getEvaSelectionResultItemBOBySetId(String setId)throws SysException;
    public Hashtable findEvaSelectionResultItemBOByObjectIds(String objectIds)throws SysException;
    public List getEvaSelectionResultItemBOBySetIdAndObjId(String setId,String objectId)throws SysException;
    public EvaSelectionResultItemBO findEvaSelectionResultItemBO(String setId,String objectId,String masterType)throws SysException;
    public void saveEvaSelectionResultItemBO(EvaSelectionResultItemBO bo)throws SysException;
    public void deleteEvaSelectionResultItemBO(String itemid)throws SysException;
    public List getAllEvaGradersBOByPlanIdAndOrgId(PageVO pagevo,String templateID,String orgId,String planId,String index)throws SysException;
    public String[] getTemplateByPlanIdAndOrgId(String planId,String orgId)throws SysException;
}
