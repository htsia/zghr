package com.hr319wg.attence.service;

import com.hr319wg.attence.dao.AttEvcctionStateDAO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ¸ßº£ÐÇ
 * Date: 11-12-2
 * Time: ÏÂÎç2:37
 * To change this template use File | Settings | File Templates.
 */
public class AttEvcctionStateServcie {
    private AttEvcctionStateDAO attEvcctionStateDao;

    public List getAllAttEvcctionRecCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName)throws SysException{
        return this.attEvcctionStateDao.getAllAttEvcctionRecCollectBO(pagevo,orgId,beginTime,endTime,personValue,postName);
    }

    public AttEvcctionRecCollectBO findAttEvcctionRecCollectBOById(String evcctionCollectNo)throws SysException{
        return (AttEvcctionRecCollectBO)this.attEvcctionStateDao.findBoById(AttEvcctionRecCollectBO.class,evcctionCollectNo);
    }

    public void saveAttEvcctionRecCollectBO(AttEvcctionRecCollectBO bo)throws SysException{
        this.attEvcctionStateDao.saveOrUpdateBo(bo);
    }

    public void deleteAttEvcctionRecCollectBO(String evcctionCollectNo) throws SysException{
        this.attEvcctionStateDao.deleteBo(AttEvcctionRecCollectBO.class,evcctionCollectNo);
    }

    public AttEvcctionRecBO findAttEvcctionRecBOBySuperId(String superId) throws SysException{
        return this.attEvcctionStateDao.findAttEvcctionRecBOBySuperId(superId);
    }
    public AttEvcctionRecBO findAttEvcctionRecBOById(String evcctionNO)throws SysException{
        return (AttEvcctionRecBO)this.attEvcctionStateDao.findBoById(AttEvcctionRecBO.class,evcctionNO);
    }

    public void saveAttEvcctionRecBO(AttEvcctionRecBO bo)throws SysException{
        this.attEvcctionStateDao.saveOrUpdateBo(bo);
    }

    public void deleteAttEvcctionRecBO(String evcctionNO)throws SysException{
       this.attEvcctionStateDao.deleteBo(AttEvcctionRecBO.class,evcctionNO);
    }

    public AttEvcctionStateDAO getAttEvcctionStateDao() {
        return attEvcctionStateDao;
    }

    public void setAttEvcctionStateDao(AttEvcctionStateDAO attEvcctionStateDao) {
        this.attEvcctionStateDao = attEvcctionStateDao;
    }
}
