package com.hr319wg.xys.eva.dao;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.EvaRelBO;
import com.hr319wg.xys.eva.pojo.bo.XysPostRoleRelBO;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-25
 * Time: 下午10:52
 * To change this template use File | Settings | File Templates.
 */
public class RelSetDAO extends BaseDAO {
    /**
     * 根据机构ID取得所属岗位
     * @param pagevo
     * @param orgId  机构id
     * @return
     * @throws SysException
     */
    public List getAllPostBOByOrgId(PageVO pagevo,String orgId)throws SysException{
        String hql="select bo from PostBO bo where 1=1";
        String countHql="select count(bo) from PostBO bo where 1=1";
        if(orgId!=null&&!orgId.equals("")){
            OrgBO org= SysCacheTool.findOrgById(orgId);
            String treeId=org.getTreeId();
            hql+=" and bo.orgTreeId like '%"+treeId+"%'";
            countHql+=" and bo.orgTreeId like '%"+treeId+"%'";
        }
        if(pagevo!=null){
            return this.pageQuery(pagevo,countHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }

    /**
     * 得到该岗位默认的下级岗位
     * @param postId
     * @return
     * @throws SysException
     */
    public List getBranchPostRelByPostId(String postId)throws SysException{
          String hql="select bo from PostBO bo where bo.superId='"+postId+"'";
          return this.hibernatetemplate.find(hql);
    }

    /**
     * 根据岗位获得考核岗位
     * @param postId 岗位id
     * @return
     * @throws SysException
     */
    public List getAllEvaRelBOByPostId(String postId)throws SysException{
        String hql="select bo from EvaRelBO bo where bo.postId='"+postId+"' order by bo.evaType";
        return this.hibernatetemplate.find(hql);
    }

    /**
     * 根据指定岗位和考核岗位取得考核关系
     * @param postId
     * @param evaPostId
     * @return
     * @throws SysException
     */
    public EvaRelBO findEqualsEvaRelBO(String postId,String evaPostId)throws SysException{
        String hql="select bo from EvaRelBO bo where bo.postId='"+postId+"' and bo.evaPostId='"+evaPostId+"'";
        List list=this.hibernatetemplate.find(hql);
        if(list!=null&&list.size()>0){
            return (EvaRelBO)list.get(0);
        }else{
            return null;
        }
    }
    
    
    /**
     * 根据岗位查询所属角色
     * @param postId 岗位编号
     * @return
     * @throws SysException
     */
    public XysPostRoleRelBO findXysPostRoleRelBOByPostId(String postId)throws SysException{
    	String hql="select bo from XysPostRoleRelBO bo where bo.postId='"+postId+"'";
    	List list=this.hibernatetemplate.find(hql);
    	if(list!=null&&list.size()>0){
    		return (XysPostRoleRelBO)list.get(0);
    	}
    	return null;
    }
    
    public Hashtable getAllXysPostRoleRelBOForMap()throws SysException{
    	String hql="select bo from XysPostRoleRelBO bo ";
    	List list=this.hibernatetemplate.find(hql);
    	Hashtable map=new Hashtable();
    	if(list!=null&&list.size()>0){
    		for(int i=0;i<list.size();i++){
    			XysPostRoleRelBO bo=(XysPostRoleRelBO)list.get(i);
    			map.put(bo.getPostId(), bo);
    		}
    	}
    	return map;
    }
    
    
    public List getXysPostRoleRelBOByRoleId(String roleId)throws SysException{
    	String hql="select bo from XysPostRoleRelBO bo where bo.roleId='"+roleId+"'";
    	return this.hibernatetemplate.find(hql);
    }
}
