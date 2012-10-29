package com.hr319wg.eva.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class jobEstimateDAO extends BaseDAO {
	public List findJOBEstimateByPlanID(String planID) throws SysException {
		String hql = "from EvaJobEstimateBO bo where bo.planID='" + planID
				+ "'";
		return this.getHibernatetemplate().find(hql);
	}
	public List findEvaJobEstimateBOForSumSort(String planId)throws SysException{
		String hql = "from EvaJobEstimateBO bo where bo.planID='" + planId
		+ "' order by bo.sumScore desc";
return this.getHibernatetemplate().find(hql);
	}

	public List findHaveCheckInPerson(PageVO pagevo, String planID, String orgId)
			throws SysException {
		OrgBO orgbo = SysCacheTool.findOrgById(orgId);
		String hql = "select pb from PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId()
				+ "%' and pb.personId in(select bo.personID from EvaJobEstimateBO bo where bo.planID='"
				+ planID + "')";
		String countsql = "select count(pb) from PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId()
				+ "%' and pb.personId in(select bo.personID from EvaJobEstimateBO bo where bo.planID='"
				+ planID + "')";
		return this.pageQuery(pagevo, countsql, hql);
	}

	public List findHaveNotCheckPerson(PageVO pagevo, String planID,
			String orgid) throws SysException {
		OrgBO orgbo = SysCacheTool.findOrgById(orgid);
		String hql = "select pb from PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId()
				+ "%' and  pb.personId not in(select bo.personID from EvaJobEstimateBO bo where bo.planID='"
				+ planID + "')";
		String countsql = "select count(pb) from PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId()
				+ "%' and  pb.personId not in(select bo.personID from EvaJobEstimateBO bo where bo.planID='"
				+ planID + "')";
		return this.pageQuery(pagevo, countsql, hql);
	}

	public List findEvaJobContentByItemID(String itemID) throws SysException {
		String hql = "from EvaJobContentBO bo where bo.itemID='" + itemID + "'";
		return this.getHibernatetemplate().find(hql);
	}

	public EvaJobEstimateBO findJobEstimate(String planID, String itemID)
			throws SysException {
		if (planID != null && !"".equals(planID)) {
			String hsql = "from EvaJobEstimateBO bo where bo.planID='" + planID
					+ "' and bo.itemID='" + itemID + "'";
			List list = this.hibernatetemplate.find(hsql);
			if (list == null || list.size() == 0) {
				return null;
			} else {
				return (EvaJobEstimateBO) list.get(0);
			}
		} else {
			String hsql = "from EvaJobEstimateBO bo where bo.itemID='" + itemID
					+ "'";
			List list = this.hibernatetemplate.find(hsql);
			if (list == null || list.size() == 0) {
				return null;
			} else {
				return (EvaJobEstimateBO) list.get(0);
			}
		}

	}

	public EvaJobEstimateBO findSelfJobEstimate(String planID, String personID)
			throws SysException {
		String hsql = "from EvaJobEstimateBO bo where bo.planID='" + planID
				+ "' and bo.personID ='" + personID + "'";
		List list = this.hibernatetemplate.find(hsql);
		if (list == null || list.size() == 0) {
			return null;
		} else {
			return (EvaJobEstimateBO) list.get(0);
		}
	}

	public List findJobContent(String itemId, String seq) throws SysException {
		String hsql = "from EvaJobContentBO bo where bo.itemID='" + itemId
				+ "' and bo.seq='" + seq + "'";
		return this.hibernatetemplate.find(hsql);
	}

	public List findJobEstimateScore(PageVO pagevo, String planID)
			throws SysException {
		String hsql = "select bo from EvaJobEstimateBO bo where bo.planID='"
				+ planID + "' order by bo.score desc";
		String countsql = "select count(bo) from EvaJobEstimateBO bo where bo.planID='"
				+ planID + "'";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countsql, hsql);
		}else{
			return this.hibernatetemplate.find(hsql);
		}
	}

	public List findResultScore(PageVO pagevo, String planID, String orgId)
			throws SysException {
		OrgBO orgbo = SysCacheTool.findOrgById(orgId);
		String hsql = "select bo from EvaJobEstimateBO bo where bo.planID='"
				+ planID
				+ "' and bo.personID in (select pb.personId from  PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId() + "%')";
		String countsql = "select count(bo) from EvaJobEstimateBO bo where bo.planID='"
				+ planID
				+ "' and bo.personID in (select pb.personId from  PersonBO pb where pb.deptTreeId like '"
				+ orgbo.getTreeId() + "%')";
		hsql+="  order by cast(bo.sumScore as float) desc";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countsql, hsql);
		}else{
			return this.hibernatetemplate.find(hsql);
		}
	}
	
	public List getAllJobEstimateLogBO(String itemID)throws SysException{
		String hsql="select bo from JobEstimateLogBO bo where bo.itemID='"+itemID+"'";
		return this.getHibernatetemplate().find(hsql);
	}
	
}
