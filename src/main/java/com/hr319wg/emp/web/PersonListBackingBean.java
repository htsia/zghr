package com.hr319wg.emp.web;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.EmpChangeTypeConfigBO;
import com.hr319wg.emp.pojo.bo.EmpReduceBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.PersonChangeVO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.qry.pojo.vo.QueryVO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.ShortMessageBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.bo.WFProcessBO;
import com.hr319wg.sys.pojo.bo.WFTypeBO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.sys.ucc.IShortMessageUCC;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.pojo.bo.UserQryBO;
import com.hr319wg.user.pojo.vo.UserQryVO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserQryUCC;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;

public class PersonListBackingBean extends BaseBackingBean
{
  private String OPER_ID = "0311";
  private String OPER_SHOWCARD = "031104";
  private String OPER_COLEDIT = "031105";
  private String OPER_SHOWREPORT = "031106";
  private IPersonUCC personucc;
  private IUserQryUCC userqryucc;
  private IQueryUCC queryucc;
  private IOrgUCC orgucc;
  private IUserReportUCC userreportucc;
  private IShortMessageUCC shortmessageucc;
  private IWageSetPersonUCC wagesetpersonucc;
  private WageAPI wageapi;
  private WorkFlowService wfservice;
  private UserAPI userApi;
  private List regTableList;
  private List listTableList;
  private String personList = null;
  private String name;
  private String nameStrs;
  private String mode;
  private boolean showCard;
  private boolean showReport;
  private boolean showColEdit;
  private List orgBrowModeList;
  private String afterType;
  private String title;
  private String personType;
  private String personTypeValue;
  private String personTypeDesc;
  private String superId = "";
  private String superName;
  private String type;
  private String defaultQry;
  private List displaySetList;
  private List pids = new ArrayList();
  private String personID;
  private String code;
  private String dept;
  private String orgMode = "1";
  private String initRetireQuery;
  private String checkingPerson;
  private String checkingPerson_audit;
  private String processDate;
  private PageVO pagevo = new PageVO();
  private List reducebos;
  private String initReduceAudit;
  private String doReduceAudit;
  private String doBatchReduceAudit;
  private EmpReduceBO reducebo = new EmpReduceBO();
  private PersonBO personbo = new PersonBO();
  private List reduceList;
  private String weaveWarn = "";

  private boolean modiPerson = false;
  private boolean modiBase = false;
  private boolean modiApply = false;

  private String workFlow = "0";
  private String reduceWorkFlow = "0";

  private String auditStatus = "";
  private String listReduce;
  private List reducingbos;
  private boolean onlyAuditing = true;
  private boolean haveA001003;
  private List insdisplaySetList;
  private String auditResult;
  private String auditOpition;
  private String auditMessage = "您报送的人员已审批通过！";
  private boolean autoMessage = true;
  
  public boolean isShowCard()
  {
    this.showCard = UserAPI.checkButtonOperate(super.getUserInfo(), this.OPER_SHOWCARD);
    return this.showCard;
  }
  public void setShowCard(boolean showCard) {
    this.showCard = showCard;
  }

  public boolean isShowReport()
  {
    this.showReport = UserAPI.checkButtonOperate(super.getUserInfo(), this.OPER_SHOWREPORT);
    return this.showReport;
  }
  public void setShowReport(boolean showReport) {
    this.showReport = showReport;
  }

  public boolean isShowColEdit() {
    this.showColEdit = UserAPI.checkButtonOperate(super.getUserInfo(), this.OPER_COLEDIT);
    return this.showColEdit;
  }
  public void setShowColEdit(boolean showColEdit) {
    this.showColEdit = showColEdit;
  }

  public List getOrgBrowModeList() {
    this.orgBrowModeList = new ArrayList();
    SelectItem si = new SelectItem();
    si.setLabel("机构树");
    si.setValue("1");
    this.orgBrowModeList.add(si);

    SelectItem si2 = new SelectItem();
    si2.setLabel("团队");
    si2.setValue("2");
    this.orgBrowModeList.add(si2);

    List list = SysCacheTool.queryCodeItemBySetId("2243");
    if ((list != null) && (list.size() > 0))
      for (int i = 0; i < list.size(); i++) {
        CodeItemBO cb = (CodeItemBO)list.get(i);
        if ("1".equals(cb.getItemStatus())) {
          SelectItem si3 = new SelectItem();
          si3.setLabel(cb.getItemName());
          si3.setValue(cb.getItemId());
          this.orgBrowModeList.add(si3);
        }
      }
    return this.orgBrowModeList;
  }
  public void setOrgBrowModeList(List orgBrowModeList) {
    this.orgBrowModeList = orgBrowModeList;
  }

  public String getAfterType()
  {
    return this.afterType;
  }
  public void setAfterType(String afterType) {
    this.afterType = afterType;
  }

  public boolean isModiPerson()
  {
    this.modiPerson = UserAPI.checkButtonOperate(super.getUserInfo(), "031101");
    return this.modiPerson;
  }

  public void setModiPerson(boolean modiPerson) {
    this.modiPerson = modiPerson;
  }

  public boolean isModiBase() {
    this.modiBase = UserAPI.checkButtonOperate(super.getUserInfo(), "031102");
    return this.modiBase;
  }

  public void setModiBase(boolean modiBase) {
    this.modiBase = modiBase;
  }

  public boolean isModiApply() {
    this.modiApply = UserAPI.checkButtonOperate(super.getUserInfo(), "031103");
    return this.modiApply;
  }

  public void setModiApply(boolean modiApply) {
    this.modiApply = modiApply;
  }

