package com.hr319wg.train.ucc.impl;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.train.pojo.bo.CourceWareItemBO;
import com.hr319wg.train.pojo.bo.CourceWareTypeBO;
import com.hr319wg.train.service.CourceWareService;
import com.hr319wg.train.ucc.ICourceWareUCC;

public class CourceWareUCCImpl
  implements ICourceWareUCC
{
  private CourceWareService courcewareservice;
  private ActivePageAPI activeapi;

  public List getAllPrivateCourceItem(String orgId)
    throws SysException
  {
    return this.courcewareservice.getAllPrivateCourceItem(orgId);
  }
  public List getAllValidItemInfo(String orgid) throws SysException {
    return this.courcewareservice.getAllValidItemInfo(orgid);
  }
  public List getAllItemInfo(String orgid) throws SysException {
    return this.courcewareservice.getAllItemInfo(orgid);
  }
  public List getAllChildType(String typeid) throws SysException {
    return this.courcewareservice.getAllChildType(typeid);
  }
  public List getAllFileInfoByType(String typeid) throws SysException {
    return this.courcewareservice.getAllFileInfoByType(typeid);
  }
  public List getAllFileInfoByType(String typeid, User user) throws SysException {
    return this.courcewareservice.getAllFileInfoByType(typeid, user);
  }

  public void DeleteType(String id) throws SysException {
    this.courcewareservice.DeleteType(id);
  }
  public void DeleteItem(String id) throws SysException {
    this.courcewareservice.DeleteItem(id);
  }
  public CourceWareTypeBO getTypeBO(String id) throws SysException {
    return this.courcewareservice.getTypeBO(id);
  }
  public CourceWareItemBO getItemBO(String id) throws SysException {
    return this.courcewareservice.getItemBO(id);
  }

  public void saveType(CourceWareTypeBO bo) throws SysException {
    this.courcewareservice.saveType(bo);
  }
  public void saveItem(CourceWareItemBO bo) throws SysException {
    this.courcewareservice.saveItem(bo);
  }

  public ActivePageAPI getActiveapi() {
    return this.activeapi;
  }
  public void setActiveapi(ActivePageAPI api) {
    this.activeapi = api;
  }
  public boolean checkHaveChild(String typeid) throws SysException {
    String sql = "select count(*) from train_courcewareitem where type_id='" + typeid + "'";
    return this.activeapi.queryForInt(sql) > 0;
  }

  public CourceWareService getCourcewareservice() {
    return this.courcewareservice;
  }
  public void setCourcewareservice(CourceWareService service) {
    this.courcewareservice = service;
  }
}