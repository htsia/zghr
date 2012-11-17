package com.hr319wg.emp.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.EmpBeginnerBO;
import com.hr319wg.emp.pojo.bo.EmpPostChangeBO;
import com.hr319wg.emp.pojo.bo.OrgBeginnerBO;
import com.hr319wg.emp.pojo.bo.OrgPostChangeBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IEmpBeginnerUCC;
import com.hr319wg.emp.ucc.IEmpPostChangeUCC;
import com.hr319wg.post.util.PostTool;
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
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.ucc.IWageAdjustUCC;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;

public class EmpPostChangeMgrBankBean extends BaseBackingBean
{
  private IEmpPostChangeUCC emppostchangeucc;
  private IEmpBeginnerUCC empbeginnerucc;
  private WorkFlowService wfservice;
  private IUserReportUCC userreportucc;
  private ISysInProcessUCC linkucc;
  private IWageSetPersonUCC wagesetpersonucc;
  private String pageInit;
  private PageVO mypage;
  private List empPostChangeList;
  private boolean apply;
  private boolean apprving;
  private boolean apprived;
  private boolean efficent;
  private boolean wageChange;
  private boolean refuse;
  private boolean mustApprov;
  private String time;
  private List regTableList;
  private String postChangeId;
  private String time2;
  private boolean enableBegin;
  private EmpPostChangeBO emppostchangbo;
  private String initEdit;
  private Map selMap = new HashMap();
  private String personNames="";
  private String personIds="";
  private String initOrgEdit;
  private OrgPostChangeBO orgchangebo;
  private String infoItem;
  private List baseFields;
  private String copySet;
  private IWageSetUCC wagesetucc;
  private String unitId;
  private String setId;
  private String probation;
  private String normailType;
  private String method;
  private String initEfictPersons;
  private String efictDate;
  private String changeIds;
  private String dateShowMode;
  private String addResume;
  private boolean enableSelect = true;
  private IWageAdjustUCC adjustucc;

  public IWageAdjustUCC getAdjustucc() {
	return adjustucc;
}

public void setAdjustucc(IWageAdjustUCC adjustucc) {
	this.adjustucc = adjustucc;
}

public IWageSetPersonUCC getWagesetpersonucc()
  {
    return this.wagesetpersonucc;
  }

