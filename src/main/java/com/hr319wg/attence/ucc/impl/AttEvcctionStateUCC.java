package com.hr319wg.attence.ucc.impl;

import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.attence.service.AttEvcctionStateServcie;
import com.hr319wg.attence.ucc.IAttEvcctionStateUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-2
 * Time: ÏÂÎç2:46
 * To change this template use File | Settings | File Templates.
 */
public class AttEvcctionStateUCC implements IAttEvcctionStateUCC {
    private AttEvcctionStateServcie attEvcctionStateServcie;
    public List getAllAttEvcctionRecCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String postName)throws SysException{
            return this.attEvcctionStateServcie.getAllAttEvcctionRecCollectBO(pagevo,orgId,beginTime,endTime,personValue,postName);
    }

    public AttEvcctionRecCollectBO findAttEvcctionRecCollectBOById(String evcctionCollectNo)throws SysException{
            return this.attEvcctionStateServcie.findAttEvcctionRecCollectBOById(evcctionCollectNo);
    }

    public void saveAttEvcctionRecCollectBO(AttEvcctionRecCollectBO bo)throws SysException{
            this.attEvcctionStateServcie.saveAttEvcctionRecCollectBO(bo);
    }

    public void deleteAttEvcctionRecCollectBO(String evcctionCollectNo) throws SysException{
            this.attEvcctionStateServcie.deleteAttEvcctionRecCollectBO(evcctionCollectNo);
    }


    public AttEvcctionRecBO findAttEvcctionRecBOBySuperId(String superId) throws SysException{
          return this.attEvcctionStateServcie.findAttEvcctionRecBOBySuperId(superId);
    }

    public AttEvcctionRecBO findAttEvcctionRecBOById(String evcctionNO)throws SysException{
           return this.attEvcctionStateServcie.findAttEvcctionRecBOById(evcctionNO);
    }

    public void saveAttEvcctionRecBO(AttEvcctionRecBO bo)throws SysException{
          this.attEvcctionStateServcie.saveAttEvcctionRecBO(bo);
    }

    public void deleteAttEvcctionRecBO(String evcctionNO)throws SysException{
          this.attEvcctionStateServcie.deleteAttEvcctionRecBO(evcctionNO);
    }

    public AttEvcctionStateServcie getAttEvcctionStateServcie() {
        return attEvcctionStateServcie;
    }

    public void setAttEvcctionStateServcie(AttEvcctionStateServcie attEvcctionStateServcie) {
        this.attEvcctionStateServcie = attEvcctionStateServcie;
    }
}
