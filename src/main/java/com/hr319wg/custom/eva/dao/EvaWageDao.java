package com.hr319wg.custom.eva.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.eva.pojo.bo.EvaWageBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class EvaWageDao extends BaseDAO{

	public List getAllEvaWageBO() throws SysException{
		String hql = " from EvaWageBO bo,UserBO u where bo.userID=u.userID and bo.status='00901' and bo.evaRealWage is not null and bo.evaRealWage <> '0' ";
		String boHql = "select bo,u.secDeptID,u.bankNO,u.cardNO "+hql +" order by u.secDeptID,u.deptId";
		return this.hibernatetemplate.find(boHql);
	}
	public List getAllEvaWageBO(PageVO pageVo, String orgID, String personType, String nameStr) throws SysException{
		String hql = " from EvaWageBO bo,UserBO u where bo.userID=u.userID and bo.status='00901' ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '"+nameStr+"')";
		}
		
		String boHql = "select bo,u.secDeptID "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(bo) "+hql;
		
		return this.pageQuery(pageVo, countHql, boHql);
	}
	
	public List getAllNotinEvaUserBO(PageVO pageVo, String orgID, String personType, String nameStr) throws SysException{
		String hql = " from UserBO u where u.userID not in (select bo.userID from EvaWageBO bo where bo.status='00901') ";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			hql+=" and (u.deptSort like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){
			hql += " and "+CommonFuns.splitInSql(personType.split(","), "u.personType");
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '"+nameStr+"')";
		}
		
		String boHql = "select u "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(u) "+hql;
		
		return this.pageQuery(pageVo, countHql, boHql);
	}
}
