package com.hr319wg.xys.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç2:25
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempDAO extends BaseDAO{
    public List getXys360TempLibBO(String superId)throws SysException{
        String hql="select bo from Xys360TempLibBO bo where bo.superId='"+superId+"'";
        return this.hibernatetemplate.find(hql);
    }

    public List getXys360TempBOByLibId(String libId)throws SysException{
        String hql="select bo from Xys360TempBO bo where bo.tmpLibId='"+libId+"'";
        return this.hibernatetemplate.find(hql);
    }
    
    public List getAllXys360TempBO()throws SysException{
    	String hql="from Xys360TempBO";
    	return this.hibernatetemplate.find(hql);
    }

    public List getXys360TempSetBOByTempId(String tempId)throws SysException{
         String hql="select bo from Xys360TempSetBO bo where bo.tempId='"+tempId+"'";
         return this.hibernatetemplate.find(hql);
    }

    public List getXys360TempItemBOByTempId(String tempId)throws SysException{
        String hql="select bo from Xys360TempItemBO bo where bo.setId" +
                " in(select vo.setId from Xys360TempSetBO vo where vo.tempId='"+tempId+"')";
        return this.hibernatetemplate.find(hql);
    }

    public List getXys360TempItemBOBySetId(String setId)throws SysException{
        String hql="select bo from Xys360TempItemBO bo where bo.setId='"+setId+"'";
        return this.hibernatetemplate.find(hql);
    }
    
}
