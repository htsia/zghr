package com.hr319wg.attence.ucc;

import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÏÂÎç1:50
 * To change this template use File | Settings | File Templates.
 */
public interface IAttOutWorkUCC {

    public List getAllAttOutWorkCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName)throws SysException;

    public AttOutWorkCollectBO findAttOutWorkCollectBOById(String outWorkCollectNo)throws SysException;

    public void saveAttOutWorkCollectBO(AttOutWorkCollectBO bo)throws SysException;

    public void deleteAttOutWorkCollectBO(String outWorkCollectNo)throws SysException;


    public List getAllAttOutWorkBO(PageVO pagevo,String orgId,String beginTime,String endTime)throws SysException;

    public AttOutWorkBO findAttOutWorkBOBySuperId(String superFurloughNo)throws SysException;

    public  AttOutWorkBO findAttOutWorkBOById(String outWorkNo)throws SysException;

    public void saveAttOutWorkBO(AttOutWorkBO bo)throws SysException;

    public void deleteAttOutWorkBO(String outWorkNo) throws SysException;
}
