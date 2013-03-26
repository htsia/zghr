package com.hr319wg.rpt.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.rpt.pojo.bo.RptDataBO;
import com.hr319wg.rpt.pojo.bo.RptGroupBO;
import com.hr319wg.rpt.pojo.bo.RptGroupDirBO;
import com.hr319wg.rpt.pojo.bo.RptGroupItemBO;
import com.hr319wg.rpt.pojo.bo.RptSetBO;
import com.hr319wg.rpt.pojo.bo.RptSetItemBO;

public class RptInfoDAO extends BaseDAO
{
  public List getRptClassBOS(String prptcode)
    throws SysException
  {
    String hsql = "";
    if ("-1".equals(prptcode)) {
      hsql = "select  bo from RptClassBO  bo where bo.prptcode='-1'";
      return this.hibernatetemplate.find(hsql);
    }
    hsql = "select  bo from RptClassBO  bo where bo.prptcode='" + prptcode + "'";

    return this.hibernatetemplate.find(hsql);
  }

  public List getRptClassBOSS(String prptcode) throws SysException
  {
    String hsql = "";
    if ("-1".equals(prptcode)) {
      hsql = "select  bo from RptClassBO  bo where bo.prptcode='-1' and bo.type='0'";
      return this.hibernatetemplate.find(hsql);
    }
    hsql = "select  bo from RptClassBO  bo where bo.prptcode='" + prptcode + "' and bo.type='0'";

    return this.hibernatetemplate.find(hsql);
  }

  public List getRptClassBOSSS(PageVO pagevo, String rptcode)
    throws SysException
  {
    String hsql = "select  bo from RptClassBO  bo where bo.prptcode='" + rptcode + "' and bo.type='1'";

    String countsql = "select  count(bo)  from RptClassBO  bo where bo.prptcode='" + rptcode + "' and bo.type='1'";

    return pageQuery(pagevo, countsql, hsql);
  }

  public List getUserRptBO(String roleID, String operateID) throws SysException
  {
    String hsql = "select  bo from UserRptBO  bo where bo.roleID='" + roleID + "' and bo.operateID='" + operateID + "' order by bo.showQue";

    return this.hibernatetemplate.find(hsql);
  }

  public List getUserRptBO1(String roleID, String operateID, String rptCode) throws SysException
  {
    String hsql = "select bo from UserRptBO  bo where bo.roleID='" + roleID + "' and bo.operateID='" + operateID + "' and bo.rptCode='" + rptCode + "'";
    return this.hibernatetemplate.find(hsql);
  }

  public List getRptStaticInfo(String orguid) throws SysException {
    String hsql = "select  bo from RptDataBO bo where bo.orguid='" + orguid + "'";

    return this.hibernatetemplate.find(hsql);
  }

  public RptDataBO getRptStaticInfo(String orguid, String rptcode) throws SysException
  {
    String hsql = "select  bo from RptDataBO bo where bo.orguid='" + orguid + "' and bo.rptcode='" + rptcode + "'";

    List list = this.hibernatetemplate.find(hsql);
    if ((list != null) && (list.size() > 0)) {
      return (RptDataBO)list.get(0);
    }
    return null;
  }

  public List getRptSetBOList()
    throws SysException
  {
    String hsql = "from RptSetBO";
    return findAll(hsql);
  }

  public List getRptSetItemBOList(PageVO mypage, String rptSetId) throws SysException {
    String hsql = "select  bo from RptSetItemBO  bo where bo.setId = '" + rptSetId + "'";

    String countsql = "select  count(bo)  from RptSetItemBO  bo where bo.setId= '" + rptSetId + "' ";

    return pageQuery(mypage, countsql, hsql);
  }

  public void deleteRptSetItems(String[] itemArr)
  {
    RptSetItemBO tmetmepBOpBO = null;
    if ((itemArr != null) && (itemArr.length > 0))
      for (int i = 0; i < itemArr.length; i++) {
        tmetmepBOpBO = new RptSetItemBO();
        tmetmepBOpBO.setItemId(itemArr[i]);
        getHibernatetemplate().delete(tmetmepBOpBO);
      }
  }

  public void deleteRptSetBO(RptSetBO repSetBO)
  {
    if ((repSetBO.getSetId() != null) && (!"".equals(repSetBO.getSetId()))) {
      String hqls = "from RptSetItemBO bo where bo.setId = '" + repSetBO.getSetId() + "'";

      List tempList = getHibernatetemplate().find(hqls);
      RptSetItemBO rptSetItme = null;
      if ((tempList != null) && (tempList.size() > 0)) {
        for (int i = 0; i < tempList.size(); i++) {
          rptSetItme = (RptSetItemBO)tempList.get(i);
          this.hibernatetemplate.delete(rptSetItme);
        }
      }
      getHibernatetemplate().delete(repSetBO);
    }
  }

