package com.hr319wg.xys.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: 下午4:41
 * To change this template use File | Settings | File Templates.
 */
public class Xys360KeyDAO extends BaseDAO {
    /**
     * 返回指标库
     * @param superId  上级ID
     * @return
     * @throws SysException
     */
    public List getXys360KeyLibBO(String superId)throws SysException{
        String hql="select bo from Xys360KeyLibBO bo where bo.superId='"+superId+"'";
        return this.hibernatetemplate.find(hql);
    }

    /**
     * 返回指标
     * @param pagevo
     * @param libId 指标库ID
     * @return
     * @throws SysException
     */
    public List getXys360KeyBOByLib(PageVO pagevo,String libId)throws SysException{
        String hql="select bo from Xys360KeyBO bo where bo.libId='"+libId+"'";
        String countHql="select count(bo) from Xys360KeyBO bo where bo.libId='"+libId+"'";
        if(pagevo!=null){
            return this.pageQuery(pagevo,countHql,hql);
        }else{
            return this.hibernatetemplate.find(hql);
        }
    }

    /**
     * 在指标库中返回指定类型指标
     * @param libId
     * @param keyType
     * @return
     * @throws SysException
     */
    public List getXys360KeyBOByLibAndType(String libId,String keyType)throws SysException{
        String hql="select bo from Xys360KeyBO bo where bo.libId='"+libId+"' and bo.keyType='"+keyType+"'";
        return this.hibernatetemplate.find(hql);
    }

}
