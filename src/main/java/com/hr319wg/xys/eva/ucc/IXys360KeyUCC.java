package com.hr319wg.xys.eva.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyLibBO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: ÏÂÎç5:03
 * To change this template use File | Settings | File Templates.
 */
public interface IXys360KeyUCC {
    public List getXys360KeyLibBO(String superId)throws SysException;
    public Xys360KeyLibBO findXys360KeyLibBOById(String libId)throws SysException;
    public void saveXys360KeyLibBO(Xys360KeyLibBO bo)throws SysException;
    public void deleteXys360KeyLibBO(String libId)throws SysException;

    public List getXys360KeyBOByLib(PageVO pagevo,String libId)throws SysException;
    public List getXys360KeyBOByLibAndType(String libId,String keyType)throws SysException;
    public Xys360KeyBO findXys360KeyBOById(String keyId)throws SysException;
    public void saveXys360KeyBO(Xys360KeyBO bo)throws SysException;
    public void deleteXys360KeyBO(String keyId)throws SysException;
}
