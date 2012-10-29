package com.hr319wg.attence.service;

import com.hr319wg.attence.dao.AttOutWorkDAO;
import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÏÂÎç1:37
 * To change this template use File | Settings | File Templates.
 */
public class AttOutWorkService {
    private AttOutWorkDAO attOutWorkDao;

    public List getAllAttOutWorkCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName)throws SysException{
        return this.attOutWorkDao.getAllAttOutWorkCollectBO(pagevo,orgId,beginTime,endTime,personValue,postName);
    }

    public AttOutWorkCollectBO findAttOutWorkCollectBOById(String outWorkCollectNo)throws SysException{
        return (AttOutWorkCollectBO)this.attOutWorkDao.findBoById(AttOutWorkCollectBO.class,outWorkCollectNo);
    }

    public void saveAttOutWorkCollectBO(AttOutWorkCollectBO bo)throws SysException{
        this.attOutWorkDao.saveOrUpdateBo(bo);
    }

    public void deleteAttOutWorkCollectBO(String outWorkCollectNo)throws SysException{
        this.attOutWorkDao.deleteBo(AttOutWorkCollectBO.class,outWorkCollectNo);
    }


    public List getAllAttOutWorkBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException{
        return this.attOutWorkDao.getAllAttOutWorkBO(pagevo,orgId,beginTime,endTime);
    }

    public AttOutWorkBO findAttOutWorkBOBySuperId(String superFurloughNo)throws SysException{
        return this.attOutWorkDao.findAttOutWorkBOBySuperId(superFurloughNo);
    }

    public  AttOutWorkBO findAttOutWorkBOById(String outWorkNo)throws SysException{
        return (AttOutWorkBO)this.attOutWorkDao.findBoById(AttOutWorkBO.class,outWorkNo);
    }

    public void saveAttOutWorkBO(AttOutWorkBO bo)throws SysException{
        this.attOutWorkDao.saveOrUpdateBo(bo);
    }

    public void deleteAttOutWorkBO(String outWorkNo) throws SysException{
         this.attOutWorkDao.deleteBo(AttOutWorkBO.class,outWorkNo);
    }

    public AttOutWorkDAO getAttOutWorkDao() {
        return attOutWorkDao;
    }

    public void setAttOutWorkDao(AttOutWorkDAO attOutWorkDao) {
        this.attOutWorkDao = attOutWorkDao;
    }
}
