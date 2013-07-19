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
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.XysDeptKpiDivBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: 下午1:23
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiDeptDAO extends BaseDAO{
    public List getXysKpiDeptObjBO(PageVO pageVO,String planId,String orgId)throws SysException{
       String hql="select bo from XysKpiDeptObjBO bo where bo.planId='"+planId+"'";
       String countHql="select count(bo) from XysKpiDeptObjBO bo where bo.planId='"+planId+"'";
       String add="";
       if(orgId!=null&&!orgId.equals("")){
           String treeId= SysCacheTool.findOrgById(orgId).getTreeId();
           add+=" and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '%"+treeId+"%')";
       }
       hql+=add+" order by cast(bo.score as float) desc,cast(bo.scoreSort as float)";
       countHql+=add;
       if(pageVO!=null){
           return this.pageQuery(pageVO,countHql,hql);
       }else{
           return this.hibernatetemplate.find(hql);
       }
    }

    public List getXysKpiDeptObjBO(String planId,String gradeItem)throws SysException{
    	String hql="select bo from XysKpiDeptObjBO bo where bo.planId='"+planId+"' and bo.gradeItem='"+gradeItem+"'  order by cast(bo.score as float) desc,cast(bo.scoreSort as float)";
    	return this.hibernatetemplate.find(hql);
    }
    public XysKpiDeptObjBO findEqualsXysKpiDeptObjBO(String planId,String personId)throws SysException{
        String hql="select bo from XysKpiDeptObjBO bo where bo.planId='"+planId+"' and bo.personId='"+personId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
            return (XysKpiDeptObjBO)list.get(0);
        }
        return null;
    }

    public List getXysKpiDeptObjBOInSelf(String personId,String where)throws SysException{
        String hql="select bo from XysKpiDeptObjBO bo where 1=1";
        if(personId!=null&&!personId.equals("")){
             hql+=" and (bo.personId = '"+personId+"' or bo.personId = '@"+personId+"' or bo.personId like '%@"+personId+"')";
             
        }
        if(where!=null&&!where.equals("")){
             hql+=where;
        }
        return this.hibernatetemplate.find(hql);
    }


    public List getXysKpiObjLibBOByObjId(String objId)throws SysException{
        String hql="select bo from XysKpiObjLibBO bo where bo.objId='"+objId+"' order by orderby";
        return this.hibernatetemplate.find(hql);
    }


    public List getXysKpiObjKeyBOByLibId(String libId)throws SysException{
        String hql="select bo from XysKpiObjKeyBO bo where bo.objLibId='"+libId+"' order by bo.orderby";
        return this.hibernatetemplate.find(hql);
    }
    public List getXysKpiObjKeyBOByObjId(String objId)throws SysException{
        String hql="select bo from XysKpiObjKeyBO bo where bo.objId='"+objId+"'";
        return this.hibernatetemplate.find(hql);
    }



    public List getXysKpiDeptSbjBOByObjId(String objId)throws SysException{
        String hql="select bo from XysKpiDeptSbjBO bo where bo.objId='"+objId+"'";
        return this.hibernatetemplate.find(hql);
    }

    public XysKpiDeptSbjBO findEqualsXysKpiDeptSbjBO(String objId,String personId)throws SysException{
        String hql="select bo from XysKpiDeptSbjBO bo where bo.objId='"+objId+"' and bo.personId='"+personId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
             return (XysKpiDeptSbjBO)list.get(0);
        }
        return null;
    }


    public List  getXysKpiDeptObjScoreBOBySbjId(String sbjId)throws SysException{
        String hql="select bo from XysKpiDeptObjScoreBO bo where bo.sbjId='"+sbjId+"'";
        return this.hibernatetemplate.find(hql);
    }
    
    public XysKpiDeptObjScoreBO findEqualsXysKpiDeptObjScoreBO(String sbjId,String key)throws SysException{
    	String hql="select bo from XysKpiDeptObjScoreBO bo where bo.sbjId='"+sbjId+"' and bo.objKeyId='"+key+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (XysKpiDeptObjScoreBO)list.get(0);
    	}
    	return null;
    }
    
    public List getAuditXysKpiDeptObjBOByPersonId(String personId)throws SysException{
    	String hql="select bo from XysKpiDeptObjBO bo where bo.gradeStatus='0' and bo.planId " +
    			"in(select vo.planId from XysEvaPlanBO vo where vo.status='"+XysEvaPlanBO.STATUS_ZHIXING+"' and vo.deptKpiStatus='1')" +
    			" and bo.objId in(select so.objId from XysKpiDeptSbjBO so where so.personId='"+personId+"')";
    	return this.hibernatetemplate.find(hql);
    }
    
    public List getXysKpiDeptSbjBOForGrade(String planId,String personId,String gradeItem,String sbjId)throws SysException{
    	String hql="select bo from XysKpiDeptSbjBO bo where bo.gradeItem='"+gradeItem+"' and bo.sbjId!='"+sbjId+"'" +
    			" and bo.personId='"+personId+"' and bo.objId in(select vo.objId from XysKpiDeptObjBO vo where vo.planId='"+planId+"')";
    	return this.hibernatetemplate.find(hql);
    }
    
    public String beginGradeByPlanId(final String planId)throws SysException{
    	String returnValue=(String)this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_begin_dept_kpi(?,?)}"); 
				cs.setString(1,planId);
				cs.registerOutParameter(2, Types.VARCHAR);
				cs.executeUpdate();
				return cs.getString(2);
			}
    		
    	});
    	return returnValue;
    }
    
    public List getXysKpiDeptObjVO(PageVO pageVO,String planId)throws SysException{
        String hql="select bo from XysKpiDeptObjVO bo where bo.planId='"+planId+"'";
        String countHql="select count(bo) from XysKpiDeptObjVO bo where bo.planId='"+planId+"'";
        if(pageVO!=null){
            return this.pageQuery(pageVO,countHql,hql);
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
    	String hql="select bo from XysKpiDeptSbjBO bo where bo.objId='"+objId+"'" +
    			" and bo.evaType='"+level+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
    
    /**
     * 部门kpi分数计算
     * @param planId
     * @throws SysException
     */
    public void caclDeptKpiByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_cacl_dept_kpi(?)}"); 
				cs.setString(1,planId);
				cs.executeUpdate();
				return null;
			}
    		
    	});
    }
    
    /**
     * 返回部门考核分数分解配置
     * @param objId
     * @return
     * @throws SysException
     */
    public List getXysDeptKpiDivBOByObjId(String objId)throws SysException{
    	String hql="select bo from XysDeptKpiDivBO bo where bo.objId='"+objId+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
    public XysDeptKpiDivBO findEqualsXysDeptKpiDivBO(String planId,String personId)throws SysException{
    	String hql="select bo from XysDeptKpiDivBO bo where bo.planId='"+planId+"' and bo.personId='"+personId+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (XysDeptKpiDivBO)list.get(0);
    	}
    	return null;
    }
}
