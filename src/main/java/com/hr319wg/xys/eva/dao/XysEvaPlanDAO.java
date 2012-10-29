package com.hr319wg.xys.eva.dao;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.EvaExcPostBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaModeSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysLevelWeightSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysScoreCtrBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightExcPersBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-26
 * Time: ����11:18
 * To change this template use File | Settings | File Templates.
 */
public class XysEvaPlanDAO extends BaseDAO {
    /**
     * �������мƻ�����ȵ�������
     */
    public List getXysEvaPlanBO(PageVO pagevo,String createOrg,String[] status) throws SysException {
        String hql = "select bo from XysEvaPlanBO bo";
        String countHql = "select count(bo) from XysEvaPlanBO bo";
        String where=" where 1=1";
        if(status!=null&&status.length>0){
             where+=" and "+ CommonFuns.splitInSql(status,"bo.status");
        }
        where+=" and bo.createOrg='"+createOrg+"'";
        hql+=where;
        countHql+=where;
        hql += " order by bo.year desc";
        if (pagevo != null) {
            return this.pageQuery(pagevo, countHql, hql);
        } else {
            return this.hibernatetemplate.find(hql);
        }
    }
    
    public List getAllXysEvaPlanBO()throws SysException{
    	return this.hibernatetemplate.find("from XysEvaPlanBO");
    }

    /**
     * ���ر��β��루�ų������˵ĸ�λ
     * @param pagevo
     * @param orgId  ����ID
     * @param planId �ƻ�ID ������ֵ
     * @param showMode  1���뿼��2�ų�
     * @return
     */
    public List getEvaPostBOByPlanId(PageVO pagevo,String orgId,String planId,String showMode)throws SysException{
        String hql="select bo from PostBO bo where 1=1";
        String cuntHql="select count(bo) from PostBO bo where 1=1";
        String addWhere="";
        if(orgId!=null&&!orgId.equals("")){
            String treeId= SysCacheTool.findOrgById(orgId).getTreeId();
            addWhere+=" and bo.orgTreeId like '%"+treeId+"%'";
        }
        if(planId!=null&&!planId.equals("")){
            if(showMode!=null&&showMode.equals("2")){
                addWhere+=" and bo.postId in(select vo.postId from EvaExcPostBO vo where vo.planId='"+planId+"' )";
            }else{
                addWhere+=" and bo.postId not in(select vo.postId from EvaExcPostBO vo where vo.planId='"+planId+"' )";
            }
        }else{
            addWhere+=" and 1=2";
        }
        hql+=addWhere;
        cuntHql+=addWhere;
        if(pagevo!=null){
            return this.pageQuery(pagevo,cuntHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }
    
    public List getEqualsPostBOByPlanId(String planId)throws SysException{
    	String hql="select bo from PostBO bo where bo.postId in(select vo.postId from XysPostRoleRelBO vo) " +
    			"and bo.postId not in(select po.postId from EvaExcPostBO po where po.planId='"+planId+"')";
    	return this.hibernatetemplate.find(hql);
    }

    /**
     * �����ض����ų���λ
     * @param planId
     * @param postId
     * @return
     * @throws SysException
     */
    public EvaExcPostBO findEqualsEvaExcPostBO(String planId,String postId)throws SysException{
        String hql="select bo from EvaExcPostBO bo where bo.planId='"+planId+"' and bo.postId='"+postId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
            return (EvaExcPostBO)list.get(0);
        }
        return null;
    }

    /**
     *ȡ�ø�λ����Ŀ���ģ��
     * @param planId �ƻ���ʾ
     * @param postId ��λ��ʶ
     * @return
     * @throws SysException
     */
    public XysEvaModeSetBO getXysEvaModeSetBO(String planId,String postId)throws SysException{
        String hql="select bo from XysEvaModeSetBO bo where bo.planId='"+planId+"' and bo.postId='"+postId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
            return (XysEvaModeSetBO)list.get(0);
        }
        return null;
    }
    
