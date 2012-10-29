package com.hr319wg.attence.ucc.impl;

import com.hr319wg.attence.pojo.bo.AttRestChangeBO;
import com.hr319wg.attence.pojo.bo.AttRestStoreBO;
import com.hr319wg.attence.service.AttRestChgService;
import com.hr319wg.attence.ucc.IAttRestChgUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-2-1
 * Time: ÏÂÎç2:03
 * To change this template use File | Settings | File Templates.
 */
public class AttRestChgUCC implements IAttRestChgUCC{
    private AttRestChgService attRestChgService;

    public List getAllAttRestStoreBO(PageVO pagevo,String begin,String end,String orgId,String queryValue)throws SysException{
        return this.attRestChgService.getAllAttRestStoreBO(pagevo,begin,end,orgId,queryValue);
    }

    public List getAttRestStoreBOByPid(PageVO pagevo,String personId)throws SysException{
        return this.attRestChgService.getAttRestStoreBOByPid(pagevo,personId);
    }

    public AttRestStoreBO findAttRestStoreBOById(String storeId)throws SysException{
        return this.attRestChgService.findAttRestStoreBOById(storeId);
    }

    public void saveAttRestStoreBO(AttRestStoreBO bo)throws SysException{
        this.attRestChgService.saveAttRestStoreBO(bo);
    }

    public void deleteAttRestStoreBO(String storeId)throws SysException{
        this.attRestChgService.deleteAttRestStoreBO(storeId);
    }

    public void saveAttRestStoreBOByRestAndPid(String orgId, String begin, String end, String personId, String itemId, String type) throws SysException{
        this.attRestChgService.saveAttRestStoreBOByRestAndPid(orgId,begin,end,personId,itemId,type);
    }

    public List getAllAttRestChangeBO(PageVO pagevo,String begin,String end,String orgId,String queryValue)throws SysException{
        return this.attRestChgService.getAllAttRestChangeBO(pagevo,begin,end,orgId,queryValue);
    }

    public List getAttRestChangeBOByPid(PageVO pagevo,String personId)throws SysException{
        return this.attRestChgService.getAttRestChangeBOByPid(pagevo,personId);
    }

    public List getAttRestChangeBOByStoreId(String storeId)throws SysException{
        return this.attRestChgService.getAttRestChangeBOByStoreId(storeId);
    }

    public AttRestChangeBO findAttRestChangeBOById(String chgId)throws SysException{
        return this.attRestChgService.findAttRestChangeBOById(chgId);
    }

    public void saveAttRestChangeBO(AttRestChangeBO bo)throws SysException{
        this.attRestChgService.saveAttRestChangeBO(bo);
    }

    public void deleteAttRestChangeBO(String chgId)throws SysException{
        this.attRestChgService.deleteAttRestChangeBO(chgId);
    }


    public AttRestChgService getAttRestChgService() {
        return attRestChgService;
    }

    public void setAttRestChgService(AttRestChgService attRestChgService) {
        this.attRestChgService = attRestChgService;
    }
}
