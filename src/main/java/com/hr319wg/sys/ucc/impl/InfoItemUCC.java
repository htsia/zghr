package com.hr319wg.sys.ucc.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemRefBO;
import com.hr319wg.sys.pojo.bo.OrgCodeRelationBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.service.InfoItemService;
import com.hr319wg.sys.ucc.IInfoItemUCC;
import com.hr319wg.user.pojo.bo.RoleDataBO;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.service.RoleDataService;
import com.hr319wg.user.service.UserManageService;
import com.hr319wg.util.CommonFuns;

public class InfoItemUCC
  implements IInfoItemUCC
{
  private InfoItemService infoitemservice;
  private UserManageService usermanageservice;
  private RoleDataService roledataservice;
  private WageAPI wageapi;
  private ActivePageAPI activeapi;

  public WageAPI getWageapi()
  {
    return this.wageapi;
  }

  public void setWageapi(WageAPI wageapi) {
    this.wageapi = wageapi;
  }

  public ActivePageAPI getActiveapi() {
    return this.activeapi;
  }

  public void setActiveapi(ActivePageAPI activeapi) {
    this.activeapi = activeapi;
  }

  public UserManageService getUsermanageservice()
  {
    return this.usermanageservice;
  }
  public void setUsermanageservice(UserManageService usermanageservice) {
    this.usermanageservice = usermanageservice;
  }

  public RoleDataService getRoledataservice() {
    return this.roledataservice;
  }
  public void setRoledataservice(RoleDataService roledataservice) {
    this.roledataservice = roledataservice;
  }

  public InfoItemService getInfoitemservice()
  {
    return this.infoitemservice;
  }
  public void setInfoitemservice(InfoItemService infoitemservice) {
    this.infoitemservice = infoitemservice;
  }

  public void createInfoItem(InfoItemBO infoItem, String userId)
    throws SysException
  {
    this.infoitemservice.createInfoItem(infoItem);
    String len = infoItem.getItemDataLength();
    if ((len == null) || (len.equals(""))) {
      len = "100";
    }
    this.wageapi.createOrDelWageInfoItem(infoItem.getSetId(), infoItem.getItemId(), len, "add");

    List lst = this.usermanageservice.queryUserRole(userId);
    if ((lst != null) && (lst.size() > 0)) {
      RoleInfoBO rbo = (RoleInfoBO)lst.get(0);
      String roleId = rbo.getRoleId();
      RoleDataBO rdbo = new RoleDataBO();
      rdbo.setDataId(infoItem.getItemId());
      rdbo.setDataType("1");
      rdbo.setPmsType("3");
      rdbo.setRoleId(roleId);
      this.roledataservice.createRoleData(rdbo);
    }

    if (("ORACLE".equals(Constants.DB_TYPE)) && ("A001".equals(infoItem.getSetId())))
      compileView();
  }

  public void updateInfoItem(InfoItemBO infoItem)
    throws SysException
  {
    try
    {
      this.infoitemservice.updateInfoItem(infoItem);
    } catch (SysException e) {
      throw new RollbackableException("", "更改失败", e, getClass());
    }
  }

  private void compileView() throws SysException {
    String sql = "CREATE OR REPLACE VIEW EMP_INFO AS SELECT A001.*,A795705,A795708,A795710,A795715,A795718,A795701,A795720,A795725, A795730,A795735,A705705,A705708,A705718,A080720,A080721,A080735,A080725,A080715,A080710,A080705,A708703,A090700,A090701,A090702,A090703 FROM A001 left join A090 on A001.id=A090.id left join A795 ON A001.ID = A795.ID left join A705 ON A001.ID = A705.ID AND A705000 = '00901' left join A080 on A080.id=A001.id left join A708 on A001.id=A708.id";
    this.activeapi.executeSql(sql);
  }

  public void deleteInfoItems(String setId, String[] itemIds, String userId) throws SysException
  {
    try {
      boolean haveA001 = false;
      String sql = "";
      this.infoitemservice.deleteInfoItems(setId, itemIds);

      for (int i = 0; i < itemIds.length; i++) {
        this.wageapi.createOrDelWageInfoItem(setId, itemIds[i], "0", "del");

        sql = "delete from sys_role_data where data_id='" + itemIds[i] + "'";
        this.activeapi.executeSql(sql);

        sql = "delete from qry_query_item where item_id='" + itemIds[i] + "'";
        this.activeapi.executeSql(sql);

        if (itemIds[i].startsWith("A001")) {
          haveA001 = true;
        }
      }
      if (("ORACLE".equals(Constants.DB_TYPE)) && (haveA001))
        compileView();
    }
    catch (Exception e) {
      throw new RollbackableException("", "删除失败", e, getClass());
    }
  }

  public InfoItemBO findInfoItem(String setId, String infoItemId)
    throws SysException
  {
    return this.infoitemservice.findInfoItem(setId, infoItemId);
  }
  public InfoItemBO[] queryInfoItems(String setId, String order) throws SysException {
    return this.infoitemservice.queryInfoItems(setId, order);
  }
  public List getCellVOList(User user, String setId) throws SysException {
    return getCellVOList(user, setId, "");
  }
  public List getCellVOList(User user, String setId, String order) throws SysException {
    InfoItemBO[] items = this.infoitemservice.queryInfoItems(setId, order);
    UserAPI pmsapi = new UserAPI();
    if ((items != null) && (items.length > 0))
    {
      List list = new ArrayList();
      for (int i = 0; i < items.length; i++) {
        CellVO cell = new CellVO();
        CommonFuns.copyProperties(cell, items[i]);
        cell.setPermission(pmsapi.checkInfoSet(user, cell.getSetId()));
        if (cell.getPermission() != 1) {
          cell.setItemDataType(InfoItemBO.getDataTypeCnName(cell.getItemDataType()));
          if (InfoItemBO.IS_NOTNULL.equals(cell.getItemNotNull()))
            cell.setItemNotNull("是");
          else {
            cell.setItemNotNull("否");
          }
          if ("1".equals(cell.getItemMust())) {
            cell.setItemStatus("<font color=blue>必用</font>");
          }
          else if (!InfoItemBO.STATUS_OPEN.equals(cell.getItemStatus()))
            cell.setItemStatus("<font color=red>禁用</font>");
          else {
            cell.setItemStatus("启用");
          }

          if ((cell.getPermission() == 2) || ("14".equals(cell.getItemDataType()))) {
            cell.setUpdateButtonDisabled(true);
            cell.setCheckReadOnly("disabled />");
          } else {
            cell.setUpdateButtonDisabled(false);
            cell.setCheckReadOnly("/>");
          }

          String itemType=items[i].getItemClass();
          if ("1".equals(itemType)){
            cell.setItemScaleName("<font color=green>国标</font>");
          }else if ("2".equals(itemType)){
            cell.setItemScaleName("<font color=red>系统</font>");
          }else {
            cell.setItemScaleName("用户");
          }
          list.add(cell);
        }
      }
      return list;
    }
    return null;
  }

  public void makeStatus(String setId, String[] itemIds, boolean status)
    throws SysException
  {
    try
    {
      for (int i = 0; i < itemIds.length; i++)
        this.infoitemservice.makeStatus(setId, itemIds[i], status);
    }
    catch (Exception e) {
      throw new RollbackableException("", "", e, getClass());
    }
  }

  public void issueInfoItem(String infoItemID)
  {
  }

  public String getNewItemId(String setId)
    throws SysException
  {
    return this.infoitemservice.getNewItemId(setId);
  }

  public String checkAllowDelete(String[] itemIds)
    throws SysException
  {
    String rtnValue = "";

    for (int i = 0; i < itemIds.length; i++) {
      if (this.wageapi.checkUsingWageInfoSet(itemIds[i])) {
        InfoItemBO item = SysCacheTool.findInfoItem(itemIds[i].substring(0, 4), itemIds[i]);
        if (item != null) {
          if ("".equals(rtnValue))
            rtnValue = "{" + item.getItemName() + "}";
          else
            rtnValue = rtnValue + ",{" + item.getItemName() + "}";
        }
      }
    }
    if (!"".equals(rtnValue)) {
      rtnValue = "指标项" + rtnValue + "已经被薪资模块使用.";
      return rtnValue;
    }

    for (int i = 0; i < itemIds.length; i++) {
      InfoItemBO item = SysCacheTool.findInfoItem(itemIds[i].substring(0, 4), itemIds[i]);
      if ("1".equals(item.getItemClass())) {
        if ("".equals(rtnValue)){
          rtnValue = "{" + item.getItemName() + "}";
        }else{
          rtnValue = rtnValue + ",{" + item.getItemName() + "}";
        }
      }
    }
    if (!"".equals(rtnValue)) {
      rtnValue = "指标项" + rtnValue + "属于国标范围.";
      return rtnValue;
    }

    for (int i = 0; i < itemIds.length; i++) {
      String id = itemIds[i].substring(4, 7);
      InfoItemBO item = SysCacheTool.findInfoItem(itemIds[i].substring(0, 4), itemIds[i]);
      if ("2".equals(item.getItemClass())) {
        if ("".equals(rtnValue)){
          rtnValue = "{" + item.getItemName() + "}";
        }else{
          rtnValue = rtnValue + ",{" + item.getItemName() + "}";
        }
      }
    }
    if (!"".equals(rtnValue)) {
      rtnValue = "指标项" + rtnValue + "属于系统使用指标集.";
      return rtnValue;
    }
    return rtnValue;
  }
  public InfoItemRefBO getInfoItemRefBO(String itemID) throws SysException {
    return this.infoitemservice.getInfoItemRefBO(itemID);
  }
  public void saveInfoItemRefBO(InfoItemRefBO bo) throws SysException {
    this.infoitemservice.saveInfoItemRefBO(bo);
  }
  public void deleteInfoItemRefBO(String itemID) throws SysException {
    this.infoitemservice.deleteInfoItemRefBO(itemID);
  }

  public void calcA001704() throws SysException {
    String sql = "select distinct A001705 as A001705 from A001";
    CellVO[] head = new CellVO[1];
    head[0] = new CellVO();
    head[0].setItemId("A001705");
    Vector vt = this.activeapi.getDataListBySql(head, sql);
    for (int i = 0; i < vt.size(); i++) {
      CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
      String dept = row[0].getValue();
      OrgBO deptBO = SysCacheTool.findOrgById(dept);
      OrgBO superBO = SysCacheTool.findOrgById(deptBO.getSuperId());
      if ((superBO != null) && (OrgBO.DEPTTYPE.equals(superBO.getorgType()))) {
        sql = "update A001 set A001704='" + superBO.getOrgId() + "' where A001705='" + dept + "'";
      }
      else {
        sql = "update A001 set A001704='" + dept + "' where A001705='" + dept + "'";
      }
      this.activeapi.executeSql(sql);
    }
  }

  public void calcA001703() throws SysException {
    String sql = "select distinct A001705 as A001705 from A001";
    CellVO[] head = new CellVO[1];
    head[0] = new CellVO();
    head[0].setItemId("A001705");
    Vector vt = this.activeapi.getDataListBySql(head, sql);
    for (int i = 0; i < vt.size(); i++) {
      CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
      String dept = row[0].getValue();
      OrgBO deptBO = SysCacheTool.findOrgById(dept);
      OrgBO superBO = SysCacheTool.findOrgById(deptBO.getSuperId());
      sql = "update A001 set A001703='" + dept + "' where A001705='" + dept + "'";
      if ((superBO != null) && (OrgBO.DEPTTYPE.equals(superBO.getorgType()))) {
        OrgBO superSuperBO = SysCacheTool.findOrgById(superBO.getSuperId());
        if ((superSuperBO != null) && (OrgBO.DEPTTYPE.equals(superSuperBO.getorgType()))) {
          sql = "update A001 set A001703='" + superSuperBO.getOrgId() + "' where A001705='" + dept + "'";
        }
      }
      this.activeapi.executeSql(sql);
    }
  }

  public void synRefRelation(String itemId) throws SysException
  {
    InfoItemRefBO ref = getInfoItemRefBO(itemId);
    if (ref != null)
      this.activeapi.executeSql(ref.getSQL());
  }

  public void setItemReadOlny(String itemId, boolean b) throws SysException {
    String itemProperty = b ? "2" : "4";
    String sql = "update sys_info_item set item_property='" + itemProperty + "' where item_id='" + itemId + "'";
    this.activeapi.executeSql(sql);
    String[] id = new String[1];
    id[0] = itemId;
    SysCache.setMap(id, 3, 4);
  }
  public OrgCodeRelationBO getOrgCodeRelationBO(String orgID, String codeID) throws SysException {
    return this.infoitemservice.getOrgCodeRelationBO(orgID, codeID);
  }
}