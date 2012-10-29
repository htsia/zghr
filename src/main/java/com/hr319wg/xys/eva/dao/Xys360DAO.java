package com.hr319wg.xys.eva.dao;

import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Hashtable;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360SbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;

public class Xys360DAO extends BaseDAO {
	/**
	 * 返回考核客体
	 * 
	 * @param pagevo
	 * @param planId
	 *            计划标识
	 * @param orgId
	 *            机构标识
	 * @return
	 * @throws SysException
	 */
	public List getXys360ObjBOByPlanId(PageVO pagevo, String planId,
			String orgId) throws SysException {
		String hql = "select bo from Xys360ObjBO bo where bo.planId='" + planId
				+ "'";
		String countHql = "select count(bo) from Xys360ObjBO bo where bo.planId='"
				+ planId + "'";
		String add = "";
		if (orgId != null && !orgId.equals("")) {
			String treeId = SysCacheTool.findOrgById(orgId).getTreeId();
			add = " and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '%"
					+ treeId + "%')";
		}
		hql += add+" order by cast(bo.score as float) desc";;
		countHql += add;
		if (pagevo != null) {
			return this.pageQuery(pagevo, countHql, hql);
		} else {
			return this.hibernatetemplate.find(hql);
		}
	}
	
	public List getXys360ObjBOByQueryValue(PageVO pagevo, String planId,String queryValue)throws SysException{
		String hql = "select bo from Xys360ObjBO bo where bo.planId='" + planId
				+ "'";
		String countHql = "select count(bo) from Xys360ObjBO bo where bo.planId='"
				+ planId + "'";
		if(queryValue!=null&&!queryValue.equals("")){
			hql+=queryValue;
			countHql+=queryValue;
		}
		if (pagevo != null) {
			return this.pageQuery(pagevo, countHql, hql);
		} else {
			return this.hibernatetemplate.find(hql);
		}
	}

	/**
	 * 返回指定考核客体
	 * 
	 * @param planId
	 *            计划标识
	 * @param personId
	 *            人员标识
	 * @return
	 * @throws SysException
	 */
	public Xys360ObjBO findEqualsXys360ObjBO(String planId, String personId)
			throws SysException {
		String hql = "select bo from Xys360ObjBO bo where bo.planId='" + planId
				+ "' and bo.personId='" + personId + "'";
		List list = this.hibernatetemplate.find(hql);
		if (list != null && list.size() > 0) {
			return (Xys360ObjBO) list.get(0);
		}
		return null;
	}

	/**
	 * 返回客体考核指标
	 * 
	 * @param objId
	 *            客体标识
	 * @return
	 * @throws SysException
	 */
	public List getXys360ObjKeyBOByObjId(String objId) throws SysException {
		String hql = "select bo from Xys360ObjKeyBO bo where bo.objId='"
				+ objId + "'";
		return this.hibernatetemplate.find(hql);
	}

	/**
	 * 返回考核主体
	 * 
	 * @param objId
	 *            客体标识
	 * @return
	 * @throws SysException
	 */
	public List getXys360SbjBOByObjId(String objId) throws SysException {
		String hql = "select bo from Xys360SbjBO bo where bo.objId='" + objId
				+ "'";
		return this.hibernatetemplate.find(hql);
	}

	/**
	 * 返回指定的主体
	 * 
	 * @param objId
	 *            客体标识
	 * @param personId
	 *            人员标识
	 * @return
	 * @throws SysException
	 */
	public Xys360SbjBO findEqualsXys360SbjBO(String objId, String personId)throws SysException {
		String hql = "select bo from Xys360SbjBO bo where bo.objId='" + objId
				+ "' and bo.personId='" + personId + "'";
		List list = this.hibernatetemplate.find(hql);
		if (list != null && list.size() > 0) {
			return (Xys360SbjBO) list.get(0);
		}
		return null;
	}

	/**
	 * 返回主体的分数表
	 * 
	 * @param SbjId
	 *            主体标识
	 * @return
	 * @throws SysException
	 */
	public List getXys360ObjScoreBOBySbjId(String sbjId) throws SysException {
		String hql = "select bo from Xys360ObjScoreBO bo where bo.sbjId='"
				+ sbjId + "'";
		return this.hibernatetemplate.find(hql);
	}

	/**
	 * 返回指定的分数
	 * 
	 * @param sbjId
	 *            客体标识
	 * @param keyId
	 *            指标标识
	 * @return
	 * @throws SysException
	 */
	public Xys360ObjScoreBO findEqualsXys360ObjScoreBO(String sbjId,
			String keyId) throws SysException {
		String hql = "select bo from Xys360ObjScoreBO bo where bo.sbjId='"
				+ sbjId + "' and bo.keyId='" + keyId + "'";
		List list = this.hibernatetemplate.find(hql);
		if (list != null && list.size() > 0) {
			return (Xys360ObjScoreBO) list.get(0);
		}
		return null;
	}
	/**
	 * 返回要打分的客体
	 * @param personId 打分人员标识
	 * @param deptId 部门标识
	 * @param showSelf 查找本部门
	 * @return
	 * @throws SysException
	 */
	public List getAuditXys360ObjBOByPersonId(String personId)throws SysException {
		String hql = "select bo from Xys360ObjBO bo where bo.gradeStatus='0' and bo.planId "
				+ "in(select vo.planId from XysEvaPlanBO vo where vo.status='"
				+ XysEvaPlanBO.STATUS_ZHIXING
				+ "' and vo.person360Status='1')"
				+ " and bo.objId in(select so.objId from Xys360SbjBO so where so.personId='"
				+ personId + "')";
		return this.hibernatetemplate.find(hql);
	}
	
