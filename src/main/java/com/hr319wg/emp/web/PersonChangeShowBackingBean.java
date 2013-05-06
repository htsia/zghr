package com.hr319wg.emp.web;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import java.util.List;
import javax.servlet.http.HttpSession;

public class PersonChangeShowBackingBean extends BaseBackingBean
{
  private String OPER_ID;
  private String unitId;
  private String unitName;
  private String flag;
  private String inputDate;
  private IPersonUCC personucc;
  private IUserReportUCC userreportucc;
  private List regReport;
  private String mode;
  private boolean showChangeUnit;

  public PersonChangeShowBackingBean()
  {
    this.OPER_ID = "1315";

    this.mode = "0";

    this.showChangeUnit = false;
  }

  public IUserReportUCC getUserreportucc()
  {
    return this.userreportucc;
  }

  public void setUserreportucc(IUserReportUCC userreportucc) {
    this.userreportucc = userreportucc;
  }

  public List getRegReport()
  {
    return this.regReport;
  }

  public void setRegReport(List regReport) {
    this.regReport = regReport;
  }

  public String getMode()
  {
    return this.mode; }

  public void setMode(String mode) {
    this.mode = mode;
  }

  public IPersonUCC getPersonucc()
  {
    return this.personucc; }

  public void setPersonucc(IPersonUCC ucc) {
    this.personucc = ucc;
  }

  public String getPageInit() {
    try {
      if (super.getRequestParameter("Init") != null) {
        if (this.unitId == null) {
          this.unitId = super.getUserInfo().getOrgId();
          this.unitName = super.getUserInfo().getOrgName();
        }
        this.regReport = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), this.OPER_ID, UserRptVO.TYPE_REG);

        query();
      }
    }
    catch (Exception e)
    {
    }
    return this.pageInit;
  }

  public boolean isShowChangeUnit() {
    User user = super.getUserInfo();
    if ((RoleInfoBO.ORGTYPE_ALL.equals(user.getprocessUnit())) || (RoleInfoBO.ORGTYPE_USD.equals(user.getprocessUnit()))) {
      this.showChangeUnit = true;
    }
    else
      this.showChangeUnit = false;

    return this.showChangeUnit; }

  public void setShowChangeUnit(boolean showChangeUnit) {
    this.showChangeUnit = showChangeUnit;
  }

  public void query()
  {
    try {
      super.getHttpSession().removeAttribute("OBJECT");
      super.getHttpSession().removeAttribute("activeSql");
      super.getHttpSession().removeAttribute("pageNum");
      super.getHttpSession().removeAttribute("rowNum");

      this.unitName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.unitId);
      TableVO table = new TableVO();
      String filter = " 1=1 ";
      if ((this.inputDate != null) && (!("".equals(this.inputDate))))
        filter = filter + " and B730701 like '" + this.inputDate + "%'";

      if ("1".equals(this.mode)) {
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          filter = filter + " and typeof(B730702,'0200','0200110001')='1'";
        }
        else
          filter = filter + " and dbo.typeof(B730702,'0200','0200110001')='1'";

      }
      else if ("2".equals(this.mode))
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          filter = filter + " and typeof(B730702,'','0200120001')='1'";
        }
        else
          filter = filter + " and dbo.typeof(B730702,'','0200120001')='1'";


      String sql = this.personucc.getChangeInfo(table, this.unitId, filter);
      int pageNum = 1;
      if (super.getRequestParameter("pageNum") != null)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));

      turnPageQuery(table, sql, pageNum, 0);
    } catch (Exception e) {
      super.showMessageDetail("´íÎó£º" + e.getMessage());
    }
  }

  public String turnPageQuery(TableVO table, String sql, int pageNum, int rowNum) {
    try {
      if (pageNum == 0)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
      if (pageNum == 0)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("pageNum")));
      if (pageNum == 0)
        pageNum = 1;

      if (rowNum == 0)
        rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("rowNum")));
      if (rowNum == 0)
        rowNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("rowNum")));
      if (rowNum == 0)
        rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (table == null)
        table = (TableVO)super.getHttpSession().getAttribute("OBJECT");
      if (sql == null)
        sql = (String)super.getHttpSession().getAttribute("activeSql");

      table = this.personucc.queryPersonBySql(table, sql, pageNum, rowNum);
      super.getHttpSession().setAttribute("activeSql", sql);
      super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
      super.getHttpSession().setAttribute("OBJECT", table);
    } catch (Exception e) {
      super.showMessageDetail("´íÎó£º" + e.getMessage());
    }
    return null;
  }

  public String getUnitId() {
    return this.unitId; }

  public void setUnitId(String unitId) {
    this.unitId = unitId;
  }

  public String getUnitName() {
    return this.unitName; }

  public void setUnitName(String unitName) {
    this.unitName = unitName;
  }

  public String getInputDate() {
    return this.inputDate; }

  public void setInputDate(String Name) {
    this.inputDate = Name;
  }

  public String getFlag() {
    return this.flag; }

  public void setFlag(String flag) {
    this.flag = flag;
  }
}