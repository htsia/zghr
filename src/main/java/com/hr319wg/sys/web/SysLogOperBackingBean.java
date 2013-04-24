package com.hr319wg.sys.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.ucc.IInfoSetUCC;
import com.hr319wg.sys.ucc.ISysLogOperUCC;
import com.hr319wg.sys.ucc.ISysLoginLogUCC;
import common.Logger;

public class SysLogOperBackingBean extends BaseBackingBean
{
  private static SimpleDateFormat sy1 = new SimpleDateFormat("yyyy-MM-dd");
  static Logger log = Logger.getLogger(SysLogOperBackingBean.class);
  private ISysLogOperUCC isyslogoperUCC;
  private ISysLoginLogUCC loginucc;
  private IPersonUCC personucc;
  private String operName;
  private String operID;
  private String modifiedName;
  private String modifiedContent;
  private String dateFrom;
  private String dateTo;
  private List infosets;
  private String modifiedOrgName;
  private String modifiedOrgIds;
  private List syslogList;
  private List logList;
  private PageVO pagevo = new PageVO();
  private IInfoSetUCC infosetucc;

  public ISysLoginLogUCC getLoginucc()
  {
    return this.loginucc;
  }
  public void setLoginucc(ISysLoginLogUCC ucc) {
    this.loginucc = ucc;
  }

  public IInfoSetUCC getInfosetucc() {
    return this.infosetucc;
  }
  public void setInfosetucc(IInfoSetUCC ucc) {
    this.infosetucc = ucc;
  }

  public PageVO getPagevo() {
    return this.pagevo;
  }
  public void setPagevo(PageVO vo) {
    this.pagevo = vo;
  }

