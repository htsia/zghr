package com.hr319wg.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaAGItemBO;
import com.hr319wg.eva.pojo.bo.EvaLevelPurview;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaSelectionResultItemBO;
import com.hr319wg.eva.pojo.bo.EvaSelectionResultSetBO;
import com.hr319wg.eva.pojo.bo.EvaTempMasterBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

import java.util.Hashtable;
import java.util.List;



public class EvaObjectsDAO extends BaseDAO {
	public List getEvaObjects(PageVO pagevo, String planID, String treeid,
			String limit,String conditionValue) throws SysException {
		String hsql = "select vo from EvaObjectsVO vo where vo.planID='"
				+ planID + "' and vo.depttree like '" + treeid + "%' ";
		String countsql = "select count(vo) from EvaObjectsVO vo where vo.planID='"
				+ planID + "' and vo.depttree like '" + treeid + "%' ";
		if(conditionValue!=null&&!conditionValue.equals("")){
			hsql+=" and (vo.personName like '%"+conditionValue+"%' or vo.shortName like '%"+conditionValue+"%')";
			countsql+=" and (vo.personName like '%"+conditionValue+"%' or vo.shortName like '%"+conditionValue+"%')";
		}
		if (limit != null && !"".equals(limit)) {
			hsql += " and " + limit;
			countsql += " and " + limit;
		}
		return this.pageQuery(pagevo, countsql, hsql);
	}

	public List getNotEvaObjects(PageVO pagevo, String planID, String treeid,
			String limit) throws SysException {
		String hsql = "select pb from PersonBO pb where pb.deptTreeId like '"
				+ treeid + "%'";
		String countsql = "select count(pb) from PersonBO pb where pb.deptTreeId like '"
				+ treeid + "%'";
		hsql += " and pb.personId not in (select vo.personID from EvaObjectsVO vo where plan_id='"
				+ planID + "' and vo.depttree like '" + treeid + "%')";
		countsql += " and pb.personId not in (select vo.personID from EvaObjectsVO vo where plan_id='"
				+ planID + "' and vo.depttree like '" + treeid + "%')";
		if (limit != null && !"".equals(limit)) {
			hsql += " and " + limit;
		}
		return this.pageQuery(pagevo, countsql, hsql);
	}