  public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
    this.wagesetpersonucc = wagesetpersonucc;
  }

  public EmpPostChangeMgrBankBean()
  {
    this.mypage = new PageVO();
    this.empPostChangeList = new ArrayList();
    this.apply = true;
    this.apprving = false;
    this.apprived = false;
    this.efficent = false;
    this.wageChange = false;
    this.refuse = false;
    this.enableBegin = false;
    this.emppostchangbo = new EmpPostChangeBO();
    this.orgchangebo = new OrgPostChangeBO();
    this.baseFields = new ArrayList();
    this.addResume = "1";
  }

  public boolean isEnableBegin() {
    return this.enableBegin;
  }
  public void setEnableBegin(boolean enableBegin) {
    this.enableBegin = enableBegin;
  }

  public String getTime2()
  {
    return this.time2;
  }

  public void setTime2(String time2) {
    this.time2 = time2;
  }

  public String getPostChangeId()
  {
    return this.postChangeId;
  }

  public void setPostChangeId(String postChangeId)
  {
    this.postChangeId = postChangeId;
  }

  public String delete()
  {
    try
    {
      this.emppostchangeucc.deleteEmpPostChangeBO(this.postChangeId);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return "";
  }

  public List getRegTableList()
  {
    try
    {
      this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), "1351", UserRptVO.TYPE_REG);
      if (this.regTableList == null)
        this.regTableList = new ArrayList();
    }
    catch (Exception e)
    {
      this.regTableList = new ArrayList();
    }
    return this.regTableList;
  }

  public void setRegTableList(List regTableList)
  {
    this.regTableList = regTableList;
  }

  public IUserReportUCC getUserreportucc()
  {
    return this.userreportucc;
  }

  public void setUserreportucc(IUserReportUCC userreportucc)
  {
    this.userreportucc = userreportucc;
  }

  public String getTime()
  {
    return this.time;
  }

  public void setTime(String time)
  {
    this.time = time;
  }

  public WorkFlowService getWfservice()
  {
    return this.wfservice;
  }

  public void setWfservice(WorkFlowService wfservice)
  {
    this.wfservice = wfservice;
  }

  public String approvid()
  {
    try {
      String id = super.getRequestParameter("form1:personStr");
      if (id != null) {
        String[] ids = id.split(",");
        int i = 0;

        while (i < ids.length)
        {
          if ((ids[i] != null) && (!ids[i].equals(""))) {
            EmpPostChangeBO bo = this.emppostchangeucc.findEmpPostChangeBOById(ids[i]);
            if (!bo.getStatus().equals(EmpPostChangeBO.APPLY)) {
              super.showMessageDetail("请选择申请状态人员！");
              break;
            }
            bo.setStatus(EmpPostChangeBO.APPROVING);
            this.emppostchangeucc.saveEmpPostChangeBO(bo);
            if ("0".equals(Constants.EMP_DIRECT_POST_CHANGE)) {
              WFTransaction wt = new WFTransaction();
              wt.setLinkID(bo.getPostChangeId());
              wt.setOperID("1351");
              wt.setUser(super.getUserInfo());
              wt.setWfType(WFTypeBO.RYGL_POST_CHANGE);
              wt.setConValue("");
              wt.setStatusValue("0");
              wt.setDeptID(bo.getOldDept());
              wt.setWffunction("emppostchangeservice");
              this.wfservice.processTrans(wt);
            } else {
              bo.setAuditResult("1");
              bo.setAuditResult1("1");
            }
          }
          i++;
        }
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return "";
  }

  public void queryApply(ValueChangeEvent event)
  {
    this.apply = "true".equals(event.getNewValue().toString());
    queryEmpPostChangeList();
  }

  public void queryApprving(ValueChangeEvent event)
  {
    this.apprving = "true".equals(event.getNewValue().toString());
    queryEmpPostChangeList();
  }

  public void queryApprived(ValueChangeEvent event)
  {
    this.apprived = "true".equals(event.getNewValue().toString());
    queryEmpPostChangeList();
  }

  public void queryEfficent(ValueChangeEvent event)
  {
    this.efficent = "true".equals(event.getNewValue().toString());
    queryEmpPostChangeList();
  }

  public void queryWageChange(ValueChangeEvent event)
  {
    this.wageChange = "true".equals(event.getNewValue().toString());
    queryEmpPostChangeList();
  }

  public void queryRsfuse(ValueChangeEvent event)
  {
    this.refuse = "true".equals(event.getNewValue().toString());
    queryEmpPostChangeList();
  }

  public boolean isApply()
  {
    return this.apply;
  }

  public void setApply(boolean apply)
  {
    this.apply = apply;
  }

  public boolean isApprving()
  {
    return this.apprving;
  }

  public void setApprving(boolean apprving)
  {
    this.apprving = apprving;
  }

  public boolean isApprived()
  {
    return this.apprived;
  }

  public void setApprived(boolean apprived)
  {
    this.apprived = apprived;
  }

  public boolean isEfficent()
  {
    return this.efficent;
  }

  public void setEfficent(boolean efficent)
  {
    this.efficent = efficent;
  }

  public boolean isWageChange()
  {
    return this.wageChange;
  }

  public void setWageChange(boolean wageChange)
  {
    this.wageChange = wageChange;
  }

  public boolean isRefuse()
  {
    return this.refuse;
  }

  public void setRefuse(boolean refuse)
  {
    this.refuse = refuse;
  }

  public String first()
  {
    this.mypage.setCurrentPage(1);
    queryEmpPostChangeList();
    return "";
  }

  public String pre()
  {
    if (this.mypage.getCurrentPage() > 1)
      this.mypage.setCurrentPage(this.mypage.getCurrentPage() - 1);
    queryEmpPostChangeList();
    return "";
  }

  public String next()
  {
    if (this.mypage.getCurrentPage() < this.mypage.getTotalPage())
      this.mypage.setCurrentPage(this.mypage.getCurrentPage() + 1);
    queryEmpPostChangeList();
    return "";
  }

  public String last()
  {
    this.mypage.setCurrentPage(this.mypage.getTotalPage());
    queryEmpPostChangeList();
    return "";
  }

  public void queryEmpPostChangeList()
  {
    try
    {
      if (this.mypage.getCurrentPage() == 0)
        this.mypage.setCurrentPage(1);
      this.empPostChangeList = new ArrayList();
      List statuses = new ArrayList();
      if (this.apply)
        statuses.add(EmpPostChangeBO.APPLY);
      if (this.apprving)
        statuses.add(EmpPostChangeBO.APPROVING);
      if (this.apprived)
        statuses.add(EmpPostChangeBO.APPROVED);
      if (this.efficent)
        statuses.add(EmpPostChangeBO.HUMANEFFICIRNT);
      if (this.refuse)
        statuses.add(EmpPostChangeBO.REFUSE);
      if (this.wageChange)
        statuses.add(EmpPostChangeBO.WAGECHANGE);
      this.empPostChangeList = this.emppostchangeucc.findAllEmpPostChangeBO(this.mypage, super.getUserInfo().getOrgId(), statuses, this.time, this.time2);
      if ((this.empPostChangeList != null) && (this.empPostChangeList.size() > 0))
      {
        for (int i = 0; i < this.empPostChangeList.size(); i++)
        {
          EmpPostChangeBO bo = (EmpPostChangeBO)this.empPostChangeList.get(i);
          bo.setPersonName(SysCacheTool.findPersonById(bo.getPersonId()).getName());
          if ((bo.getOldPost() != null) && (!bo.getOldPost().equals("")))
            bo.setOldPost(PostTool.getPostName(bo.getOldPost()));
          if ((bo.getOldJob() != null) && (!bo.getOldJob().equals("")))
            bo.setOldJob(CodeUtil.interpertCode(bo.getOldJob()));
          bo.setNewDept(SysCacheTool.findOrgById(bo.getNewDept()).getName());
          if ((bo.getNewPost() != null) && (!bo.getNewPost().equals("")))
            bo.setNewPost(PostTool.getPostName(bo.getNewPost()));
          if ((bo.getNewJob() != null) && (!bo.getNewJob().equals("")))
            bo.setNewJob(CodeUtil.interpertCode(bo.getNewJob()));
          bo.setChangeReasonDes(CodeUtil.interpertCode(bo.getChangeReason()));
        }
      }

    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  public String getPageInit()
  {
    queryEmpPostChangeList();
    return this.pageInit;
  }

  public void setPageInit(String pageInit)
  {
    this.pageInit = pageInit;
  }

  public PageVO getMypage()
  {
    return this.mypage;
  }

  public void setMypage(PageVO mypage)
  {
    this.mypage = mypage;
  }

  public List getEmpPostChangeList()
  {
    return this.empPostChangeList;
  }

  public void setEmpPostChangeList(List empPostChangeList)
  {
    this.empPostChangeList = empPostChangeList;
  }

  public IEmpPostChangeUCC getEmppostchangeucc()
  {
    return this.emppostchangeucc;
  }

  public void setEmppostchangeucc(IEmpPostChangeUCC emppostchangeucc)
  {
    this.emppostchangeucc = emppostchangeucc;
  }

  public String getPersonNames()
  {
    return this.personNames;
  }

  public void setPersonNames(String personNames)
  {
    this.personNames = personNames;
  }

  public String getPersonIds()
  {
    return this.personIds;
  }

  public void setPersonIds(String personIds)
  {
    this.personIds = personIds;
  }

	public String save() {
		try {
			String[] ids = this.personIds.split(",");
			for (int i = 0; i < ids.length; i++)
				if ((ids[i] != null) && (!ids[i].equals(""))) {
					PersonBO pbo = SysCacheTool.findPersonById(ids[i]);
					EmpPostChangeBO bo = new EmpPostChangeBO();
					bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					bo.setOldDept(pbo.getDeptId());
					bo.setOldPost(pbo.getPostId());
					bo.setOldJob(pbo.getHeadshipName());
					bo.setNewDept(this.emppostchangbo.getNewDept());
					bo.setNewJob(this.emppostchangbo.getNewJob());
					bo.setNewPost(this.emppostchangbo.getNewPost());
					bo.setChangeReason(this.emppostchangbo.getChangeReason());
					bo.setChangeType(this.emppostchangbo.getChangeType());
					bo.setChangeBase(this.emppostchangbo.getChangeBase());
					bo.setChangeLetterNO(this.emppostchangbo.getChangeLetterNO());
					bo.setPersonId(ids[i]);
					bo.setStatus(EmpPostChangeBO.APPLY);
					if (this.enableBegin) {
						bo.setLinkBeginMgr("1");
						bo.setPassPost(this.emppostchangbo.getPassPost());
						bo.setPassPostLevel(this.emppostchangbo.getPassPostLevel());
					} else {
						bo.setLinkBeginMgr("0");
					}
					this.emppostchangeucc.saveEmpPostChangeBO(bo);

					if (!this.enableSelect) {
						SysInProcessBO sb = new SysInProcessBO();

						sb.setSendPerson(super.getUserInfo().getUserId());
						sb.setSendDate(CommonFuns
								.getSysDate("yyyy-MM-dd HH:mm:ss"));
						sb.setOrguid(super.getUserInfo().getOrgId());
						sb.setHave_process("0");
						sb.setContent(super.getUserInfo().getName()
								+ "提出转岗要求，请审批");
						sb.setOperateID("1351");
						this.linkucc.saveProcessBO(sb);
					}
					importData(bo);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public void importData(EmpPostChangeBO changbo) {
		try {
			WageAdjustBO adjust = this.adjustucc
					.getWageAdjustBOByLinkID(changbo.getPostChangeId());
			if (adjust == null) {
				PersonBO pb = SysCacheTool.findPersonById(changbo.getPersonId());
				adjust = new WageAdjustBO();
				adjust.setPersonID(changbo.getPersonId());
				adjust.setOrgID(pb.getOrgId());
				adjust.setStatus(WageAdjustBO.STATUS_APPLY);
				adjust.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
				adjust.setLinkID(changbo.getPostChangeId());
				adjust.setAdjustType("岗位调整");
				this.adjustucc.saveWageAdjustBO(adjust);

				OrgPostChangeBO opo = this.emppostchangeucc.findOrgPostChangeBO(super.getUserInfo().getOrgId());
				if ((opo != null) && (opo.getWageItem() != null)&& (!opo.getWageItem().equals(""))){
					this.adjustucc.createAdjustDetail(changbo.getPersonId(),adjust.getItemID(), opo.getWageItem().split(","));
				}
				CommonUtil.setWageAdjust(adjust.getItemID(), changbo.getPersonId(), changbo, false);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
  public void selPerson() {
    PersonBO[] pbos = (PersonBO[])(PersonBO[])super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
    if (pbos != null && pbos.length > 0) {
    	for(PersonBO p : pbos){
    		if(!selMap.containsKey(p.getPersonId())){
    			selMap.put(p.getPersonId(), p.getName());
    			this.personIds+=p.getPersonId()+",";
    			this.personNames+=p.getName()+",";
    		}
    	}
    }
  }
  public void clearPerson() {
	  this.selMap=new HashMap();
	  this.personNames = "";
	  this.personIds = "";
  }

  public boolean isEnableSelect()
  {
    return this.enableSelect;
  }
  public void setEnableSelect(boolean enableSelect) {
    this.enableSelect = enableSelect;
  }

  public String getInitEdit()
  {
    if ("true".equals(super.getRequestParameter("isMe"))) {
      this.enableSelect = false;
      this.personNames = super.getUserInfo().getName();
      this.personIds = super.getUserInfo().getUserId();
    }
    return this.initEdit;
  }

  public void setInitEdit(String initEdit) {
    this.initEdit = initEdit;
  }

  public EmpPostChangeBO getEmppostchangbo() {
    return this.emppostchangbo;
  }

  public void setEmppostchangbo(EmpPostChangeBO emppostchangbo) {
    this.emppostchangbo = emppostchangbo;
  }

  public String saveOrgPostChangeBO()
  {
    try
    {
      if ((this.baseFields != null) && (this.baseFields.size() > 0))
      {
        String fs = ((InfoItemBO)this.baseFields.get(0)).getItemId();
        for (int i = 1; i < this.baseFields.size(); i++) {
          fs = fs + "," + ((InfoItemBO)this.baseFields.get(i)).getItemId();
        }
        this.orgchangebo.setWageItem(fs);
      }
      else {
        this.orgchangebo.setWageItem("");
      }
      if ("new".equals(this.method))
        this.emppostchangeucc.saveOrgPostChangeBO(this.orgchangebo);
      else
        this.emppostchangeucc.updateOrgPostChangeBO(this.orgchangebo);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return "success";
  }

  public String getMethod()
  {
    return this.method;
  }

  public void setMethod(String method)
  {
    this.method = method;
  }

  public String getInitOrgEdit()
  {
    try
    {
      this.orgchangebo = this.emppostchangeucc.findOrgPostChangeBO(super.getUserInfo().getOrgId());
      if (this.orgchangebo != null)
      {
        this.orgchangebo.setOrgName(SysCacheTool.findOrgById(this.orgchangebo.getOrgUid()).getName());
        this.method = "update";
        find();
      }
      else {
        this.orgchangebo = new OrgPostChangeBO();
        this.orgchangebo.setOrgUid(super.getUserInfo().getOrgId());
        this.orgchangebo.setOrgName(SysCacheTool.findOrgById(super.getUserInfo().getOrgId()).getName());
        this.method = "new";
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return this.initOrgEdit;
  }

  public void setInitOrgEdit(String initOrgEdit)
  {
    this.initOrgEdit = initOrgEdit;
  }

  public OrgPostChangeBO getOrgchangebo()
  {
    return this.orgchangebo;
  }

  public void setOrgchangebo(OrgPostChangeBO orgchangebo)
  {
    this.orgchangebo = orgchangebo;
  }

  public String getInfoItem()
  {
    return this.infoItem;
  }

  public void setInfoItem(String infoItem)
  {
    this.infoItem = infoItem;
  }

  public List getBaseFields()
  {
    return this.baseFields;
  }

  public void setBaseFields(List baseFields)
  {
    this.baseFields = baseFields;
  }

  public String getCopySet()
  {
    return this.copySet;
  }

  public void setCopySet(String copySet)
  {
    this.copySet = copySet;
  }

  public IWageSetUCC getWagesetucc()
  {
    return this.wagesetucc;
  }

  public void setWagesetucc(IWageSetUCC wagesetucc)
  {
    this.wagesetucc = wagesetucc;
  }

  public String getUnitId()
  {
    return this.unitId;
  }

  public void setUnitId(String unitId)
  {
    this.unitId = unitId;
  }

  public String getSetId()
  {
    return this.setId;
  }

  public void setSetId(String setId)
  {
    this.setId = setId;
  }

  public String getProbation()
  {
    return this.probation;
  }

  public void setProbation(String probation)
  {
    this.probation = probation;
  }

  public String getNormailType()
  {
    return this.normailType;
  }

  public void setNormailType(String normailType)
  {
    this.normailType = normailType;
  }

  public void find()
  {
    if ((this.orgchangebo.getWageItem() != null) && (!"".equals(this.orgchangebo.getWageItem())))
    {
      String[] fs = this.orgchangebo.getWageItem().split(",");
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
    return "";
  }

  public String saveCopyPersonItem()
  {
    try
    {
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
    return "";
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
          if ((this.orgchangebo.getWageItem() == null) || ("".equals(this.orgchangebo.getWageItem())))
            break;
          String items = "";
          String[] fs = this.orgchangebo.getWageItem().split(",");
          for (int j = 0; j < fs.length; j++)
          {
            InfoItemBO ib1 = SysCacheTool.findInfoItem("", fs[j]);
            if (!ib1.getItemId().equals(ib.getItemId())) {
              items = items + ib1.getItemId() + ",";
            }
          }
          this.orgchangebo.setWageItem(items);
          try
          {
            this.emppostchangeucc.updateOrgPostChangeBO(this.orgchangebo);
          }
          catch (SysException e)
          {
            e.printStackTrace();
          }
          break;
        }

        i++;
      }
    }
    return "";
  }

  public String movePre()
  {
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
    return "";
  }

  public String moveNext()
  {
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
    return "";
  }

  public String getDateShowMode()
  {
    InfoItemBO bo = SysCacheTool.findInfoItem("", "A017015");
    if (bo.getItemDataType().equals("15"))
      this.dateShowMode = "6";
    else
      this.dateShowMode = "8";
    return this.dateShowMode;
  }

  public void setDateShowMode(String dateShowMode)
  {
    this.dateShowMode = dateShowMode;
  }

  private void linkAddBegin(EmpPostChangeBO changebo) {
    try {
      String pid = changebo.getPersonId();
      PersonBO pbo = SysCacheTool.findPersonById(pid);
      EmpBeginnerBO bo = new EmpBeginnerBO();
      bo.setCurPost(CommonFuns.filterNull(pbo.getPostId()));
      bo.setCurPostLevel(CommonFuns.filterNull(pbo.getPostLevel()));
      OrgBeginnerBO obo = this.empbeginnerucc.findOrgBeginnerBOByOrgId(super.getUserInfo().getOrgId());
      if ((obo != null) && (obo.getProbation() != null) && (!obo.getProbation().equals("")))
      {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cd = new GregorianCalendar();
        cd.setTime(sdf.parse(CommonFuns.getSysDate("yyyy-MM-dd")));
        cd.add(2, Integer.parseInt(obo.getProbation()));
        bo.setPlanPassDate(sdf.format(cd.getTime()));
      }
      else {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cd = new GregorianCalendar();
        cd.setTime(sdf.parse(CommonFuns.getSysDate("yyyy-MM-dd")));
        cd.add(2, Integer.parseInt(Constants.DEFAULT_BEGINNER));
        bo.setPlanPassDate(sdf.format(cd.getTime()));
      }
      bo.setPassPost(CommonFuns.filterNull(changebo.getPassPost()));
      bo.setPassPostLevel(CommonFuns.filterNull(changebo.getPassPostLevel()));
      bo.setPersonId(pid);
      bo.setStatus(EmpBeginnerBO.BEGINNERPROBATION);
      this.empbeginnerucc.saveEmpBeginnerBO(bo);
    } catch (Exception e) {
    }
  }

  private void notice(String name) throws SysException {
    SysInProcessBO sb = new SysInProcessBO();

    sb.setSendPerson(super.getUserInfo().getUserId());
    sb.setSendDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
    sb.setHave_process("0");
    sb.setContent("请办理" + name + "转岗工资变动");
    sb.setOrguid(super.getUserInfo().getOrgId());
    sb.setOperateID("0675");
    this.linkucc.saveProcessBO(sb);
  }

  public String shengxiao() {
    try {
      if ((this.personIds != null) && (!"".equals(this.personIds))) {
        String[] ids = this.personIds.split(",");
        for (int i = 0; i < ids.length; i++)
          if ((ids[i] != null) && (!ids[i].equals(""))) {
            EmpPostChangeBO bo = this.emppostchangeucc.findEmpPostChangeBOById(ids[i]);
            bo.setHrValidDate(this.efictDate);
            bo.setAddResume(this.addResume);
            this.emppostchangeucc.personMessageChange(super.getUserInfo(), bo);
            bo.setStatus(EmpPostChangeBO.HUMANEFFICIRNT);
            this.emppostchangeucc.saveEmpPostChangeBO(bo);
            if ("1".equals(bo.getLinkBeginMgr())) {
              linkAddBegin(bo);
            }

            if ("1".equals(Constants.EMP_POST_CHANGE_LINK)) {
              this.wagesetpersonucc.adjustWageDept(super.getUserInfo(), bo);
            }
            notice(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, bo.getPersonId()));
          }
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return "success";
  }

  public String getChangeIds() {
    return this.changeIds;
  }

  public void setChangeIds(String changeIds) {
    this.changeIds = changeIds;
  }

  public String getInitEfictPersons()
  {
    try {
      if (super.getRequestParameter("changeIds") != null)
      {
        this.changeIds = super.getRequestParameter("changeIds");
        InfoItemBO itembo = SysCacheTool.findInfoItem("", "A017015");
        if (itembo.getItemDataType().equals("15"))
          this.efictDate = CommonFuns.getSysDate("yyyy-MM");
        else
          this.efictDate = CommonFuns.getSysDate("yyyy-MM-dd");
        String[] ids = this.changeIds.split(",");
        this.personNames = "";
        this.personIds = "";
        for (int i = 0; i < ids.length; i++)
        {
          EmpPostChangeBO bo = this.emppostchangeucc.findEmpPostChangeBOById(ids[i]);
          if (bo == null)
            continue;
          PersonBO pbo = SysCacheTool.findPersonById(bo.getPersonId());
          if (Constants.EMP_DIRECT_POST_CHANGE.equals("0"))
          {
            if (bo.getStatus().equals(EmpPostChangeBO.APPROVED))
              if (this.personIds.equals(""))
              {
                this.personIds += bo.getPostChangeId();
                this.personNames += pbo.getName();
              }
              else {
                this.personIds = (this.personIds + "," + bo.getPostChangeId());
                this.personNames = (this.personNames + "," + pbo.getName());
              }
          }
          else if (bo.getStatus().equals(EmpPostChangeBO.APPLY)) {
            if (this.personIds.equals(""))
            {
              this.personIds += bo.getPostChangeId();
              this.personNames += pbo.getName();
            }
            else {
              this.personIds = (this.personIds + "," + bo.getPostChangeId());
              this.personNames = (this.personNames + "," + pbo.getName());
            }
          }
        }
      }

    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return this.initEfictPersons;
  }

  public void setInitEfictPersons(String initEfictPersons)
  {
    this.initEfictPersons = initEfictPersons;
  }

  public String getEfictDate()
  {
    return this.efictDate;
  }

  public void setEfictDate(String efictDate) {
    this.efictDate = efictDate;
  }

  public String getAddResume() {
    return this.addResume;
  }
  public void setAddResume(String addResume) {
    this.addResume = addResume;
  }

  public IEmpBeginnerUCC getEmpbeginnerucc() {
    return this.empbeginnerucc;
  }
  public void setEmpbeginnerucc(IEmpBeginnerUCC empbeginnerucc) {
    this.empbeginnerucc = empbeginnerucc;
  }

  public ISysInProcessUCC getLinkucc() {
    return this.linkucc;
  }
  public void setLinkucc(ISysInProcessUCC linkucc) {
    this.linkucc = linkucc;
  }

  public boolean isMustApprov() {
    this.mustApprov = "0".equals(Constants.EMP_DIRECT_POST_CHANGE);
    return this.mustApprov;
  }
  public void setMustApprov(boolean mustApprov) {
    this.mustApprov = mustApprov;
  }
}