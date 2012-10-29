package com.hr319wg.attence.ucc;

import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttfurloughBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÏÂÎç4:28
 * To change this template use File | Settings | File Templates.
 */
public interface IAttFurloughRecUCC {
    public List getAllAttfurloughBO()throws SysException;

    public AttfurloughBO findAttfurloughBOById(String flID)throws SysException;

    public void saveAttfurloughBO(AttfurloughBO bo)throws SysException;

    public void deleteAttfurloughBO(String flID)throws SysException;


    public List getAllAttFurloughRecCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type,String postName)throws SysException;

    public AttFurloughRecCollectBO findAttFurloughRecCollectBOById(String furloughCollectNO)throws SysException;

    public void saveAttFurloughRecCollectBO(AttFurloughRecCollectBO bo)throws SysException;

    public void deleteAttFurloughRecCollectBO(String furloughCollectNO)throws SysException;

    public List getAllAttFurloughRecBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type)throws SysException;

    public AttFurloughRecBO findAttFurloughRecBOById(String furloughNO)throws SysException;

    public AttFurloughRecBO findAttFurlouoghRecBOBySuperId(String superFurloughNo)throws SysException;

    public void saveAttFurloughRecBO(AttFurloughRecBO bo)throws SysException;

    public void deleteAttFurloughRecBO(String furloughNO)throws SysException;


}
