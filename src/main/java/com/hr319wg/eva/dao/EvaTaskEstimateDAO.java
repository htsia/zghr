package com.hr319wg.eva.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class EvaTaskEstimateDAO extends BaseDAO {
	public List getAllEvaTaskMasterBO(String planId)throws SysException{
		String hql="select bo from EvaTaskMasterBO bo where bo.planId='"+planId+"' order by bo.score desc";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllEvaTaskMasterBOForSumSort(String planId)throws SysException{
		String hql="select bo from EvaTaskMasterBO bo where bo.planId='"+planId+"' order by bo.sumScore desc";
		return this.hibernatetemplate.find(hql);
	}
	public List getAllEvaTaskMasterBOforPage(PageVO pagevo,String planId)throws SysException{
		String hql="select bo from EvaTaskMasterBO bo where bo.planId='"+planId+"'";
		String chql="select count(bo) from EvaTaskMasterBO bo where bo.planId='"+planId+"'";
		return this.pageQuery(pagevo, chql, hql);
	}
	public List getEvaTaskMasterBOByOrgId(PageVO pagevo, String planID, String orgId)throws SysException{
		OrgBO orgbo = SysCacheTool.findOrgById(orgId);
		String hql = "select pb from PersonBO pb where pb.deptTreeId like '"
			+ orgbo.getTreeId()
			+ "%' and pb.personId in(select bo.personId from EvaTaskMasterBO bo where bo.planId='"
			+ planID + "')";
		String countsql = "select count(pb) from PersonBO pb where pb.deptTreeId like '"
			+ orgbo.getTreeId()
			+ "%' and pb.personId in(select bo.personId from EvaTaskMasterBO bo where bo.planId='"
			+ planID + "')";
		return this.pageQuery(pagevo, countsql, hql);
	}
	public List getNotEvaTaskMasterBOPeson(PageVO pagevo, String planID, String orgId)throws SysException{
		OrgBO orgbo = SysCacheTool.findOrgById(orgId);
		String hql = "select pb from PersonBO pb where pb.deptTreeId like '"
			+ orgbo.getTreeId()
			+ "%' and pb.personId not in(select bo.personId from EvaTaskMasterBO bo where bo.planId='"
			+ planID + "')";
		String countsql = "select count(pb) from PersonBO pb where pb.deptTreeId like '"
			+ orgbo.getTreeId()
			+ "%' and pb.personId not in(select bo.personId from EvaTaskMasterBO bo where bo.planId='"
			+ planID + "')";
		return this.pageQuery(pagevo, countsql, hql);
	}
	public EvaTaskMasterBO findEvaTaskMasterBOByPid(String planId,String personId)throws SysException{
		String hql="select bo from EvaTaskMasterBO bo where bo.planId='"+planId+"' and bo.personId='"+personId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (EvaTaskMasterBO)list.get(0);
		}else{
			return null;
		}
	}
	public List findEvaTaskEstimateBOByMasterId(String masterId)throws SysException{
		String hql="select bo from EvaTaskEstimateBO bo where bo.masterId='"+masterId+"'";
		return this.getHibernatetemplate().find(hql);
	}
	public List findTaskResultScore( String planID, String orgId)throws SysException{
		OrgBO orgbo = SysCacheTool.findOrgById(orgId);
		String hsql = "select bo from EvaTaskMasterBO bo where bo.planId='"
			+ planID
			+ "' and bo.personId in (select pb.personId from  PersonBO pb where pb.deptTreeId like '"
			+ orgbo.getTreeId() + "%')";
		return this.hibernatetemplate.find(hsql);
	}
	public List getTaskResultScore(PageVO pagevo,String planID, String orgId)throws SysException{
		OrgBO orgbo = SysCacheTool.findOrgById(orgId);
		String hsql = "select bo from EvaTaskMasterBO bo where bo.planId='"
			+ planID
			+ "' and bo.personId in (select pb.personId from  PersonBO pb where pb.deptTreeId like '%"
			+ orgbo.getTreeId() + "%')";
		String counthql="select count(bo) from EvaTaskMasterBO bo where bo.planId='"
			+ planID
			+ "' and bo.personId in (select pb.personId from  PersonBO pb where pb.deptTreeId like '%"
			+ orgbo.getTreeId() + "%')";
		hsql+="  order by cast(bo.sumScore as float) desc";
		if(pagevo!=null){
			return this.pageQuery(pagevo, counthql, hsql);
		}else{
			return this.hibernatetemplate.find(hsql);
		}
	}
	public List getAllLogByMasterId(String masterId)throws SysException{
		String hql="select bo from EvaTaskEstimateLogBO bo where bo.masterId='"+masterId+"'";
		return this.getHibernatetemplate().find(hql);
	}
	public List getAllProcessByItemId(String itemId)throws SysException{
		String hql="select bo from EvaTaskProcessBO bo where bo.itemId='"+itemId+"' order by bo.reportDate desc";
		return this.hibernatetemplate.find(hql);
	}
}
