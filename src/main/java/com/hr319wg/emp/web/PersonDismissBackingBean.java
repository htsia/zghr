package com.hr319wg.emp.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.cont.ucc.IContUCC;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.emp.pojo.bo.ChangeInfoBO;
import com.hr319wg.emp.pojo.bo.EmpBlackSheetBO;
import com.hr319wg.emp.pojo.bo.EmpReduceBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.PersonChangeVO;
import com.hr319wg.emp.ucc.IEmpChangeUCC;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.SysInProcessBO;
import com.hr319wg.sys.pojo.bo.WFDefineExcludeBO;
import com.hr319wg.sys.pojo.bo.WFTypeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.sys.ucc.ISysInProcessUCC;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;

public class PersonDismissBackingBean extends BaseBackingBean
{
  private IEmpChangeUCC empchangeucc;
  private IPersonUCC personucc;
  private WorkFlowService wfservice;
  private ISysInProcessUCC linkucc;
  private IContUCC contucc;
  private IUserReportUCC userreportucc;
  private IWageSetPersonUCC wagesetpersonucc;
  private IWageSetUCC wagesetucc;
  private PersonChangeVO personchangevo = new PersonChangeVO();
  private ChangeInfoBO changevo = new ChangeInfoBO();
  private String pageInit;
  private String chgs;
  private String posts;
  private PageVO pagevo = new PageVO();
  private String postLevel;
  private String afterType;
  private String afterStatus;
  private String initReceive;
  private String initReceiveAudit;
  private String initReceiveWage;
  private String receiveEdit;
  private String receiveWageEdit;
  private String processDate;
  private List personList;
  private List personAuditList;
  private List regTableList;
  private WageAPI wageapi;
  private boolean onlyNotApprove = true;

  private boolean joinBlack = false;
  private String joinReason;
  private boolean useA001725 = true;
  private List wagesets;
  private String wageset;
  private String wageUnit;

  public PageVO getPagevo()
  {
    return this.pagevo;
  }

  public void setPagevo(PageVO pagevo) {
    this.pagevo = pagevo;
  }

  public String getPostLevel()
  {
    return this.postLevel;
  }

  public void setPostLevel(String postLevel) {
    this.postLevel = postLevel;
  }

  public String getInitReceiveWage()
  {
    this.onlyNotApprove = false;
    return this.initReceiveWage;
  }

  public void setInitReceiveWage(String initReceiveWage) {
    this.initReceiveWage = initReceiveWage;
  }

  public String getInitReceiveAudit()
  {
    if (super.getRequestParameter("Init") != null) {
      doQuery();
    }
    return this.initReceiveAudit;
  }

  public void setInitReceiveAudit(String initReceiveAudit) {
    this.initReceiveAudit = initReceiveAudit;
  }

  public boolean isJoinBlack()
  {
    return this.joinBlack;
  }
  public void setJoinBlack(boolean joinBlack) {
    this.joinBlack = joinBlack;
  }

  public String getJoinReason() {
    return this.joinReason;
  }
  public void setJoinReason(String joinReason) {
    this.joinReason = joinReason;
  }

  public boolean isUseA001725()
  {
    this.useA001725 = false;
    InfoItemBO ib = SysCacheTool.findInfoItem("", "A001725");
    if ((ib != null) && 
      ("1".equals(ib.getItemStatus()))) {
      this.useA001725 = true;
    }

    return this.useA001725;
  }

  public void setUseA001725(boolean useA001725) {
    this.useA001725 = useA001725;
  }

  public WorkFlowService getWfservice()
  {
    return this.wfservice;
  }
  public void setWfservice(WorkFlowService wfservice) {
    this.wfservice = wfservice;
  }

  public String getPosts() {
    return this.posts;
  }
  public void setPosts(String po) {
    this.posts = po;
  }

  public boolean isOnlyNotApprove() {
    return this.onlyNotApprove;
  }
  public void setOnlyNotApprove(boolean b) {
    this.onlyNotApprove = b;
  }

  public List getWagesets() {
    return this.wagesets;
  }