  public void saveOrUpdateRptSetItem(RptSetItemBO repSetBO)
    throws SysException
  {
    String hql = "from RptSetItemBO bo where bo.rptCode = '" + repSetBO.getRptCode() + "'and bo.setId = '" + repSetBO.getSetId() + "'";

    List rptItem = findAll(hql);
    if ((rptItem != null) && 
      (rptItem.size() == 0))
      saveOrUpdateBo(repSetBO);
  }

  public List getRptGroupDefineList()
  {
    String hsql = "from RptGroupBO";
    return findAll(hsql);
  }

  public List getRptGroupDirList(String superId, String parentGroupId) {
    List list = null;
    String hsql = "";
    if ("-1".equals(superId)) {
      hsql = "select  bo from RptGroupDirBO bo where bo.parentId = '" + superId + "' and bo.groupId = '" + parentGroupId + "'";

      list = this.hibernatetemplate.find(hsql);
    } else if (superId != null) {
      hsql = "select  bo from RptGroupDirBO  bo where bo.parentId='" + superId + "'";

      list = this.hibernatetemplate.find(hsql);
    } else if ((superId != null) && (parentGroupId == null)) {
      hsql = "select  bo from RptGroupDirBO bo where bo.parentId = '-1'";
      list = this.hibernatetemplate.find(hsql);
    }
    return list;
  }

  public List getRptGroupDirList(String superId) {
    String hsql = "";
    List list = null;
    if ("-1".equals(superId)) {
      hsql = "select  bo from RptGroupDirBO bo where bo.parentId = '-1'";
      list = this.hibernatetemplate.find(hsql);
    } else {
      hsql = "select  bo from RptGroupDirBO  bo  where bo.parentId='" + superId + "'";

      list = this.hibernatetemplate.find(hsql);
    }
    return list;
  }

  public List getGroupItemBOList(String groupDirId) throws SysException
  {
    String hsql = "select  bo from RptGroupItemBO  bo where bo.dirId = '" + groupDirId + "'";
    return this.hibernatetemplate.find(hsql);
  }

  public void deleteRptGroupBO(RptGroupBO rptGroupBO)
  {
    if ((rptGroupBO.getGroupId() != null) && (!"".equals(rptGroupBO.getGroupId())))
    {
      String hqls = "from RptGroupDirBO bo where bo.groupId = '" + rptGroupBO.getGroupId() + "'";

      List dirBOList = getHibernatetemplate().find(hqls);
      RptGroupDirBO dirBO = null;
      if ((dirBOList != null) && (dirBOList.size() > 0)) {
        for (int i = 0; i < dirBOList.size(); i++) {
          dirBO = (RptGroupDirBO)dirBOList.get(i);
          hqls = "from RptGroupItemBO  bo where bo.dirId = '" + dirBO.getDirId() + "'";

          List itemBOList = getHibernatetemplate().find(hqls);
          RptGroupItemBO itemBO = null;
          if ((itemBOList != null) && (itemBOList.size() > 0)) {
            for (int j = 0; j < itemBOList.size(); j++) {
              itemBO = (RptGroupItemBO)itemBOList.get(j);
              this.hibernatetemplate.delete(itemBO);
            }
          }
          this.hibernatetemplate.delete(dirBO);
        }
      }
      getHibernatetemplate().delete(rptGroupBO);
    }
  }

  public void deleteRptGroupDirBO(String rptGroupDirId) throws SysException
  {
    if ((rptGroupDirId != null) && (!"".equals(rptGroupDirId))) {
      String hqls = "from RptGroupItemBO bo where bo.dirId = '" + rptGroupDirId + "'";

      List dirBOList = getHibernatetemplate().find(hqls);
      RptGroupItemBO itemBO = null;
      if ((dirBOList != null) && (dirBOList.size() > 0)) {
        for (int i = 0; i < dirBOList.size(); i++) {
          itemBO = (RptGroupItemBO)dirBOList.get(i);
          this.hibernatetemplate.delete(itemBO);
        }
      }
      deleteBo(RptGroupDirBO.class, rptGroupDirId);
    }
  }

  public List getRptSetItemBOList(String rptSetId)
  {
    String hsql = "select  bo from RptSetItemBO  bo where bo.setId = '" + rptSetId + "'";
    return this.hibernatetemplate.find(hsql);
  }

  public List getGroupList() {
    String hsql = "from RptGroupBO";
    return findAll(hsql);
  }

  public String getOrgIdBySetId(String setID) {
    String hqls = "select  bo.orguId  from RptGroupDirBO bo where bo.dirId = (select po.groupId from RptSetBO po where po.setId = '" + setID + "' )";
    List list = findAll(hqls);
    String orgId = "";
    if ((list != null) && (list.size() > 0)) {
      orgId = (String)list.get(0);
    }
    return orgId;
  }
}