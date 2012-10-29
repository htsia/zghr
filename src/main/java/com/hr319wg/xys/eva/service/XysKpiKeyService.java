package com.hr319wg.xys.eva.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.xys.eva.dao.XysKpiKeyDAO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyLibBO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-9
 * Time: ÏÂÎç5:42
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiKeyService {
    private XysKpiKeyDAO xysKpiKeyDAO;
    private ActivePageAPI activePageAPI;

    public List getXysKpiKeyLibBOByPostId(String postId)throws SysException{
         return xysKpiKeyDAO.getXysKpiKeyLibBOByPostId(postId);
    }
    public XysKpiKeyLibBO findXysKpiKeyLibBOById(String libId)throws SysException{
        return (XysKpiKeyLibBO)xysKpiKeyDAO.findBoById(XysKpiKeyLibBO.class,libId);
    }
    public void saveXysKpiKeyLibBO(XysKpiKeyLibBO bo)throws SysException{
        xysKpiKeyDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysKpiKeyLibBO(String libId)throws SysException{
        xysKpiKeyDAO.deleteBo(XysKpiKeyLibBO.class,libId);
    }


    public List getXysKpiKeyBOByLibId(String libId)throws SysException{
         return xysKpiKeyDAO.getXysKpiKeyBOByLibId(libId);
    }
    public List getXysKpiKeyBOByPostId(String postId)throws SysException{
         return xysKpiKeyDAO.getXysKpiKeyBOByPostId(postId);
    }
    public XysKpiKeyBO  findXysKpiKeyBOById(String keyId)throws SysException{
        return (XysKpiKeyBO)xysKpiKeyDAO.findBoById(XysKpiKeyBO.class,keyId);
    }
    public void saveXysKpiKeyBO(XysKpiKeyBO bo)throws SysException{
        xysKpiKeyDAO.saveOrUpdateBo(bo);
    }
    public void deleteXysKpiKeyBO(String keyId)throws SysException{
        xysKpiKeyDAO.deleteBo(XysKpiKeyBO.class,keyId);
    }

    public String findPostIdByPostNameByDeptName(String deptName,String postName)throws SysException{
        String hql="select postId from C001 where C001005 ='"+postName+"' and C001010 in(select orgUid from B001 where B001005 like '%"+deptName+"%')";
        System.out.println("hql="+hql);
        return activePageAPI.queryForString(hql);
    }


    public XysKpiKeyDAO getXysKpiKeyDAO() {
        return xysKpiKeyDAO;
    }

    public void setXysKpiKeyDAO(XysKpiKeyDAO xysKpiKeyDAO) {
        this.xysKpiKeyDAO = xysKpiKeyDAO;
    }

    public ActivePageAPI getActivePageAPI() {
        return activePageAPI;
    }

    public void setActivePageAPI(ActivePageAPI activePageAPI) {
        this.activePageAPI = activePageAPI;
    }
}
