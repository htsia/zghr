package com.hr319wg.xys.eva.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.EvaRelBO;
import com.hr319wg.xys.eva.pojo.bo.XysPostRoleRelBO;

import java.util.Hashtable;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-25
 * Time: ÏÂÎç11:03
 * To change this template use File | Settings | File Templates.
 */
public interface IRelSetUCC {
    public List getAllPostBOByOrgId(PageVO pagevo,String orgId)throws SysException;
    public List getBranchPostRelByPostId(String postId)throws SysException;
    public List getAllSuperPostByPostId(String postId)throws SysException;

    public List getAllEvaRelBOByPostId(String postId)throws SysException;
    public EvaRelBO findEqualsEvaRelBO(String postId,String evaPostId)throws SysException;
    public EvaRelBO findEvaRelBOById(String relId)throws SysException;
    public void saveEvaRelBO(EvaRelBO bo)throws SysException;
    public void deleteEvaRelBO(String relId)throws SysException;
    
    public XysPostRoleRelBO findXysPostRoleRelBOByPostId(String postId)throws SysException;
    public void saveXysPostRoleRelBO(XysPostRoleRelBO bo)throws SysException;
    public Hashtable getAllXysPostRoleRelBOForMap()throws SysException;
    public List getXysPostRoleRelBOByRoleId(String roleId)throws SysException;
}
