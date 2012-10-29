package com.hr319wg.attence.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-12
 * Time: обнГ2:24
 * To change this template use File | Settings | File Templates.
 */
public interface IAttSumDataMgrUCC {
    public List getAllAttenceDayLogBO(PageVO pagevo,String beginDate,String endDate,String orgId,String queryValue)throws SysException;

    public List getAllAttenceDayMonthBO(PageVO pagevo,String likeDate,String orgId,String queryValue)throws SysException;
}
