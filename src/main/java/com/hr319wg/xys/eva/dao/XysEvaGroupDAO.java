package com.hr319wg.xys.eva.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupPostBO;

public class XysEvaGroupDAO extends BaseDAO {
	public List getEvaGroupBO(PageVO pagevo,String orgId)throws SysException{
		String hql="select bo from EvaGroupBO bo where bo.createOrg='"+orgId+"'";
		String countHql="select count(bo) from EvaGroupBO bo where bo.createOrg='"+orgId+"'";
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql,hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	public List getEvaGroupPostBO(PageVO pagevo,String groupId)throws SysException{
		String hql="select bo from EvaGroupPostBO bo where bo.groupId='"+groupId+"'";
		String countHql="select count(bo) from EvaGroupPostBO bo where bo.groupId='"+groupId+"'";
		if(pagevo!=null){
			return this.pageQuery(pagevo,countHql, hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	public EvaGroupPostBO findEqualsEvaGroupPostBO(String groupId,String postId)throws SysException{
		String hql="select bo from EvaGroupPostBO bo where bo.groupId='"+groupId+"' and bo.postId='"+postId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (EvaGroupPostBO)list.get(0);
		}
		return null;
	}
}