	public List getMasters(String objectID,String queryValue) throws SysException {
		String hsql = "select  bo from EvaMasterBO bo where bo.objectID='"
				+ objectID + "'";
		if(queryValue!=null&&!queryValue.equals("")){
			hsql+=" and bo.personID in(select vo.personId from PersonBO vo where vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%')";
		}
		hsql+=" order by cast(bo.score as float) desc";
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getMastersByMasterType(String objectID,String masterType) throws SysException {
		String hsql = "select  bo from EvaMasterBO bo where bo.objectID='"
				+ objectID + "' and bo.masterType='"+masterType+"'";
		return this.hibernatetemplate.find(hsql);
	}
	public List getEvaMasterBOByObjectIdAndGradeId(String objectID,String gradeId)throws SysException{
		String hsql = "select  bo from EvaMasterBO bo where bo.objectID='"
			+ objectID + "' and bo.gradeId='"+gradeId+"'";
	return this.hibernatetemplate.find(hsql);
	}

	public List getMastersByPersonID(String personID) throws SysException {
		String hsql = "select bo from EvaMasterBO bo where bo.personID='"
				+ personID + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getMasterByMasterPlanId(String planID, String loginID)
			throws SysException {
		String hsql = "select bo from EvaMasterBO bo where bo.personID='"
				+ loginID
				+ "' and "
				+ " bo.objectID in (select vo.objectID from EvaObjectsBO vo where vo.planID='"
				+ planID + "')";
		return this.hibernatetemplate.find(hsql);
	}
	public List getMasterByMasterPlanIdAndMasterType(String planID, String loginID,String masterType)throws SysException {
		String hsql = "select bo from EvaMasterBO bo where bo.personID='"
				+ loginID
				+ "' and bo.masterType='"+masterType+"' and"
				+ " bo.objectID in (select vo.objectID from EvaObjectsBO vo where vo.planID='"
				+ planID + "')";
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getMasterByPersonIdAndObjIds(String perosnId,String[] objId)throws SysException{
		String objs="'1'";
		for(int i=0;i<objId.length;i++){
			objs+=",'"+objId[i]+"'";
		}
		String hql="select bo from EvaMasterBO bo where bo.personID='"+ perosnId+ "' and"+ " bo.objectID in ("+objs+")";
		return this.hibernatetemplate.find(hql);
	}
	 

	// fangxia
	public List getObjectByObjId(String objectid) throws SysException {
		String hsql = "select new EvaObjectsBO(bo.objectID,bo.personID) from EvaObjectsBO bo  WHERE bo.objectID='"
				+ objectid + "' GROUP BY bo.personID,bo.objectID";
		return this.hibernatetemplate.find(hsql);
	}

	public List getMasterScore(PageVO pagevo, String planId, String templateId,
			String orgid) throws SysException {
		OrgBO orgbo = SysCacheTool.findOrgById(orgid);
		String hsql = "select bo from EvaMasterBO bo  where bo.objectID in(select o.objectID from EvaObjectsBO o  where  o.planID='"
				+ planId
				+ "' and o.templateID='"
				+ templateId
				+ "' and o.personID in (select pb.personId from  PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId() + "%'))";
		String countsql = "select count(bo) from EvaMasterBO bo  where bo.objectID in(select o.objectID from EvaObjectsBO o  where  o.planID='"
				+ planId
				+ "' and o.templateID='"
				+ templateId
				+ "' and o.personID in (select pb.personId from  PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId() + "%'))";
		return this.pageQuery(pagevo, countsql, hsql);
	}
	public List getMasterBO(String planId,String templateId,String personId,String deptId,String gradeId)throws SysException{
		OrgBO orgbo = SysCacheTool.findOrgById(deptId);
		String hsql = "select bo from EvaMasterBO bo  where bo.objectID in(select o.objectID from EvaObjectsBO o  where  o.planID='"
			+ planId
			+ "' and o.templateID='"
			+ templateId
			+ "' and o.personID in (select pb.personId from  PersonBO pb where pb.deptTreeId like '%"
			+ orgbo.getTreeId() + "%')) and bo.personID='"+personId+"' and bo.gradeId='"+gradeId+"'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getResultScore(PageVO pagevo, String planId,String queryValue,String objType)
			throws SysException {
		EvaPlanBO pbo=(EvaPlanBO)this.findBoById(EvaPlanBO.class, planId);
		String hsql = "select bo from EvaObjectsBO bo  where bo.planID='"+ planId + "'";
		String countsql = "select count(bo) from EvaObjectsBO bo  where bo.planID='"+ planId + "'";
		if(queryValue!=null&&!queryValue.equals("")&&objType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
			hsql+=" and bo.personID in(select vo.personId from PersonBO vo where (vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%'))";
			countsql+=" and bo.personID in(select vo.personId from PersonBO vo where (vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%'))";
		}
		hsql+=" order by cast(bo.sumScore as float) desc,cast(bo.score as float) desc";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countsql, hsql);
		}else{
			return this.hibernatetemplate.find(hsql);
		}
	}

	public List getTemMasterBOList(String planID) throws SysException {
		String hsql = "select bo from EvaTempMasterBO bo where bo.evaPlanID='"
				+ planID + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List AddTeamMasterPerson(PageVO pagevo, String planID, String orgid)
			throws SysException {
		String hql = "select pb from PersonBO pb where pb.orgId='"
				+ orgid
				+ "' and  pb.personId not in(select bo.masterName from EvaTempMasterBO bo where bo.evaPlanID='"
				+ planID + "')";
		String countsql = "select count(pb) from PersonBO pb where pb.orgId='"
				+ orgid
				+ "' and  pb.personId not in(select bo.masterName from EvaTempMasterBO bo where bo.evaPlanID='"
				+ planID + "')";
		return this.pageQuery(pagevo, countsql, hql);
	}

	// 刘云龙
	public List getfindEvaTempMasterBO(String username) throws SysException {
		String hql = "select bo from EvaTempMasterBO  bo where bo.masterID='"
				+ username + "'";
		return this.hibernatetemplate.find(hql);
	}

	public void updateEvaTempMasterBO(EvaTempMasterBO evaTempMasterBO)
			throws SysException {
		this.hibernatetemplate.update(evaTempMasterBO);
	}

	public void saveTempMasterBO(EvaTempMasterBO bo) throws SysException {
		this.hibernatetemplate.save(bo);
	}

	public void updateTempMasterBO(EvaTempMasterBO bo) throws SysException {
		this.hibernatetemplate.update(bo);
	}

	public List getPlanByMasterName(String masterName) throws SysException {
		String hsql = "select bo from EvaTempMasterBO bo  where bo.masterID='"
				+ masterName + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List getObjectsByPlanId(PageVO pagevo,String planId) throws SysException {
		String hsql = "select bo from EvaObjectsBO bo  where bo.planID='"+ planId + "'";
		String countHql="select count(bo) from EvaObjectsBO bo  where bo.planID='"
			+ planId + "'";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hsql);
		}else{
			hsql+="  order by cast(bo.score as float) desc";
			return this.hibernatetemplate.find(hsql);
		}
	}
	public List getObjectsByPlanIdAndOrgId(PageVO pagevo,String planId,String orgId) throws SysException {
		OrgBO org=SysCacheTool.findOrgById(orgId);
		String hsql = "select bo from EvaObjectsBO bo  where bo.planID='"+ planId + "'";
		String countHql="select count(bo) from EvaObjectsBO bo  where bo.planID='"+ planId + "'";
		if(orgId!=null&&!orgId.equals("")){
			hsql+=" and bo.personID in(select vo.personId from PersonBO vo where vo.deptTreeId like '"+org.getTreeId()+"%')";
			countHql+=" and bo.personID in(select vo.personId from PersonBO vo where vo.deptTreeId like '"+org.getTreeId()+"%')";
		}
		hsql+="  order by cast(bo.sumScore as float) desc,cast(bo.score as float) desc";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hsql);
		}else{
			return this.hibernatetemplate.find(hsql);
		}
	}
	public List getObjectsBOByPlanIdForSumSort(String planId)throws SysException{
		String hsql = "select bo from EvaObjectsBO bo  where bo.planID='"+ planId + "' order by cast(bo.sumScore as float) desc";
		return this.hibernatetemplate.find(hsql);
	}
	public List getEvaObjectsVOByPlanIdAndQuery(PageVO pagevo,String planId,String queryValue)throws SysException{
		String hsql="select bo from EvaObjectsVO bo where bo.planID='"+planId+"'";
		String countHql="select count(bo) from EvaObjectsVO bo where bo.planID='"+planId+"'";
		if(queryValue!=null&&!queryValue.equals("")){
			hsql+=" and (bo.personName like '%"+queryValue+"%' or bo.shortName like '%"+queryValue+"%')";
			countHql+=" and (bo.personName like '%"+queryValue+"%' or bo.shortName like '%"+queryValue+"%')";
		}
		return this.pageQuery(pagevo, countHql, hsql);
	}
	
