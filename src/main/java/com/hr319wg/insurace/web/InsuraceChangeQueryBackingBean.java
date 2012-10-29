package com.hr319wg.insurace.web;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.ExceptionMsg;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class InsuraceChangeQueryBackingBean extends BaseBackingBean
{
  private String OperID;
  private IPersonUCC personucc;
  private IUserReportUCC userreportucc;
  private List reportList;
  private List listrptList;
  private String superId;
  private String name;
  private String personCountDetail;
  private String namelist;

  public InsuraceChangeQueryBackingBean()
  {
    this.OperID = "1412";
  }

  public String getPersonCountDetail()
  {
    String month = super.getRequestParameter("month");
    getHttpSession().removeAttribute("OBJECT");
    getHttpSession().removeAttribute("activeSql");
    getHttpSession().removeAttribute("pageNum");
    getHttpSession().removeAttribute("rowNum");
    try {
      TableVO table = new TableVO();
      table.setSetId("A001");
      table.setSetPk("ID");
      String rowNums = (String)getHttpSession().getAttribute("rowNum");
      int rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (rowNums != null)
        rowNum = Integer.parseInt(rowNums);

      String sql = "";
      User user = super.getUserInfo();
      sql = this.personucc.queryInsChangePersonListByMonth(table, month, super.getUserInfo().getOrgId(), 1, rowNum, user);
      getHttpSession().setAttribute("activeSql", sql);
      getHttpSession().setAttribute("pageNum", String.valueOf("1"));
      getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      getHttpSession().setAttribute("OBJECT", table);
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute("OBJECT");
      getHttpSession().removeAttribute("activeSql");
      getHttpSession().removeAttribute("pageNum");
      getHttpSession().removeAttribute("rowNum");
      this.msg.setMainMsg(e, getClass());
    }
    return this.personCountDetail; }

  public void setPersonCountDetail(String detail) {
    this.personCountDetail = detail;
  }

  public String getSuperId() {
    if ((this.superId == null) || (this.superId.equals("")))
      this.superId = super.getRequestParameter("superId");

    return this.superId; }

  public void setSuperId(String id) {
    this.superId = id;
  }

  public String getName() {
    return this.name; }

  public void setName(String id) {
    this.name = id;
  }

  public String getNamelist()
  {
    queryPerson();
    return this.namelist; }

  public void setNamelist(String namelist) {
    this.namelist = namelist;
  }

  public List getReportList()
  {
    try
    {
      this.reportList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), this.OperID, UserRptVO.TYPE_REG);
    }
    catch (Exception e) {
      this.reportList = null;
    }
    return this.reportList; }

  public String queryPerson() {
    String pageFlag = getServletRequest().getParameter("pageFlag");
    if ("1".equals(pageFlag)) {
      try {
        String rowNums = getServletRequest().getParameter("rowNum");
        int pageNum = ((getServletRequest().getParameter("pageNum") == null) || ("".equals(getServletRequest().getParameter("pageNum")))) ? 1 : Integer.parseInt(getServletRequest().getParameter("pageNum"));

        String sql = (String)getHttpSession().getAttribute("activeSql");

        TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");

        if (table == null)
          table = new TableVO();
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null)
          rowNum = Integer.parseInt(rowNums);

        User user = getUserInfo();

        this.personucc.querySql(table, sql, user, pageNum, rowNum);
        getHttpSession().setAttribute("OBJECT", table);
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));

        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      } catch (SysException e) {
      }
    } else {
      getHttpSession().removeAttribute("OBJECT");
      getHttpSession().removeAttribute("activeSql");
      getHttpSession().removeAttribute("pageNum");
      getHttpSession().removeAttribute("rowNum");
      try {
        TableVO table = new TableVO();
        table.setSetId("A001");
        table.setSetPk("ID");
        String rowNums = (String)getHttpSession().getAttribute("rowNum");
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null)
          rowNum = Integer.parseInt(rowNums);

        String sql = "";
        User user = super.getUserInfo();
        sql = this.personucc.queryInsChangePersonList(table, this.name, getSuperId(), 1, rowNum, user);
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf("1"));
        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
        getHttpSession().setAttribute("OBJECT", table);
      }
      catch (Exception e) {
        e.printStackTrace();
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        this.msg.setMainMsg(e, getClass()); }
    }
    return "";
  }

  public IPersonUCC getPersonucc()
  {
    return this.personucc; }

  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public void setUserreportucc(IUserReportUCC iur) {
    this.userreportucc = iur; }

  public IUserReportUCC getUserreportucc() {
    return this.userreportucc;
  }

  public List getListrptList() {
    try {
      this.listrptList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), this.OperID, UserRptVO.TYPE_ROSTER);
    }
    catch (Exception e) {
      this.listrptList = null;
    }
    return this.listrptList; }

  public void setListrptList(List listrptList) {
    this.listrptList = listrptList;
  }
}