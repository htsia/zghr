package com.hr319wg.xys.eva.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyLibBO;
import com.hr319wg.xys.eva.service.Xys360KeyService;
import com.hr319wg.xys.eva.ucc.IXys360KeyUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: ÏÂÎç5:05
 * To change this template use File | Settings | File Templates.
 */
public class Xys360KeyUCC implements IXys360KeyUCC{
    private Xys360KeyService xys360KeyService;

    public List getXys360KeyLibBO(String superId)throws SysException{
         return xys360KeyService.getXys360KeyLibBO(superId);
    }
    public Xys360KeyLibBO findXys360KeyLibBOById(String libId)throws SysException{
         return xys360KeyService.findXys360KeyLibBOById(libId);
    }
    public void saveXys360KeyLibBO(Xys360KeyLibBO bo)throws SysException{
         xys360KeyService.saveXys360KeyLibBO(bo);
    }
    public void deleteXys360KeyLibBO(String libId)throws SysException{
         xys360KeyService.deleteXys360KeyLibBO(libId);
    }

    public List getXys360KeyBOByLib(PageVO pagevo,String libId)throws SysException{
         return xys360KeyService.getXys360KeyBOByLib(pagevo,libId);
    }
    public List getXys360KeyBOByLibAndType(String libId,String keyType)throws SysException{
        return xys360KeyService.getXys360KeyBOByLibAndType(libId,keyType);
    }
    public Xys360KeyBO findXys360KeyBOById(String keyId)throws SysException{
         return xys360KeyService.findXys360KeyBOById(keyId);
    }
    public void saveXys360KeyBO(Xys360KeyBO bo)throws SysException{
         xys360KeyService.saveXys360KeyBO(bo);
    }
    public void deleteXys360KeyBO(String keyId)throws SysException{
         xys360KeyService.deleteXys360KeyBO(keyId);
    }


    public Xys360KeyService getXys360KeyService() {
        return xys360KeyService;
    }

    public void setXys360KeyService(Xys360KeyService xys360KeyService) {
        this.xys360KeyService = xys360KeyService;
    }
}
