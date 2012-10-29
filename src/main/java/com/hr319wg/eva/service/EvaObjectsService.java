package com.hr319wg.eva.service;

import com.hr319wg.eva.dao.EvaObjectsDAO;
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
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

public class EvaObjectsService {
	private EvaObjectsDAO evaobjectdao;
	private ActivePageAPI activeapi;

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}
	
	public String[] getTemplateByPlanIdAndOrgId(String planId,String orgId)throws SysException{
		OrgBO org=SysCacheTool.findOrgById(orgId);
		String sql="";
		if(org!=null){
			sql="select distinct(template_ID) from v_evaobjects where PLAN_ID='"+planId+"' and A001738 like '"+org.getTreeId()+"%'";
		}else{
			sql="select distinct(template_ID) from v_evaobjects where PLAN_ID='"+planId+"' and "+orgId+"";
		}
		CellVO[] cv=new CellVO[1];
        cv[0]=new CellVO();
        cv[0].setItemId("template_ID");
        Vector rs=activeapi.getDataListBySql(cv,sql);
        String[] temp=new String[rs.size()];
        for(int i=0;i<rs.size();i++){
	          CellVO row[]=(CellVO[])rs.get(i);
	          temp[i]=(row[0].getValue());
	    }
        return temp;
	}

	public List getEvaObjects(PageVO pagevo, String planID, String orgId,
			String limit,String conditionValue) throws SysException {
		return evaobjectdao.getEvaObjects(pagevo, planID, orgId, limit,conditionValue);
	}

	public List getNotEvaObjects(PageVO pagevo, String planID, String orgId,
			String limit) throws SysException {
		return evaobjectdao.getNotEvaObjects(pagevo, planID, orgId, limit);
	}

	public EvaObjectsVO findEvaObject(String id) throws SysException {
		return (EvaObjectsVO) evaobjectdao.findBoById(EvaObjectsVO.class, id);
	}

	public void savaEvaObject(EvaObjectsBO bo) throws SysException {
		evaobjectdao.saveOrUpdateBo(bo);
	}

	public void deleteEvaObject(String item) throws SysException {
		evaobjectdao.deleteBo(EvaObjectsBO.class, item);
	}

	public void deleteEvaMasterBO(String itemid) throws SysException {
		evaobjectdao.deleteBo(EvaMasterBO.class, itemid);
	}

	public void saveEvaMasterBO(EvaMasterBO bo) throws SysException {
		this.evaobjectdao.saveOrUpdateBo(bo);
	}

	public List getMasters(String objectID,String queryValue) throws SysException {
		return evaobjectdao.getMasters(objectID,queryValue);
	}

	public EvaObjectsDAO getEvaobjectdao() {
		return evaobjectdao;
	}

	public void setEvaobjectdao(EvaObjectsDAO dao) {
		this.evaobjectdao = dao;
	}

	public List getMasterByMasterPlanId(String planID, String loginID)
			throws SysException {
		return evaobjectdao.getMasterByMasterPlanId(planID, loginID);
	}

	public List getMastersByPersonID(String personID) throws SysException {
		return evaobjectdao.getMastersByPersonID(personID);
	}

	public List getObjectByObjId(String objectid) throws SysException {
		return evaobjectdao.getObjectByObjId(objectid);
	}

	public List getMasterScore(PageVO pagevo, String planId, String templateId,
			String orgId) throws SysException {
		return evaobjectdao.getMasterScore(pagevo, planId, templateId, orgId);
	}

	public List getResultScore(PageVO pagevo, String planId,String queryValue,String objType)
			throws SysException {
		return evaobjectdao.getResultScore(pagevo, planId,queryValue,objType);
	}

	public EvaObjectsBO findEvaObjectBOById(String objectId)
			throws SysException {
		return (EvaObjectsBO) evaobjectdao.findBoById(EvaObjectsBO.class,
				objectId);
	}

	public List getTemMasterBOList(String planID) throws SysException {
		return evaobjectdao.getTemMasterBOList(planID);
	}

	public List AddTeamMasterPerson(PageVO pagevo, String planID, String orgid)
			throws SysException {
		return evaobjectdao.AddTeamMasterPerson(pagevo, planID, orgid);
	}

	public void saveTempMasterBO(EvaTempMasterBO bo) throws SysException {
		evaobjectdao.saveTempMasterBO(bo);
	}

	public void deleteTempMasterBO(String masterid) throws SysException {
		evaobjectdao.deleteBo(EvaTempMasterBO.class, masterid);
	}

	public EvaTempMasterBO findEvaTempMasterBOById(String masterid)
			throws SysException {
		return (EvaTempMasterBO) evaobjectdao.findBoById(EvaTempMasterBO.class,
				masterid);
	}

	public void updateTempMasterBO(EvaTempMasterBO bo) throws SysException {
		evaobjectdao.updateTempMasterBO(bo);
	}

	
	public List getfindEvaTempMasterBO(String username) throws SysException {
		return evaobjectdao.getfindEvaTempMasterBO(username);
	}

	public void updateEvaTempMasterBO(EvaTempMasterBO evaTempMasterBO)
			throws SysException {
		evaobjectdao.updateEvaTempMasterBO(evaTempMasterBO);
	}


	public List getPlanByMasterName(String masterName) throws SysException {
		return evaobjectdao.getPlanByMasterName(masterName);
	}

	public List getObjectsByPlanId(PageVO pagevo,String planId) throws SysException {
		return evaobjectdao.getObjectsByPlanId(pagevo,planId);
	}
	
	public List getTempMasters(String planId) throws SysException {
		return evaobjectdao.getTempMasters(planId);
	}

	public void saveTempMasters(EvaMasterBO bo) throws SysException {
		evaobjectdao.saveOrUpdateBo(bo);
	}

	public void insertEvaMasterBO(EvaMasterBO bo) throws SysException {
		this.evaobjectdao.createBo(bo);
	}

	public EvaTempMasterBO getEvaTempMasterBO(String masterId)
			throws SysException {
		return evaobjectdao.getEvaTempMasterBO(masterId);
	}

	public EvaMasterBO getEvaMasterBOBymasterId(String objectId, String personId)
			throws SysException {
		return evaobjectdao.getEvaMasterBOBymasterId(objectId, personId);
	}

	public List getMasterIdByOIdandPid(String objectId, String personId)
			throws SysException {
		return evaobjectdao.getMasterIdByOIdandPid(objectId, personId);
	}

	public User verifyLogon(String loginName, String password) throws Exception {
		User user = null;
		if (password != null && !"".equals(password)) {
			user = evaobjectdao.verifyLogon(loginName, password);
		}
		if (user == null) // 用户名或密码错误
			throw new SysException("USER00001", "", null,
					EvaObjectsService.class);
		if (!User.STATUS_OPEN.equals(user.getStatus())
				&& user.getStatus() != null) {
			throw new SysException("登录失败,此用户" + user.getLoginName()
					+ "已禁用!status=" + user.getStatus());
		}
		return user;
	}
	//层次权重
	public List getAllLevelPurviewByObjectId(String objectId)throws SysException{
		return evaobjectdao.getAllLevelPurviewByObjectId(objectId);
	}
	
	public EvaLevelPurview findEvaLevelPurviewById(String levelId)throws SysException{
		return (EvaLevelPurview)evaobjectdao.findBoById(EvaLevelPurview.class, levelId);
	}
	
	public void saveEvaLevelPurview(EvaLevelPurview bo)throws SysException{
		evaobjectdao.saveOrUpdateBo(bo);
	}
	
	public void updateEvaLevelPurview(EvaLevelPurview bo)throws SysException{
		evaobjectdao.updateEvaLevelPurview(bo);
	}
	
	public void deleteEvaLevelPurview(String levelid)throws SysException{
		evaobjectdao.deleteBo(EvaLevelPurview.class, levelid);
	}
	public List getMastersByMasterType(String objectID,String masterType) throws SysException {
		return evaobjectdao.getMastersByMasterType(objectID, masterType);
	}
	public EvaLevelPurview getLevelPurviewByObjectIdAndType(String objectId,String masterType)throws SysException{
		return evaobjectdao.getLevelPurviewByObjectIdAndType(objectId, masterType);
	}
	public void updateMasterbo(EvaMasterBO masterbo)throws SysException{
		evaobjectdao.updateMasterbo(masterbo);
	}
	public List getDefaultLevelByPlanId(String planid)throws SysException{
		return evaobjectdao.getDefaultLevelByPlanId(planid);
	}
	public EvaDefaultLevelBO findDefaultLevelById(String levelid)throws SysException{
		return (EvaDefaultLevelBO)evaobjectdao.findBoById(EvaDefaultLevelBO.class, levelid);
	}
	public void deleteEvaDefaultLevel(String levelid)throws SysException{
		evaobjectdao.deleteBo(EvaDefaultLevelBO.class, levelid);
	}
	public void saveEvaDefaultLevel(EvaDefaultLevelBO defaultbo)throws SysException{
		evaobjectdao.saveOrUpdateBo(defaultbo);
	}
	public EvaMasterBO findEvaMasterBOById(String mastorid)throws SysException{
		return (EvaMasterBO)evaobjectdao.findBoById(EvaMasterBO.class, mastorid);
	}
	public List getEvaObjectsVOByPlanIdPersonIdAndTemId(PageVO pagevo,String planId,String personId,String temId,String queryValue)throws SysException{
		return this.evaobjectdao.getEvaObjectsVOByPlanIdPersonIdAndTemId(pagevo,planId, personId,temId,queryValue);
	}
	public EvaObjectsBO getEvaObjectsBOByPlanIdAndPersonId(String planId,String pid)throws SysException{
		return this.evaobjectdao.getEvaObjectsBOByPlanIdAndPersonId(planId, pid);
	}
	public List getEvaObjectsBOByPlanIdAndTimId(PageVO pagevo,String planId,String temId)throws SysException{
		return this.evaobjectdao.getEvaObjectsBOByPlanIdAndTimId(pagevo, planId, temId);
	}
	
	public List getAllEvaAuditGroupBOByPlanId(String planId)throws SysException{
		return this.evaobjectdao.getAllEvaAuditGroupBOByPlanId(planId);
	}
	public EvaAuditGroupBO findEvaAuditGroupBO(String groupId)throws SysException{
		return (EvaAuditGroupBO)this.evaobjectdao.findBoById(EvaAuditGroupBO.class, groupId);
	}
	public void saveEvaAuditGroupBO(EvaAuditGroupBO bo)throws SysException{
		this.evaobjectdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaAuditGroupBO(String groupId)throws SysException{
		this.evaobjectdao.deleteBo(EvaAuditGroupBO.class, groupId);
	}
	public List getAllEvaAGItemBOByGroupId(String groupId,String queryValue)throws SysException{
		return this.evaobjectdao.getAllEvaAGItemBOByGroupId(groupId,queryValue);
	}
	public EvaAGItemBO findEvaAGItemBOByItemId(String itemId)throws SysException{
		return (EvaAGItemBO)this.evaobjectdao.findBoById(EvaAGItemBO.class, itemId);
	}
	public void saveEvaAGItemBO(EvaAGItemBO bo)throws SysException{
		this.evaobjectdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaAGItemBO(String itemId)throws SysException{
		this.evaobjectdao.deleteBo(EvaAGItemBO.class, itemId);
	}
	public EvaAGItemBO findEvaAGItemBOByPersonIdAndGroupId(String groupId,String personId)throws SysException{
		return this.evaobjectdao.findEvaAGItemBOByPersonIdAndGroupId(groupId, personId);
	}
	public List getEvaObjectsBOForResutlShow(PageVO pagevo,String planId,String temId,String orgId)throws SysException{
		return this.evaobjectdao.getEvaObjectsBOForResutlShow(pagevo, planId, temId, orgId);
	}
	public List getEvaObjectsBOByMasterAndGardeItem(String planId,String personId,String temId,String itemId,String queryValue)throws SysException{
		return this.evaobjectdao.getEvaObjectsBOByMasterAndGardeItem(planId, personId, temId, itemId,queryValue);
	}
	public List getMasterBO(String planId,String templateId,String personId,String deptId,String gradeId)throws SysException{
		return this.evaobjectdao.getMasterBO(planId, templateId, personId, deptId, gradeId);
	}
	public List getMasterByMasterPlanIdAndMasterType(String planID, String loginID,String masterType)throws SysException{
		return this.evaobjectdao.getMasterByMasterPlanIdAndMasterType(planID, loginID, masterType);
	}
	public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String personId,String masterType,String gradeItem,String deptId)throws SysException{
		return this.evaobjectdao.getEvaObjectsBOByPlanIdAndMasterPid(planId, personId,masterType,gradeItem,deptId);
	}
	public Hashtable getMasterByPersonIdAndObjIds(String perosnId,String[] objId)throws SysException{
		Hashtable ht=new Hashtable();
		List list=this.evaobjectdao.getMasterByPersonIdAndObjIds(perosnId,objId);
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				EvaMasterBO vo=(EvaMasterBO)list.get(i);
				ht.put(vo.getObjectID(), vo);
			}
		}
		return ht;
	}
	public Hashtable getEvaMasterBOByObjectIdsForHash(String[] objId)throws SysException{
		return this.evaobjectdao.getEvaMasterBOByObjectIdsForHash(objId);
	}
	public Hashtable getEvaObjectBOByObjectIds(String [] objId)throws SysException{
		return this.evaobjectdao.getEvaObjectBOByObjectIds(objId);
	}
	public Hashtable getEvaMasterBOByObjectIds(String[] objId)throws SysException{
		return this.evaobjectdao.getEvaMasterBOByObjectIds(objId);
	}
	public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String masterPid)throws SysException{
		return this.evaobjectdao.getEvaObjectsBOByPlanIdAndMasterPid(planId, masterPid);
	}
	public List getEvaObjectsVOByPlanIdAndQuery(PageVO pagevo,String planId,String queryValue)throws SysException{
		return this.evaobjectdao.getEvaObjectsVOByPlanIdAndQuery(pagevo, planId, queryValue);
	}
	public List getEvaMasterBOByObjectIdAndGradeId(String objectID,String gradeId)throws SysException{
		return this.evaobjectdao.getEvaMasterBOByObjectIdAndGradeId(objectID, gradeId);
	}
	public List getObjectsByPlanIdAndOrgId(PageVO pagevo,String planId,String orgId) throws SysException{
		return this.evaobjectdao.getObjectsByPlanIdAndOrgId(pagevo, planId, orgId);
	}
	public List getEvaSelectionResultSetBOByPlanId(String planId)throws SysException{
		return this.evaobjectdao.getEvaSelectionResultSetBOByPlanId(planId);
	}
	public EvaSelectionResultSetBO findEvaSelectionResultSetBO(String setId)throws SysException{
		return (EvaSelectionResultSetBO)this.evaobjectdao.findBoById(EvaSelectionResultSetBO.class, setId);
	}
	public EvaSelectionResultSetBO getEvaSelectionResultSetBOForResult(String planId)throws SysException{
		return this.evaobjectdao.getEvaSelectionResultSetBOForResult(planId);
	}
	public void saveEvaSelectionResultSetBO(EvaSelectionResultSetBO bo)throws SysException{
		this.evaobjectdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaSelectionResultSetBO(String setId)throws SysException{
		this.evaobjectdao.deleteBo(EvaSelectionResultSetBO.class, setId);
	}
	public List getEvaSelectionResultItemBOBySetId(String setId)throws SysException{
		return this.evaobjectdao.getEvaSelectionResultItemBOBySetId(setId);
	}
	public List getEvaSelectionResultItemBOBySetIdAndObjId(String setId,String objectId)throws SysException{
		return this.evaobjectdao.getEvaSelectionResultItemBOBySetIdAndObjId(setId,objectId);
	}
	public Hashtable findEvaSelectionResultItemBOByObjectIds(String objectIds)throws SysException{
		return this.evaobjectdao.findEvaSelectionResultItemBOByObjectIds(objectIds);
	}
	public EvaSelectionResultItemBO findEvaSelectionResultItemBO(String setId,String objectId,String masterType)throws SysException{
		return this.evaobjectdao.findEvaSelectionResultItemBO(setId, objectId, masterType);
	}
	public void saveEvaSelectionResultItemBO(EvaSelectionResultItemBO bo)throws SysException{
		this.evaobjectdao.saveOrUpdateBo(bo);
	}
	public void deleteEvaSelectionResultItemBO(String itemid)throws SysException{
		this.evaobjectdao.deleteBo(EvaSelectionResultItemBO.class, itemid);
	}
	public List getAllEvaGradersBOByPlanIdAndOrgId(PageVO pagevo,String templateID,String orgId,String planId,String index)throws SysException{
		return this.evaobjectdao.getAllEvaGradersBOByPlanIdAndOrgId(pagevo,templateID, orgId, planId,index);
	}
}
