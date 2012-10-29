package com.hr319wg.attence.service;

import com.hr319wg.attence.dao.AttOverTimeDAO;
import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-2
 * Time: ÏÂÎç5:26
 * To change this template use File | Settings | File Templates.
 */
public class AttOverTimeService {
    private AttOverTimeDAO attOverTimeDao;

    public List getAllAttOverTimeLogBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName) throws SysException{
        return this.attOverTimeDao.getAllAttOverTimeLogBO(pagevo,orgId,beginTime,endTime,personValue,postName);
    }

    public AttOverTimeLogBO findAttOverTimeLogBOById(String overTimeLogNO)throws SysException{
        return (AttOverTimeLogBO)this.attOverTimeDao.findBoById(AttOverTimeLogBO.class,overTimeLogNO);
    }

    public void saveAttOverTimeLogBO(AttOverTimeLogBO bo) throws SysException{
        this.attOverTimeDao.saveOrUpdateBo(bo);
    }

    public void deleteAttOverTimeLogBO(String overTimeLogNO)throws SysException{
        this.attOverTimeDao.deleteBo(AttOverTimeLogBO.class,overTimeLogNO);
    }


    public List getAllAttOverTimeRecBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException{
        return this.attOverTimeDao.getAllAttOverTimeRecBO(pagevo,orgId,beginTime,endTime);
    }

    public AttOverTimeRecBO findAttOverTimeRecBOBySuperId(String superFurloughNo)throws SysException{
        return this.attOverTimeDao.findAttOverTimeRecBOBySuperId(superFurloughNo);
    }

    public  AttOverTimeRecBO findAttOverTimeRecBOById(String overTimeNO) throws SysException{
         return (AttOverTimeRecBO) this.attOverTimeDao.findBoById(AttOverTimeRecBO.class,overTimeNO);
    }

    public void saveAttOverTimeRecBO(AttOverTimeRecBO bo) throws SysException{
        this.attOverTimeDao.saveOrUpdateBo(bo);
    }

    public void deleteAttOverTimeRecBO(String overTimeNO)throws SysException{
        this.attOverTimeDao.deleteBo(AttOverTimeRecBO.class,overTimeNO);
    }

    public AttOverTimeDAO getAttOverTimeDao() {
        return attOverTimeDao;
    }

    public void setAttOverTimeDao(AttOverTimeDAO attOverTimeDao) {
        this.attOverTimeDao = attOverTimeDao;
    }
}
