package com.hr319wg.xys.eva.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.EvaRelBO;
import com.hr319wg.xys.eva.pojo.bo.XysPostRoleRelBO;
import com.hr319wg.xys.eva.service.RelSetService;
import com.hr319wg.xys.eva.ucc.IRelSetUCC;


import java.util.Hashtable;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-25
 * Time: ÏÂÎç11:05
 * To change this template use File | Settings | File Templates.
 */
public class RelSetUCC implements IRelSetUCC {
    private RelSetService relSetService;

    public List getAllPostBOByOrgId(PageVO pagevo,String orgId)throws SysException{
         return this.relSetService.getAllPostBOByOrgId(pagevo,orgId);
    }
    public List getAllSuperPostByPostId(String postId)throws SysException{
        return this.relSetService.getAllSuperPostByPostId(postId);
    }
    public List getBranchPostRelByPostId(String postId)throws SysException{
         return this.relSetService.getBranchPostRelByPostId(postId);
    }

    public List getAllEvaRelBOByPostId(String postId)throws SysException{
         return this.relSetService.getAllEvaRelBOByPostId(postId);
    }
    public EvaRelBO findEqualsEvaRelBO(String postId,String evaPostId)throws SysException{
         return this.relSetService.findEqualsEvaRelBO(postId,evaPostId);
    }
    public EvaRelBO findEvaRelBOById(String relId)throws SysException{
         return this.relSetService.findEvaRelBOById(relId);
    }
    public void saveEvaRelBO(EvaRelBO bo)throws SysException{
         this.relSetService.saveEvaRelBO(bo);
    }
    public void deleteEvaRelBO(String relId)throws SysException{
         this.relSetService.deleteEvaRelBO(relId);
    }
    
    public XysPostRoleRelBO findXysPostRoleRelBOByPostId(String postId)throws SysException{
    	 return this.relSetService.findXysPostRoleRelBOByPostId(postId);
    }
    public void saveXysPostRoleRelBO(XysPostRoleRelBO bo)throws SysException{
    	 this.relSetService.saveXysPostRoleRelBO(bo);
    }
    public Hashtable getAllXysPostRoleRelBOForMap()throws SysException{
    	return this.relSetService.getAllXysPostRoleRelBOForMap();
    }
    
    public List getXysPostRoleRelBOByRoleId(String roleId)throws SysException{
    	return this.relSetService.getXysPostRoleRelBOByRoleId(roleId);
    }

    public RelSetService getRelSetService() {
        return relSetService;
    }

    public void setRelSetService(RelSetService relSetService) {
        this.relSetService = relSetService;
    }
}
