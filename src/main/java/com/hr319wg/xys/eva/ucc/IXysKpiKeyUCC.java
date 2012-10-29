package com.hr319wg.xys.eva.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyLibBO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-9
 * Time: ÏÂÎç5:50
 * To change this template use File | Settings | File Templates.
 */
public interface IXysKpiKeyUCC {
    public List getXysKpiKeyLibBOByPostId(String postId)throws SysException;
    public XysKpiKeyLibBO findXysKpiKeyLibBOById(String libId)throws SysException;
    public void saveXysKpiKeyLibBO(XysKpiKeyLibBO bo)throws SysException;
    public void deleteXysKpiKeyLibBO(String libId)throws SysException;

    public List getXysKpiKeyBOByLibId(String libId)throws SysException;
    public List getXysKpiKeyBOByPostId(String postId)throws SysException;
    public XysKpiKeyBO findXysKpiKeyBOById(String keyId)throws SysException;
    public void saveXysKpiKeyBO(XysKpiKeyBO bo)throws SysException;
    public void deleteXysKpiKeyBO(String keyId)throws SysException;

    public String findPostIdByPostNameByDeptName(String deptName,String postName)throws SysException;
}
