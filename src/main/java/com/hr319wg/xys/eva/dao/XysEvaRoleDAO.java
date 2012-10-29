package com.hr319wg.xys.eva.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;


public class XysEvaRoleDAO extends BaseDAO {
	public List getXysEvaRoleBOByOrgId(PageVO pagevo,String orgId)throws SysException{
		String hql="select bo from XysEvaRoleBO bo where 1=1";
		String countHql="select count(bo) from XysEvaRoleBO bo where 1=1";
		if(orgId!=null&&!orgId.equals("")){
			hql+=" and bo.createOrg='"+orgId+"'";
			countHql+=" and bo.createOrg='"+orgId+"'";
		}
		if(pagevo!=null){
			return this.pageQuery(pagevo,countHql,hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
}
