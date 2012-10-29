package com.hr319wg.attence.ucc.impl;

import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.attence.service.AttOutWorkService;
import com.hr319wg.attence.ucc.IAttOutWorkUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÏÂÎç1:52
 * To change this template use File | Settings | File Templates.
 */
public class AttOutWorkUCC implements IAttOutWorkUCC{
    private AttOutWorkService attOutWorkService;

    public List getAllAttOutWorkCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName)throws SysException{
        return this.attOutWorkService.getAllAttOutWorkCollectBO(pagevo,orgId,beginTime,endTime,personValue,postName);
    }

    public AttOutWorkCollectBO findAttOutWorkCollectBOById(String outWorkCollectNo)throws SysException{
        return this.attOutWorkService.findAttOutWorkCollectBOById(outWorkCollectNo);
    }

    public void saveAttOutWorkCollectBO(AttOutWorkCollectBO bo)throws SysException{
        this.attOutWorkService.saveAttOutWorkCollectBO(bo);
    }

    public void deleteAttOutWorkCollectBO(String outWorkCollectNo)throws SysException{
        this.attOutWorkService.deleteAttOutWorkCollectBO(outWorkCollectNo);
    }


    public List getAllAttOutWorkBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException{
        return this.attOutWorkService.getAllAttOutWorkBO(pagevo,orgId,beginTime,endTime);
    }

    public AttOutWorkBO findAttOutWorkBOBySuperId(String superFurloughNo)throws SysException{
        return this.attOutWorkService.findAttOutWorkBOBySuperId(superFurloughNo);
    }

    public  AttOutWorkBO findAttOutWorkBOById(String outWorkNo)throws SysException{
        return this.attOutWorkService.findAttOutWorkBOById(outWorkNo);
    }

    public void saveAttOutWorkBO(AttOutWorkBO bo)throws SysException{
        this.attOutWorkService.saveAttOutWorkBO(bo);
    }

    public void deleteAttOutWorkBO(String outWorkNo) throws SysException{
        this.attOutWorkService.deleteAttOutWorkBO(outWorkNo);
    }


    public AttOutWorkService getAttOutWorkService() {
        return attOutWorkService;
    }

    public void setAttOutWorkService(AttOutWorkService attOutWorkService) {
        this.attOutWorkService = attOutWorkService;
    }
}
