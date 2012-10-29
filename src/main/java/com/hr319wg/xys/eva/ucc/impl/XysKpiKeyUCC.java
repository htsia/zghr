package com.hr319wg.xys.eva.ucc.impl;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyLibBO;
import com.hr319wg.xys.eva.service.XysKpiKeyService;
import com.hr319wg.xys.eva.ucc.IXysKpiKeyUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-9
 * Time: ÏÂÎç5:53
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiKeyUCC implements IXysKpiKeyUCC{
    private XysKpiKeyService xysKpiKeyService;

    public List getXysKpiKeyLibBOByPostId(String postId)throws SysException{
        return xysKpiKeyService.getXysKpiKeyLibBOByPostId(postId);
    }
    public XysKpiKeyLibBO findXysKpiKeyLibBOById(String libId)throws SysException{
        return xysKpiKeyService.findXysKpiKeyLibBOById(libId);
    }
    public void saveXysKpiKeyLibBO(XysKpiKeyLibBO bo)throws SysException{
        xysKpiKeyService.saveXysKpiKeyLibBO(bo);
    }
    public void deleteXysKpiKeyLibBO(String libId)throws SysException{
        xysKpiKeyService.deleteXysKpiKeyLibBO(libId);
    }

    public List getXysKpiKeyBOByLibId(String libId)throws SysException{
        return xysKpiKeyService.getXysKpiKeyBOByLibId(libId);
    }
    public List getXysKpiKeyBOByPostId(String postId)throws SysException{
        return xysKpiKeyService.getXysKpiKeyBOByPostId(postId);
    }
    public XysKpiKeyBO findXysKpiKeyBOById(String keyId)throws SysException{
        return xysKpiKeyService.findXysKpiKeyBOById(keyId);
    }
    public void saveXysKpiKeyBO(XysKpiKeyBO bo)throws SysException{
        xysKpiKeyService.saveXysKpiKeyBO(bo);
    }
    public void deleteXysKpiKeyBO(String keyId)throws SysException{
        xysKpiKeyService.deleteXysKpiKeyBO(keyId);
    }


    public String findPostIdByPostNameByDeptName(String deptName,String postName)throws SysException{
        return xysKpiKeyService.findPostIdByPostNameByDeptName(deptName,postName);
    }

    public XysKpiKeyService getXysKpiKeyService() {
        return xysKpiKeyService;
    }

    public void setXysKpiKeyService(XysKpiKeyService xysKpiKeyService) {
        this.xysKpiKeyService = xysKpiKeyService;
    }
}
