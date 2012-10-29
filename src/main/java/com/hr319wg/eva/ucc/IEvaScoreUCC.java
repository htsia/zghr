package com.hr319wg.eva.ucc;

import com.hr319wg.common.exception.SysException;

import com.hr319wg.eva.pojo.bo.EvaCaclScoresBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;


import java.util.Hashtable;
import java.util.List;

public interface IEvaScoreUCC {
    public List getScoreInfo(String masterID,String objectID) throws SysException ;
    public void saveScore(EvaScoreBO bo) throws SysException ;
    public void deleteAllScore(String masterID,String objectID) throws SysException;
    public void calc(String planID) throws SysException;
    public List getEvaCaclScoresBOByObjectId(String objectId)throws SysException;
    public Hashtable getEvaCaclScoresBOByObjectIds(String[] objIds)throws SysException;
    public EvaCaclScoresBO findEvaCaclScoresBOById(String scoreId)throws SysException;
    public void saveEvaCaclScoresBO(EvaCaclScoresBO bo)throws SysException;
    public void deleteEvaCaclScoresBO(String scoreId)throws SysException;
    public EvaCaclScoresBO findEvaCaclScoresBOByItemIdAndObjectId(String objectId,String itemId)throws SysException;
    
  //·½Ï¼¿ªÊ¼
    public List getPersonType() throws SysException ;
    public List getAllObjectByObjectId(String objectid) throws SysException;
    public List getAllScoreByObjectIdAndItemId(String objectid,String itemid)throws SysException;
    public List getAllEvaScoreBOByObjIdAndMasterId(String objId,String masterId)throws SysException;
    public void caclTheMasterScoreForObject(String objectId,String masterId)throws SysException;
    public EvaScoreBO findEvaScoreBOByObjIdMasterIdAndItemId(String objId,String masterId,String itemId)throws SysException;
    public Hashtable getEvaScoreBOByPlanIdAndPersonIdForHash(String personId,String[] objId)throws SysException;
    
    public void caclVirtualPlan(String planId)throws SysException;
    public Hashtable getEvaScoreBOForItemHash(String[] objId,String temid)throws SysException;
    public boolean isHaveTheTypeMasterByPlanId(String planId,String masterType)throws SysException;
    public List getThePersonTypeByPlanId(String planId) throws SysException;

    public List getAllEvaMastersVOByPlanId(String planId)throws SysException;
}
