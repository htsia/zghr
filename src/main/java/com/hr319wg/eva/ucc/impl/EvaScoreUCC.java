package com.hr319wg.eva.ucc.impl;

import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.eva.service.EvaScoreService;
import com.hr319wg.eva.pojo.bo.EvaCaclScoresBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;
import com.hr319wg.common.exception.SysException;


import java.util.Hashtable;
import java.util.List;

public class EvaScoreUCC implements IEvaScoreUCC {
	private EvaScoreService scoreservice;

	public List getScoreInfo(String masterID, String objectID)
			throws SysException {
		return scoreservice.getScoreInfo(masterID, objectID);
	}

	public void saveScore(EvaScoreBO bo) throws SysException {
		scoreservice.saveScore(bo);
	}

	public void deleteAllScore(String masterID, String objectID)
			throws SysException {
		scoreservice.deleteAllScore(masterID, objectID);
	}

	public void calc(String planID) throws SysException {
		scoreservice.calc(planID);
	}

	public EvaScoreService getScoreservice() {
		return scoreservice;
	}
	public void setScoreservice(EvaScoreService scoreservice) {
		this.scoreservice = scoreservice;
	}
	public List getEvaCaclScoresBOByObjectId(String objectId)throws SysException{
		return this.scoreservice.getEvaCaclScoresBOByObjectId(objectId);
	}
	public Hashtable getEvaCaclScoresBOByObjectIds(String[] objIds)throws SysException{
		return this.scoreservice.getEvaCaclScoresBOByObjectIds(objIds);
	}
    public EvaCaclScoresBO findEvaCaclScoresBOById(String scoreId)throws SysException{
    	return this.scoreservice.findEvaCaclScoresBOById(scoreId);
    }
    public void saveEvaCaclScoresBO(EvaCaclScoresBO bo)throws SysException{
    	this.scoreservice.saveEvaCaclScoresBO(bo);
    }
    public void deleteEvaCaclScoresBO(String scoreId)throws SysException{
    	this.scoreservice.deleteEvaCaclScoresBO(scoreId);
    }
    public EvaCaclScoresBO findEvaCaclScoresBOByItemIdAndObjectId(String objectId,String itemId)throws SysException{
    	return this.scoreservice.findEvaCaclScoresBOByItemIdAndObjectId(objectId, itemId);
    }

	public List getAllScoreByObjectIdAndItemId(String objectid,String itemid)throws SysException{
		return scoreservice.getAllScoreByObjectIdAndItemId(objectid, itemid);
	}
	public List getPersonType() throws SysException {
		return scoreservice.getPersonType();
	}
	public List getAllEvaScoreBOByObjIdAndMasterId(String objId,String masterId)throws SysException{
		return this.scoreservice.getAllEvaScoreBOByObjIdAndMasterId(objId, masterId);
	}

	public List getAllObjectByObjectId(String objectid) throws SysException {

		return scoreservice.getAllObjectByObjectId(objectid);
	}
	public void caclTheMasterScoreForObject(String objectId,String masterId)throws SysException{
		this.scoreservice.caclTheMasterScoreForObject(objectId, masterId);
	}
	public EvaScoreBO findEvaScoreBOByObjIdMasterIdAndItemId(String objId,String masterId,String itemId)throws SysException{
		return this.scoreservice.findEvaScoreBOByObjIdMasterIdAndItemId(objId, masterId, itemId);
	}
	public Hashtable getEvaScoreBOByPlanIdAndPersonIdForHash(String personId,String[] objId)throws SysException{
		return this.scoreservice.getEvaScoreBOByPlanIdAndPersonIdForHash( personId,objId);
	}
	public Hashtable getEvaScoreBOForItemHash(String[] objId,String temid)throws SysException{
		return this.scoreservice.getEvaScoreBOForItemHash(objId, temid);
	}
	public void caclVirtualPlan(String planId)throws SysException{
		this.scoreservice.caclVirtualPlan(planId);
	}
	public boolean isHaveTheTypeMasterByPlanId(String planId,String masterType)throws SysException{
		return this.scoreservice.isHaveTheTypeMasterByPlanId(planId, masterType);
	}
	public List getThePersonTypeByPlanId(String planId) throws SysException{
		return this.scoreservice.getThePersonTypeByPlanId(planId);
	}

    public List getAllEvaMastersVOByPlanId(String planId)throws SysException{
        return this.scoreservice.getAllEvaMastersVOByPlanId(planId);
    }
}
