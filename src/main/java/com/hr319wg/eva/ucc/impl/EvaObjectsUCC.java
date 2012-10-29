package com.hr319wg.eva.ucc.impl;

import com.hr319wg.eva.service.EvaObjectsService;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
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
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;

import java.util.Hashtable;
import java.util.List;

public class EvaObjectsUCC implements IEvaObjectsUCC {
	private EvaObjectsService evaservice;

	public List getEvaObjects(PageVO pagevo, String planID, String orgId,
			String limit,String conditionValue) throws SysException {
		return evaservice.getEvaObjects(pagevo, planID, orgId, limit,conditionValue);
	}

	public void deleteEvaObject(String item) throws SysException {
		evaservice.deleteEvaObject(item);
	}

	public EvaObjectsVO findEvaObject(String id) throws SysException {
		return evaservice.findEvaObject(id);
	}

	public List getNotEvaObjects(PageVO pagevo, String planID, String orgId,
			String limit) throws SysException {
		return evaservice.getNotEvaObjects(pagevo, planID, orgId, limit);
	}

	public void savaEvaObject(EvaObjectsBO bo) throws SysException {
		evaservice.savaEvaObject(bo);
	}

	// -----------÷˜ÃÂ…Ë÷√-----------
	public void deleteEvaMasterBO(String itemid) throws SysException {
		evaservice.deleteEvaMasterBO(itemid);
	}

	public void saveEvaMasterBO(EvaMasterBO bo) throws SysException {
		this.evaservice.saveEvaMasterBO(bo);
	}

	public List getMasters(String objectID,String queryValue) throws SysException {
		return evaservice.getMasters(objectID,queryValue);
	}

	public EvaObjectsService getEvaservice() {
		return evaservice;
	}

	public void setEvaservice(EvaObjectsService service) {
		this.evaservice = service;
	}

	public List getMasterByMasterPlanId(String planID, String loginID)
			throws SysException {
		return evaservice.getMasterByMasterPlanId(planID, loginID);
	}

	public List getMastersByPersonID(String personID) throws SysException {
		return evaservice.getMastersByPersonID(personID);
	}

	// fangxia
	public List getObjectByObjId(String objectid) throws SysException {
		return evaservice.getObjectByObjId(objectid);
	}

	public List getMasterScore(PageVO pagevo, String planId, String templateId,
			String orgId) throws SysException {
		return evaservice.getMasterScore(pagevo, planId, templateId, orgId);
	}

	public List getResultScore(PageVO pagevo, String planId,String queryValue,String objType)
			throws SysException {
		return evaservice.getResultScore(pagevo, planId,queryValue,objType);
	}

	public EvaObjectsBO findEvaObjectBOById(String objectId)
			throws SysException {
		return evaservice.findEvaObjectBOById(objectId);
	}

	public List getTemMasterBOList(String planID) throws SysException {
		return evaservice.getTemMasterBOList(planID);
	}

	public List AddTeamMasterPerson(PageVO pagevo, String planID, String orgid)
			throws SysException {
		return evaservice.AddTeamMasterPerson(pagevo, planID, orgid);
	}

	public void saveTempMasterBO(EvaTempMasterBO bo) throws SysException {
		evaservice.saveTempMasterBO(bo);
	}

	public void deleteTempMasterBO(String masterid) throws SysException {
		evaservice.deleteTempMasterBO(masterid);
	}

	public EvaTempMasterBO findEvaTempMasterBOById(String masterid)
			throws SysException {
		return evaservice.findEvaTempMasterBOById(masterid);
	}

	public void updateTempMasterBO(EvaTempMasterBO bo) throws SysException {
		evaservice.updateTempMasterBO(bo);
	}

	public List getfindEvaTempMasterBO(String username) throws SysException {
		return evaservice.getfindEvaTempMasterBO(username);
	}

	public void updateEvaTempMasterBO(EvaTempMasterBO evaTempMasterBO)
			throws SysException {
		evaservice.updateEvaTempMasterBO(evaTempMasterBO);
	}

	public List getPlanByMasterName(String masterName) throws SysException {
		return evaservice.getPlanByMasterName(masterName);
	}