  public void setWagesets(List wagesets) {
    this.wagesets = wagesets;
  }

  public String getWageset()
  {
    return this.wageset;
  }

  public void setWageset(String wageset) {
    this.wageset = wageset;
  }

  public String getWageUnit()
  {
    return this.wageUnit;
  }

  public void setWageUnit(String wageUnit) {
    this.wageUnit = wageUnit;
  }

  public String getReceiveWageEdit()
  {
    try
    {
      if (super.getRequestParameter("chgID") != null) {
        this.changevo = this.empchangeucc.findChangeInfo(super.getRequestParameter("chgID"));
        if (this.changevo != null) {
          this.changevo.setName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, this.changevo.getPersonId()));
          this.changevo.setFromOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.changevo.getFromOrgId()));
        }
        List list = this.wagesetucc.querySetByUnitId(this.changevo.getToOrgId());
        this.wagesets = new ArrayList();
        SelectItem si0 = new SelectItem();
        si0.setLabel("--选择帐套--");
        si0.setValue("");
        this.wagesets.add(si0);

        for (int i = 0; i < list.size(); i++) {
          WageSetBO setbo = (WageSetBO)list.get(i);
          if ("0".equals(setbo.getNoUse())) {
            SelectItem si = new SelectItem();
            si.setLabel(setbo.getName());
            si.setValue(setbo.getSetId());
            this.wagesets.add(si);
          }
        }
      }
    }
    catch (Exception e)
    {
    }
    return this.receiveWageEdit;
  }
  public void setReceiveWageEdit(String edit) {
    this.receiveWageEdit = edit;
  }

  public String getReceiveEdit() {
    try {
      if (super.getRequestParameter("chgID") != null) {
        this.changevo = this.empchangeucc.findChangeInfo(super.getRequestParameter("chgID"));
        if (this.changevo != null) {
          this.changevo.setName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, this.changevo.getPersonId()));
          this.changevo.setFromOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.changevo.getFromOrgId()));
        }
        InfoItemBO bo = SysCacheTool.findInfoItem("", "A016020");
        if ("5".equals(bo.getItemDataType())) {
          this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
        }
        else {
          this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM"));
        }
        this.personchangevo.setChangeType("0200300008");
      }
    }
    catch (Exception e)
    {
    }
    return this.receiveEdit;
  }
  public void setReceiveEdit(String edit) {
    this.receiveEdit = edit;
  }

  public String saveReceiveWage() {
    try {
      ChangeInfoBO cb = this.empchangeucc.findChangeInfo(this.changevo.getChgId());

      this.wageapi.addPersonRelation(this.wageUnit, cb.getPersonId());

      if ((this.wageset != null) && (!"".equals(this.wageset))) {
        String[] personId = new String[1];
        personId[0] = cb.getPersonId();
        this.wagesetpersonucc.batchAddPerson(this.wageset, personId);
        this.wagesetpersonucc.batchAdd(super.getUserInfo().getUserId(), this.wageset, personId);
      }
      cb.setWageTransed("1");
      this.empchangeucc.saveOrUpdateChangeInfo(cb);
    }
    catch (Exception e)
    {
    }
    return "success";
  }

  public String saveReceive() {
    try {
      ChangeInfoBO cb = this.empchangeucc.findChangeInfo(this.changevo.getChgId());
      cb.setReceiveDate(this.changevo.getReceiveDate());
      cb.setToDepId(this.changevo.getToDepId());
      cb.setToPostId(this.changevo.getToPostId());
      if ("1".equals(Constants.RECEIVE_BY_AUDIT)) {
        cb.setApplyStatus(ChangeInfoBO.STATUS_TO_APPROVE);
      }
      else {
        cb.setApplyStatus(ChangeInfoBO.STATUS_FINISH);
      }
      cb.setToPostLevel(this.changevo.getToPostLevel());
      this.empchangeucc.saveOrUpdateChangeInfo(cb);

      if (!"1".equals(Constants.RECEIVE_BY_AUDIT))
      {
        this.personchangevo.setTractPerson(super.getUserInfo().getUserId());
        this.personchangevo.setTractDate(CommonFuns.getSysDate("yyyy-MM-dd"));
        this.personucc.chgDismiss(this.personchangevo, cb, cb.getPersonId().split(","));
        SysCache.setMap(cb.getPersonId().split(","), 3, 6);
      }

      SysInProcessBO bo = this.linkucc.getProcessBOByProcessID(cb.getChgId());
      if (bo != null) {
        bo.setHave_process("1");
        this.linkucc.saveProcessBO(bo);
      }

      this.wagesetpersonucc.markTransfer(cb);
    }
    catch (Exception e)
    {
    }
    return "success";
  }
  public String getProcessDate() {
    if (this.processDate == null) {
      this.processDate = CommonFuns.getSysDate("yyyy-MM");
    }
    return this.processDate;
  }
  public void setProcessDate(String date) {
    this.processDate = date;
  }
  public List getRegTableList() {
    try {
      this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), "0431", UserRptVO.TYPE_REG);
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

  public String refreshQuery()
  {
    getPersonList();
    return "";
  }

  public String changeCont() {
    try {
      this.contucc.changeContMaster(this.chgs);
      super.showMessageDetail("处理成功完成！");
    }
    catch (Exception e)
    {
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

  public String doOK() {
    try {
      ChangeInfoBO cb = this.empchangeucc.findChangeInfo(this.chgs);
      cb.setApplyStatus(ChangeInfoBO.STATUS_FINISH);
      this.empchangeucc.saveOrUpdateChangeInfo(cb);

      this.personchangevo.setTractPerson(super.getUserInfo().getUserId());
      this.personchangevo.setTractDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      this.personucc.chgDismiss(this.personchangevo, cb, cb.getPersonId().split(","));
      SysCache.setMap(cb.getPersonId().split(","), 3, 6);
    }
    catch (Exception e)
    {
    }
    return doQuery();
  }
  public String doCancel() {
    try {
      ChangeInfoBO cb = this.empchangeucc.findChangeInfo(this.chgs);
      cb.setApplyStatus(ChangeInfoBO.STATUS_FINISH);
      this.empchangeucc.saveOrUpdateChangeInfo(cb);
    }
    catch (Exception e)
    {
    }
    return doQuery();
  }

  public String doQuery() {
    try {
      if (this.pagevo.getCurrentPage() == 0) this.pagevo.setCurrentPage(1);
      if (this.onlyNotApprove) {
        this.personAuditList = this.empchangeucc.findInfoByOrg("-1", getProcessDate(), ChangeInfoBO.STATUS_TO_APPROVE, this.pagevo);
      }
      else {
        this.personAuditList = this.empchangeucc.findInfoByReceiveOrg("-1", getProcessDate(), "");
      }
      if (this.personAuditList != null)
        for (int i = 0; i < this.personAuditList.size(); i++) {
          ChangeInfoBO cb = (ChangeInfoBO)this.personAuditList.get(i);
          PersonBO pb = SysCacheTool.findPersonById(cb.getPersonId());
          cb.setName(pb.getName());
          cb.setPersonCode(pb.getPersonCode());
          cb.setFromOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getFromOrgId()));
          cb.setToOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getToOrgId()));
          cb.setFromDepName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getFromDepId()));
          cb.setToDepName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getToDepId()));
          cb.setFromPostName(CodeUtil.interpertCode(CodeUtil.TYPE_POST, cb.getFromPostId()));
        }
    }
    catch (Exception e)
    {
      this.personAuditList = new ArrayList();
    }
    return "";
  }
  public List getPersonAuditList() {
    return this.personAuditList;
  }

  public void setPersonAuditList(List personAuditList) {
    this.personAuditList = personAuditList;
  }

  public List getPersonList() {
    try {
      if (this.onlyNotApprove) {
        this.personList = this.empchangeucc.findInfoByReceiveOrg(super.getUserInfo().getOrgId(), getProcessDate(), ChangeInfoBO.STATUS_APPLY);
      }
      else {
        this.personList = this.empchangeucc.findInfoByReceiveOrg(super.getUserInfo().getOrgId(), getProcessDate(), "");
      }
      if (this.personList != null)
        for (int i = 0; i < this.personList.size(); i++) {
          ChangeInfoBO cb = (ChangeInfoBO)this.personList.get(i);
          PersonBO pb = SysCacheTool.findPersonById(cb.getPersonId());
          if (pb != null) {
            cb.setName(pb.getName());
            cb.setPersonCode(pb.getPersonCode());
          }
          else {
            cb.setName(cb.getPersonId());
          }
          cb.setFromOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getFromOrgId()));
          cb.setToOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getToOrgId()));
          cb.setFromDepName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getFromDepId()));
          cb.setFromPostName(CodeUtil.interpertCode(CodeUtil.TYPE_POST, cb.getFromPostId()));
        }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return this.personList;
  }
  public void setPersonList(List list) {
    this.personList = list;
  }

  public ChangeInfoBO getChangevo() {
    return this.changevo;
  }
  public void setChangevo(ChangeInfoBO vo) {
    this.changevo = vo;
  }

  public String getInitReceive() {
    return this.initReceive;
  }
  public void setInitReceive(String init) {
    this.initReceive = init;
  }

  public WageAPI getWageapi() {
    return this.wageapi;
  }
  public void setWageapi(WageAPI api) {
    this.wageapi = api;
  }

  public String getAfterType()
  {
    return this.afterType;
  }
  public void setAfterType(String newtype) {
    this.afterType = newtype;
  }

  public String getAfterStatus() {
    return this.afterStatus;
  }
  public void setAfterStatus(String newtype) {
    this.afterStatus = newtype;
  }

  public String getPageInit() {
    try {
      if (getServletRequest().getParameter("perids") != null) {
        String perIds = getServletRequest().getParameter("perids");
        getServletRequest().setAttribute("perIds", perIds);
        InfoItemBO retireTime = SysCacheTool.findInfoItem("", "A016020");
        if ("15".equals(retireTime.getItemDataType())) {
          this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM"));
        }
        else {
          this.personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
        }
        if (super.getRequestParameter("mode") != null) {
          String m = super.getRequestParameter("mode");
          if (m.indexOf(",") < 0) {
            this.personchangevo.setChangeType(m);
          }
          else {
            this.personchangevo.setChangeType("");
          }
        }
        if (super.getRequestParameter("afterType") != null) {
          String m = super.getRequestParameter("afterType");
          if (m.indexOf(",") < 0) {
            this.afterType = m;
          }
          else {
            this.afterType = "";
          }
        }
        this.personchangevo.setChangeUnit(super.getUserInfo().getOrgName());
      }
    }
    catch (Exception e)
    {
    }
    return this.pageInit;
  }

  public void setPageInit(String pageInit) {
    this.pageInit = pageInit;
  }

  public String getChgs() {
    return this.chgs;
  }
  public void setChgs(String chgs) {
    this.chgs = chgs;
  }

  public IEmpChangeUCC getEmpchangeucc() {
    return this.empchangeucc;
  }
  public void setEmpchangeucc(IEmpChangeUCC empchangeucc) {
    this.empchangeucc = empchangeucc;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public PersonChangeVO getPersonchangevo() {
    return this.personchangevo;
  }
  public void setPersonchangevo(PersonChangeVO personchangevo) {
    this.personchangevo = personchangevo;
  }

  public String saveAdjust()
  {
    try
    {
      String ids = getServletRequest().getParameter("pids");

      this.personucc.adjustDepartment(ids.split(","), this.chgs);

      this.personucc.adjustPost(ids.split(","), this.posts);
      SysCache.setMap(ids.split(","), 3, 6);
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
      getServletRequest().setAttribute("flag", "1");
      return "close";
    }
    getServletRequest().setAttribute("message", "调动成功!");
    return "close";
  }

  public String saveDispatch() {
    try {
      String ids = getServletRequest().getParameter("pids");

      PersonChangeVO personchangevo = new PersonChangeVO();
      personchangevo.setChangeType(PersonChangeVO.CHANGE_TYPE_OUT);
      personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      ChangeInfoBO changeinfo = new ChangeInfoBO();
      OrgBO orgbo = OrgTool.getOrgByDept(this.chgs);
      changeinfo.setToOrgId(orgbo.getOrgId());
      changeinfo.setToDepId(this.chgs);
      changeinfo.setToPostId(this.posts);
      changeinfo.setToPostLevel(this.postLevel);
      changeinfo.setFromOperator(super.getUserInfo().getUserId());
      personchangevo.setTractPerson(super.getUserInfo().getName());
      personchangevo.setTractDate(CommonFuns.getSysDate("yyyy-MM-dd"));

      String[] idArray = ids.split(",");
      String[] pid = new String[1];
      JdbcTemplate jdbcTemplate = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
      for (int i = 0; i < idArray.length; i++) {
        pid[0] = idArray[i];
        PersonBO p=SysCacheTool.findPersonById(idArray[i]);
        changeinfo.setPersonId(idArray[i]);
        changeinfo.setFromOrgId(SysCacheTool.findPersonById(idArray[i]).getOrgId());
        this.personucc.chgDismiss(personchangevo, changeinfo, pid);
        //同步财务中间库,添加一条人员部门变动记录
        if(!this.chgs.equals(p.getDeptId())){
        	SqlUtil.updateData("insert into a001_bd (user_id,change_date,change_type,old_dept_id,new_dept_id,user_type,name,user_code) values " +
        			"('"+idArray[i]+"',getdate(),'部门变动','"+p.getDeptId()+"','"+this.chgs+"','"+p.getPersonType()+"','"+p.getName()+"','"+p.getPersonCode()+"')");
        	SqlUtil.updateData("update a001 set a001705 ='"+this.chgs+"' where id='"+p.getPersonId()+"'");
        }
      }
      if ("1".equals(Constants.EMP_TRANSFER_WAGE_LINK)) {
        for (int i = 0; i < idArray.length; i++) {
          changeinfo.setPersonId(idArray[i]);
          changeinfo.setFromOrgId(SysCacheTool.findPersonById(idArray[i]).getOrgId());
          this.wagesetpersonucc.transferLink(super.getUserInfo(), changeinfo);
        }
      }

      SysCache.setMap(ids.split(","), 3, 6);
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
      getServletRequest().setAttribute("flag", "1");
      return "close";
    }
    getServletRequest().setAttribute("message", "调动成功!");
    return "close";
  }

  public String saveSend()
  {
    try {
      String ids = getServletRequest().getParameter("pids");
      User user = getUserInfo();
      String name = "";
      if ((ids != null) && (!"".equals(ids))) {
        String[] idList = ids.split(",");

        for (int i = 0; i < idList.length; i++) {
          PersonBO pb = SysCacheTool.findPersonById(idList[i]);
          this.changevo.setChgId(null);
          this.changevo.setApplyStatus(ChangeInfoBO.STATUS_APPLY);
          this.changevo.setPersonId(pb.getPersonId());
          this.changevo.setFromOrgId(pb.getOrgId());
          this.changevo.setFromDepId(pb.getDeptId());
          this.changevo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
          this.changevo.setFromPostId(pb.getPostId());
          this.changevo.setFromOpinion("1");
          this.changevo.setFromOperator(super.getUserInfo().getUserId());

          if (!this.empchangeucc.checkIsApplyed(idList[i])) {
            this.empchangeucc.saveOrUpdateChangeInfo(this.changevo);

            SysInProcessBO sb = new SysInProcessBO();

            sb.setSendPerson(super.getUserInfo().getUserId());
            sb.setSendDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
            sb.setHave_process("0");
            sb.setContent("接收调入人员(" + pb.getName() + ")");
            sb.setOrguid(this.changevo.getToOrgId());
            sb.setOperateID("0366");
            sb.setProcessID(this.changevo.getChgId());
            this.linkucc.saveProcessBO(sb);
          }
        }
      }
    } catch (Exception e) {
      return "";
    }
    return "success";
  }

  public String saveRetire()
  {
    try
    {
      String ids = getServletRequest().getParameter("pids");
      User user = getUserInfo();
      WFDefineExcludeBO excludebo = null;
      if ("2".equals(Constants.EMP_REDUCE_AFTER_APPROVE)) {
        excludebo = this.wfservice.findWFDefineExcludeBO(WFTypeBO.RYGL_COMMON_IN);
      }

      if (((excludebo != null) && (excludebo.getOrguid() != null) && (!"".equals(excludebo.getOrguid())) && (excludebo.getOrguid().indexOf(user.getOrgId()) >= 0)) || ("0200221231".equals(this.personchangevo.getChangeType())) || ("0".equals(Constants.EMP_REDUCE_AFTER_APPROVE)))
      {
        if ((ids != null) && (!"".equals(ids))) {
          if (this.personchangevo != null) {
            this.personchangevo.setTractPerson(user.getUserId());
          }
          this.personucc.updateRetirePerson(super.getUserInfo(), this.personchangevo, ids.split(","));
          this.personucc.ModifyPersonType(ids.split(","), this.afterType);
          if (isUseA001725()) {
            this.personucc.ModifyPersonStatus(ids.split(","), this.afterStatus);
          }
          SysCache.setMap(ids.split(","), 3, 6);
        }
      }
      else {
        String[] personids = ids.split(",");
        for (int i = 0; i < personids.length; i++)
        {
          if (this.personucc.findReduceBOByPID(personids[i]) != null)
            continue;
          EmpReduceBO eb = new EmpReduceBO();
          eb.setPersID(personids[i]);
          eb.setA016010(this.personchangevo.getChangeType());
          eb.setA016020(this.personchangevo.getChangeDate());
          eb.setA001054(this.afterType);
          eb.setA001725(this.afterStatus);
          eb.setApplyID(user.getUserId());
          eb.setA016060(this.personchangevo.getReason());
          eb.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
          eb.setStatus("0");
          this.personucc.saveReduceBO(eb);

          WFTransaction trans = new WFTransaction();
          trans.setUser(super.getUserInfo());
          PersonBO pb = SysCacheTool.findPersonById(personids[i]);
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
          trans.setLinkID(eb.getItemID());
          trans.setStatusValue("报批");
          trans.setDeptID(pb.getDeptId());
          trans.setWffunction("emp_retireservice");
          this.wfservice.processTrans(trans);
        }
      }

      if (this.joinBlack) {
        String[] personids = ids.split(",");
        for (int i = 0; i < personids.length; i++) {
          EmpBlackSheetBO black = new EmpBlackSheetBO();
          black.setPersID(personids[i]);
          black.setOperID(super.getUserInfo().getUserId());
          black.setOperDate(CommonFuns.getSysDate("yyyy-MM-dd"));
          black.setReson(this.joinReason);
          this.personucc.addEmpBlackSheetBO(black);
        }
      }
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
      getServletRequest().setAttribute("flag", "1");
      return "close";
    }
    this.personchangevo = null;
    getServletRequest().setAttribute("message", "处理业务成功!");
    return "close";
  }

  public ISysInProcessUCC getLinkucc() {
    return this.linkucc;
  }
  public void setLinkucc(ISysInProcessUCC linkucc) {
    this.linkucc = linkucc;
  }

  public IContUCC getContucc() {
    return this.contucc;
  }
  public void setContucc(IContUCC contucc) {
    this.contucc = contucc;
  }

  public void setUserreportucc(IUserReportUCC iur) {
    this.userreportucc = iur;
  }
  public IUserReportUCC getUserreportucc() {
    return this.userreportucc;
  }

  public IWageSetPersonUCC getWagesetpersonucc() {
    return this.wagesetpersonucc;
  }
  public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
    this.wagesetpersonucc = wagesetpersonucc;
  }

  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }
  public void setWagesetucc(IWageSetUCC wagesetucc) {
    this.wagesetucc = wagesetucc;
  }
}