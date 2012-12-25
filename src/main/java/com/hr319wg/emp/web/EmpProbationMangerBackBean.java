package com.hr319wg.emp.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.EmpProbationBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IEmpProbationUCC;
import com.hr319wg.org.pojo.bo.OrgProbationBO;
import com.hr319wg.org.ucc.IOrgProbationUcc;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.SysInProcessBO;
import com.hr319wg.sys.pojo.bo.WFTypeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.sys.ucc.ISysInProcessUCC;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.ucc.IWageSetUCC;

public class EmpProbationMangerBackBean extends BaseBackingBean
{
  private IEmpProbationUCC empprobationucc;
  private IOrgProbationUcc orgprobationucc;
  private WorkFlowService wfservice;
  private IUserReportUCC userreportucc;
  private ISysInProcessUCC linkucc;
  private String pageInit;
  private String passMonth;
  private String passMonth2;
  private List personList;
  private boolean newProbation = true;
  private boolean newProbation2 = true;
  private boolean apprving = false;
  private boolean apprived = false;
  private boolean efficent = false;
  private boolean refuse = false;

  private PageVO mypage = new PageVO();
  private String mustApprov;
  private List regTableList;
  private String personId;
  private String name;
  private String time;
  private String time2;
  private String initEdit;
  private OrgProbationBO orgprobationbo = new OrgProbationBO();
  private String method;
  private String infoItem;
  private List baseFields = new ArrayList();
  private String copySet;
  private IWageSetUCC wagesetucc;
  private String unitId;
  private String setId;
  private String probation;
  private String jianxi;
  private String initPersonEdit;
  private EmpProbationBO empprobationbo = new EmpProbationBO();
  private String planDate;

