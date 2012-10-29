package com.hr319wg.xys.eva.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.XysXspjScoreBO;

public class StudentGradeDAO extends BaseDAO {
	public List getXysXspjScoreBO(PageVO pagevo,String planId,String queryValue)throws SysException{
		String hql="select bo from XysXspjScoreBO bo where bo.planId='"+planId+"'";
		String countHql="select count(bo) from XysXspjScoreBO bo where bo.planId='"+planId+"'";
		if(queryValue!=null&&!queryValue.equals("")){
			hql+=queryValue;
			countHql+=queryValue;
		}
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
    }
	
	public XysXspjScoreBO findEqualsXysXspjScoreBO(String planId,String personId)throws SysException{
		String hql="select bo from XysXspjScoreBO bo where bo.planId='"+planId+"' and bo.personId='"+personId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (XysXspjScoreBO)list.get(0);
		}
		return null;
	}
}
