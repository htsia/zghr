package com.hr319wg.xys.eva.dao;

import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonScoreBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-13
 * Time: 下午4:15
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiPersonDAO extends BaseDAO{
    public List getXysKpiPersonObjBO(PageVO pageVO,String planId,String orgId)throws SysException{
        String hql="select bo from XysKpiPersonObjBO bo where bo.planId='"+planId+"'";
       String countHql="select count(bo) from XysKpiPersonObjBO bo where bo.planId='"+planId+"'";
       String add="";
       if(orgId!=null&&!orgId.equals("")){
           String treeId= SysCacheTool.findOrgById(orgId).getTreeId();
           add+=" and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '%"+treeId+"%')";
       }
       hql+=add+" order by cast(bo.score as float) desc";
       countHql+=add;
       if(pageVO!=null){
           return this.pageQuery(pageVO,countHql,hql);
       }else{
           return this.hibernatetemplate.find(hql);
       }
    }
    
    public List getXysKpiPersonObjBOByQueryValue(PageVO pageVO,String planId,String where)throws SysException{
    	String hql="select bo from XysKpiPersonObjBO bo where bo.planId='"+planId+"'";
        String countHql="select count(bo) from XysKpiPersonObjBO bo where bo.planId='"+planId+"'";
        if(where!=null&&!where.equals("")){
        	hql+=where;
        	countHql+=where;
        }
        if(pageVO!=null){
            return this.pageQuery(pageVO,countHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }

    public XysKpiPersonObjBO findEqualsXysKpiPersonObjBO(String planId,String personId)throws SysException{
        String hql="select bo from XysKpiPersonObjBO bo where bo.planId='"+planId+"' and bo.personId='"+personId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
            return (XysKpiPersonObjBO)list.get(0);
        }
        return null;
    }

    public List getXysKpiPersonObjBOForSelf(String personId,String where)throws SysException{
    	PersonBO pbo1=SysCacheTool.findPersonById(personId);
    	String in = pbo1.getPostId();
    	
    	PersonBO pbo2=SysCacheTool.findPersonById("@"+personId);
    	if(pbo2 != null){
    		in += ","+pbo2.getPostId();
    	}
    	
    	PersonBO pbo3=SysCacheTool.findPersonById("@@"+personId);
    	if(pbo3 != null){
    		in += ","+pbo3.getPostId();
    	}
    	
        String hql="select bo from XysKpiPersonObjBO bo where " +
                " bo.personId in(select po.personId from " +
        			"PersonBO po where po.postId in(select wo.postId " +
        			"from XysWeightSetBO wo where wo.evaType='1' and wo.evaPostId in ("+in+") and bo.planId=wo.planId))";
        if(where!=null&&!where.equals("")){
             hql+=where;
        }
        return this.hibernatetemplate.find(hql);
    }
    
    public List getSelfXysKpiPersonObjBO(String personId,String where)throws SysException{
        String hql="select bo from XysKpiPersonObjBO bo where bo.personId='"+personId+"'";
        if(where!=null&&!where.equals("")){
            hql+=where;
       }
        return this.hibernatetemplate.find(hql);
    }
    
    public List getAuditXysKpiPersonObjBOByPersonId(String personId)throws SysException{
    	String hql="select bo from XysKpiPersonObjBO bo where bo.gradeStatus='0' and bo.planId " +
    			"in(select vo.planId from XysEvaPlanBO vo where vo.status='"+XysEvaPlanBO.STATUS_ZHIXING+"' and vo.personKpiStatus='1')" +
    			" and bo.objId in(select so.objId from XysKpiPersonSbjBO so where so.personId='"+personId+"' or  so.personId='@"+personId+"'  or so.personId like '%@"+personId+"'  )";
    	return this.hibernatetemplate.find(hql);
    }

     public List getXysKpiPersonSbjBOByObjId(String objId)throws SysException{
        String hql="select bo from XysKpiPersonSbjBO bo where bo.objId='"+objId+"'";
        return this.hibernatetemplate.find(hql);
    }

    public XysKpiPersonSbjBO findEqualsXysKpiPersonSbjBO(String objId,String personId)throws SysException{
        String hql="select bo from XysKpiPersonSbjBO bo where bo.objId='"+objId+"' and ( bo.personId='"+personId+"' or  bo.personId='@"+personId+"' or  bo.personId like '%@"+personId+"')";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
             return (XysKpiPersonSbjBO)list.get(0);
        }
        return null;
    }


    public List  getXysKpiPersonScoreBOBySbjId(String sbjId)throws SysException{
        String hql="select bo from XysKpiPersonScoreBO bo where bo.sbjId='"+sbjId+"'";
        return this.hibernatetemplate.find(hql);
    }
    
    public XysKpiPersonScoreBO findEqualsXysKpiPersonScoreBO(String sbjId,String key)throws SysException{
    	String hql="select bo from XysKpiPersonScoreBO bo where bo.sbjId='"+sbjId+"' and bo.objKeyId='"+key+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (XysKpiPersonScoreBO)list.get(0);
    	}
    	return null;
    }
    
    public List getXysKpiPersonSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException{
    	String hql="select bo from XysKpiPersonSbjBO bo where bo.gradeItem='"+gradeItem+"' and bo.sbjId!='"+sbjId+"'" +
    			" and bo.personId='"+personId+"' and bo.objId in(select vo.objId from XysKpiDeptObjBO vo where vo.planId='"+planId+"')";
    	return this.hibernatetemplate.find(hql);
    }
    
    public String beginGradeByPlanId(final String planId)throws SysException{
    	String returnValue=(String)this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_begin_person_kpi(?,?)}"); 
				cs.setString(1,planId);
				cs.registerOutParameter(2, Types.VARCHAR);
				cs.executeUpdate();
				return cs.getString(2);
			}
    		
    	});
    	return returnValue;
    }
    
    public List getXysKpiPersonObjVO(PageVO pagevo,String planId,String orgId)throws SysException{
    	String hql="select vo from XysKpiPersonObjVO vo where vo.planId='"+planId+"'";
    	String countHql="select count(vo) from XysKpiPersonObjVO vo where vo.planId='"+planId+"'";
    	if(orgId!=null&&!orgId.equals("")){
    		String treeId=SysCacheTool.findOrgById(orgId).getTreeId();
    		hql+=" and vo.deptTreeId like '"+treeId+"%'";
    		countHql+=" and vo.deptTreeId like '"+treeId+"%'";
    	}
    	if(pagevo!=null){
    		return this.pageQuery(pagevo, countHql, hql);
    	}else{
    		return this.hibernatetemplate.find(hql);
    	}
    }
    
    public List getXysKpiPersonObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
    	String hql="select bo from XysKpiPersonObjVO bo where bo.planId='"+planId+"'";
    	String countHql="select count(bo) from XysKpiPersonObjVO bo where bo.planId='"+planId+"'";
    	if(where!=null&&!where.equals("")){
        	hql+=where;
        	countHql+=where;
        }
        if(pagevo!=null){
            return this.pageQuery(pagevo,countHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }
    
    
    /**
     * 校验客体合法性
     * @param objId 客体标识
     * @param postId 客体岗位
     * @param level 级别
     * @return
     * @throws SysException
     */
    public List checkSbjGradeData(String objId,String level)throws SysException{
    	String hql="select bo from XysKpiPersonSbjBO bo where bo.objId='"+objId+"'" +
    			"  and bo.evaType='"+level+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
    /**
     * 个人kpi分数计算
     * @param planId
     * @throws SysException
     */
    public void caclPersonKpiByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_cacl_person_kpi(?)}"); 
				cs.setString(1,planId);
				cs.executeUpdate();
				return null;
			}
    		
    	});
    }
   
    /**
     * 个人kpi导出
     * @param planId
     * @throws SysException
     */
    public void exportPersonKpiByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_export_person_kpi(?)}"); 
				cs.setString(1,planId);
				cs.executeUpdate();
				return null;
			}
    		
    	});
    }
    
    /**
     * 加载考核岗位
     */
    public void loadPersonKpiObjByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
    		public Object doInHibernate(Session session)
			throws HibernateException, SQLException {
			CallableStatement cs = session.connection().prepareCall ("{call proc_eva_load_person_kpi_obj(?)}"); 
			cs.setString(1,planId);
			cs.executeUpdate();
			return null;
    		}
    	});
    }
}
