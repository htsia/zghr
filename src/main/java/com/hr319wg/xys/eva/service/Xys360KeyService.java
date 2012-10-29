package com.hr319wg.xys.eva.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.dao.Xys360KeyDAO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyLibBO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: ÏÂÎç4:57
 * To change this template use File | Settings | File Templates.
 */
public class Xys360KeyService {
    private Xys360KeyDAO xys360KeyDAO;

    public List getXys360KeyLibBO(String superId)throws SysException{
        return xys360KeyDAO.getXys360KeyLibBO(superId);
    }
    public Xys360KeyLibBO findXys360KeyLibBOById(String libId)throws SysException{
        return (Xys360KeyLibBO)xys360KeyDAO.findBoById(Xys360KeyLibBO.class,libId);
    }
    public void saveXys360KeyLibBO(Xys360KeyLibBO bo)throws SysException{
        xys360KeyDAO.saveOrUpdateBo(bo);
    }
    public void deleteXys360KeyLibBO(String libId)throws SysException{
        xys360KeyDAO.deleteBo(Xys360KeyLibBO.class,libId);
    }


    public List getXys360KeyBOByLib(PageVO pagevo,String libId)throws SysException{
         return xys360KeyDAO.getXys360KeyBOByLib(pagevo,libId);
    }
    public List getXys360KeyBOByLibAndType(String libId,String keyType)throws SysException{
        return xys360KeyDAO.getXys360KeyBOByLibAndType(libId,keyType);
    }
    public Xys360KeyBO findXys360KeyBOById(String keyId)throws SysException{
        return (Xys360KeyBO)xys360KeyDAO.findBoById(Xys360KeyBO.class,keyId);
    }
    public void saveXys360KeyBO(Xys360KeyBO bo)throws SysException{
        xys360KeyDAO.saveOrUpdateBo(bo);
    }
    public void deleteXys360KeyBO(String keyId)throws SysException{
        xys360KeyDAO.deleteBo(Xys360KeyBO.class,keyId);
    }


    public Xys360KeyDAO getXys360KeyDAO() {
        return xys360KeyDAO;
    }

    public void setXys360KeyDAO(Xys360KeyDAO xys360KeyDAO) {
        this.xys360KeyDAO = xys360KeyDAO;
    }
}