	public List getObjectsByPlanId(PageVO pagevo,String planId) throws SysException {
		return evaservice.getObjectsByPlanId(pagevo,planId);
	}
	//qiaolei
	public List getTempMasters(String planId) throws SysException{
		return evaservice.getTempMasters(planId);
	}
	public void getSaveTempMaster(EvaMasterBO bo) throws SysException{
		evaservice.saveEvaMasterBO(bo);
	}
	public EvaTempMasterBO getEvaTempMasterBO(String masterId) throws SysException{
		return evaservice.getEvaTempMasterBO(masterId);
	}
	public EvaMasterBO getEvaMasterBOBymasterId(String objectId,String personId) throws SysException{
		return evaservice.getEvaMasterBOBymasterId(objectId,personId);
	}
	public void insertEvaMasterBO(EvaMasterBO bo) throws SysException{
		evaservice.insertEvaMasterBO(bo);
	}
	public List getMasterIdByOIdandPid(String objectId,String personId) throws SysException{
		return evaservice.getMasterIdByOIdandPid(objectId, personId);
	}
	public User verifyLogon(String loginName, String password) throws Exception {
	    User user = evaservice.verifyLogon(loginName, password);
	    return user;
	}
	public List getAllLevelPurviewByObjectId(String objectId)throws SysException{
		return evaservice.getAllLevelPurviewByObjectId(objectId);
	}
    public EvaLevelPurview findEvaLevelPurviewById(String levelId)throws SysException{
    	return evaservice.findEvaLevelPurviewById(levelId);
    }
    public void saveEvaLevelPurview(EvaLevelPurview bo)throws SysException{
    	evaservice.saveEvaLevelPurview(bo);
    }
    public void updateEvaLevelPurview(EvaLevelPurview bo)throws SysException{
    	evaservice.updateEvaLevelPurview(bo);
    }
    public void deleteEvaLevelPurview(String levelid)throws SysException{
    	evaservice.deleteEvaLevelPurview(levelid);
    }
    public List getMastersByMasterType(String objectID,String masterType) throws SysException{
    	return evaservice.getMastersByMasterType(objectID, masterType);
    }
    public EvaLevelPurview getLevelPurviewByObjectIdAndType(String objectId,String masterType)throws SysException{
    	return evaservice.getLevelPurviewByObjectIdAndType(objectId, masterType);
    }
    public void updateMasterbo(EvaMasterBO masterbo)throws SysException{
    	evaservice.updateMasterbo(masterbo);
    }
    public List getDefaultLevelByPlanId(String planid)throws SysException{
    	return evaservice.getDefaultLevelByPlanId(planid);
    }
    public EvaDefaultLevelBO findDefaultLevelById(String levelid)throws SysException{
    	return evaservice.findDefaultLevelById(levelid);
    }
    public void deleteEvaDefaultLevel(String levelid)throws SysException{
    	evaservice.deleteEvaDefaultLevel(levelid);
    }
    public void saveEvaDefaultLevel(EvaDefaultLevelBO defaultbo)throws SysException{
    	evaservice.saveEvaDefaultLevel(defaultbo);
    }
    public EvaMasterBO findEvaMasterBOById(String mastorid)throws SysException{
    	return evaservice.findEvaMasterBOById(mastorid);
    }
    public List getEvaObjectsVOByPlanIdPersonIdAndTemId(PageVO pagevo,String planId,String personId,String temId,String queryValue)throws SysException {
    	return this.evaservice.getEvaObjectsVOByPlanIdPersonIdAndTemId(pagevo,planId, personId,temId,queryValue);
    }
    public EvaObjectsBO getEvaObjectsBOByPlanIdAndPersonId(String planId,String pid)throws SysException{
    	return this.evaservice.getEvaObjectsBOByPlanIdAndPersonId(planId, pid);
    }
    public List getEvaObjectsBOByPlanIdAndTimId(PageVO pagevo,String planId,String temId)throws SysException{
    	return this.evaservice.getEvaObjectsBOByPlanIdAndTimId(pagevo, planId, temId);
    }
   
