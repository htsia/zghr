package com.hr319wg.emp.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.ucc.IAttachmentUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class PersonBrowBackingBean extends BaseBackingBean
{
  private ActivePageAPI activepageapi;
  private IPersonUCC personucc;
  private String superId = "";
  private String superName = "";
  private String filter = "";
  private String queryMode;
  private PageVO pagevo = new PageVO();
  private IAttachmentUCC aucc;
  private String jlBrow;

  public String getQueryMode()
  {
    return this.queryMode;
  }
  public void setQueryMode(String queryMode) {
    this.queryMode = queryMode;
  }

  public IAttachmentUCC getAucc()
  {
    return this.aucc;
  }
  public void setAucc(IAttachmentUCC ucc) {
    this.aucc = ucc;
  }

  public String getFilter() {
    return this.filter;
  }
  public void setFilter(String f) {
    this.filter = f;
  }

  public PageVO getPagevo() {
    return this.pagevo;
  }
  public void setPagevo(PageVO vo) {
    this.pagevo = vo;
  }

  public String getSuperId() {
    return this.superId;
  }
  public void setSuperId(String id) {
    this.superId = id;
  }

  public String getSuperName() {
    return this.superName;
  }
  public void setSuperName(String id) {
    this.superName = id;
  }
  public String first() {
    this.pagevo.setCurrentPage(1);
    queryPerson();
    return "";
  }
  public String last() {
    this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
    queryPerson();
    return "";
  }
  public String pre() {
    if (this.pagevo.getCurrentPage() >= 2) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
      queryPerson();
    }
    return "";
  }
  public String next() {
    if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
      queryPerson();
    }
    return "";
  }
  private void queryPerson() {
    try {
      this.pagevo.setPageSize(12);
      if (this.pagevo.getCurrentPage() == 0) {
        this.pagevo.setCurrentPage(1);
      }
      OrgBO orgbo = SysCacheTool.findOrgById(this.superId);

      String where = " and (p.deptTreeId like '" + orgbo.getTreeId() + "%' or p.groupID='" + this.superId + "')";
      if ((this.filter != null) && (!"".equals(this.filter))) {
        where = where + " and " + this.filter;
      }
      where +=" and p.personType not like '01352%'";
      User user = super.getUserInfo();
      UserAPI api = (UserAPI)SysContext.getBean("user_pmsAPI");
      String scale = api.getScaleConditionByType(user, "A001738", "A001750", "A001054", "A", false, false);
      if ((scale != null) && (!"".equals(scale))) {
        where = where + " and " + scale;
      }
      List list = null;

      if ((!"true".equals(this.queryMode)) && ("0".equals(Constants.EMP_PERSON_BROWUNIT)) && ("089110".equals(orgbo.getorgType()))) {
        list = new ArrayList();
      }
      else {
        list = this.personucc.queryAllPersonInPage(where, this.pagevo);
        String basepath = BaseBackingBean.getServletContext().getRealPath("/");
        for (int i = 0; i < list.size(); i++) {
          PersonBO pb = (PersonBO)list.get(i);
          String zpValue = pb.getImageId();
          if ((zpValue != null) && (!"".equals(zpValue)) && (!this.aucc.checkAttachFileExist(basepath, zpValue))) {
            this.aucc.getFileContentToFile(basepath, zpValue);
          }
        }
      }

      super.getHttpSession().setAttribute("PersonList", list);
    }
    catch (Exception e)
    {
    }
  }

  public String getPageInit() {
    if (super.getRequestParameter("superId") != null) {
      if ("TOMCAT".equals(CommonFuns.getAppType())) {
        String value = CommonFuns.getParaFromURL(super.getServletRequest().getQueryString(), "filter");
        if ((value != null) && (!"".equals(value))) {
          this.filter = value;
        }
      }
      else if (super.getRequestParameter("filter") != null) {
        this.filter = super.getRequestParameter("filter");
      }
      this.superId = super.getRequestParameter("superId");
      this.superName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.superId);
      this.queryMode = super.getRequestParameter("queryMode");
      queryPerson();
    }
    return this.pageInit;
  }

  public String getJlBrow() {
    if (super.getRequestParameter("superId") != null) {
      if (super.getRequestParameter("filter") != null) {
        this.filter = super.getRequestParameter("filter");
      }
      this.superId = super.getRequestParameter("superId");
      this.superName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.superId);
      queryPerson();
    }
    return this.jlBrow;
  }
  public void setJlBrow(String jlBrow) {
    this.jlBrow = jlBrow;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC ucc) {
    this.personucc = ucc;
  }

  public ActivePageAPI getActivepageapi() {
    return this.activepageapi;
  }
  public void setActivepageapi(ActivePageAPI activepageapi) {
    this.activepageapi = activepageapi;
  }
}