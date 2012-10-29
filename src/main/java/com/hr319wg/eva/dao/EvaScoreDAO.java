package com.hr319wg.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.eva.pojo.bo.EvaCaclScoresBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;

import java.util.Hashtable;
import java.util.List;

public class EvaScoreDAO extends BaseDAO {
	public List getScoreInfo(String masterID, String objectID)
			throws SysException {
		String hsql = "select bo from EvaScoreBO bo where bo.masterID='"
				+ masterID + "' and bo.objectID='" + objectID + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getPersonType() throws SysException {
		String hsql = "select bo from CodeItemBO bo where bo.setId='0652'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getAllObjectByObjectId(String objectid) throws SysException {
		String hql = "select bo from EvaScoreBO bo  where bo.objectID='"
				+ objectid + "'";
		return this.hibernatetemplate.find(hql);
	}

	public List getAllScoreByObjectIdAndItemId(String objectid, String itemid)
			throws SysException {
		String hql = "select bo from EvaScoreBO bo  where bo.objectID='"
				+ objectid + "' and bo.itemID='" + itemid + "'";
		return this.hibernatetemplate.find(hql);
	}

	public List getAllScoreByObjectIdsAndTemId(String objIds[], String temId)
			throws SysException {
		String objid = "'1'";
		for (int i = 0; i < objIds.length; i++) {
			if (objIds[i] != null && !objIds[i].equals("")) {
				objid += ",'" + objIds[i] + "'";
			}
		}
		String hql="select bo from EvaScoreBO bo where bo.itemID in(select vo.itemID from TemplateItemBO vo where vo.templateID='"+temId+"') and bo.objectID in("+objid+")";
		return this.hibernatetemplate.find(hql);
	}

	public List getAllEvaScoreBOByObjIdAndMasterId(String objId, String masterId)
			throws SysException {
		String hql = "select bo from EvaScoreBO bo where bo.objectID='" + objId
				+ "' and bo.masterID='" + masterId + "'";
		return this.hibernatetemplate.find(hql);
	}

	public List getEvaCaclScoresBOByObjectId(String objectId)
			throws SysException {
		String hql = "select bo from EvaCaclScoresBO bo where bo.objectId='"
				+ objectId + "'";
		return this.hibernatetemplate.find(hql);
	}

	public Hashtable getEvaCaclScoresBOByObjectIds(String[] objIds)
			throws SysException {
		Hashtable ht = new Hashtable();
		String objid = "'1'";
		for (int i = 0; i < objIds.length; i++) {
			if (objIds[i] != null && !objIds[i].equals("")) {
				objid += ",'" + objIds[i] + "'";
			}
		}
		String hql = "select bo from EvaCaclScoresBO bo where bo.objectId in("
				+ objid + ")";
		List list = this.hibernatetemplate.find(hql);
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				EvaCaclScoresBO bo = (EvaCaclScoresBO) list.get(i);
				ht.put(bo.getObjectId() + bo.getItemId(), bo);
			}
		}
		return ht;
	}

	public EvaCaclScoresBO findEvaCaclScoresBOByItemIdAndObjectId(
			String objectId, String itemId) throws SysException {
		String hql = "select bo from EvaCaclScoresBO bo where bo.objectId='"
				+ objectId + "' and bo.itemId='" + itemId + "'";
		List list = this.hibernatetemplate.find(hql);
		if (list != null && list.size() > 0) {
			return (EvaCaclScoresBO) list.get(0);
		} else {
			return null;
		}
	}

	public EvaScoreBO findEvaScoreBOByObjIdMasterIdAndItemId(String objId,
			String masterId, String itemId) throws SysException {
		String hql = "select bo from EvaScoreBO bo where bo.masterID='"
				+ masterId + "' and bo.objectID='" + objId
				+ "' and bo.itemID='" + itemId + "'";
		List list = this.hibernatetemplate.find(hql);
		if (list != null && list.size() > 0) {
			return (EvaScoreBO) list.get(0);
		} else {
			return null;
		}
	}

	public List getEvaScoreBOByPlanIdAndPersonId(String personId, String[] objId)
			throws SysException {
		String objs = "'1'";
		for (int i = 0; i < objId.length; i++) {
			objs += ",'" + objId[i] + "'";
		}
		String hql = "select bo from EvaScoreBO bo where  bo.masterID in(select mo.masterID from EvaMasterBO mo where mo.personID='"
				+ personId + "') and bo.objectID in (" + objs + ")";
		return this.hibernatetemplate.find(hql);
	}

}