  public String first() {
    this.pagevo.setCurrentPage(1);
    querySysLog();
    return "";
  }
  public String last() {
    this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
    querySysLog();
    return "";
  }
  public String pre() {
    if (this.pagevo.getCurrentPage() >= 2) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
      querySysLog();
    }
    return "";
  }
  public String next() {
    if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
      querySysLog();
    }
    return "";
  }

  public List getInfosets() {
    try {
      if (this.infosets == null) {
        this.infosets = new ArrayList();
        SelectItem si0 = new SelectItem();
        si0.setLabel("--ÇëÑ¡Ôñ--");
        si0.setValue("");
        this.infosets.add(si0);
        this.modifiedName = "";
        List list = this.infosetucc.getAllPersonSet();
        for (int i = 0; i < list.size(); i++) {
          InfoSetBO ib = (InfoSetBO)list.get(i);
          SelectItem si = new SelectItem();
          si.setLabel(ib.getSetNameEx());
          si.setValue(ib.getSetId());
          this.infosets.add(si);
        }
        list = this.infosetucc.getAllOrgSet();
        for (int i = 0; i < list.size(); i++) {
          InfoSetBO ib = (InfoSetBO)list.get(i);
          SelectItem si = new SelectItem();
          si.setLabel(ib.getSetNameEx());
          si.setValue(ib.getSetId());
          this.infosets.add(si);
        }
      }
    }
    catch (Exception e)
    {
    }
    return this.infosets;
  }
  public void setInfosets(List list) {
    this.infosets = list;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC ucc) {
    this.personucc = ucc;
  }
  public String loginfirst() {
    this.pagevo.setCurrentPage(1);
    queryLoginLog();
    return "";
  }
  public String loginlast() {
    this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
    queryLoginLog();
    return "";
  }
  public String loginpre() {
    if (this.pagevo.getCurrentPage() >= 2) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
      queryLoginLog();
    }
    return "";
  }
  public String loginnext() {
    if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
      queryLoginLog();
    }
    return "";
  }

  public String queryLoginLog() {
    try {
      if (this.pagevo.getCurrentPage() == 0) {
        this.pagevo.setCurrentPage(1);
      }

      this.logList = this.loginucc.queryLoginLogList(this.pagevo, this.dateFrom, this.dateTo, super.getUserInfo().getUserId(), "", "");
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public String querySysLog() {
    try {
      String tSql = "";
      if ((this.operName != null) && (!"".equals(this.operName))) {
        String[] pids = this.personucc.getPIDsbyNameORCode(this.operName);
        if ((pids != null) && (pids.length > 0)) {
          String where = "'" + pids[0] + "'";
          for (int i = 1; i < pids.length; i++) {
            where = where + ",'" + pids[i] + "'";
          }
          tSql += " and slobo.operatorId in (" + where + ")";
        }else{
        	tSql+=" and 1=0 ";
        }
      }
      if ((this.modifiedName != null) && (!"".equalsIgnoreCase(this.modifiedName))) {
        tSql += " and slobo.operInfosetId = '" + this.modifiedName.trim() + "'";
      }
      if ((this.dateFrom != null) && (!"".equals(this.dateFrom))) {
        if ((this.dateTo != null) && (!"".equals(this.dateTo)))
          tSql += " and (slobo.dateTime>='" + this.dateFrom.trim() + "' and slobo.dateTime<='" + this.dateTo.trim() + " 23;59:59')";
        else
          tSql += " and slobo.dateTime>='" + this.dateFrom.trim() + "' ";
      }
      if ((this.modifiedOrgIds != null) && (!"".equalsIgnoreCase(this.modifiedOrgIds))) {
        OrgBO org = SysCacheTool.findOrgById(this.modifiedOrgIds);
        if (org != null) {
          tSql += " and slobo.operUserTreeId like '" + org.getTreeId() + "%'";
        }
      }

      if (this.pagevo.getCurrentPage() == 0) {
        this.pagevo.setCurrentPage(1);
      }
      this.syslogList = this.isyslogoperUCC.queryLogbySql(this.pagevo, tSql, " order by slobo.dateTime desc");
    } catch (SysException e) {
      log.debug(e);
      this.msg.setMainMsg(e, getClass());
    }

    return "";
  }

  public String exportSysLog() {
    return "";
  }

  public ISysLogOperUCC getIsyslogoperUCC()
  {
    return this.isyslogoperUCC;
  }
  public void setIsyslogoperUCC(ISysLogOperUCC isyslogoperUCC) {
    this.isyslogoperUCC = isyslogoperUCC;
  }

  public List getSyslogList() {
    return this.syslogList;
  }
  public void setSyslogList(List syslogList) {
    this.syslogList = syslogList;
  }

  public List getLogList() {
    return this.logList;
  }
  public void setLogList(List log) {
    this.logList = log;
  }

  public String getModifiedContent() {
    return this.modifiedContent;
  }
  public void setModifiedContent(String modifiedContent) {
    this.modifiedContent = modifiedContent;
  }

  public String getModifiedName() {
    return this.modifiedName;
  }
  public void setModifiedName(String modifiedName) {
    this.modifiedName = modifiedName;
  }

  public String getModifiedOrgName()
  {
    return this.modifiedOrgName;
  }
  public void setModifiedOrgName(String modifiedOrgName) {
    this.modifiedOrgName = modifiedOrgName;
  }

  public String getOperName() {
    return this.operName;
  }
  public void setOperName(String operName) {
    this.operName = operName;
  }

  public String getOperID() {
    return this.operID;
  }
  public void setOperID(String operName) {
    this.operID = operName;
  }

  public String getModifiedOrgIds() {
    return this.modifiedOrgIds;
  }
  public void setModifiedOrgIds(String modifiedOrgIds) {
    this.modifiedOrgIds = modifiedOrgIds;
  }

  public String getDateFrom() {
    return this.dateFrom;
  }
  public void setDateFrom(String dateFrom) {
    this.dateFrom = dateFrom;
  }

  public String getDateTo()
  {
    return this.dateTo;
  }
  public void setDateTo(String dateTo) {
    this.dateTo = dateTo;
  }
}