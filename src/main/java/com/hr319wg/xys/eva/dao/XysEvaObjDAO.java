package com.hr319wg.xys.eva.dao;

import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.XysEvaObjBO;

public class XysEvaObjDAO extends BaseDAO {
	public List getXysEvaObjBOByPlanId(PageVO pagevo,String planId,String orgId,String showMode)throws SysException{
		String hql="select bo from XysEvaObjBO bo where bo.planId='"+planId+"'";
		String countHql="select count(bo) from XysEvaObjBO bo where bo.planId='"+planId+"'";
		if(orgId!=null&&!orgId.equals("")){
			String treeId=SysCacheTool.findOrgById(orgId).getTreeId();
			hql+=" and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '"+treeId+"%')";
			countHql+=" and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '"+treeId+"%')";
		}
		if(showMode!=null&&showMode.equals("2")){
			hql+=" order by cast(bo.forceSort as float),cast(bo.adjustTotalScore as float) desc";
		}else{
			hql+=" order by cast(bo.natureSort as float),cast(bo.adjustTotalScore as float) desc";
		}
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	public List getXysEvaObjBOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
		String hql="select bo from XysEvaObjBO bo where bo.planId='"+planId+"'";
		String countHql="select count(bo) from XysEvaObjBO bo where bo.planId='"+planId+"'";
		if(where!=null&&!where.equals("")){
			hql+=where;
			countHql+=where;
		}
		if(pagevo!=null){
			return this.pageQuery(pagevo, countHql, hql);
		}else{
			return this.hibernatetemplate.find(hql);
		}
	}
	
	public XysEvaObjBO findEqualsXysEvaObjBO(String planId,String personId)throws SysException{
		String hql="select bo from XysEvaObjBO bo where bo.planId='"+planId+"' and bo.personId='"+personId+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (XysEvaObjBO)list.get(0);
		}
		return null;
	}
	
	public List getXysEvaObjBOForSort(String planId,String orgId)throws SysException{
		String hql="select bo from XysEvaObjBO bo where bo.planId='"+planId+"'";
		if(orgId!=null&&!orgId.equals("")){
			String treeId=SysCacheTool.findOrgById(orgId).getTreeId();
			hql +=" and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '"+treeId+"%')";
		}
		hql+=" order by cast(bo.adjustTotalScore as float) desc";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getXysEvaObjBOForGrade(String planId,String orgId,String gradeItem)throws SysException{
		String hql="select bo from XysEvaObjBO bo where bo.planId='"+planId+"' and bo.natureGrade='"+gradeItem+"'";
		if(orgId!=null&&!orgId.equals("")){
			String treeId=SysCacheTool.findOrgById(orgId).getTreeId();
			hql +=" and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '"+treeId+"%')";
		}
		hql+=" order by cast(bo.adjustTotalScore as float) desc,cast(bo.natureSort as float)";
		return this.hibernatetemplate.find(hql);
	}
	
	/**
     * ×ÛºÏ¼ÆËã
     * @param planId
     * @throws SysException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public void caclEvaObjBOByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_cacl_total(?)}"); 
				cs.setString(1,planId);
				cs.executeUpdate();
				return null;
			}
    		
    	});
    }
}
