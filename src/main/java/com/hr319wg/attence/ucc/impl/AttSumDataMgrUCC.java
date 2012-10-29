package com.hr319wg.attence.ucc.impl;

import com.hr319wg.attence.service.AttSumDataMgrService;
import com.hr319wg.attence.ucc.IAttSumDataMgrUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-12
 * Time: ÏÂÎç2:26
 * To change this template use File | Settings | File Templates.
 */
public class AttSumDataMgrUCC implements IAttSumDataMgrUCC{
    private AttSumDataMgrService attSumDataMgrService;

    public List getAllAttenceDayLogBO(PageVO pagevo,String beginDate,String endDate,String orgId,String queryValue)throws SysException{
         return this.attSumDataMgrService.getAllAttenceDayLogBO(pagevo,beginDate,endDate,orgId,queryValue);
    }

    public List getAllAttenceDayMonthBO(PageVO pagevo,String likeDate,String orgId,String queryValue)throws SysException{
         return this.attSumDataMgrService.getAllAttenceDayMonthBO(pagevo,likeDate,orgId,queryValue);
    }

    public AttSumDataMgrService getAttSumDataMgrService() {
        return attSumDataMgrService;
    }

    public void setAttSumDataMgrService(AttSumDataMgrService attSumDataMgrService) {
        this.attSumDataMgrService = attSumDataMgrService;
    }
}
