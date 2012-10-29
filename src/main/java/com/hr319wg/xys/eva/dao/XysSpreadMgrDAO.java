package com.hr319wg.xys.eva.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadDeptSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetBO;

public class XysSpreadMgrDAO extends BaseDAO {
	public List getXysSpreadSetBOByPlanId(String planId)throws SysException{
		String  hql="select bo from XysSpreadSetBO bo where bo.planId='"+planId+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	public XysSpreadSetBO findEqualsXysSpreadSetBO(String planId,String gradeItem)throws SysException{
		String hql="select bo from XysSpreadSetBO bo where bo.planId='"+planId+"' and bo.gradeItem='"+gradeItem+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (XysSpreadSetBO)list.get(0);
		}
		return null;
	}
	
	public List getXysSpreadSetItemBOBySetId(String setId)throws SysException{
		String hql="select bo from XysSpreadSetItemBO bo where bo.setId='"+setId+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	
	public List getXysSpreadDeptSetBO(String planId,String deptId)throws SysException{
		String hql="select bo from XysSpreadDeptSetBO bo where bo.planId='"+planId+"' and bo.deptId='"+deptId+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	public XysSpreadDeptSetBO findEquealsXysSpreadDeptSetBO(String planId,String deptId,String gradeItem)throws SysException{
		String hql="select bo from XysSpreadDeptSetBO bo where bo.planId='"+planId+"' and bo.deptId='"+deptId+"' and bo.gradeItem='"+gradeItem+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (XysSpreadDeptSetBO)list.get(0);
		}
		return null;
	}
}
