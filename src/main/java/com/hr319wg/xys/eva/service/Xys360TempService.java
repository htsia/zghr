package com.hr319wg.xys.eva.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.dao.Xys360TempDAO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempItemBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempLibBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempSetBO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç2:32
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempService {
    private Xys360TempDAO xys360TempDAO;

    public List getXys360TempLibBO(String superId)throws SysException{
         return xys360TempDAO.getXys360TempLibBO(superId);
    }
    public Xys360TempLibBO findXys360TempLibBO(String libId)throws SysException{
        return (Xys360TempLibBO)xys360TempDAO.findBoById(Xys360TempLibBO.class,libId);
    }
    public void saveXys360TempLibBO(Xys360TempLibBO bo)throws SysException{
        xys360TempDAO.saveOrUpdateBo(bo);
    }
    public void deleteXys360TempLibBO(String libId)throws SysException{
        xys360TempDAO.deleteBo(Xys360TempLibBO.class,libId);
    }



    public List getXys360TempBOByLibId(String libId)throws SysException{
         return xys360TempDAO.getXys360TempBOByLibId(libId);
    }
    public List getAllXys360TempBO()throws SysException{
    	return this.xys360TempDAO.getAllXys360TempBO();
    }
    public Xys360TempBO findXys360TempBO(String tempId)throws SysException{
        return (Xys360TempBO)xys360TempDAO.findBoById(Xys360TempBO.class,tempId);
    }
    public void saveXys360TempBO(Xys360TempBO bo)throws SysException{
        xys360TempDAO.saveOrUpdateBo(bo);
    }
    public void deleteXys360TempBO(String tempId)throws SysException{
        xys360TempDAO.deleteBo(Xys360TempBO.class,tempId);
    }


    public List getXys360TempSetBOByTempId(String tempId)throws SysException{
        return xys360TempDAO.getXys360TempSetBOByTempId(tempId);
    }
    public Xys360TempSetBO findXys360TempSetBOById(String setId)throws SysException{
        return (Xys360TempSetBO)xys360TempDAO.findBoById(Xys360TempSetBO.class,setId);
    }
    public void saveXys360TempSetBO(Xys360TempSetBO bo)throws SysException{
        xys360TempDAO.saveOrUpdateBo(bo);
    }
    public void deleteXys360TempSetBO(String setId)throws SysException{
        xys360TempDAO.deleteBo(Xys360TempSetBO.class,setId);
    }


    public List getXys360TempItemBOBySetId(String setId)throws SysException{
        return xys360TempDAO.getXys360TempItemBOBySetId(setId);
    }
    public Xys360TempItemBO findXys360TempItemBOById(String itemId)throws SysException{
        return (Xys360TempItemBO)xys360TempDAO.findBoById(Xys360TempItemBO.class,itemId);
    }
    public void saveXys360TempItemBO(Xys360TempItemBO bo)throws SysException{
        xys360TempDAO.saveOrUpdateBo(bo);
    }
    public void deleteXys360TempItemBO(String itemId)throws SysException{
        xys360TempDAO.deleteBo(Xys360TempItemBO.class,itemId);
    }
    public List getXys360TempItemBOByTempId(String tempId)throws SysException{
        return xys360TempDAO.getXys360TempItemBOByTempId(tempId);
    }
    
    
    public void deleteAll(List list)throws SysException{
    	this.xys360TempDAO.deleteAll(list);
    }

    public Xys360TempDAO getXys360TempDAO() {
        return xys360TempDAO;
    }

    public void setXys360TempDAO(Xys360TempDAO xys360TempDAO) {
        this.xys360TempDAO = xys360TempDAO;
    }
}