    public Hashtable getXysEvaModeSetBOByPlanForMap(String planId)throws SysException{
    	Hashtable map=new Hashtable();
    	String hql="select bo from XysEvaModeSetBO bo where bo.planId='"+planId+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		for(int i=0;i<list.size();i++){
    			XysEvaModeSetBO bo=(XysEvaModeSetBO)list.get(i);
    			map.put(bo.getPostId(),bo);
    		}
    	}
    	return map;
    }
    

    /**
     * ���ؿ��˸�λ����
     * @param postId ��λ���
     * @param type  1 kpi�� 2 360
     * @return
     * @throws SysException
     */
    public List getXysWeightSetBO(String planId,String postId,String type)throws SysException{
        String hql="select bo from XysWeightSetBO bo where bo.planId='"+planId+"'" +
        		" and bo.postId='"+postId+"' and bo.type='"+type+"' order by bo.evaType";
        return this.hibernatetemplate.find(hql);
    }
     /**
     * ���ؿ��˸�λ����
     * @param postId ��λ���
     * @param type  1 kpi�� 2 360
     * @param  evaPost ���˸�λ���
     * @return
     * @throws SysException
     */
    public XysWeightSetBO findEqualsXysWeightSetBO(String planId,String postId,String evaPost,String type)throws SysException{
        String hql="select bo from XysWeightSetBO bo where bo.postId='"+postId+"' and bo.type='"+type+"'";
        hql+=" and bo.evaPostId='"+evaPost+"' and bo.planId='"+planId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
            return (XysWeightSetBO)list.get(0);
        }
        return null;
    }
    
    public List getPersonBOByWeightSetId(String setId)throws SysException{
    	String[] personType=Constants.IN_SERVICE_TYPE.split(",");
    	String hql="select bo from PersonBO bo where bo.postId" +
    			" in(select vo.evaPostId from XysWeightSetBO vo where vo.setId='"+setId+"') " +
    			"and "+CommonFuns.splitInSql(personType, "bo.personType");
    	return this.hibernatetemplate.find(hql);
    }
    
    /**
     * �����ų���λ
     * @param setId Ȩ�����ñ�ʶ
     * @param personId ��Ա��ʶ
     * @return
     * @throws SysException
     */
    public XysWeightExcPersBO findEqualsXysWeightExcPersBO(String setId,String personId)throws SysException{
    	String hql="select bo from XysWeightExcPersBO bo where bo.setId='"+setId+"' and bo.personId='"+personId+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return(XysWeightExcPersBO)list.get(0);
    	}
    	return null;
    }
    
    
    /**
     * ���ش�ֿ���
     * @param planId �ƻ���ʾ
     * @param type 1����KPI 2����KPI 3 360
     * @return
     * @throws SysException
     */
    public List getXysScoreCtrBOByPlanId(String planId,String type)throws SysException{
    	String hql="select bo from XysScoreCtrBO bo where bo.planId='"+planId+"' and bo.type='"+type+"'";
    	return this.hibernatetemplate.find(hql);
    }
    /**
     * ����ָ���ȼ�����
     * @param planId
     * @param type
     * @param gradItem
     * @return
     * @throws SysException
     */
    public XysScoreCtrBO findEqualsXysScoreCtrBO(String planId,String type,String gradItem)throws SysException{
    	String hql="select bo from XysScoreCtrBO bo where bo.planId='"+planId+"' " +
    			"and bo.type='"+type+"' and bo.gradeItem='"+gradItem+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (XysScoreCtrBO)list.get(0);
    	}
    	return null;
    }
    /**
     * ���ش�����־
     * @param planId �ƻ���ʾ
     * @param objType �������� 1����KPI����2����KPI����3360
     * @return
     * @throws SysException
     */
    public List getXysBeginGradeErrorBO(PageVO pagevo,String planId,String objType)throws SysException{
    	String hql="select bo from XysBeginGradeErrorBO bo where bo.planId='"+planId+"' and bo.objType='"+objType+"'";
    	String countHql="select count(bo) from XysBeginGradeErrorBO bo where bo.planId='"+planId+"' and bo.objType='"+objType+"'";
    	if(pagevo!=null){
    		return this.pageQuery(pagevo, countHql, hql);
    	}else{
    		return this.hibernatetemplate.find(hql);
    	}
    }
    /**
     * Ȩ������
     * @param planId �ƻ���ʶ
     * @param postId ��λ��ʶ
     * @param type 1kpi 2 360
     * @return
     * @throws SysException
     */
    public XysLevelWeightSetBO findEqualsXysLevelWeightSetBO(String planId,String postId,String type)throws SysException{
    	String hql="select bo from XysLevelWeightSetBO bo where bo.planId='"+planId+"' and bo.postId='"+postId+"' and bo.type='"+type+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (XysLevelWeightSetBO)list.get(0);
    	}
    	return null;
    }
    
    public Hashtable getIllegalPostBOByPlanIdForMap(String planId)throws SysException{
    	String hql="select bo from PostBO bo where " +
    			"bo.postId not in(select mode.postId from XysEvaModeSetBO mode where mode.planId='"+planId+"')" +
    			" or bo.postId not in(select w.postId from XysWeightSetBO w where w.planId='"+planId+"' and w.type='"+XysWeightSetBO.TYPE_KPI+"')" +
    			" or bo.postId not in(select w1.postId from XysWeightSetBO w1 where w1.planId='"+planId+"' and w1.type='"+XysWeightSetBO.TYPE_360+"')" +
    			" or bo.postId not in(select l1.postId from XysLevelWeightSetBO l1 where l1.planId='"+planId+"' and l1.type='1')" +
    		    " or bo.postId not in(select l2.postId from XysLevelWeightSetBO l2 where l2.planId='"+planId+"' and l2.type='2')";
    	List list=this.hibernatetemplate.find(hql);
    	Hashtable map=new Hashtable();
    	if(list!=null&&list.size()>0){
    		for(int i=0;i<list.size();i++){
    			PostBO bo=(PostBO)list.get(i);
    			map.put(bo.getPostId(), bo);
    		}
    	}
    	return map;
    }
   
    public List getXysExportTempBOByPlanId(String planId)throws SysException{
    	String hql="select bo from XysExportTempBO bo where bo.planId='"+planId+"'";
    	return this.hibernatetemplate.find(hql);
    }
}
