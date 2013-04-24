package com.hr319wg.train.dao;

import java.util.List;

import org.activiti.engine.impl.persistence.entity.UserManager;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class CourceWareDAO extends BaseDAO
{
  public List getAllValidItemInfo(String orgid)
    throws SysException
  {
    String today = CommonFuns.getSysDate("yyyy-MM-dd");
    String sql = "select bo from CourceWareItemBO bo where (bo.orgID='" + orgid + "' or bo.orgID='-1') and bo.publicFlag='1' and bo.startDate<='" + today + "' and bo.endDate>'" + today + "' order by bo.createDate desc";
    return this.hibernatetemplate.find(sql);
  }
  public List getAllPrivateCourceItem(String orgId) throws SysException {
    String hql = "select bo from CourceWareItemBO bo where (bo.orgID='" + orgId + "' or bo.orgID='-1') and bo.publicFlag='0'";
    return this.hibernatetemplate.find(hql);
  }
  public List getAllItemInfo(String orgid) throws SysException {
    return this.hibernatetemplate.find("select bo from CourceWareItemBO bo where (bo.orgID='" + orgid + "' or bo.orgID='-1') order by bo.createDate desc");
  }
  public List getAllFileInfoByType(String type) throws SysException {
    return this.hibernatetemplate.find("select bo from CourceWareItemBO bo where bo.typeID='" + type + "' order by bo.createDate desc");
  }
  public List getAllFileInfoByType(String type, User user) throws SysException {
	  String hql="select bo from CourceWareItemBO bo where bo.typeID='" + type+"'";
	  if(!user.ischo()){
		  hql+= " and bo.createor='" + user.getUserId() + "'";		  
	  }
	  hql+=" order by bo.createDate desc";
    return this.hibernatetemplate.find(hql);
  }
  public List getAllChildType(String typeid) throws SysException {
    return this.hibernatetemplate.find("select bo from CourceWareTypeBO bo where bo.parentTypeid='" + typeid + "' ");
  }
}