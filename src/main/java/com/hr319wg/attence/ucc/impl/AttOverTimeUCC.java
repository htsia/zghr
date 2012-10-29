package com.hr319wg.attence.ucc.impl;

import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.attence.service.AttOverTimeService;
import com.hr319wg.attence.ucc.IAttOverTimeUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÉÏÎç11:18
 * To change this template use File | Settings | File Templates.
 */
public class AttOverTimeUCC implements IAttOverTimeUCC{
    private AttOverTimeService  attOverTimeService;

    public List getAllAttOverTimeLogBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName) throws SysException{
          return this.attOverTimeService.getAllAttOverTimeLogBO(pagevo,orgId,beginTime,endTime,personValue,postName);
    }

    public AttOverTimeLogBO findAttOverTimeLogBOById(String overTimeLogNO)throws SysException{
          return this.attOverTimeService.findAttOverTimeLogBOById(overTimeLogNO);
    }

    public void saveAttOverTimeLogBO(AttOverTimeLogBO bo) throws SysException{
          this.attOverTimeService.saveAttOverTimeLogBO(bo);
    }

    public void deleteAttOverTimeLogBO(String overTimeLogNO)throws SysException{
           this.attOverTimeService.deleteAttOverTimeLogBO(overTimeLogNO);
    }


    public List getAllAttOverTimeRecBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException{
           return this.attOverTimeService.getAllAttOverTimeRecBO(pagevo,orgId,beginTime,endTime);
    }

    public AttOverTimeRecBO findAttOverTimeRecBOBySuperId(String superFurloughNo)throws SysException{
        return this.attOverTimeService.findAttOverTimeRecBOBySuperId(superFurloughNo);
    }

    public AttOverTimeRecBO findAttOverTimeRecBOById(String overTimeNO) throws SysException{
           return this.attOverTimeService.findAttOverTimeRecBOById(overTimeNO);
    }

    public void saveAttOverTimeRecBO(AttOverTimeRecBO bo) throws SysException{
           this.attOverTimeService.saveAttOverTimeRecBO(bo);
    }

    public void deleteAttOverTimeRecBO(String overTimeNO)throws SysException{
           this.attOverTimeService.deleteAttOverTimeRecBO(overTimeNO);
    }

     public AttOverTimeService getAttOverTimeService() {
        return attOverTimeService;
    }

    public void setAttOverTimeService(AttOverTimeService attOverTimeService) {
        this.attOverTimeService = attOverTimeService;
    }
}
