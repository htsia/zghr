package com.hr319wg.wage.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.servlet.http.HttpSession;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.qry.pojo.vo.QueryVO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.WFTypeBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.ucc.IWagePersonQueryUCC;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;

public class EnterPersonSetBackingBean extends BaseBackingBean
{
  private String setId;
  private String setName;
  private String unitId;
  private String name;
  private String selectedUserIDs;
  private boolean done;
  private boolean noDone = true;
  private boolean operRight = true;
  private IWageSetPersonUCC wagesetpersonucc;
  private IWagePersonQueryUCC wagepersonqueryucc;
  private IQueryUCC queryucc;
  private IWageSetUCC wagesetucc;
  private IPersonUCC personucc;
  private List regTableList;
  private IUserReportUCC userreportucc;
  private WorkFlowService wfservice;
  private String listEnterPerson;
  private String manyPerson;
  private String unitName;
  private String inputDate;
  private String ids;

  public String getSelectedUserIDs() {
	return selectedUserIDs;
}

public void setSelectedUserIDs(String selectedUserIDs) {
	this.selectedUserIDs = selectedUserIDs;
}

public boolean isDone() {
	return done;
}

public void setDone(boolean done) {
	this.done = done;
}

public boolean isNoDone() {
	return noDone;
}

public void setNoDone(boolean noDone) {
	this.noDone = noDone;
}

public List getRegTableList()
  {
    try
    {
      this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), "0674", UserRptVO.TYPE_REG);
      if (this.regTableList == null)
        this.regTableList = new ArrayList();
    }
    catch (Exception e)
    {
      this.regTableList = new ArrayList();
    }
    return this.regTableList;
  }

  public void setRegTableList(List regTableList) {
    this.regTableList = regTableList;
  }

  public IUserReportUCC getUserreportucc() {
    return this.userreportucc;
  }

  public void setUserreportucc(IUserReportUCC userreportucc) {
    this.userreportucc = userreportucc;
  }

  public WorkFlowService getWfservice() {
    return this.wfservice;
  }

  public void setWfservice(WorkFlowService wfservice) {
    this.wfservice = wfservice;
  }

  public String getIds()
  {
    return this.ids;
  }
  public void setIds(String ids) {
    this.ids = ids;
  }

  public String getInputDate() {
    return this.inputDate;
  }
  public void setInputDate(String inputDate) {
    this.inputDate = inputDate;
  }

  public String getUnitName() {
    this.unitName = super.getUserInfo().getOrgName();
    return this.unitName;
  }
  public void setUnitName(String unitName) {
    this.unitName = unitName;
  }
  public String removeFromSet() {
    try {
      String[] array = this.ids.split("\\|");
      for (int i = 0; i < array.length; i++) {
        String[] vars = array[i].split(",");
        if (vars.length == 2) {
          String[] sel = new String[1];
          sel[0] = vars[0];
          this.wagesetpersonucc.batchRemovePerson(vars[1], sel);
          this.wagesetpersonucc.batchMinus(super.getUserInfo().getUserId(), vars[1], sel);

          WFTransaction trans = new WFTransaction();
          trans.setUser(super.getUserInfo());
          PersonBO pb = SysCacheTool.findPersonById(vars[0]);
          if ((pb.getDegree() != null) && (Constants.EMP_CADRESCODE.indexOf(pb.getDegree() + ",") >= 0)) {
            trans.setWfType(WFTypeBO.RYGL_CAR_EXIT);
          }
          else {
            trans.setWfType(WFTypeBO.RYGL_WORK_EXIT);
          }

          trans.setOperID("0673");
          trans.setLinkID(vars[0]);
          this.wfservice.processTrans(trans);
        }
      }
    }
    catch (Exception e)
    {
    }
    return null;
  }

  public void setDone(ValueChangeEvent event) {
	  this.done = event.getNewValue().toString().equals("true");
  }
  public void setNoDone(ValueChangeEvent event) {
	  this.noDone = event.getNewValue().toString().equals("true");
  }
  public String queryEnter() {
    try {
      super.getHttpSession().removeAttribute("OBJECT");
      super.getHttpSession().removeAttribute("activeSql");
      super.getHttpSession().removeAttribute("pageNum");
      super.getHttpSession().removeAttribute("rowNum");

      TableVO table = new TableVO();
      String filter = "dbo.typeof(B730702,'0200','0200110001')='1' ";
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        filter = " typeof(B730702,'0200','0200110001')='1' ";
      }
      if ((this.inputDate != null) && (!"".equals(this.inputDate))) {
        filter += " and B730701 like '" + this.inputDate + "%'";
      }
      
      List list = SysCacheTool.queryInfoItemBySetId("B730");
      for (int i = 0; i < list.size(); i++) {
        InfoItemBO in = (InfoItemBO)list.get(i);
        if ("0".equals(in.getItemStatus())) {
          list.remove(i);
          i--;
        }
        if ((InfoItemBO.PROPERTY_CONTROL_HIDE.equals(in.getItemProperty())) || (InfoItemBO.PROPERTY_SYSTEM_.equals(in.getItemProperty()))) {
          list.remove(i);
          i--;
        }
        if ("B730704".equals(in.getItemId())) {
          list.remove(i);
          i--;
        }
      }
      String sql = this.wagepersonqueryucc.getChangeInfo(table, list, super.getUserInfo().getOrgId(), filter);
      int pageNum = 1;
      if (super.getRequestParameter("pageNum") != null) {
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
      }
      turnPageQuery(table, sql, pageNum, 0);
    } catch (Exception e) {
      super.showMessageDetail("¥ÌŒÛ£∫" + e.getMessage());
    }
    return "";
  }

  public String turnPageQuery(TableVO table, String sql, int pageNum, int rowNum)
  {
    try {
      if (pageNum == 0)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
      if (pageNum == 0)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("pageNum")));
      if (pageNum == 0) {
        pageNum = 1;
      }
      if (rowNum == 0)
        rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("rowNum")));
      if (rowNum == 0)
        rowNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("rowNum")));
      if (rowNum == 0)
        rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (table == null)
        table = (TableVO)super.getHttpSession().getAttribute("OBJECT");
      if (sql == null) {
        sql = (String)super.getHttpSession().getAttribute("activeSql");
      }
      table = this.personucc.queryPersonBySql(table, sql, pageNum, rowNum);
      super.getHttpSession().setAttribute("activeSql", sql);
      super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
      super.getHttpSession().setAttribute("OBJECT", table);
    } catch (Exception e) {
      super.showMessageDetail("¥ÌŒÛ£∫" + e.getMessage());
    }
    return null;
  }

  public String getListEnterPerson() {
    queryEnter();
    return this.listEnterPerson;
  }
  public void setListEnterPerson(String listAllPerson) {
    this.listEnterPerson = listAllPerson;
  }

  public String getSetId() {
    return this.setId;
  }
  public void setSetId(String setId) {
    this.setId = setId;
  }

  public String getManyPerson() {
    return this.manyPerson;
  }
  public void setManyPerson(String mp) {
    this.manyPerson = mp;
  }

  public String getName() {
    return this.name;
  }
  public void setName(String id) {
    this.name = id;
  }

  public String getSetName() {
    return this.setName;
  }
  public void setSetName(String setName) {
    this.setName = setName;
  }

  public String getUnitId() {
    return this.unitId;
  }
  public void setUnitId(String unitId) {
    this.unitId = unitId;
  }

  public IWageSetPersonUCC getWagesetpersonucc() {
    return this.wagesetpersonucc;
  }
  public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
    this.wagesetpersonucc = wagesetpersonucc;
  }

  public IWagePersonQueryUCC getWagepersonqueryucc() {
    return this.wagepersonqueryucc;
  }

  public void setWagepersonqueryucc(IWagePersonQueryUCC wagepersonqueryucc) {
    this.wagepersonqueryucc = wagepersonqueryucc;
  }

  public IQueryUCC getQueryucc() {
    return this.queryucc;
  }

  public void setQueryucc(IQueryUCC queryucc) {
    this.queryucc = queryucc;
  }

  public boolean isOperRight() {
    return this.operRight;
  }

  public void setOperRight(boolean operRight) {
    this.operRight = operRight;
  }

  public String queryMultiPerson()
  {
    try {
      HttpSession session = super.getHttpSession();

      String tableName = "WAGE_SET_PERS_R";
      String setIdName = tableName + ".A815700";

      QueryVO vo = this.queryucc.findQueryVO("140");
      CellVO[] header = this.queryucc.getCellVO(vo.getItem(), vo.getSetType());

      Hashtable sqlHash = this.queryucc.buildQuerySqlHash(getUserInfo(), vo);

      String select = (String)sqlHash.get("SQL_SELECT_PART");
      String from = (String)sqlHash.get("SQL_FROM_PART");
      String where = (String)sqlHash.get("SQL_WHERE_PART");
      String order = (String)sqlHash.get("SQL_ORDER_PART");

      TableVO tablevo = new TableVO();
      tablevo.setHeader(header);

      String wageCond = setIdName + "='" + this.setId + "' ";
      if ((this.manyPerson != null) && (!this.manyPerson.equals(""))) {
        String[] ids = this.manyPerson.split(",");
        String con = " 1=0 ";
        for (int i = 0; i < ids.length; i++) {
          if (!"".equals(ids[i])) {
            con = con + " or A001.A001001 like '%" + ids[i] + "%' or A001.A001735 like '%" + ids[i] + "%' or A001.A001002 like '%" + ids[i].toLowerCase() + "%' or A001.A001999 like '%" + ids[i].toLowerCase() + "%' ";
          }
        }
        wageCond = wageCond + " and (" + con + ")";
      }
      if (from.indexOf(tableName) < 0) {
        from = from + " LEFT JOIN " + tableName + " ON A001.ID = " + tableName + ".ID ";
      }
      if ((where != null) && (where.length() > 0))
        where = where + " AND " + wageCond;
      else {
        where = wageCond;
      }
      String sql = "SELECT " + select;
      sql = sql + " FROM " + from;
      sql = sql + " WHERE " + where;
      if (order.length() > 0) {
        sql = sql + " ORDER BY " + order;
      }
      trunPageQuery(tablevo, sql, 1, 0);
    }
    catch (Exception e) {
      super.showMessageDetail("¥ÌŒÛ:" + e.getMessage());
    }
    return "personList";
  }
  public String queryPerson() {
    try {
      HttpSession session = super.getHttpSession();

      String tableName = "WAGE_SET_PERS_R";
      String setIdName = tableName + ".A815700";

      QueryVO vo = this.queryucc.findQueryVO("140");
      CellVO[] header = this.queryucc.getCellVO(vo.getItem(), vo.getSetType());

      Hashtable sqlHash = this.queryucc.buildQuerySqlHash(getUserInfo(), vo);

      String select = (String)sqlHash.get("SQL_SELECT_PART");
      String from = (String)sqlHash.get("SQL_FROM_PART");
      String where = (String)sqlHash.get("SQL_WHERE_PART");
      String order = (String)sqlHash.get("SQL_ORDER_PART");

      TableVO tablevo = new TableVO();
      tablevo.setHeader(header);

      String wageCond = setIdName + "='" + this.setId + "' ";
      if ((this.name != null) && (!this.name.equals(""))) {
        wageCond = wageCond + " and (A001.A001001 like '%" + this.name + "%' or A001.A001735 like '%" + this.name + "%' or A001.A001002 like '%" + this.name.toLowerCase() + "%')";
      }
      if (from.indexOf(tableName) < 0) {
        from = from + " LEFT JOIN " + tableName + " ON A001.ID = " + tableName + ".ID ";
      }
      if ((where != null) && (where.length() > 0))
        where = where + " AND " + wageCond;
      else {
        where = wageCond;
      }
      String sql = "SELECT " + select;
      sql = sql + " FROM " + from;
      sql = sql + " WHERE " + where;
      if (order.length() > 0) {
        sql = sql + " ORDER BY " + order;
      }
      trunPageQuery(tablevo, sql, 1, 0);
    }
    catch (Exception e) {
      super.showMessageDetail("¥ÌŒÛ:" + e.getMessage());
    }
    return "personList";
  }

  public String saveEnter() {
    try {
      if ((this.ids != null) && (!"".equals(this.ids.trim()))) {
    	  String[] selectedIDs = this.ids.split(",");
    	  this.ids=null;
        this.wagesetpersonucc.batchAddPerson(this.setId, selectedIDs);
        this.wagesetpersonucc.batchAdd(super.getUserInfo().getUserId(), this.setId, selectedIDs);
        for (int i = 0; i < selectedIDs.length; i++)
        {
          WFTransaction trans = new WFTransaction();
          trans.setUser(super.getUserInfo());
          PersonBO pb = SysCacheTool.findPersonById(selectedIDs[i]);
          if ((pb.getDegree() != null) && (Constants.EMP_CADRESCODE.indexOf(pb.getDegree() + ",") >= 0)) {
            trans.setWfType(WFTypeBO.RYGL_CAR_ENTER);
          }
          else {
            trans.setWfType(WFTypeBO.RYGL_WORK_ENTER);
          }
          trans.setOperID("0674");
          trans.setLinkID(selectedIDs[i]);
          trans.setStatusValue("00901");
          this.wfservice.processTrans(trans);
        }
        super.showMessageDetail("»À‘±“—≥…π¶º”»Î’ÀÃ◊");
      }
    } catch (Exception e) {
      super.showMessageDetail("¥ÌŒÛ£∫" + e.getMessage());
    }
    return queryEnter();
  }

  public String trunPageQuery(TableVO table, String sql, int pageNum, int rowNum)
  {
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
        table = (TableVO)super.getHttpSession().getAttribute("setPersonTableVO");
      if (sql == null) {
        sql = (String)super.getHttpSession().getAttribute("activeSql");
      }
      table = this.wagepersonqueryucc.queryPersonBySql(table, sql, pageNum, rowNum);
      super.getHttpSession().setAttribute("activeSql", sql);
      super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
      super.getHttpSession().setAttribute("setPersonTableVO", table);
    } catch (Exception e) {
      super.showMessageDetail("¥ÌŒÛ£∫" + e.getMessage());
    }
    return null;
  }

  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }
  public void setWagesetucc(IWageSetUCC wagesetucc) {
    this.wagesetucc = wagesetucc;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC ucc) {
    this.personucc = ucc;
  }
}