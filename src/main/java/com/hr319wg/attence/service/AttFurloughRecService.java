package com.hr319wg.attence.service;

import com.hr319wg.attence.dao.AttFurloughRecDAO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttfurloughBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÏÂÎç4:16
 * To change this template use File | Settings | File Templates.
 */
public class AttFurloughRecService {
    private AttFurloughRecDAO attFurloughRecDAO;

    public List getAllAttfurloughBO()throws SysException{
        return this.attFurloughRecDAO.getAllAttfurloughBO();
    }

    public AttfurloughBO findAttfurloughBOById(String flID)throws SysException{
        return (AttfurloughBO)this.attFurloughRecDAO.findBoById(AttfurloughBO.class,flID);
    }

    public void saveAttfurloughBO(AttfurloughBO bo)throws SysException{
        this.attFurloughRecDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttfurloughBO(String flID)throws SysException{
        this.attFurloughRecDAO.deleteBo(AttfurloughBO.class,flID);
    }

    public List getAllAttFurloughRecCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type,String postName)throws SysException{
        return this.attFurloughRecDAO.getAllAttFurloughRecCollectBO(pagevo,orgId,beginTime,endTime,personValue,type,postName);
    }

    public AttFurloughRecCollectBO findAttFurloughRecCollectBOById(String furloughCollectNO)throws SysException{
         return (AttFurloughRecCollectBO)this.attFurloughRecDAO.findBoById(AttFurloughRecCollectBO.class,furloughCollectNO);
    }

    public void saveAttFurloughRecCollectBO(AttFurloughRecCollectBO bo)throws SysException{
        this.attFurloughRecDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttFurloughRecCollectBO(String furloughCollectNO)throws SysException{
        this.attFurloughRecDAO.deleteBo(AttFurloughRecCollectBO.class,furloughCollectNO);
    }

    public List getAllAttFurloughRecBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type)throws SysException{
        return this.attFurloughRecDAO.getAllAttFurloughRecBO(pagevo,orgId,beginTime,endTime,personValue,type);
    }

    public AttFurloughRecBO findAttFurlouoghRecBOBySuperId(String superFurloughNo)throws SysException{
        return this.attFurloughRecDAO.findAttFurlouoghRecBOBySuperId(superFurloughNo);
    }

    public AttFurloughRecBO findAttFurloughRecBOById(String furloughNO)throws SysException{
        return (AttFurloughRecBO)this.attFurloughRecDAO.findBoById(AttFurloughRecBO.class,furloughNO);
    }

    public void saveAttFurloughRecBO(AttFurloughRecBO bo)throws SysException{
        this.attFurloughRecDAO.saveOrUpdateBo(bo);
    }

    public void deleteAttFurloughRecBO(String furloughNO)throws SysException{
        this.attFurloughRecDAO.deleteBo(AttFurloughRecBO.class,furloughNO);
    }

    public AttFurloughRecDAO getAttFurloughRecDAO() {
        return attFurloughRecDAO;
    }

    public void setAttFurloughRecDAO(AttFurloughRecDAO attFurloughRecDAO) {
        this.attFurloughRecDAO = attFurloughRecDAO;
    }
}
