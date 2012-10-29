package com.hr319wg.attence.service;

import com.hr319wg.attence.dao.AttSumDataMgrDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ¸ßº£ÐÇ
 * Date: 11-12-12
 * Time: ÏÂÎç2:21
 * To change this template use File | Settings | File Templates.
 */
public class AttSumDataMgrService {
    private AttSumDataMgrDAO attSumDataMgrDAO;

    public List getAllAttenceDayLogBO(PageVO pagevo,String beginDate,String endDate,String orgId,String queryValue)throws SysException{
        return this.attSumDataMgrDAO.getAllAttenceDayLogBO(pagevo,beginDate,endDate,orgId,queryValue);
    }

    public List getAllAttenceDayMonthBO(PageVO pagevo,String likeDate,String orgId,String queryValue)throws SysException{
        return this.attSumDataMgrDAO.getAllAttenceDayMonthBO(pagevo,likeDate,orgId,queryValue);
    }

    public AttSumDataMgrDAO getAttSumDataMgrDAO() {
        return attSumDataMgrDAO;
    }

    public void setAttSumDataMgrDAO(AttSumDataMgrDAO attSumDataMgrDAO) {
        this.attSumDataMgrDAO = attSumDataMgrDAO;
    }
}