	public EvaObjectsBO getEvaObjectsBOByPlanIdAndPersonId(String planId,String pid)throws SysException{
		String hql="select bo from EvaObjectsBO bo where bo.planID='"+planId+"' and bo.personID='"+pid+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (EvaObjectsBO)list.get(0);
		}else{
			return null;
		}
	}
	
	public List getEvaObjectsVOByPlanIdPersonIdAndTemId(PageVO pagevo,String planId,String personId,String temId,String queryValue)throws SysException{
	    String hql="select bo from EvaObjectsVO bo where bo.planID='"+planId+"' and bo.templateID='"+temId+"'";
	    String counthql="select count(bo) from EvaObjectsVO bo where bo.planID='"+planId+"' and bo.templateID='"+temId+"'";
		if(queryValue!=null&&!queryValue.equals("")){
			hql+=" and (bo.personName like '%"+queryValue+"%' or bo.shortName like '%"+queryValue+"%')";
			counthql+=" and (bo.personName like '%"+queryValue+"%' or bo.shortName like '%"+queryValue+"%')";
		}
		hql+=" and bo.objectID in(select vo.objectID from EvaMasterBO vo where vo.personID='"+personId+"') order by bo.deptid desc";
		counthql+=" and bo.objectID in(select vo.objectID from EvaMasterBO vo where vo.personID='"+personId+"')";
		return this.pageQuery(pagevo, counthql, hql);
	}
	public List getEvaObjectsBOByMasterAndGardeItem(String planId,String personId,String temId,String itemId,String queryValue)throws SysException{
		String hql="select bo from EvaMasterBO bo where bo.personID='"+personId+"' and bo.gradeId='"+itemId+"' and bo.objectID in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+temId+"'";
		if(queryValue!=null&&!queryValue.equals("")){
			hql+="and (vo.personName like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%')";
		}
		hql+=") order by bo.score desc";
		return this.hibernatetemplate.find(hql);
	}
	public List getEvaObjectsBOByPlanIdAndTimId(PageVO pagevo,String planId,String temId)throws SysException{
		String hql="select bo from EvaObjectsBO bo  where bo.planID='"+planId+ "' and bo.templateID='"+temId+"'";
		String countHql="select count(bo) from EvaObjectsBO bo  where bo.planID='"+planId+ "' and bo.templateID='"+temId+"'";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	
	//乔磊
	public List getTempMasters(String planId) throws SysException {
		String hsql = "select bo from EvaTempMasterBO bo where bo.evaPlanID='"+planId+"'";
		return this.hibernatetemplate.find(hsql);
	}

	public EvaTempMasterBO getEvaTempMasterBO(String masterId)
			throws SysException {
		String hsql = "select bo from EvaTempMasterBO bo where bo.masterID='"
				+ masterId + "'";
		List list = this.hibernatetemplate.find(hsql);
		if (list.size() == 0 || list == null) {
			return null;
		} else {
			EvaTempMasterBO bo = (EvaTempMasterBO) list.get(0);
			return bo;
		}
	}

	public EvaMasterBO getEvaMasterBOBymasterId(String objectId, String personId)
			throws SysException {
		String hsql = "select bo from EvaMasterBO bo where bo.objectID='"
				+ objectId + "' and bo.personID='" + personId + "'";
		List list = this.hibernatetemplate.find(hsql);
		if (list.size() == 0 || list == null) {
			return null;
		} else {
			EvaMasterBO bo = (EvaMasterBO) list.get(0);
			return bo;
		}
	}

	public List getMasterIdByOIdandPid(String objectId, String personId)
			throws SysException {
		String hsql = "select bo from EvaMasterBO bo  where bo.objectID='"
				+ objectId + "' and bo.personID='" + personId + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public User verifyLogon(String loginName, String password)
			throws SysException {
		try {
			User user;
			loginName = loginName.trim();
			password = password.trim();

			List list = hibernatetemplate
					.find("from EvaTempMasterBO bo where bo.masterID='"
							+ loginName + "'");
			if (!list.isEmpty()) {
				user = new User();
				EvaTempMasterBO bo = (EvaTempMasterBO) list.get(0);
				user.setUserId(bo.getMasterID());
				user.setPassword(bo.getPassword());
				if (password.equals(user.getPassword()))
					return user;
			}
			return null;
		} catch (Exception e) {
			throw new SysException("", "读取用户信息错误！", e, EvaObjectsDAO.class);
		}
	}
	//根据ObjectID查询所有的层次考核实体
	public List getAllLevelPurviewByObjectId(String objectId)throws SysException{
		String hql="from EvaLevelPurview bo where bo.objectId='"+objectId+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	public EvaLevelPurview getLevelPurviewByObjectIdAndType(String objectId,String masterType)throws SysException{
		String hql="from EvaLevelPurview bo where bo.objectId='"+objectId+"' and bo.masterType='"+masterType+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (EvaLevelPurview)list.get(0);
		}else{
			return null;
		}
		
	}
	
	public List getDefaultLevelByPlanId(String planid)throws SysException{
		String hql="from EvaDefaultLevelBO bo where bo.planId='"+planid+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	public void updateEvaLevelPurview(EvaLevelPurview bo)throws SysException{
		this.hibernatetemplate.update(bo);
	}
	
	public void updateMasterbo(EvaMasterBO masterbo)throws SysException{
		this.getHibernatetemplate().update(masterbo);
	}
	//评审团
	public List getAllEvaAuditGroupBOByPlanId(String planId)throws SysException{
		String hql="select bo from EvaAuditGroupBO bo where bo.planId='"+planId+"'";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllEvaAGItemBOByGroupId(String groupId,String queryValue)throws SysException{
		String hql="select bo from EvaAGItemBO bo where bo.groupId='"+groupId+"'";
		if(queryValue!=null&&!queryValue.equals("")){
			hql+=" and bo.personId in(select vo.personId from PersonBO vo where vo.name like '%"+queryValue+"%' or vo.shortName like '%"+queryValue+"%')";
		}
		return this.hibernatetemplate.find(hql);
	}
	public EvaAGItemBO findEvaAGItemBOByPersonIdAndGroupId(String groupId,String personId)throws SysException{
		String hql="select bo from EvaAGItemBO bo where bo.groupId='"+groupId+"' and bo.personId='"+personId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (EvaAGItemBO)list.get(0);
		}else{
			return null;
		}
	}
	public List getEvaObjectsBOForResutlShow(PageVO pagevo,String planId,String temId,String orgId)throws SysException{
		OrgBO org=SysCacheTool.findOrgById(orgId);
		String treeId="";
		String hql="";
		String countHql="";
		if(org!=null){
			treeId=org.getTreeId();
			hql="select bo from EvaObjectsBO bo  where bo.planID='"+planId+ "' and bo.templateID='"+temId+
				"' and bo.personID in (select vo.personId from PersonBO vo where vo.deptTreeId like '%"+treeId+"%')";
			
			countHql="select count(bo) from EvaObjectsBO bo  where bo.planID='"+planId+ "' and bo.templateID='"+temId+
					"' and bo.personID in (select vo.personId from PersonBO vo where vo.deptTreeId like '%"+treeId+"%')";
		}else{
			treeId=orgId.replaceAll("A001738", "vo.deptTreeId");
			hql="select bo from EvaObjectsBO bo  where bo.planID='"+planId+ "' and bo.templateID='"+temId+
			"' and bo.personID in (select vo.personId from PersonBO vo where "+treeId+")";
		
			countHql="select count(bo) from EvaObjectsBO bo  where bo.planID='"+planId+ "' and bo.templateID='"+temId+
				"' and bo.personID in (select vo.personId from PersonBO vo where "+treeId+")";
		}
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String personId,String masterType,String gradeItem,String deptId)throws SysException{
		String hql="select bo from EvaObjectsBO bo where bo.planID='"+planId+"' and bo.objectID in(select vo.objectID from EvaMasterBO vo where vo.personID='"+personId+"' and vo.masterType='"+masterType+"' and vo.gradeId='"+gradeItem+"')";
		if(deptId!=null&&!deptId.equals("")){
			OrgBO org=SysCacheTool.findOrgById(deptId);
			hql+=" and bo.personID in(select po.personId from PersonBO po where po.deptTreeId like '"+org.getTreeId()+"%') ";
		}
		return this.hibernatetemplate.find(hql);
	}
	public Hashtable getEvaMasterBOByObjectIds(String[] objId)throws SysException{
		Hashtable ht=new Hashtable();
		String objs="'1'";
		for(int i=0;i<objId.length;i++){
			objs+=",'"+objId[i]+"'";
		}
		String hql="select bo from EvaMasterBO bo where bo.objectID in("+objs+")";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				EvaMasterBO bo=(EvaMasterBO)list.get(i);
				ht.put(bo.getMasterID(), bo);
			}
		}
		return ht;
	}
	public Hashtable getEvaMasterBOByObjectIdsForHash(String[] objId)throws SysException{
		Hashtable ht=new Hashtable();
		String objs="'1'";
		for(int i=0;i<objId.length;i++){
			if(objId[i]!=null&&!objId[i].equals("")){
				objs+=",'"+objId[i]+"'";
			}
		}
		String hql="select bo from EvaMasterBO bo where bo.objectID in("+objs+")";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				EvaMasterBO bo=(EvaMasterBO)list.get(i);
				ht.put(bo.getObjectID()+bo.getPersonID(), bo);
			}
		}
		return ht;
	}
	public Hashtable getEvaObjectBOByObjectIds(String [] objId)throws SysException{
		Hashtable ht=new Hashtable();
		String objs="'1'";
		for(int i=0;i<objId.length;i++){
			if(objId[i]!=null&&!objId[i].equals("")){
				objs+=",'"+objId[i]+"'";
			}
		}
		String hql="select bo from EvaObjectsBO bo where bo.objectID in("+objs+")";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				EvaObjectsBO bo=(EvaObjectsBO)list.get(i);
				ht.put(bo.getObjectID(), bo);
			}
		}
		return ht;
	}
	public List getEvaObjectsBOByPlanIdAndMasterPid(String planId,String masterPid)throws SysException{
		String hql="select bo from EvaObjectsBO bo where bo.planID='"+planId+"' and bo.objectID in(select vo.objectID from EvaMasterBO vo where vo.personID='"+masterPid+"')";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getEvaSelectionResultSetBOByPlanId(String planId)throws SysException{
		String hql="select bo from EvaSelectionResultSetBO bo where bo.planId='"+planId+"'";
		return this.hibernatetemplate.find(hql);
	}
	public EvaSelectionResultSetBO getEvaSelectionResultSetBOForResult(String planId)throws SysException{
		String hql="select bo from EvaSelectionResultSetBO bo where bo.planId='"+planId+"' and bo.isSel='1'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (EvaSelectionResultSetBO)list.get(0);
		}else{
			return null;
		}
	}
	public List getEvaSelectionResultItemBOBySetId(String setId)throws SysException{
		String hql="select bo from EvaSelectionResultItemBO bo where bo.setId='"+setId+"'";
		return this.hibernatetemplate.find(hql);
	}
	public List getEvaSelectionResultItemBOBySetIdAndObjId(String setId,String objectId)throws SysException{
		String hql="select bo from EvaSelectionResultItemBO bo where bo.setId='"+setId+"' and bo.objectId='"+objectId+"'";
		return this.hibernatetemplate.find(hql);
	}
	public EvaSelectionResultItemBO findEvaSelectionResultItemBO(String setId,String objectId,String masterType)throws SysException{
		String hql="select bo from EvaSelectionResultItemBO bo where bo.setId='"+setId+"' and bo.objectId='"+objectId+"' and bo.masterType='"+masterType+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (EvaSelectionResultItemBO)list.get(0);
		}else{
			return null;
		}
	}
	public Hashtable findEvaSelectionResultItemBOByObjectIds(String objectIds)throws SysException{
		String hql="select bo from EvaSelectionResultItemBO bo where  bo.objectId in("+objectIds+")";
		List list=this.hibernatetemplate.find(hql);
		Hashtable ht=new Hashtable();
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				EvaSelectionResultItemBO bo=(EvaSelectionResultItemBO)list.get(i);
				ht.put(bo.getSetId()+bo.getObjectId()+bo.getMasterType(), bo);
			}
		}
		return ht;
	}
	public List getAllEvaGradersBOByPlanIdAndOrgId(PageVO pagevo,String templateID,String orgId,String planId,String index)throws SysException{
		OrgBO org=SysCacheTool.findOrgById(orgId);
		if(org!=null){
			if(index.equals("0")){
				String hql="select bo from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and vo.depttree like '"+org.getTreeId()+"%') order by cast(bo.s as float) desc";
				String countHql="select count(bo) from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and vo.depttree like '"+org.getTreeId()+"%')";
				return this.pageQuery(pagevo, countHql, hql);
			}else{
				String hql="select bo from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and vo.depttree like '"+org.getTreeId()+"%') order by cast(bo.s"+index+" as float) desc";
				String countHql="select count(bo) from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and vo.depttree like '"+org.getTreeId()+"%')";
				return this.pageQuery(pagevo, countHql, hql);
			}
		}else{
			orgId=orgId.replaceAll("A001738", "vo.depttree");
			if(index.equals("0")){
				String hql="select bo from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and "+orgId+") order by cast(bo.s as float) desc";
				String countHql="select count(bo) from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and "+orgId+")";
				return this.pageQuery(pagevo, countHql, hql);
			}else{
				String hql="select bo from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and "+orgId+") order by cast(bo.s"+index+" as float) desc";
				String countHql="select count(bo) from EvaGradersBO bo where bo.objectId in(select vo.objectID from EvaObjectsVO vo where vo.planID='"+planId+"' and vo.templateID='"+templateID+"' and "+orgId+")";
				return this.pageQuery(pagevo, countHql, hql);
			}
		}
	}
}