  public String getInitRetireQuery()
  {
    try
    {
      String pageFlag = getServletRequest().getParameter("pageFlag");
      if ("1".equals(pageFlag)) {
        try {
          String rowNums = getServletRequest().getParameter("rowNum");
          int pageNum = (getServletRequest().getParameter("pageNum") == null) || ("".equals(getServletRequest().getParameter("pageNum"))) ? 1 : Integer.parseInt(getServletRequest().getParameter("pageNum"));

          String sql = (String)getHttpSession().getAttribute("activeSql");

          TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
          if (table == null) table = new TableVO();
          int rowNum = Constants.ACTIVE_PAGE_SIZE;
          if (rowNums != null) {
            rowNum = Integer.parseInt(rowNums);
          }
          User user = getUserInfo();
          this.personucc.querySql(table, sql, user, pageNum, rowNum);
          getHttpSession().setAttribute("OBJECT", table);
          getHttpSession().setAttribute("activeSql", sql);
          getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
          getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
          return "";
        } catch (Exception e) {
          e.printStackTrace();
          getHttpSession().removeAttribute("OBJECT");
          getHttpSession().removeAttribute("activeSql");
          getHttpSession().removeAttribute("pageNum");
          getHttpSession().removeAttribute("rowNum");
          this.msg.setMainMsg(e, getClass());
        }
      }

      if (super.getRequestParameter("mode") != null) {
        this.mode = super.getRequestParameter("mode");
        this.afterType = CommonFuns.filterNull(super.getRequestParameter("afterType"));
        EmpChangeTypeConfigBO bo = this.personucc.getEmpChangeTypeConfigBO(this.mode);
        if (bo != null) {
          this.personType = bo.getChangingType();
          this.personTypeDesc = CodeUtil.interpertCode(this.personType);
        }

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
        String sql = this.personucc.queryPersonListForRetire(table, this.name, this.personType, this.superId, 1, rowNum, "00900", user);
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf("1"));
        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
        getHttpSession().setAttribute("OBJECT", table);
      }
    }
    catch (Exception e)
    {
    }
    return this.initRetireQuery;
  }
  public void setInitRetireQuery(String initRetireQuery) {
    this.initRetireQuery = initRetireQuery;
  }

  public String getOrgMode() {
    return this.orgMode;
  }
  public void setOrgMode(String orgMode) {
    this.orgMode = orgMode;
  }

  public String getReduceWorkFlow() {
    try {
      if (("1".equals(Constants.EMP_REDUCE_AFTER_APPROVE)) || ("2".equals(Constants.EMP_REDUCE_AFTER_APPROVE))) {
        this.reduceWorkFlow = "1";
      }
    }
    catch (Exception e)
    {
    }
    return this.reduceWorkFlow;
  }
  public void setReduceWorkFlow(String workFlow) {
    this.reduceWorkFlow = workFlow;
  }

  public String getWorkFlow() {
    try {
      if ((this.wfservice.findWFDefine(super.getUserInfo().getOrgId(), WFTypeBO.RYGL_CAR_ENTER) != null) || (this.wfservice.findWFDefine(super.getUserInfo().getOrgId(), WFTypeBO.RYGL_WORK_ENTER) != null))
      {
        this.workFlow = "1";
      }
    }
    catch (Exception e)
    {
    }
    return this.workFlow;
  }
  public void setWorkFlow(String workFlow) {
    this.workFlow = workFlow;
  }

  public String getWeaveWarn()
  {
    try
    {
      if (super.getRequestParameter("pk") != null) {
        this.weaveWarn = this.personucc.weaveWarn(super.getRequestParameter("pk"));
      }
      else if (super.getServletRequest().getAttribute("P_PERSONID") != null) {
        this.weaveWarn = this.personucc.weaveWarn(super.getRequestParameter("P_PERSONID"));
      }
    }
    catch (Exception e)
    {
    }
    return this.weaveWarn;
  }
  public void setWeaveWarn(String weaveWarn) {
    this.weaveWarn = weaveWarn;
  }

  public IWageSetPersonUCC getWagesetpersonucc()
  {
    return this.wagesetpersonucc;
  }
  public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
    this.wagesetpersonucc = wagesetpersonucc;
  }

  public UserAPI getUserApi() {
    return this.userApi;
  }
  public void setUserApi(UserAPI userApi) {
    this.userApi = userApi;
  }

  public WageAPI getWageapi() {
    return this.wageapi;
  }
  public void setWageapi(WageAPI wageapi) {
    this.wageapi = wageapi;
  }

  public List getReduceList() {
    return this.reduceList;
  }
  public void setReduceList(List list) {
    this.reduceList = list;
  }

  public PersonBO getPersonbo() {
    return this.personbo;
  }
  public void setPersonbo(PersonBO bo) {
    this.personbo = bo;
  }

  public EmpReduceBO getReducebo() {
    return this.reducebo;
  }
  public void setReducebo(EmpReduceBO bo) {
    this.reducebo = bo;
  }

  public String getDoBatchReduceAudit() {
    try {
      if (super.getRequestParameter("pIDs") != null) {
        this.code = super.getRequestParameter("pIDs");
        String[] pids = this.code.split(",");
        this.reduceList = new ArrayList();
        for (int i = 0; i < pids.length; i++) {
          EmpReduceBO rb = this.personucc.findReduceBO(pids[i]);
          PersonBO pb = SysCacheTool.findPersonById(rb.getPersID());
          rb.setA001054cur(CodeUtil.interpertCode("0135", pb.getPersonType()));
          rb.setPersName(pb.getName());
          rb.setPersCode(pb.getPersonCode());
          rb.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId()));
          if (pb.getDegree() != null) {
            rb.setDegreeName(CodeUtil.interpertCode("0140", pb.getDegree()));
          }
          if (rb.getA001054() != null) {
            rb.setA001054des(CodeUtil.interpertCode("0135", rb.getA001054()));
          }
          if (rb.getA001725() != null) {
            rb.setA001725des(CodeUtil.interpertCode("0145", rb.getA001725()));
          }
          if (rb.getA016010() != null) {
            rb.setA016010des(CodeUtil.interpertCode("0200", rb.getA016010()));
          }
          this.reduceList.add(rb);
          String sql = "insert into emp_audit_info (id,changedate,changetype) values('"+pids[i]+"','"+CommonFuns.getSysDate("yyyy-MM-dd")+"','2')";
          JdbcTemplate jdbcTemplate = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
          jdbcTemplate.execute(sql);
        }
      }
    }
    catch (Exception e)
    {
    }
    return this.doBatchReduceAudit;
  }
  public void setDoBatchReduceAudit(String audit) {
    this.doBatchReduceAudit = audit;
  }

  public String getDoReduceAudit() {
    try {
      if (super.getRequestParameter("pID") != null) {
        this.code = super.getRequestParameter("pID");
        this.reducebo = this.personucc.findReduceBO(this.code);
        this.personbo = SysCacheTool.findPersonById(this.reducebo.getPersID());
        this.personbo.setPersonType(CodeUtil.interpertCode("0135", this.personbo.getPersonType()));
        this.personbo.setSex(CodeUtil.interpertCode("0100", this.personbo.getSex()));
        this.personbo.setState(CodeUtil.interpertCode("0145", this.personbo.getState()));
        this.personbo.setFolk(CodeUtil.interpertCode("0115", this.personbo.getFolk()));
        this.reducebo.setPersName(this.personbo.getName());
        this.reducebo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.personbo.getOrgId()));
        if (this.personbo.getDegree() != null) {
          this.reducebo.setDegreeName(CodeUtil.interpertCode("0140", this.personbo.getDegree()));
        }
        if (this.reducebo.getA001054() != null) {
          this.reducebo.setA001054des(CodeUtil.interpertCode("0135", this.reducebo.getA001054()));
        }
        if (this.reducebo.getA001725() != null) {
          this.reducebo.setA001725des(CodeUtil.interpertCode("0145", this.reducebo.getA001725()));
        }
        if (this.reducebo.getA016010() != null) {
          this.reducebo.setA016010des(CodeUtil.interpertCode("0200", this.reducebo.getA016010()));
        }
        this.reducebo.setApplyIDName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, this.reducebo.getApplyID()));
      }
    }
    catch (Exception e)
    {
    }
    return this.doReduceAudit;
  }
  public void setDoReduceAudit(String audit) {
    this.doReduceAudit = audit;
  }

  public String getAuditStatus() {
    return this.auditStatus;
  }

  public void setAuditStatus(String auditStatus) {
    this.auditStatus = auditStatus;
  }

  public String getType()
  {
    return this.type;
  }
  public void setType(String st) {
    this.type = st;
  }

  public String getInitReduceAudit() {
    if (super.getRequestParameter("type") != null) {
      this.superId = super.getRequestParameter("superId");
      this.type = super.getRequestParameter("type");
      doauditQuery();
    }

    return this.initReduceAudit;
  }
  public void setInitReduceAudit(String init) {
    this.initReduceAudit = init;
  }

  public PageVO getPagevo() {
    return this.pagevo;
  }
  public void setPagevo(PageVO vo) {
    this.pagevo = vo;
  }

  public String getListReduce()
  {
    return this.listReduce;
  }

  public void setListReduce(String listReduce) {
    this.listReduce = listReduce;
  }

  public String batchauditReduceNO()
  {
    try
    {
      if ((this.code != null) && (!"".equals(this.code))) {
        String[] pids = this.code.split(",");
        for (int i = 0; i < pids.length; i++) {
          EmpReduceBO rb = this.personucc.findReduceBO(pids[i]);
          rb.setAuditID(super.getUserInfo().getUserId());
          rb.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
          rb.setAuditResult("0");
          this.personucc.saveReduceBO(rb);
        }
      }
    }
    catch (Exception e)
    {
    }
    return "success";
  }

  public String batchauditReduceOK() {
    try {
      if ((this.code != null) && (!"".equals(this.code))) {
        String[] pids = this.code.split(",");
        for (int i = 0; i < pids.length; i++) {
          EmpReduceBO rb = this.personucc.findReduceBO(pids[i]);
          rb.setAuditID(super.getUserInfo().getUserId());
          rb.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
          rb.setAuditResult("1");
          this.personucc.saveReduceBO(rb);
          String[]ids=rb.getPersID().split(",");
          PersonChangeVO personchangevo = new PersonChangeVO();
          personchangevo.setTractDate(CommonFuns.getSysDate("yyyy-MM-dd"));
          personchangevo.setTractPerson(super.getUserInfo().getUserId());
          personchangevo.setChangeDate(rb.getApplyDate());
          personchangevo.setChangeType(rb.getA016010());
          
          this.personucc.updateRetirePerson(super.getUserInfo(), personchangevo, ids);
//          this.personucc.updateRetirePerson(personchangevo, rb.getPersID().split(","));
          this.personucc.ModifyPersonType(ids, rb.getA001054());
          this.personucc.ModifyPersonStatus(ids, rb.getA001725());
          SysCache.setMap(rb.getPersID().split(","), 3, 6);
        }
      }
    }
    catch (Exception e)
    {
    }
    return "success";
  }

  public String auditReduceNO() {
    try {
      this.reducebo.setAuditID(super.getUserInfo().getUserId());
      this.reducebo.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      this.reducebo.setAuditResult("0");
      this.reducebo.setStatus("2");
      this.personucc.saveReduceBO(this.reducebo);

      this.name = "";
      String[] personids = this.reducebo.getPersID().split(",");
      for (int i = 0; i < personids.length; i++) {
        WFTransaction trans = new WFTransaction();
        trans.setUser(super.getUserInfo());
        PersonBO pb = SysCacheTool.findPersonById(personids[i]);
        this.name = (this.name + " " + pb.getName());
        if ((pb.getDegree() != null) && (!"".equals(pb.getDegree())) && (Constants.EMP_CADRESCODE.indexOf(pb.getDegree() + ",") >= 0)) {
          trans.setWfType(WFTypeBO.RYGL_CAR_EXIT);
          trans.setOperID("0357");
        }
        else {
          trans.setWfType(WFTypeBO.RYGL_WORK_EXIT);
          trans.setOperID("0356");
        }
        trans.setLinkID(this.reducebo.getItemID());
        trans.setStatusValue("0");
        trans.getParaHash().put("NAME", pb.getName());
        trans.getParaHash().put("RESULT", "未通过审批");

        this.wfservice.processTrans(trans);
      }

      if (this.autoMessage) {
        String[] oper = this.personucc.queryReducePersonOperater(personids);
        for (int i = 0; i < oper.length; i++) {
          ShortMessageBO sbo = new ShortMessageBO();
          sbo.setReceiveID(oper[i]);
          sbo.setSendID(super.getUserInfo().getUserId());
          sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
          sbo.setIsPopup("0");
          sbo.setContent("您报送的人员未通过审批！(" + this.name + " )");
          this.shortmessageucc.SaveMessage(sbo);
        }
      }
    }
    catch (Exception e)
    {
    }
    return "success";
  }

  public String resumeAudit() {
    try {
      this.reducebo.setAuditID("");
      this.reducebo.setAuditDate("");
      this.reducebo.setAuditResult("");
      this.reducebo.setStatus("");
      this.personucc.saveReduceBO(this.reducebo);

      if ("1".equals(Constants.EMP_REDUCE_AFTER_APPROVE))
      {
        WFTransaction trans = new WFTransaction();
        trans.setUser(super.getUserInfo());
        PersonBO pb = SysCacheTool.findPersonById(this.reducebo.getPersID());
        if ("2".equals(Constants.EMP_REDUCE_AFTER_APPROVE)) {
          trans.setWfType(WFTypeBO.RYGL_COMMON_OUT);
        }
        else if ((pb.getDegree() != null) && (!"".equals(pb.getDegree())) && (Constants.EMP_CADRESCODE.indexOf(pb.getDegree() + ",") >= 0)) {
          trans.setWfType(WFTypeBO.RYGL_CAR_EXIT);
        }
        else {
          trans.setWfType(WFTypeBO.RYGL_WORK_EXIT);
        }

        trans.setOperID("0303");
        trans.setLinkID(this.reducebo.getItemID());
        trans.setStatusValue("报批");
        trans.setDeptID(pb.getDeptId());
        trans.setWffunction("emp_retireservice");

        WFProcessBO processbo = this.wfservice.findWFProcessBOByLinkID(trans.getLinkID());
        WFNodeBO node = this.wfservice.findWFNodeBOByOper(processbo.getDefID(), "0303");
        if (node != null) {
          processbo.setCurNode(node.getNodeID());
          this.wfservice.saveWFProcessBO(processbo);
        }

        this.wfservice.processTrans(trans);
      }
    }
    catch (Exception e)
    {
    }
    return "success";
  }
  public String auditReduceOK() {
    try {
      this.reducebo.setAuditID(super.getUserInfo().getUserId());
      this.reducebo.setAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      this.reducebo.setAuditResult("1");
      this.reducebo.setStatus("1");
      this.personucc.saveReduceBO(this.reducebo);

      PersonChangeVO personchangevo = new PersonChangeVO();
      personchangevo.setTractDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      personchangevo.setTractPerson(this.reducebo.getApplyID());
      personchangevo.setChangeDate(this.reducebo.getA016020());
      personchangevo.setChangeType(this.reducebo.getA016010());
      personchangevo.setReason(this.reducebo.getA016060());
      this.personucc.updateRetirePerson(super.getUserInfo(), personchangevo, this.reducebo.getPersID().split(","));
//      this.personucc.updateRetirePerson(personchangevo, this.reducebo.getPersID().split(","));
      this.personucc.ModifyPersonType(this.reducebo.getPersID().split(","), this.reducebo.getA001054());
      this.personucc.ModifyPersonStatus(this.reducebo.getPersID().split(","), this.reducebo.getA001725());
      SysCache.setMap(this.reducebo.getPersID().split(","), 3, 6);

      String[] personids = this.reducebo.getPersID().split(",");
      this.name = "";
      for (int i = 0; i < personids.length; i++) {
        WFTransaction trans = new WFTransaction();
        trans.setUser(super.getUserInfo());
        PersonBO pb = SysCacheTool.findPersonById(personids[i]);
        this.name = (this.name + " " + pb.getName());
        if ((pb.getDegree() != null) && (Constants.EMP_CADRESCODE.indexOf(pb.getDegree() + ",") >= 0)) {
          trans.setWfType(WFTypeBO.RYGL_CAR_EXIT);
          trans.setOperID("0357");
        }
        else {
          trans.setWfType(WFTypeBO.RYGL_WORK_EXIT);
          trans.setOperID("0356");
        }
        trans.setLinkID(personids[i]);
        trans.setStatusValue("1");
        trans.getParaHash().put("NAME", pb.getName());
        trans.getParaHash().put("RESULT", "通过审批");
        this.wfservice.processTrans(trans);
        String sql = "insert into emp_audit_info (id,changedate,changetype) values('"+personids[i]+"','"+CommonFuns.getSysDate("yyyy-MM-dd")+"','2')";
        JdbcTemplate jdbcTemplate = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
        jdbcTemplate.execute(sql);
      }

      if (this.autoMessage) {
        String[] oper = this.personucc.queryReducePersonOperater(personids);
        for (int i = 0; i < oper.length; i++) {
        	
          ShortMessageBO sbo = new ShortMessageBO();
          sbo.setReceiveID(oper[i]);
          sbo.setSendID(super.getUserInfo().getUserId());
          sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
          sbo.setIsPopup("0");
          sbo.setContent("您报送的人员已审批通过！(" + this.name + " )");
          this.shortmessageucc.SaveMessage(sbo);
        }
      }
      doauditQuery();
    }
    catch (Exception e)
    {
    }
    return "success";
  }
  
  public String auditfirst() {
    this.pagevo.setCurrentPage(1);
    doauditQuery();
    return "";
  }
  public String auditlast() {
    this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
    doauditQuery();
    return "";
  }
  public String auditpre() {
    if (this.pagevo.getCurrentPage() >= 2) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
      doauditQuery();
    }
    return "";
  }
  public String auditnext() {
    if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
      doauditQuery();
    }
    return "";
  }
  public String downloadFile() {
    ServletContext context = BaseBackingBean.getServletContext();
    String path = context.getRealPath("/") + File.separator + "file" + File.separator + "tmp";
    List list = new ArrayList();
    String[] header = new String[8];

    header[0] = "申请时间";
    header[1] = "所属单位";
    header[2] = "姓名";
    header[3] = "身份";
    header[4] = "减少类别";
    header[5] = "变更后类别";
    header[6] = "变更后状态";
    try {
      for (int i = 0; i < this.reducebos.size(); i++) {
        EmpReduceBO vo = (EmpReduceBO)this.reducebos.get(i);
        String[] content = new String[16];
        content[0] = CommonFuns.filterNull(vo.getApplyDate());
        content[1] = CommonFuns.filterNull(vo.getOrgName());
        content[2] = CommonFuns.filterNull(vo.getPersName());
        content[3] = CommonFuns.filterNull(vo.getDegreeName());
        content[4] = CommonFuns.filterNull(vo.getA016010des());
        content[5] = CommonFuns.filterNull(vo.getA001054des());
        content[6] = CommonFuns.filterNull(vo.getA001725des());
        list.add(i, content);
      }
      String fileName = FileUtil.exportFile(path, header, null, list, false);

      String url = super.getServletRequest().getContextPath() + "/file/tmp/" + fileName;
      FacesContext ctx = FacesContext.getCurrentInstance();
      HttpServletResponse response = (HttpServletResponse)ctx.getExternalContext().getResponse();
      ServletOutputStream out = response.getOutputStream();
      StringBuffer buf = new StringBuffer();
      buf.append("<script type=text/javascript>");
      buf.append("window.open('").append(url).append("')");
      buf.append("</script >");
      out.print(buf.toString());
      out.flush();
    } catch (Exception e) {
    }
    return "";
  }

  public String doauditQuery() {
    try {
      if ((this.superId == null) || ("".equals(this.superId))) {
        User user = super.getUserInfo();
        if ("-1".equals(user.getprocessUnit())) {
          this.superId = Constants.ORG_BENBU;
        }
        else {
          this.superId = user.getOrgId();
        }
      }
      if (this.pagevo.getCurrentPage() == 0) this.pagevo.setCurrentPage(1);
      String addwhere = "  bo.applyDate like '" + CommonFuns.filterNull(this.processDate) + "%'";
      if ("1".equals(this.type)) {
        addwhere = addwhere + " and (pb.degree in (" + Constants.EMP_CADRESCODE + ") or pb.degree is null or pb.degree='')";
      }
      else {
        addwhere = addwhere + " and (pb.degree in (" + Constants.EMP_WORKCODE + ") or pb.degree is null or pb.degree='')";
      }
      if (("".equals(this.auditStatus)) || (this.auditStatus == null)) {
        addwhere = addwhere + " and isnull(bo.auditResult,' ')=' '";
      }
      else {
        addwhere = addwhere + " and bo.auditResult='" + this.auditStatus + "' ";
      }
      if ((this.name != null) && (!"".equals(this.name))) {
        addwhere = addwhere + " and (pb.name like '%" + this.name + "%' or pb.shortName like '%" + this.name + "%' or pb.personCode like '%" + this.name + "%')";
      }
      this.reducebos = this.personucc.queryReducingPersonList(this.superId, this.pagevo, addwhere);
    } catch (Exception ex) {
      this.msg.setMainMsg(ex, getClass());
    }
    return "";
  }
  public String first() {
    this.pagevo.setCurrentPage(1);
    doQuery();
    return "";
  }
  public String last() {
    this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
    doQuery();
    return "";
  }
  public String pre() {
    if (this.pagevo.getCurrentPage() >= 2) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
      doQuery();
    }
    return "";
  }
  public String next() {
    if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
      doQuery();
    }
    return "";
  }

  public List getReducingbos() {
    doQuery();
    return this.reducingbos;
  }

  public void setReducingbos(List reducingbos) {
    this.reducingbos = reducingbos;
  }

  public List getReducebos()
  {
    if (this.reducebos == null) {
      this.reducebos = new ArrayList();
    }
    return this.reducebos;
  }
  public void setReducebos(List list) {
    this.reducebos = list;
  }

  public boolean isOnlyAuditing() {
    return this.onlyAuditing;
  }

  public void setOnlyAuditing(boolean onlyAuditing) {
    this.onlyAuditing = onlyAuditing;
  }

  public void doQuery()
  {
    try {
      if ((this.superId == null) || ("".equals(this.superId))) {
        this.superId = super.getUserInfo().getOrgId();
      }
      if (this.pagevo.getCurrentPage() == 0) this.pagevo.setCurrentPage(1);
      String addwhere = " 1=1 ";
      if ((this.processDate != null) && (!"".equals(this.processDate))) {
        addwhere = addwhere + " and bo.applyDate like '" + this.processDate + "%'";
      }

      if (("".equals(this.auditStatus)) || (this.auditStatus == null)) {
        addwhere = addwhere + " and isnull(bo.auditResult,' ')=' '";
      }
      else {
        addwhere = addwhere + " and bo.auditResult='" + this.auditStatus + "' ";
      }

      this.reducingbos = this.personucc.queryReducingPersonList(this.superId, this.pagevo, addwhere);
      for (int i = 0; i < this.reducingbos.size(); i++) {
        EmpReduceBO bo = (EmpReduceBO)this.reducingbos.get(i);
        bo.setA016060des(CodeUtil.interpertCode(bo.getA016060()));
      }
    } catch (Exception ex) {
      this.msg.setMainMsg(ex, getClass());
    }
  }

  public String getProcessDate() {
    return this.processDate;
  }
  public void setProcessDate(String date) {
    this.processDate = date;
  }
  public void changeAuditStatus(ValueChangeEvent event) {
    this.auditStatus = event.getNewValue().toString();
    doQueryCheckAuditPerson();
  }

  public String doQueryCheckAuditPerson() {
    try {
      User user = getUserInfo();
      if ("".equals(this.superId)) {
        if (RoleInfoBO.ORGTYPE_ALL.equals(user.getprocessUnit())) {
          this.superId = Constants.ORG_BENBU;
        }
        else {
          this.superId = user.getOrgId();
        }
      }

      TableVO table = new TableVO();
      String rowNums = (String)getHttpSession().getAttribute("rowNum");
      int rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (rowNums != null) {
        rowNum = Integer.parseInt(rowNums);
      }

      String sql = "";

      int pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
      if (pageNum == 0)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("pageNum")));
      if (pageNum == 0) {
        pageNum = 1;
      }
      String typeWhere = "";
      if ("1".equals(this.type)) {
        typeWhere = " (A001031 in (" + Constants.EMP_CADRESCODE + ") or A001031 is null or A001031='')";
      }
      else if ("2".equals(this.type)) {
        typeWhere = " (A001031 in (" + Constants.EMP_WORKCODE + ") or A001031 is null or A001031='')";
      }
      else {
        typeWhere = " (A001031 in (" + Constants.EMP_OTHER + ")  or A001031 is null or A001031='')";
      }
      if ((this.name != null) && (!"".equals(this.name))) {
        typeWhere += " and (A001001 like '%" + this.name + "%' or a001002 like '%" + this.name + "%' or A001735 like '%" + this.name + "%')";
      }
      if ((this.processDate != null) && (!"".equals(this.processDate))) {
        typeWhere += " and A016020 like '" + this.processDate + "%' ";
      }
      if (("00000".equals(this.auditStatus)) || ("".equals(this.auditStatus)) || (this.auditStatus == null)) {
        sql = this.personucc.queryAuditingPersonList(table, this.superId, pageNum, rowNum, user, "157", "  ((auditResult <>'00900' and  auditResult<>'00901') or auditResult is null) and " + typeWhere);
      }
      else {
        sql = this.personucc.queryAuditingPersonList(table, this.superId, pageNum, rowNum, user, "157", " auditResult='" + this.auditStatus + "' and " + typeWhere);
      }
      CommonFuns.DebugLog(sql);
      getHttpSession().setAttribute("activeSql", sql);
      getHttpSession().setAttribute("pageNum", String.valueOf("1"));
      getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      getHttpSession().setAttribute("OBJECT", table);
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public String getCheckingPerson_audit() {
    try {
      if (super.getRequestParameter("superId") != null) {
        this.superId = super.getRequestParameter("superId");
        this.superName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.superId);
      }
      if (super.getRequestParameter("type") != null) {
        if ((this.auditStatus == null) || ("".equals(this.auditStatus))) {
          this.auditStatus = "00000";
        }
        this.type = super.getRequestParameter("type");
        doQueryCheckAuditPerson();
      }
    }
    catch (Exception e)
    {
    }
    return this.checkingPerson_audit;
  }
  public void setCheckingPerson_audit(String check) {
    this.checkingPerson_audit = check;
  }

  public String doQueryCheckingPerson() {
    return getCheckingPerson();
  }

  public String getCheckingPerson() {
    try {
      if (super.getRequestParameter("mode") != null) {
        this.mode = super.getRequestParameter("mode");
      }
      TableVO table = new TableVO();
      String rowNums = (String)getHttpSession().getAttribute("rowNum");
      int rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (rowNums != null) {
        rowNum = Integer.parseInt(rowNums);
      }
      int pageNum = 1;
      if ((super.getRequestParameter("pageNum") != null) && (!"".equals(super.getRequestParameter("pageNum")))) {
        pageNum = Integer.parseInt(super.getRequestParameter("pageNum"));
      }
      User user = getUserInfo();
      String sql = "";
      String dateWhere = " 1=1 ";
      if ((!"-1".equals(getProcessDate())) && (!"".equals(getProcessDate()))) {
        dateWhere = dateWhere + " and A016020 like '" + getProcessDate() + "%'";
      }
      String orgid = null;
      if (!RoleInfoBO.ORGTYPE_ALL.equals(user.getprocessUnit()))
        orgid = user.getOrgId();
      String condition;
      if ((this.auditStatus == null) || ("".equals(this.auditStatus))) {
        condition = "  (auditResult is null or  auditResult='' or auditResult='报批') and " + dateWhere;
      }
      else {
        condition = " auditResult='" + this.auditStatus + "'  and " + dateWhere;
      }
      if ("EMP_CADRESCODE".equals(this.mode)) {
        condition = condition + " and (A001031 is null or A001031='' or A001031 in ('" + Constants.EMP_CADRESCODE.replaceAll(",", "','") + "'))";
      }
      else {
        condition = condition + " and (A001031 is null or A001031='' or A001031 in ('" + Constants.EMP_WORKCODE.replaceAll(",", "','") + "'))";
      }
      sql = this.personucc.queryAuditingPersonList(table, orgid, pageNum, rowNum, user, "157", condition);
      getHttpSession().setAttribute("activeSql", sql);
      getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
      getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      getHttpSession().setAttribute("OBJECT", table);
    }
    catch (Exception e)
    {
    }
    return this.checkingPerson;
  }
  public void setCheckingPerson(String person) {
    this.checkingPerson = person;
  }

  public List getListTableList()
  {
    try {
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

  public void setPids(List li) {
    this.pids = li;
  }
  public List getPids() {
    return this.pids;
  }

  public String getNameStrs() {
    return this.nameStrs;
  }
  public void setNameStrs(String c) {
    this.nameStrs = c;
  }

  public String getCode() {
    return this.code;
  }
  public void setCode(String c) {
    this.code = c;
  }

  public String getPersonID() {
    return this.personID;
  }
  public void setPersonID(String setId) {
    this.personID = setId;
  }

  public String getDept() {
    return this.dept;
  }
  public void setDept(String setId) {
    this.dept = setId;
  }

  public String getDefaultQry() {
    return this.defaultQry;
  }
  public void setDefaultQry(String id) {
    this.defaultQry = id;
  }

  public boolean isHaveA001003() {
    InfoItemBO bo = SysCacheTool.findInfoItem("", "A001003");
    if ((bo == null) || (!"1".equals(bo.getItemStatus()))) {
      this.haveA001003 = false;
    }
    else {
      this.haveA001003 = true;
    }
    return this.haveA001003;
  }

  public void setHaveA001003(boolean haveA001003) {
    this.haveA001003 = haveA001003;
  }

  public IUserQryUCC getUserqryucc()
  {
    return this.userqryucc;
  }
  public void setUserqryucc(IUserQryUCC iu) {
    this.userqryucc = iu;
  }

  public IShortMessageUCC getShortmessageucc() {
    return this.shortmessageucc;
  }
  public void setShortmessageucc(IShortMessageUCC ucc) {
    this.shortmessageucc = ucc;
  }

  public IQueryUCC getQueryucc() {
    return this.queryucc;
  }
  public void setQueryucc(IQueryUCC iu) {
    this.queryucc = iu;
  }

  public void setUserreportucc(IUserReportUCC iur) {
    this.userreportucc = iur;
  }
  public IUserReportUCC getUserreportucc() {
    return this.userreportucc;
  }

  public List getDisplaySetList() {
    if (this.displaySetList == null) {
      InitDisplay();
    }
    return this.displaySetList;
  }
  public void setDisplaySetList(List list) {
    this.displaySetList = list;
  }

  public List getInsdisplaySetList() {
    if (this.insdisplaySetList == null) {
      InitInsDisplay();
    }
    return this.insdisplaySetList;
  }
  public void setInsdisplaySetList(List insdisplaySetList) {
    this.insdisplaySetList = insdisplaySetList;
  }

  public String getPersonTypeDesc()
  {
    if ((this.personTypeValue == null) || ("".equals(this.personTypeValue))) {
      this.personTypeDesc = "当前人员类别:全部人员";
    }
    else {
      this.personTypeDesc = ("当前人员类别:" + this.personTypeValue);
    }
    return this.personTypeDesc;
  }
  public void setPersonTypeDesc(String desc) {
    this.personTypeDesc = desc;
  }

  public String getMode()
  {
    if (super.getRequestParameter("mode") != null) {
      this.mode = super.getRequestParameter("mode");
    }
    return this.mode;
  }
  public void setMode(String mo) {
    this.mode = mo;
  }

  public String getTitle() {
    if (super.getRequestParameter("title") != null) {
      this.title = super.getRequestParameter("title");
    }
    return this.title;
  }
  public void setTitle(String mo) {
    this.title = mo;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public WorkFlowService getWfservice() {
    return this.wfservice;
  }
  public void setWfservice(WorkFlowService wfservice) {
    this.wfservice = wfservice;
  }
  private List _initDisplay(String defaultqry, String operID) {
    ArrayList setList = new ArrayList();
    SelectItem itemSpace = new SelectItem();
    itemSpace.setLabel("---请选择显示方案---");
    itemSpace.setValue("-1");
    setList.add(itemSpace);
    try
    {
      QueryVO qv = this.queryucc.findQueryVO(defaultqry);
      SelectItem itemDefault = new SelectItem();
      itemDefault.setLabel(qv.getName());
      itemDefault.setValue(qv.getQryId());
      setList.add(itemDefault);
      this.defaultQry = defaultqry;

      List list = this.userqryucc.queryUserQry(super.getUserInfo().getUserId(), operID);
      for (int i = 0; i < list.size(); i++) {
        UserQryVO role = (UserQryVO)list.get(i);
        SelectItem item = new SelectItem();
        item.setLabel(role.getQryName());
        item.setValue(role.getQryID());
        if ((role.getIsCurrent() != null) && (role.getIsCurrent().equals("1"))) {
          this.defaultQry = role.getQryID();
        }
        setList.add(item);
      }
    }
    catch (Exception e)
    {
    }
    return setList;
  }

  private void InitDisplay() {
    this.displaySetList = _initDisplay("156", this.OPER_ID);
  }
  private void InitInsDisplay() {
    this.insdisplaySetList = _initDisplay("143", "1402");
  }

  public String getPersonList() {
    if(this.personType==null || "".equals(this.personType)){
		try {
			this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
    String pageFlag = getServletRequest().getParameter("pageFlag");
    if ("1".equals(pageFlag)) {
      try {
        String rowNums = getServletRequest().getParameter("rowNum");
        int pageNum = (getServletRequest().getParameter("pageNum") == null) || ("".equals(getServletRequest().getParameter("pageNum"))) ? 1 : Integer.parseInt(getServletRequest().getParameter("pageNum"));

        String sql = (String)getHttpSession().getAttribute("activeSql");

        TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
        if (table == null) table = new TableVO();
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null) {
          rowNum = Integer.parseInt(rowNums);
        }
        User user = getUserInfo();
        this.personucc.querySql(table, sql, user, pageNum, rowNum);
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
      return "inited";
    }

    if (super.getRequestParameter("superId") != null) {
      if (super.getRequestParameter("QryID") != null) {
        this.defaultQry = super.getRequestParameter("QryID");
        if ("143".equals(this.defaultQry)) {
          InitInsDisplay();
        }
        else
          InitDisplay();
      }
      else
      {
        InitDisplay();
      }
      String flag = getServletRequest().getParameter("flag");
      if ((flag != null) && (!"".equals(flag))) {
        this.orgMode = flag;
      }
      String sessionFlag = getServletRequest().getParameter("sessionFlag");
      String backFlag = getServletRequest().getParameter("backFlag");
      if ("2".equals(flag)) {
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        try {
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
          String where = " A001.ID in (select PERSON_ID from EMP_TEAM_PERSON where TEAM_ID='" + this.superId + "')";
          String sql = this.personucc.queryPersonList(table, this.name, this.personType, null, 1, rowNum, "00900", null, this.defaultQry, where);
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
      else {
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        try {
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
          String sql = "";

          if ("1".equals(backFlag))
            sql = this.personucc.queryPersonListBack(table, this.name, this.personType, this.superId, 1, rowNum, "00900", user);
          else if ("2".equals(backFlag))
            sql = this.personucc.queryPersonListForRetire(table, this.name, this.personType, this.superId, 1, rowNum, "00900", user);
          else {
            sql = this.personucc.queryPersonList(table, this.name, this.personType, this.superId, 1, rowNum, "00900", user, this.defaultQry);
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
    }

    return "inited";
  }
  public void setPersonList(String personList) {
    this.personList = personList;
  }

  public String getName() {
    return this.name;
  }
  public void setName(String name) {
    this.name = name;
  }

  public String getPersonType()
  {
    if ((this.personType == null) || ("".equals(this.personType))) {
      if ((this.mode != null) && (!"".equals(this.mode))) {
        this.personType = Constants.OUT_PERSON_SCOPE;
        this.personTypeValue = Constants.OUT_PERSON_SCOPE_DES;
      }
      else {
        this.personType = Constants.IN_SERVICE_TYPE;
        this.personTypeValue = Constants.IN_SERVICE_DES;
      }
    }

    return this.personType;
  }
  public void setPersonType(String personType) {
    this.personType = personType;
  }

  public String getPersonTypeValue()
  {
    this.personTypeValue = "";
    if (this.personType != null) {
      this.personTypeValue = CodeUtil.interpertCode(CodeUtil.TYPE_CODE, this.personType);
    }
    return this.personTypeValue;
  }
  public void setPersonTypeValue(String personTypeValue) {
    this.personTypeValue = personTypeValue;
  }

  public String getSuperName()
  {
    if ((this.superId != null) && (!"".equals(this.superId))) {
      this.superName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.superId);
    }
    else {
      this.superName = "";
    }
    return this.superName;
  }
  public void setSuperName(String superId) {
    this.superName = superId;
  }

  public String getSuperId() {
    return this.superId;
  }
  public void setSuperId(String superId) {
    this.superId = superId;
  }
  private void _changeQueryConfig(ValueChangeEvent event, String defaultqry, String operid) {
    try {
      this.defaultQry = event.getNewValue().toString();
      this.userqryucc.CancelSelect(super.getUserInfo().getUserId(), operid);

      if (!this.defaultQry.equals(defaultqry)) {
        UserQryBO ub = this.userqryucc.getQueryByID(super.getUserInfo().getUserId(), this.defaultQry, operid);
        ub.setIsCurrent("1");
        this.userqryucc.save(ub);
      }
      queryPerson();
    }
    catch (Exception e) {
    }
  }

  public void changeQuery(ValueChangeEvent event) {
    _changeQueryConfig(event, "156", this.OPER_ID);
  }
  public void changeInsQuery(ValueChangeEvent event) {
    _changeQueryConfig(event, "143", "1402");
  }

  public String queryMultPerson() {
    String backFlag = getServletRequest().getParameter("backFlag");
    getHttpSession().removeAttribute("OBJECT");
    getHttpSession().removeAttribute("activeSql");
    getHttpSession().removeAttribute("pageNum");
    getHttpSession().removeAttribute("rowNum");
    try {
      TableVO table = new TableVO();
      String rowNums = (String)getHttpSession().getAttribute("rowNum");
      int rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (rowNums != null) {
        rowNum = Integer.parseInt(rowNums);
      }
      User user = getUserInfo();
      String sql = "";
      if ("1".equals(this.orgMode)) {
        sql = this.personucc.queryPersonList(table, this.nameStrs, this.personType, this.superId, 1, rowNum, "00900", user, this.defaultQry);
      }
      else {
        String where = " A001.ID in (select PERSON_ID from EMP_TEAM_PERSON where TEAM_ID='" + this.superId + "')";
        sql = this.personucc.queryPersonList(table, this.name, this.personType, null, 1, rowNum, "00900", null, this.defaultQry, where);
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
    return null;
  }

  public String queryPerson() {
    String backFlag = getServletRequest().getParameter("backFlag");
    getHttpSession().removeAttribute("OBJECT");
    getHttpSession().removeAttribute("activeSql");
    getHttpSession().removeAttribute("pageNum");
    getHttpSession().removeAttribute("rowNum");
    try {
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
      String sql = "";
      if ("1".equals(this.orgMode)) {
        if ("1".equals(backFlag)) {
          sql = this.personucc.queryPersonListBack(table, this.name, this.personType, this.superId, 1, rowNum, "00900", user);
        }
        else
          sql = this.personucc.queryPersonList(table, this.name, this.personType, this.superId, 1, rowNum, "00900", user, this.defaultQry);
      }
      else
      {
        String where = " A001.ID in (select PERSON_ID from EMP_TEAM_PERSON where TEAM_ID='" + this.superId + "')";
        sql = this.personucc.queryPersonList(table, this.name, this.personType, null, 1, rowNum, "00900", null, this.defaultQry, where);
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
    return null;
  }

  public boolean isAutoMessage()
  {
    return this.autoMessage;
  }
  public void setAutoMessage(boolean b) {
    this.autoMessage = b;
  }

  public String getAuditMessage() {
    return this.auditMessage;
  }
  public void setAuditMessage(String ad) {
    this.auditMessage = ad;
  }

  public String getAuditOpition() {
    return this.auditOpition;
  }
  public void setAuditOpition(String ad) {
    this.auditOpition = ad;
  }

  public String getAuditResult() {
    return this.auditResult;
  }
  public void setAuditResult(String ad) {
    this.auditResult = ad;
  }

  public String deleteInvalid() {
    try {
      String ids = super.getRequestParameter("pids");
      if (ids != null) {
        String[] idList = ids.split(",");

        for (int i = 0; i < idList.length; i++) {
          String oper = this.personucc.queryAddPersonOperater(idList[i]);
          ShortMessageBO sbo = new ShortMessageBO();
          sbo.setReceiveID(oper);
          sbo.setSendID(super.getUserInfo().getUserId());
          sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
          sbo.setIsPopup("0");
          sbo.setContent(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, idList[i]) + "数据不合法，已经删除!");
          this.shortmessageucc.SaveMessage(sbo);

          this.personucc.DeleteHiddenPerson(idList[i]);
        }
      }
    }
    catch (Exception e)
    {
    }
    return "success";
  }

  public String saveAudit() {
    try {
      String name = "";
      String[] ids = getServletRequest().getParameter("pids").split(",");
      JdbcTemplate jdbcTemplate = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
      for (int i = 0; i < ids.length; i++) {
    	this.personucc.UpdateAuditState(ids[i], this.auditOpition, this.auditResult, CommonFuns.getSysDate("yyyy-MM-dd"), super.getUserInfo().getUserId());
        if ("00901".equals(this.auditResult)) {
          this.personucc.UpdateA001730(ids[i], "00900");

          if ("1".equals(Constants.WAGE_POST_LINK)) {
            String set = this.wageapi.querySetByPersonPost(ids[i]);
            if ((set != null) && (!"".equals(set))) {
              String[] pids = new String[1];
              pids[0] = ids[i];
              this.wagesetpersonucc.batchAddPerson(set, pids);
              this.wagesetpersonucc.batchAdd(super.getUserInfo().getUserId(), set, pids);
            }
          }
          String sql = "insert into emp_audit_info (id,changedate,changetype) values('"+ids[i]+"','"+CommonFuns.getSysDate("yyyy-MM-dd")+"','1')";
          jdbcTemplate.execute(sql);
        }
        SysCache.setPerson(ids[i], 2);
        PersonBO pb = SysCacheTool.findPersonById(ids[i]);
        name = name + " " + pb.getName();

        WFTransaction trans = new WFTransaction();
        trans.setUser(super.getUserInfo());
        if ((pb.getDegree() != null) && (Constants.EMP_CADRESCODE.indexOf(pb.getDegree() + ",") >= 0)) {
          trans.setWfType(WFTypeBO.RYGL_CAR_ENTER);
          trans.setOperID("0371");
        }
        else {
          trans.setWfType(WFTypeBO.RYGL_WORK_ENTER);
          trans.setOperID("0369");
        }

        trans.setLinkID(ids[i]);
        trans.setStatusValue(this.auditResult);
        trans.getParaHash().put("NAME", pb.getName());
        trans.getParaHash().put("RESULT", this.auditMessage);
        this.wfservice.processTrans(trans);
      }

      if (this.autoMessage) {
        String[] oper = this.personucc.queryAddPersonOperater(ids);
        for (int i = 0; i < oper.length; i++) {
          ShortMessageBO sbo = new ShortMessageBO();
          sbo.setReceiveID(oper[i]);
          sbo.setSendID(super.getUserInfo().getUserId());
          sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
          sbo.setIsPopup("0");
          sbo.setContent(this.auditMessage + "(" + name + " )");
          this.shortmessageucc.SaveMessage(sbo);
        }
      }
    }
    catch (Exception e) {
    	e.printStackTrace();
    }
    return "success";
  }
}