    public List getAllEvaAuditGroupBOByPlanId(String planId)throws SysException{
    	return this.evaservice.getAllEvaAuditGroupBOByPlanId(planId);
    }
    public EvaAuditGroupBO findEvaAuditGroupBO(String groupId)throws SysException{
    	return this.evaservice.findEvaAuditGroupBO(groupId);
    }
    public void saveEvaAuditGroupBO(EvaAuditGroupBO bo)throws SysException{
    	this.evaservice.saveEvaAuditGroupBO(bo);
    }
    public void deleteEvaAuditGroupBO(String groupId)throws SysException{
    	this.evaservice.deleteEvaAuditGroupBO(groupId);
    }
    public List getAllEvaAGItemBOByGroupId(String groupId,String queryValue)throws SysException{
    	return this.evaservice.getAllEvaAGItemBOByGroupId(groupId,queryValue);
    }
    public EvaAGItemBO findEvaAGItemBOByItemId(String itemId)throws SysException{
    	return this.evaservice.findEvaAGItemBOByItemId(itemId);
    }
    public void saveEvaAGItemBO(EvaAGItemBO bo)throws SysException{
    	this.evaservice.saveEvaAGItemBO(bo);
    }
    public void deleteEvaAGItemBO(String itemId)throws SysException{
    	this.evaservice.deleteEvaAGItemBO(itemId);
    }
    public List getEvaObjectsBOForResutlShow(PageVO pagevo,String planId,String temId,String orgId)throws SysException{
    	return this.evaservice.getEvaObjectsBOForResutlShow(pagevo, planId, temId, orgId);
    }
    public EvaAGItemBO findEvaAGItemBOByPersonIdAndGroupId(String groupId,String personId)throws SysException{
    	return this.evaservice.findEvaAGItemBOByPersonIdAndGroupId(groupId, personId);
    }
    public List getEvaObjectsBOByMasterAndGardeItem(String planId,String personId,String temId,String itemId,String queryValue)throws SysException{
    	return this.evaservice.getEvaObjectsBOByMasterAndGardeItem(planId, personId, temId, itemId,queryValue);
    }
    public List getMasterBO(String planId,String templateId,String personId,String deptId,String gradeId)throws SysException{
    	return this.evaservice.getMasterBO(planId, templateId, personId, deptId, gradeId);
    }
    public List getMasterByMasterPlanIdAndMasterType(String planID, String loginID,String masterType)throws SysException{
    	return this.evaservice.getMasterByMasterPlanIdAndMasterType(planID, loginID, masterType);
    }
    public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String personId,String masterType,String gradeItem,String deptId)throws SysException{
    	return this.evaservice.getEvaObjectsBOByPlanIdAndMasterPid(planId, personId, masterType, gradeItem, deptId);
    }
    public Hashtable getMasterByPersonIdAndObjIds(String perosnId,String[] objId)throws SysException{
    	return this.evaservice.getMasterByPersonIdAndObjIds(perosnId, objId);
    }
    public Hashtable getEvaMasterBOByObjectIdsForHash(String[] objId)throws SysException{
    	return this.evaservice.getEvaMasterBOByObjectIdsForHash(objId);
    }
    public Hashtable getEvaObjectBOByObjectIds(String [] objId)throws SysException{
    	return this.evaservice.getEvaObjectBOByObjectIds(objId);
    }
    public Hashtable getEvaMasterBOByObjectIds(String[] objId)throws SysException{
    	return this.evaservice.getEvaMasterBOByObjectIds(objId);
    }
    public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String masterPid)throws SysException{
    	return this.evaservice.getEvaObjectsBOByPlanIdAndMasterPid(planId, masterPid);
    }
    public List getEvaObjectsVOByPlanIdAndQuery(PageVO pagevo,String planId,String queryValue)throws SysException{
    	return this.evaservice.getEvaObjectsVOByPlanIdAndQuery(pagevo, planId, queryValue);
    }
    public List getEvaMasterBOByObjectIdAndGradeId(String objectID,String gradeId)throws SysException{
    	return this.evaservice.getEvaMasterBOByObjectIdAndGradeId(objectID, gradeId);
    }
    public List getObjectsByPlanIdAndOrgId(PageVO pagevo,String planId,String orgId) throws SysException{
    	return this.evaservice.getObjectsByPlanIdAndOrgId(pagevo, planId, orgId);
    }
    public List getEvaSelectionResultSetBOByPlanId(String planId)throws SysException{
    	return this.evaservice.getEvaSelectionResultSetBOByPlanId(planId);
    }
    public EvaSelectionResultSetBO findEvaSelectionResultSetBO(String setId)throws SysException{
    	return this.evaservice.findEvaSelectionResultSetBO(setId);
    }
    public EvaSelectionResultSetBO getEvaSelectionResultSetBOForResult(String planId)throws SysException{
    	return this.evaservice.getEvaSelectionResultSetBOForResult(planId);
    }
    public void saveEvaSelectionResultSetBO(EvaSelectionResultSetBO bo)throws SysException{
    	 this.evaservice.saveEvaSelectionResultSetBO(bo);
    }
    public void deleteEvaSelectionResultSetBO(String setId)throws SysException{
    	this.evaservice.deleteEvaSelectionResultSetBO(setId);
    }
    public List getEvaSelectionResultItemBOBySetId(String setId)throws SysException{
    	return this.evaservice.getEvaSelectionResultItemBOBySetId(setId);
    }
    public List getEvaSelectionResultItemBOBySetIdAndObjId(String setId,String objectId)throws SysException{
    	return this.evaservice.getEvaSelectionResultItemBOBySetIdAndObjId(setId, objectId);
    }
    public Hashtable findEvaSelectionResultItemBOByObjectIds(String objectIds)throws SysException{
    	return this.evaservice.findEvaSelectionResultItemBOByObjectIds(objectIds);
    }
    public EvaSelectionResultItemBO findEvaSelectionResultItemBO(String setId,String objectId,String masterType)throws SysException{
    	return this.evaservice.findEvaSelectionResultItemBO(setId, objectId, masterType);
    }
    public void saveEvaSelectionResultItemBO(EvaSelectionResultItemBO bo)throws SysException{
    	 this.evaservice.saveEvaSelectionResultItemBO(bo);
    }
    public void deleteEvaSelectionResultItemBO(String itemid)throws SysException{
    	this.evaservice.deleteEvaSelectionResultItemBO(itemid);
    }
    public List getAllEvaGradersBOByPlanIdAndOrgId(PageVO pagevo,String templateID,String orgId,String planId,String index)throws SysException{
    	return this.evaservice.getAllEvaGradersBOByPlanIdAndOrgId(pagevo, templateID,orgId, planId,index);
    }
    public String[] getTemplateByPlanIdAndOrgId(String planId,String orgId)throws SysException{
    	return this.evaservice.getTemplateByPlanIdAndOrgId(planId, orgId);
    }
}
