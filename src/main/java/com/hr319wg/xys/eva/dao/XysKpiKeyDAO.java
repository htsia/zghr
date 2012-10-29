package com.hr319wg.xys.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-9
 * Time: ÏÂÎç5:36
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiKeyDAO extends BaseDAO{
    public List getXysKpiKeyLibBOByPostId(String postId)throws SysException{
        String hql="select bo from XysKpiKeyLibBO bo where bo.postId='"+postId+"'";
        return this.hibernatetemplate.find(hql);
    }

    public List getXysKpiKeyBOByLibId(String libId)throws SysException{
        String hql="select bo from XysKpiKeyBO bo where bo.libId='"+libId+"'";
        return this.hibernatetemplate.find(hql);
    }

    public List getXysKpiKeyBOByPostId(String postId)throws SysException{
        String hql="select bo from XysKpiKeyBO bo where bo.libId in(select vo.libId from XysKpiKeyLibBO vo where vo.postId='"+postId+"')";
        return this.hibernatetemplate.find(hql);
    }
}
