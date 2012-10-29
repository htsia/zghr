package com.hr319wg.xys.eva.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempItemBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempLibBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempSetBO;
import com.hr319wg.xys.eva.service.Xys360TempService;
import com.hr319wg.xys.eva.ucc.IXys360TempUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç2:39
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempUCC implements IXys360TempUCC{
    private Xys360TempService xys360TempService;

    public List getXys360TempLibBO(String superId)throws SysException{
         return xys360TempService.getXys360TempLibBO(superId);
    }
    public Xys360TempLibBO findXys360TempLibBO(String libId)throws SysException{
         return xys360TempService.findXys360TempLibBO(libId);
    }
    public void saveXys360TempLibBO(Xys360TempLibBO bo)throws SysException{
        xys360TempService.saveXys360TempLibBO(bo);
    }
    public void deleteXys360TempLibBO(String libId)throws SysException{
        xys360TempService.deleteXys360TempLibBO(libId);
    }

    public List getXys360TempBOByLibId(String libId)throws SysException{
        return xys360TempService.getXys360TempBOByLibId(libId);
    }
    public List getAllXys360TempBO()throws SysException{
    	return this.xys360TempService.getAllXys360TempBO();
    }
    public Xys360TempBO findXys360TempBO(String tempId)throws SysException{
        return xys360TempService.findXys360TempBO(tempId);
    }
    public void saveXys360TempBO(Xys360TempBO bo)throws SysException{
        xys360TempService.saveXys360TempBO(bo);
    }
    public void deleteXys360TempBO(String tempId)throws SysException{
        xys360TempService.deleteXys360TempBO(tempId);
    }

    public List getXys360TempSetBOByTempId(String tempId)throws SysException{
         return xys360TempService.getXys360TempSetBOByTempId(tempId);
    }
    public Xys360TempSetBO findXys360TempSetBOById(String setId)throws SysException{
         return xys360TempService.findXys360TempSetBOById(setId);
    }
    public void saveXys360TempSetBO(Xys360TempSetBO bo)throws SysException{
        xys360TempService.saveXys360TempSetBO(bo);
    }
    public void deleteXys360TempSetBO(String setId)throws SysException{
        xys360TempService.deleteXys360TempSetBO(setId);
    }

    public List getXys360TempItemBOBySetId(String setId)throws SysException{
         return xys360TempService.getXys360TempItemBOBySetId(setId);
    }
    public Xys360TempItemBO findXys360TempItemBOById(String itemId)throws SysException{
         return xys360TempService.findXys360TempItemBOById(itemId);
    }
    public void saveXys360TempItemBO(Xys360TempItemBO bo)throws SysException{
         xys360TempService.saveXys360TempItemBO(bo);
    }
    public void deleteXys360TempItemBO(String itemId)throws SysException{
        xys360TempService.deleteXys360TempItemBO(itemId);
    }
    public List getXys360TempItemBOByTempId(String tempId)throws SysException{
        return xys360TempService.getXys360TempItemBOByTempId(tempId);
    }

    public void deleteAll(List list)throws SysException{
    	 this.xys360TempService.deleteAll(list);
    }
    public Xys360TempService getXys360TempService() {
        return xys360TempService;
    }

    public void setXys360TempService(Xys360TempService xys360TempService) {
        this.xys360TempService = xys360TempService;
    }
}
