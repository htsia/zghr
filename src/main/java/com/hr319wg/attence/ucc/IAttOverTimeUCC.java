package com.hr319wg.attence.ucc;

import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÉÏÎç11:15
 * To change this template use File | Settings | File Templates.
 */
public interface IAttOverTimeUCC {

    public List getAllAttOverTimeLogBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName) throws SysException;

    public AttOverTimeLogBO findAttOverTimeLogBOById(String overTimeLogNO)throws SysException;

    public void saveAttOverTimeLogBO(AttOverTimeLogBO bo) throws SysException;

    public void deleteAttOverTimeLogBO(String overTimeLogNO)throws SysException;


    public List getAllAttOverTimeRecBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException;

    public AttOverTimeRecBO findAttOverTimeRecBOBySuperId(String superFurloughNo)throws SysException;

    public AttOverTimeRecBO findAttOverTimeRecBOById(String overTimeNO) throws SysException;

    public void saveAttOverTimeRecBO(AttOverTimeRecBO bo) throws SysException;

    public void deleteAttOverTimeRecBO(String overTimeNO)throws SysException;
}
