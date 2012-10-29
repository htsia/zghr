package com.hr319wg.attence.ucc;

import com.hr319wg.attence.pojo.bo.AttRestChangeBO;
import com.hr319wg.attence.pojo.bo.AttRestStoreBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-2-1
 * Time: ÏÂÎç2:00
 * To change this template use File | Settings | File Templates.
 */
public interface IAttRestChgUCC {
    public List getAllAttRestStoreBO(PageVO pagevo,String begin,String end,String orgId,String queryValue)throws SysException;

    public List getAttRestStoreBOByPid(PageVO pagevo,String personId)throws SysException;

    public AttRestStoreBO findAttRestStoreBOById(String storeId)throws SysException;

    public void saveAttRestStoreBO(AttRestStoreBO bo)throws SysException;

    public void deleteAttRestStoreBO(String storeId)throws SysException;

    public void saveAttRestStoreBOByRestAndPid(String orgId, String begin, String end, String personId, String itemId, String type) throws SysException;

    public List getAllAttRestChangeBO(PageVO pagevo,String begin,String end,String orgId,String queryValue)throws SysException;

    public List getAttRestChangeBOByPid(PageVO pagevo,String personId)throws SysException;

    public List getAttRestChangeBOByStoreId(String storeId)throws SysException;

    public AttRestChangeBO findAttRestChangeBOById(String chgId)throws SysException;

    public void saveAttRestChangeBO(AttRestChangeBO bo)throws SysException;

    public void deleteAttRestChangeBO(String chgId)throws SysException;
}
