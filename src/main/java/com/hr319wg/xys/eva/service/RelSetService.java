package com.hr319wg.xys.eva.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.dao.RelSetDAO;
import com.hr319wg.xys.eva.pojo.bo.EvaRelBO;
import com.hr319wg.xys.eva.pojo.bo.XysPostRoleRelBO;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-25
 * Time: ÏÂÎç11:01
 * To change this template use File | Settings | File Templates.
 */
public class RelSetService {
    private RelSetDAO relSetDAO;
    private ActivePageAPI activePageAPI;

    public List getAllPostBOByOrgId(PageVO pagevo,String orgId)throws SysException{
        return this.relSetDAO.getAllPostBOByOrgId(pagevo,orgId);
    }
    public List getAllSuperPostByPostId(String postId)throws SysException{
        String sql="select C001040,C001041,C001042,C001043 from C001 where POSTID='"+postId+"'";
        CellVO[] cv=new CellVO[4];
        cv[0]=new CellVO();
        cv[0].setItemId("C001040");
        cv[1]=new CellVO();
        cv[1].setItemId("C001041");
        cv[2]=new CellVO();
        cv[2].setItemId("C001042");
        cv[3]=new CellVO();
        cv[3].setItemId("C001043");
        Vector rs=activePageAPI.getDataListBySql(cv,sql);
        List list=new ArrayList();
        if(rs!=null&&rs.size()>0){
             CellVO row[]=(CellVO[])rs.get(0);
             list.add(CommonFuns.filterNull(row[0].getValue()));
             list.add(CommonFuns.filterNull(row[1].getValue()));
             list.add(CommonFuns.filterNull(row[2].getValue()));
             list.add(CommonFuns.filterNull(row[3].getValue()));
        }
        return list;
    }
    public List getBranchPostRelByPostId(String postId)throws SysException{
        return this.relSetDAO.getBranchPostRelByPostId(postId);
    }

    public List getAllEvaRelBOByPostId(String postId)throws SysException{
        return this.relSetDAO.getAllEvaRelBOByPostId(postId);
    }
    public EvaRelBO findEqualsEvaRelBO(String postId,String evaPostId)throws SysException{
        return this.relSetDAO.findEqualsEvaRelBO(postId,evaPostId);
    }
    public EvaRelBO findEvaRelBOById(String relId)throws SysException{
        return (EvaRelBO)this.relSetDAO.findBoById(EvaRelBO.class,relId);
    }
    public void saveEvaRelBO(EvaRelBO bo)throws SysException{
        this.relSetDAO.saveOrUpdateBo(bo);
    }
    public void deleteEvaRelBO(String relId)throws SysException{
        this.relSetDAO.deleteBo(EvaRelBO.class,relId);
    }
    
    public XysPostRoleRelBO findXysPostRoleRelBOByPostId(String postId)throws SysException{
    	return this.relSetDAO.findXysPostRoleRelBOByPostId(postId);
    }
    public void saveXysPostRoleRelBO(XysPostRoleRelBO bo)throws SysException{
    	this.relSetDAO.saveOrUpdateBo(bo);
    }
    public Hashtable getAllXysPostRoleRelBOForMap()throws SysException{
    	return this.relSetDAO.getAllXysPostRoleRelBOForMap();
    }
    public List getXysPostRoleRelBOByRoleId(String roleId)throws SysException{
    	return this.relSetDAO.getXysPostRoleRelBOByRoleId(roleId);
    }

    public ActivePageAPI getActivePageAPI() {
        return activePageAPI;
    }

    public void setActivePageAPI(ActivePageAPI activePageAPI) {
        this.activePageAPI = activePageAPI;
    }

    public RelSetDAO getRelSetDAO() {
        return relSetDAO;
    }

    public void setRelSetDAO(RelSetDAO relSetDAO) {
        this.relSetDAO = relSetDAO;
    }
}
