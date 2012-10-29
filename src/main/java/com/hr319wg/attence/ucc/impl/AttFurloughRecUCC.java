package com.hr319wg.attence.ucc.impl;

import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttfurloughBO;
import com.hr319wg.attence.service.AttFurloughRecService;
import com.hr319wg.attence.ucc.IAttFurloughRecUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-3
 * Time: ÏÂÎç4:33
 * To change this template use File | Settings | File Templates.
 */
public class AttFurloughRecUCC implements IAttFurloughRecUCC{
     private AttFurloughRecService attFurloughRecService;

     public List getAllAttfurloughBO()throws SysException{
         return this.attFurloughRecService.getAllAttfurloughBO();
     }

     public AttfurloughBO findAttfurloughBOById(String flID)throws SysException{
         return this.attFurloughRecService.findAttfurloughBOById(flID);
     }

     public void saveAttfurloughBO(AttfurloughBO bo)throws SysException{
         this.attFurloughRecService.saveAttfurloughBO(bo);
     }

     public void deleteAttfurloughBO(String flID)throws SysException{
          this.attFurloughRecService.deleteAttfurloughBO(flID);
     }


     public List getAllAttFurloughRecCollectBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type,String postName)throws SysException{
         return this.attFurloughRecService.getAllAttFurloughRecCollectBO(pagevo,orgId,beginTime,endTime,personValue,type,postName);
     }

     public AttFurloughRecCollectBO findAttFurloughRecCollectBOById(String furloughCollectNO)throws SysException{
         return this.attFurloughRecService.findAttFurloughRecCollectBOById(furloughCollectNO);
     }

     public void saveAttFurloughRecCollectBO(AttFurloughRecCollectBO bo)throws SysException{
         this.attFurloughRecService.saveAttFurloughRecCollectBO(bo);
     }

     public void deleteAttFurloughRecCollectBO(String furloughCollectNO)throws SysException{
         this.attFurloughRecService.deleteAttFurloughRecCollectBO(furloughCollectNO);
     }

     public List getAllAttFurloughRecBO(PageVO pagevo,String orgId,String beginTime,String endTime,String personValue,String type)throws SysException{
         return this.attFurloughRecService.getAllAttFurloughRecBO(pagevo,orgId,beginTime,endTime,personValue,type);
     }

     public AttFurloughRecBO findAttFurloughRecBOById(String furloughNO)throws SysException{
         return this.attFurloughRecService.findAttFurloughRecBOById(furloughNO);
     }

     public AttFurloughRecBO findAttFurlouoghRecBOBySuperId(String superFurloughNo)throws SysException{
         return this.attFurloughRecService.findAttFurlouoghRecBOBySuperId(superFurloughNo);
     }

     public void saveAttFurloughRecBO(AttFurloughRecBO bo)throws SysException{
         this.attFurloughRecService.saveAttFurloughRecBO(bo);
     }

     public void deleteAttFurloughRecBO(String furloughNO)throws SysException{
         this.attFurloughRecService.deleteAttFurloughRecBO(furloughNO);
     }

     public AttFurloughRecService getAttFurloughRecService() {
        return attFurloughRecService;
    }

    public void setAttFurloughRecService(AttFurloughRecService attFurloughRecService) {
        this.attFurloughRecService = attFurloughRecService;
    }

}
