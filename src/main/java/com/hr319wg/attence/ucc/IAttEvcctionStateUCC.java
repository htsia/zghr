package com.hr319wg.attence.ucc;

import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-2
 * Time: ÏÂÎç2:45
 * To change this template use File | Settings | File Templates.
 */
public interface IAttEvcctionStateUCC {

    public List getAllAttEvcctionRecCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName)throws SysException;

    public AttEvcctionRecCollectBO findAttEvcctionRecCollectBOById(String evcctionCollectNo)throws SysException;

    public void saveAttEvcctionRecCollectBO(AttEvcctionRecCollectBO bo)throws SysException;

    public void deleteAttEvcctionRecCollectBO(String evcctionCollectNo) throws SysException;


    public AttEvcctionRecBO findAttEvcctionRecBOBySuperId(String superId) throws SysException;

    public AttEvcctionRecBO findAttEvcctionRecBOById(String evcctionNO)throws SysException;

    public void saveAttEvcctionRecBO(AttEvcctionRecBO bo)throws SysException;

    public void deleteAttEvcctionRecBO(String evcctionNO)throws SysException;
}
