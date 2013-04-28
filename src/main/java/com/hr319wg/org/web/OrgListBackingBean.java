package com.hr319wg.org.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;

public class OrgListBackingBean extends BaseBackingBean
{
  private String OPER_ID = "0103";
  private String OPER_SHOWCOLEDIT = "010301";
  private String OPER_SHOWREPORT = "010302";
  private IOrgUCC orgucc;
  private String orgList;
  private String orgName;
  private String superId;
  private String orgType;
  private List regTableList;
  private IUserReportUCC userreportucc;
  private List listTableList;
  private boolean showColEdit;
  private boolean showReport;
  private QueryAPI queryAPI;
  
  public QueryAPI getQueryAPI() {
	return queryAPI;
  }
  public void setQueryAPI(QueryAPI queryAPI) {
	this.queryAPI = queryAPI;
  }

  public IUserReportUCC getUserreportucc()
  {
    return this.userreportucc;
  }

  public void setUserreportucc(IUserReportUCC userreportucc) {
    this.userreportucc = userreportucc;
  }

  public List getListTableList()
  {
    try
    {
      this.listTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), this.OPER_ID, UserRptVO.TYPE_ROSTER);
      if (this.listTableList == null)
        this.listTableList = new ArrayList();
    }
    catch (Exception e)
    {
      this.listTableList = new ArrayList();
    }
    return this.listTableList;
  }
  public void setListTableList(List li) {
    this.listTableList = li;
  }

  public List getRegTableList() {
    try {
      this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), this.OPER_ID, UserRptVO.TYPE_REG);
      if (this.regTableList == null)
        this.regTableList = new ArrayList();
    }
    catch (Exception e)
    {
      this.regTableList = new ArrayList();
    }
    return this.regTableList;
  }
  public void setRegTableList(List li) {
    this.regTableList = li;
  }

  public IOrgUCC getOrgucc() {
    return this.orgucc;
  }

  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public String getOrgList() {
    String pageFlag = getServletRequest().getParameter("pageFlag");
    String flag = getServletRequest().getParameter("flag");
    String sessionFlag = getServletRequest().getParameter("sessionFlag");
    if (sessionFlag == null) {
      getHttpSession().removeAttribute("OBJECT");
    }
    if ("1".equals(pageFlag)) {
      try {
        String rowNums = getServletRequest().getParameter("rowNum");
        int pageNum = (getServletRequest().getParameter("pageNum") == null) || ("".equals(getServletRequest().getParameter("pageNum"))) ? 1 : Integer.parseInt(getServletRequest().getParameter("pageNum"));

        String sql = (String)getHttpSession().getAttribute("activeSql");

        TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null) {
          rowNum = Integer.parseInt(rowNums);
        }
        User user = getUserInfo();
        this.orgucc.querySql(table, sql, user, pageNum, rowNum);
        getHttpSession().setAttribute("OBJECT", table);
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      } catch (Exception e) {
        e.printStackTrace();
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        this.msg.setMainMsg(e, getClass());
      }
    }
    if ("1".equals(flag)) {
      try {
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        String superOrg = getServletRequest().getParameter("superId");
        if ((superOrg != null) && (!"".equals(superOrg))) {
          this.superId = superOrg;
        }
        TableVO table = new TableVO();
        String rowNums = (String)getHttpSession().getAttribute("rowNum");
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null) {
          rowNum = Integer.parseInt(rowNums);
        }
        User user = getUserInfo();
        String sql=null;
        String loaddata=super.getRequestParameter("loaddata");
        if(!"0".equals(loaddata)){
        	sql = this.orgucc.queryOrgList(table, this.orgName, this.superId, this.orgType, 1, rowNum, "00900", user, "1");        	
        }else{
        	CellVO[] c1 = queryAPI.queryInfoItem("135");
	        table.setHeader(c1);
	        table.setSetType("A");
        }
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf("1"));
        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
        getHttpSession().setAttribute("OBJECT", table);
      } catch (Exception e) {
        e.printStackTrace();
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        this.msg.setMainMsg(e, getClass());
      }
    }
    return this.orgList;
  }

  public void setOrgList(String orgList) {
    this.orgList = orgList;
  }

  public String getOrgName() {
    return this.orgName;
  }

  public void setOrgName(String orgName) {
    this.orgName = orgName;
  }

  public String getSuperId() {
    return this.superId;
  }

  public void setSuperId(String superId) {
    this.superId = superId;
  }

  public String getOrgType() {
    return this.orgType;
  }

  public void setOrgType(String orgType) {
    this.orgType = orgType;
  }

  public boolean isShowColEdit() {
    this.showColEdit = UserAPI.checkButtonOperate(super.getUserInfo(), this.OPER_SHOWCOLEDIT);
    return this.showColEdit;
  }

  public void setShowColEdit(boolean showColEdit) {
    this.showColEdit = showColEdit;
  }

  public boolean isShowReport() {
    this.showReport = UserAPI.checkButtonOperate(super.getUserInfo(), this.OPER_SHOWREPORT);
    return this.showReport;
  }

  public void setShowReport(boolean showReport) {
    this.showReport = showReport;
  }

  public String queryOrg()
  {
    try
    {
      String superOrg = getServletRequest().getParameter("superId");
      if ((superOrg != null) && (!"".equals(superOrg))) {
        this.superId = superOrg;
      }
      TableVO table = new TableVO();
      String rowNums = (String)getHttpSession().getAttribute("rowNum");
      int rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (rowNums != null) {
        rowNum = Integer.parseInt(rowNums);
      }
      User user = getUserInfo();
      String sql = this.orgucc.queryOrgList(table, this.orgName, this.superId, this.orgType, 1, rowNum, "00900", user, "2");
      getHttpSession().setAttribute("activeSql", sql);
      getHttpSession().setAttribute("pageNum", String.valueOf("1"));
      getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      getHttpSession().setAttribute("OBJECT", table);
    } catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute("OBJECT");
      getHttpSession().removeAttribute("activeSql");
      getHttpSession().removeAttribute("pageNum");
      getHttpSession().removeAttribute("rowNum");
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }
}