  public String getPassMonth2() {
	return passMonth2;
}

public void setPassMonth2(String passMonth2) {
	this.passMonth2 = passMonth2;
}

public boolean isNewProbation2() {
	return newProbation2;
}

public void setNewProbation2(boolean newProbation2) {
	this.newProbation2 = newProbation2;
}

public String getJianxi() {
	return jianxi;
}

public void setJianxi(String jianxi) {
	this.jianxi = jianxi;
}

public String getName()
  {
    return this.name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getTime()
  {
    return this.time;
  }

  public void setTime(String time) {
    this.time = time;
  }

  public String getTime2() {
    return this.time2;
  }

  public void setTime2(String time2) {
    this.time2 = time2;
  }

  public String delete() {
    try {
      this.empprobationucc.deleteEmpProbationBO(this.personId);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

  public String getPersonId() {
    return this.personId;
  }

  public void setPersonId(String personId) {
    this.personId = personId;
  }

  public IUserReportUCC getUserreportucc() {
    return this.userreportucc;
  }

  public void setUserreportucc(IUserReportUCC userreportucc) {
    this.userreportucc = userreportucc;
  }

  public List getRegTableList()
  {
    try {
      this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), "0346", UserRptVO.TYPE_REG);
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

  public String getMustApprov() {
    return Constants.EMP_DIRECT_PROBATION;
  }

  public void setMustApprov(String mustApprov) {
    this.mustApprov = mustApprov;
  }

  public boolean isNewProbation() {
    return this.newProbation;
  }

  public void setNewProbation(boolean newProbation) {
    this.newProbation = newProbation;
  }

  public boolean isApprving() {
    return this.apprving;
  }

  public void setApprving(boolean apprving) {
    this.apprving = apprving;
  }

  public boolean isApprived() {
    return this.apprived;
  }

  public void setApprived(boolean apprived) {
    this.apprived = apprived;
  }

  public boolean isEfficent() {
    return this.efficent;
  }

  public void setEfficent(boolean efficent) {
    this.efficent = efficent;
  }

  public boolean isRefuse() {
    return this.refuse;
  }

  public void setRefuse(boolean refuse) {
    this.refuse = refuse;
  }

  public PageVO getMypage() {
    return this.mypage;
  }

  public void setMypage(PageVO mypage) {
    this.mypage = mypage;
  }

  public WorkFlowService getWfservice() {
    return this.wfservice;
  }

  public void setWfservice(WorkFlowService wfservice) {
    this.wfservice = wfservice;
  }

  public String approvid() {
    try {
      String id = super.getRequestParameter("form1:personStr");
      boolean isflag = true;
      if (id != null) {
        String[] ids = id.split(",");
        for (int i = 0; i < ids.length; i++) {
          if ((ids[i] != null) && (!ids[i].equals(""))) {
            EmpProbationBO bo = this.empprobationucc.findEmpProbationBOByPid(ids[i]);
            if (!bo.getStatus().equals(EmpProbationBO.PROBATION)) {
              super.showMessageDetail("请选择试用状态人员！");
              isflag = false;
              break;
            }
            bo.setStatus(EmpProbationBO.PROBATIONADUIT);
            this.empprobationucc.saveEmpProbationBO(bo);
            if ("0".equals(Constants.EMP_DIRECT_PROBATION)) {
              WFTransaction wt = new WFTransaction();
              wt.setLinkID(bo.getPersonId());
              wt.setOperID("0346");
              wt.setUser(super.getUserInfo());
              wt.setWfType(WFTypeBO.RYGL_PROBATION);
              wt.setConValue("");
              wt.setStatusValue("0");
              wt.setWffunction("empprobationservice");
              this.wfservice.processTrans(wt);
            } else {
              bo.setAuditResult("1");
              bo.setAuditResult2("1");
              this.empprobationucc.saveEmpProbationBO(bo);
            }
          }
        }

        if (isflag)
          super.showMessageDetail("报批成功！");
      }
    }
    catch (Exception e)
    {
      super.showMessageDetail("报批失败:" + e.getMessage());
      e.printStackTrace();
    }
    return null;
  }
  private void notice(String name) throws SysException {
    SysInProcessBO sb = new SysInProcessBO();

    sb.setSendPerson(super.getUserInfo().getUserId());
    sb.setSendDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
    sb.setHave_process("0");
    sb.setContent("请办理" + name + "转正工资");
    sb.setOrguid(super.getUserInfo().getOrgId());
    sb.setOperateID("0675");
    this.linkucc.saveProcessBO(sb);
  }

  public String shengxiao() {
    try {
      String id = super.getRequestParameter("form1:personStr");
      OrgProbationBO oo = this.orgprobationucc.findOrgProbationBOByOrgId(super.getUserInfo().getOrgId());
      if(oo != null) {
        if (id != null) {
          String[] ids = id.split(",");
          for (int i = 0; i < ids.length; i++) {
            if ((ids[i] != null) && (!ids[i].equals(""))) {
              EmpProbationBO bo = this.empprobationucc.findEmpProbationBOByPid(ids[i]);
              long day = CommonFuns.betweenDays(bo.getPlanPassDate(), CommonFuns.getSysDate("yyyy-MM-dd"));
              if (day > 0L) {
                super.showMessageDetail("未到转正日期！");
                break;
              }
              if (Constants.EMP_DIRECT_PROBATION.equals("0")) {
                if (bo.getStatus().equals(EmpProbationBO.PASS)) {
                  bo.setStatus(EmpProbationBO.EFFICIRNT);
                  this.empprobationucc.saveEmpProbationBO(bo);
                  JdbcTemplate jdbcTemplate = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
                  String sql = "update wage_adjust set approstatus='1' where adjust_type='转正' and person_id='"+ids[i]+"'";
                  jdbcTemplate.execute(sql);
                  notice(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, bo.getPersonId()));
                } else {
                  super.showMessageDetail("请选择转正状态的人员");
                  break;
                }
              }
              else if (EmpProbationBO.JIANXI.equals(bo.getStatus()) || EmpProbationBO.PROBATION.equals(bo.getStatus())) {
                bo.setStatus(EmpProbationBO.EFFICIRNT);
                this.empprobationucc.saveEmpProbationBO(bo);
                notice(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, ids[i]));
              } else {
                super.showMessageDetail("请选择转正状态的人员");
                break;
              }
            }
          }
        }
      }else{
        super.showMessageDetail("转正人员未设置");
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

  public List getPersonList() {
    return this.personList;
  }

  public void setPersonList(List personList) {
    this.personList = personList;
  }

  public void queryNewProbation(ValueChangeEvent event) {
    this.newProbation = "true".equals(event.getNewValue().toString());
  }
  public void queryNewProbation2(ValueChangeEvent event) {
	  this.newProbation2 = "true".equals(event.getNewValue().toString());
  }
  public void queryApprving(ValueChangeEvent event) {
    this.apprving = "true".equals(event.getNewValue().toString());
  }
  public void queryApprived(ValueChangeEvent event) {
    this.apprived = "true".equals(event.getNewValue().toString());
  }
  public void queryEfficent(ValueChangeEvent event) {
    this.efficent = "true".equals(event.getNewValue().toString());
  }
  public void queryRefuse(ValueChangeEvent event) {
    this.refuse = "true".equals(event.getNewValue().toString());
  }
  public String first() {
    this.mypage.setCurrentPage(1);
    return null;
  }
  public String pre() {
    if (this.mypage.getCurrentPage() > 1) {
      this.mypage.setCurrentPage(this.mypage.getCurrentPage() - 1);
    }
    return null;
  }
  public String next() {
    if (this.mypage.getCurrentPage() < this.mypage.getTotalPage()) {
      this.mypage.setCurrentPage(this.mypage.getCurrentPage() + 1);
    }
    return null;
  }
  public String last() {
    this.mypage.setCurrentPage(this.mypage.getTotalPage());
    return null;
  }
  public void queryPersonList() {
    try {
      if (this.mypage.getCurrentPage() == 0) this.mypage.setCurrentPage(1);
      this.personList = new ArrayList();
      List statuses = new ArrayList();
      if (this.newProbation) {
        statuses.add(EmpProbationBO.PROBATION);
      }
      if (this.apprving) {
        statuses.add(EmpProbationBO.PROBATIONADUIT);
      }
      if (this.apprived) {
        statuses.add(EmpProbationBO.PASS);
      }
      if (this.efficent) {
        statuses.add(EmpProbationBO.EFFICIRNT);
      }
      if (this.refuse) {
        statuses.add(EmpProbationBO.HAVENOTPASS);
      }
      if (this.newProbation2) {
    	  statuses.add(EmpProbationBO.JIANXI);
      }
      
      this.personList = this.empprobationucc.findNoPassPerson(this.mypage, super.getUserInfo().getOrgId(), statuses, this.time, this.time2, this.name);
      if ((this.personList != null) && (this.personList.size() > 0))
        for (int i = 0; i < this.personList.size(); i++) {
          EmpProbationBO bo = (EmpProbationBO)this.personList.get(i);
          PersonBO pbo = SysCacheTool.findPersonById(bo.getPersonId());
          bo.setName(pbo.getName());
          bo.setBirthday(pbo.getName());
          bo.setBirthday(pbo.getBirth());
          bo.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
          bo.setOrgName(SysCacheTool.findOrgById(pbo.getOrgId()).getName());
          bo.setPersonType(CodeUtil.interpertCode(pbo.getPersonType()));
          bo.setSex(CodeUtil.interpertCode(pbo.getSex()));
          bo.setUnitTime(pbo.getUnitTime());
          bo.setPostName(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pbo.getPostId()));
          bo.setPostLevel(CodeUtil.interpertCode(pbo.getPostLevel()));

          if (CommonFuns.betweenDays(bo.getPlanPassDate(), CommonFuns.getSysDate("yyyy-MM-dd")) >= 0L)
            bo.setHaveDays(new Long(CommonFuns.betweenDays(bo.getPlanPassDate(), CommonFuns.getSysDate("yyyy-MM-dd"))).toString());
          else {
            bo.setHaveDays("过期" + new Long(CommonFuns.betweenDays(CommonFuns.getSysDate("yyyy-MM-dd"), bo.getPlanPassDate())).toString());
          }
          this.personList.set(i, bo);
        }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public IEmpProbationUCC getEmpprobationucc() {
    return this.empprobationucc;
  }

  public void setEmpprobationucc(IEmpProbationUCC empprobationucc) {
    this.empprobationucc = empprobationucc;
  }

  public IOrgProbationUcc getOrgprobationucc() {
    return this.orgprobationucc;
  }

  public void setOrgprobationucc(IOrgProbationUcc orgprobationucc) {
    this.orgprobationucc = orgprobationucc;
  }

  public String getPageInit() {
    queryPersonList();
    return this.pageInit;
  }

  public void setPageInit(String pageInit) {
    this.pageInit = pageInit;
  }

	public String getPassMonth() {
		try {
			OrgProbationBO bo = this.orgprobationucc.findOrgProbationBOByOrgId(super.getUserInfo().getOrgId());
			if (bo != null) {
				this.passMonth = bo.getProbation();
				this.passMonth2=bo.getJianxi();
			} else{
				this.passMonth = Constants.DEFAULT_PROBATION;
				this.passMonth2 = Constants.DEFAULT_PROBATION;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.passMonth;
	}

  public void setPassMonth(String passMonth) {
    this.passMonth = passMonth;
  }

  public String getProbation()
  {
    return this.probation;
  }

  public void setProbation(String probation) {
    this.probation = probation;
  }
  public String getUnitId() {
    this.unitId = super.getUserInfo().getOrgId();
    return this.unitId;
  }

  public void setUnitId(String unitId) {
    this.unitId = unitId;
  }

  public String getSetId() {
    return this.setId;
  }

  public void setSetId(String setId) {
    this.setId = setId;
  }

  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }

  public void setWagesetucc(IWageSetUCC wagesetucc) {
    this.wagesetucc = wagesetucc;
  }

  public String getCopySet() {
    return this.copySet;
  }

  public void setCopySet(String copySet) {
    this.copySet = copySet;
  }

  public String addfield()
  {
    if ((this.infoItem != null) && (!"".equals(this.infoItem)))
    {
      String[] inf = this.infoItem.replace('.', ',').split(",");
      InfoItemBO ib = SysCacheTool.findInfoItem("", inf[1]);
      ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, inf[0]));
      ib.setItemSequence(String.valueOf(this.baseFields.size() + 1));
      this.baseFields.add(ib);
    }
    return null;
  }

  public String saveCopyPersonItem()
  {
    try {
      WageSetBO wb = this.wagesetucc.findSetBySetId(this.copySet);
      this.baseFields = new ArrayList();
      if ((wb.getBaseinfo() != null) && (!"".equals(wb.getBaseinfo())))
      {
        String[] fs = wb.getBaseinfo().split(",");
        for (int i = 0; i < fs.length; i++)
        {
          InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
          ib.setItemSequence(String.valueOf(i + 1));
          ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, ib.getSetId()));
          this.baseFields.add(ib);
        }
      }
    }
    catch (Exception e) {
    }
    return null;
  }

  public String delfield()
  {
    if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null))
    {
      int i = 0;

      while (i < this.baseFields.size())
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.infoItem.equals(ib.getItemId()))
        {
          this.baseFields.remove(i);
          if ((this.orgprobationbo.getWageItems() == null) || ("".equals(this.orgprobationbo.getWageItems())))
            break;
          String items = "";
          String[] fs = this.orgprobationbo.getWageItems().split(",");
          for (int j = 0; j < fs.length; j++)
          {
            InfoItemBO ib1 = SysCacheTool.findInfoItem("", fs[j]);
            if (!ib1.getItemId().equals(ib.getItemId())) {
              items = items + ib1.getItemId() + ",";
            }
          }
          this.orgprobationbo.setWageItems(items);
          try {
            this.orgprobationucc.updateOrgProbationBO(this.orgprobationbo);
          } catch (SysException e) {
            e.printStackTrace();
          }
          break;
        }

        i++;
      }
    }
    return null;
  }

  public String movePre() {
    if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null))
    {
      int i = 0;
      i = 0;

      while (i < this.baseFields.size())
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.infoItem.equals(ib.getItemId()))
          break;
        i++;
      }
      if ((i < this.baseFields.size()) && (i > 0))
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        this.baseFields.set(i, this.baseFields.get(i - 1));
        this.baseFields.set(i - 1, ib);
      }
    }
    return null;
  }

  public String moveNext() {
    if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null))
    {
      int i = 0;
      i = 0;

      while (i < this.baseFields.size())
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.infoItem.equals(ib.getItemId()))
          break;
        i++;
      }
      if (i < this.baseFields.size() - 1)
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i + 1);
        this.baseFields.set(i + 1, this.baseFields.get(i));
        this.baseFields.set(i, ib);
      }
    }
    return null;
  }

  public String getInfoItem() {
    return this.infoItem;
  }
  public void setInfoItem(String infoItem) {
    this.infoItem = infoItem;
  }

  public List getBaseFields() {
    return this.baseFields;
  }

  public void setBaseFields(List baseFields) {
    this.baseFields = baseFields;
  }

  public String getMethod() {
    return this.method;
  }

  public void setMethod(String method) {
    this.method = method;
  }

  public String saveOrgProbationBO() {
    try {
      if ((this.baseFields != null) && (this.baseFields.size() > 0)) {
        String fs = ((InfoItemBO)this.baseFields.get(0)).getItemId();
        for (int i = 1; i < this.baseFields.size(); i++) {
          fs = fs + "," + ((InfoItemBO)this.baseFields.get(i)).getItemId();
        }
        this.orgprobationbo.setWageItems(fs);
      }
      else {
        this.orgprobationbo.setWageItems("");
      }
      this.orgprobationbo.setProbation(this.probation);
      this.orgprobationbo.setJianxi(this.jianxi);
      if ("new".equals(this.method))
        this.orgprobationucc.saveOrgProbationBO(this.orgprobationbo);
      else {
        this.orgprobationucc.updateOrgProbationBO(this.orgprobationbo);
      }
      List list = this.empprobationucc.getAllProbationStatusPerson(super.getUserInfo().getOrgId(), "0,5");
      if ((list != null) && (list.size() > 0))
        for (int i = 0; i < list.size(); i++) {
          EmpProbationBO bo = (EmpProbationBO)list.get(i);
          PersonBO pbo = SysCacheTool.findPersonById(bo.getPersonId());
          if ((pbo.getUnitTime() != null) && (!pbo.getUnitTime().equals(""))) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cd = new GregorianCalendar();
            cd.setTime(sdf.parse(pbo.getUnitTime()));
            if("0".equals(bo.getStatus())){
            	cd.add(2, Integer.parseInt(this.orgprobationbo.getProbation()));            	
            }else if("5".equals(bo.getStatus())){
            	cd.add(2, Integer.parseInt(this.orgprobationbo.getJianxi()));            	            	
            }
            bo.setPlanPassDate(sdf.format(cd.getTime()));
          } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cd = new GregorianCalendar();
            cd.setTime(sdf.parse(CommonFuns.getSysDate("yyyy-MM-dd")));
            if("0".equals(bo.getStatus())){
            	cd.add(2, Integer.parseInt(this.orgprobationbo.getProbation()));            	
            }else if("5".equals(bo.getStatus())){
            	cd.add(2, Integer.parseInt(this.orgprobationbo.getJianxi()));            	            	
            }
            bo.setPlanPassDate(sdf.format(cd.getTime()));
          }
          this.empprobationucc.saveEmpProbationBO(bo);
        }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return "success";
  }

  public OrgProbationBO getOrgprobationbo() {
    return this.orgprobationbo;
  }

  public void setOrgprobationbo(OrgProbationBO orgprobationbo) {
    this.orgprobationbo = orgprobationbo;
  }

  public String getInitEdit() {
    try {
      this.orgprobationbo = this.orgprobationucc.findOrgProbationBOByOrgId(super.getUserInfo().getOrgId());

      if (this.orgprobationbo != null) {
        this.orgprobationbo.setOrgName(SysCacheTool.findOrgById(this.orgprobationbo.getOrgUid()).getName());

        if (this.probation==null || "".equals(this.probation)) {
          this.probation = this.orgprobationbo.getProbation();
        }
        if (this.jianxi==null || "".equals(this.jianxi)) {
        	this.jianxi = this.orgprobationbo.getJianxi();
        }
        this.method = "update";
        find();
      } else {
        this.orgprobationbo = new OrgProbationBO();
        this.orgprobationbo.setOrgUid(super.getUserInfo().getOrgId());
        this.orgprobationbo.setOrgName(SysCacheTool.findOrgById(super.getUserInfo().getOrgId()).getName());

        this.method = "new";
      }
      if (this.probation != null && !"".equals(this.probation)) {
        this.orgprobationbo.setProbation(this.probation);
      }
      if (this.jianxi != null && !"".equals(this.jianxi)) {
    	  this.orgprobationbo.setJianxi(this.jianxi);
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return this.initEdit;
  }

  public void setInitEdit(String initEdit) {
    this.initEdit = initEdit;
  }
  public void find() {
    if ((this.orgprobationbo.getWageItems() != null) && (!"".equals(this.orgprobationbo.getWageItems())))
    {
      String[] fs = this.orgprobationbo.getWageItems().split(",");
      for (int i = 0; i < fs.length; i++)
      {
        InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
        ib.setItemSequence(String.valueOf(i + 1));
        ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, ib.getSetId()));
        if (!this.baseFields.contains(ib))
          this.baseFields.add(ib);
      }
    }
  }

  public String saveEmpProbationBO()
  {
    try
    {
      this.empprobationucc.saveEmpProbationBO(this.empprobationbo);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "success";
  }

  public String getPlanDate() {
    return this.planDate;
  }

  public void setPlanDate(String planDate) {
    this.planDate = planDate;
  }

  public EmpProbationBO getEmpprobationbo() {
    return this.empprobationbo;
  }

  public void setEmpprobationbo(EmpProbationBO empprobationbo) {
    this.empprobationbo = empprobationbo;
  }

  public String getInitPersonEdit() {
    try {
      if (super.getRequestParameter("personId") != null) {
        this.empprobationbo = this.empprobationucc.findEmpProbationBOByPid(super.getRequestParameter("personId"));
        this.planDate = this.empprobationbo.getPlanPassDate();
        this.empprobationbo.setName(SysCacheTool.findPersonById(super.getRequestParameter("personId")).getName());
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return this.initPersonEdit;
  }

  public void setInitPersonEdit(String initPersonEdit) {
    this.initPersonEdit = initPersonEdit;
  }

  public ISysInProcessUCC getLinkucc() {
    return this.linkucc;
  }
  public void setLinkucc(ISysInProcessUCC linkucc) {
    this.linkucc = linkucc;
  }
}