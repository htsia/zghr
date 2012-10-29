package com.hr319wg.xys.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: ����4:41
 * To change this template use File | Settings | File Templates.
 */
public class Xys360KeyDAO extends BaseDAO {
    /**
     * ����ָ���
     * @param superId  �ϼ�ID
     * @return
     * @throws SysException
     */
    public List getXys360KeyLibBO(String superId)throws SysException{
        String hql="select bo from Xys360KeyLibBO bo where bo.superId='"+superId+"'";
        return this.hibernatetemplate.find(hql);
    }

    /**
     * ����ָ��
     * @param pagevo
     * @param libId ָ���ID
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
     * ��ָ����з���ָ������ָ��
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