	public List getAuditXys360ObjBOByPersonId(String personId,String planId,String deptId,boolean showSelf)throws SysException {
		String hql = "select bo from Xys360ObjBO bo where bo.gradeStatus='0' and bo.planId='"+planId+"' "
				+ " and bo.objId in(select so.objId from Xys360SbjBO so where so.personId='"
				+ personId + "')";
		if(deptId!=null&&!deptId.equals("")){
			if(showSelf){
				hql+=" and bo.personId in(select po.personId from PersonBO po where po.deptTreeId like '"+deptId+"%')";
			}else{
				hql+=" and bo.personId not in(select po.personId from PersonBO po where po.deptTreeId like '"+deptId+"%')";
			}
		}
		return this.hibernatetemplate.find(hql);
	}
	
	public List getXys360SbjBOForGrade(String planId,String personId,String gradeItem,
			String sbjId,String deptId,boolean showSelf )throws SysException{
	    String hql="select bo from Xys360SbjBO bo where bo.gradeItem='"+gradeItem+"' and bo.sbjId!='"+sbjId+"'" +
	    			" and bo.personId='"+personId+"' and bo.objId in(select vo.objId from Xys360ObjBO vo where vo.planId='"+planId+"'";
	    if(showSelf){
			hql+=" and vo.personId in(select po.personId from PersonBO po where po.deptTreeId like '"+deptId+"%'))";
		}else{
			hql+=" and vo.personId not in(select po.personId from PersonBO po where po.deptTreeId like '"+deptId+"%'))";
		}
	    return this.hibernatetemplate.find(hql);
	}
	
	public Hashtable getXys360SbjBOByPersonId(String personId)throws SysException{
		Hashtable map=new Hashtable();
		String hql="select bo from Xys360SbjBO bo where bo.personId='"+personId+"'" +
				" and bo.objId in(select obj.objId from Xys360ObjBO obj where" +
				" obj.planId in(select po.planId from XysEvaPlanBO po where po.status='"+XysEvaPlanBO.STATUS_ZHIXING+"'))";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Xys360SbjBO sbj=(Xys360SbjBO)list.get(i);
				map.put(sbj.getObjId(),sbj);
			}
		}
		return map;
	}

	public String beginGradeByPlanId(final String planId)throws SysException{
    	String returnValue=(String)this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_begin_person_360(?,?)}"); 
				cs.setString(1,planId);
				cs.registerOutParameter(2, Types.VARCHAR);
				cs.executeUpdate();
				return cs.getString(2);
			}
    		
    	});
    	return returnValue;
    }
	
	public List getXys360ObjVO(PageVO pagevo,String planId,String orgId)throws SysException{
    	String hql="select vo from Xys360ObjVO vo where vo.planId='"+planId+"'";
    	String countHql="select count(vo) from Xys360ObjVO vo where vo.planId='"+planId+"'";
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
	
	public List getXys360ObjVOByQueryValue(PageVO pagevo,String planId,String where)throws SysException{
    	String hql="select bo from Xys360ObjVO bo where bo.planId='"+planId+"'";
    	String countHql="select count(bo) from Xys360ObjVO bo where bo.planId='"+planId+"'";
    	if(where!=null&&!where.equals("")){
			hql+=where;
			countHql+=where;
		}
		if (pagevo != null) {
			return this.pageQuery(pagevo, countHql, hql);
		} else {
			return this.hibernatetemplate.find(hql);
		}
    }
    
	 /**
     * 校验客体合法性
     * @param objId 客体标识
     * @param level 级别
     * @return
     * @throws SysException
     */
    public List checkSbjGradeData(String objId,String level)throws SysException{
    	String hql="select bo from Xys360SbjBO bo where bo.objId='"+objId+"'" +
    			" and bo.evaType='"+level+"'";
    	return this.hibernatetemplate.find(hql);
    }
    
    /**
     * 个人360分数计算
     * @param planId
     * @throws SysException
     */
    public void caclPerson360ByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_cacl_person_360(?)}"); 
				cs.setString(1,planId);
				cs.executeUpdate();
				return null;
			}
    		
    	});
    }
    
    /**
     * 个人360导出
     * @param planId
     * @throws SysException
     */
    public void exportPerson360ByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_export_person_360(?)}"); 
				cs.setString(1,planId);
				cs.executeUpdate();
				return null;
			}
    		
    	});
    }
    
    //加载考核客体
    public void load360OjbByPlanId(final String planId)throws SysException{
    	this.hibernatetemplate.execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				CallableStatement cs = session.connection().prepareCall ("{call proc_eva_load_person_360_obj(?)}"); 
				cs.setString(1,planId);
				cs.executeUpdate();
				return null;
			}
    		
    	});
    }
}
