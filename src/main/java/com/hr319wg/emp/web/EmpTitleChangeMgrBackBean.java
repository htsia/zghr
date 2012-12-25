package com.hr319wg.emp.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.EmpTitleChangeBO;
import com.hr319wg.emp.pojo.bo.OrgTitleChangeBO;
import com.hr319wg.emp.pojo.bo.OrgTitleWageBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IEmpTitleChangeUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.ucc.IWageAdjustUCC;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;

public class EmpTitleChangeMgrBackBean extends BaseBackingBean
{
  private IEmpTitleChangeUCC empTitleChangeUcc;
  private IWageAdjustUCC adjustucc;
  private List regTableList;
  private IUserReportUCC userreportucc;
  private String pageInit;
  private List personList;
  private PageVO mypage = new PageVO();
  private String titleChangeId;
  private boolean apply = true;
  private boolean efficent = false;
  private String initEdit;
  private String personIds;
  private String personNames;
  private EmpTitleChangeBO changeBo = new EmpTitleChangeBO();
  private String initWageItem;
  private List wageItemList;
  private String itemId;
  private IWageSetPersonUCC wagesetpersonucc;
  private String initItemEdit;
  private String initOrgEdit;
  private OrgTitleChangeBO orgchangebo = new OrgTitleChangeBO();
  private String wageInfoItem;
  private List baseFields = new ArrayList();
  private String copySet;
  private IWageSetUCC wagesetucc;
  private String unitId;
  private String setId;
  private String method;
  private String initOrgWageList;
  private List orgWageItemList;
  private String initOrgWageItemEdit;
  private OrgTitleWageBO orgTitleWagebo = new OrgTitleWageBO();

  public IWageAdjustUCC getAdjustucc()
  {
    return this.adjustucc;
  }
  public void setAdjustucc(IWageAdjustUCC adjustucc) {
    this.adjustucc = adjustucc;
  }

  public void queryApply(ValueChangeEvent event)
  {
    this.apply = "true".equals(event.getNewValue().toString());
    doQuery();
  }
  public void queryEfficent(ValueChangeEvent event) {
    this.efficent = "true".equals(event.getNewValue().toString());
    doQuery();
  }

  public boolean isApply() {
    return this.apply;
  }
  public void setApply(boolean apply) {
    this.apply = apply;
  }
  public boolean isEfficent() {
    return this.efficent;
  }
  public void setEfficent(boolean efficent) {
    this.efficent = efficent;
  }
  public String delete() {
    try {
      this.empTitleChangeUcc.deleteEmpTitleChangeBO(this.titleChangeId);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "";
  }
  public String perfict() {
    try {
      EmpTitleChangeBO bo = this.empTitleChangeUcc.findEmpTitleChangeBOById(this.titleChangeId);
      this.empTitleChangeUcc.saveEmpTitleChangeBOToHr(bo, super.getUserInfo());
      String zhicheng=bo.getZhicheng()==null?"":bo.getZhicheng();
      String prDate=bo.getPinrenDate()==null?"":bo.getPinrenDate();
      String prNum=bo.getPinrenNum()==null?"":bo.getPinrenNum();
      String isMost=bo.getIsMost()==null?"":bo.getIsMost();
      String isPr=bo.getIsPinren()==null?"":bo.getIsPinren();
      String remark=bo.getRemark()==null?"":bo.getRemark();
      String sql ="update a010 set A010005='"+zhicheng+"',A010015='"+prDate+"',A010705='"+prNum+"',A010206='"+isMost+"'," +
      		"A010207='"+isPr+"',A010201='"+remark+"' where subid=(select max(cast(subid as int)) from a010 where id ='"+bo.getPersonId()+"')";
      JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
      jdbc.execute(sql);
      bo.setStatus("1");
      this.empTitleChangeUcc.saveEmpTitleChangeBO(bo);
      super.showMessageDetail("生效成功！");
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "";
  }
  public String getTitleChangeId() {
    return this.titleChangeId;
  }
  public void setTitleChangeId(String titleChangeId) {
    this.titleChangeId = titleChangeId;
  }
  public String first() {
    this.mypage.setCurrentPage(1);
    doQuery();
    return "";
  }
  public String pre() {
    if (this.mypage.getCurrentPage() > 1) {
      this.mypage.setCurrentPage(this.mypage.getCurrentPage() - 1);
    }
    doQuery();
    return "";
  }
  public String next() {
    if (this.mypage.getCurrentPage() < this.mypage.getTotalPage()) {
      this.mypage.setCurrentPage(this.mypage.getCurrentPage() + 1);
    }
    doQuery();
    return "";
  }
  public String last() {
    this.mypage.setCurrentPage(this.mypage.getTotalPage());
    doQuery();
    return "";
  }
  public void doQuery() {
    try {
      if (this.mypage.getCurrentPage() == 0) this.mypage.setCurrentPage(1);
      List status = new ArrayList();
      if (this.apply == true) {
        status.add("0");
      }
      if (this.efficent == true) {
        status.add("1");
      }
      this.personList = this.empTitleChangeUcc.getAllEmpTitleChangeBO(this.mypage, super.getUserInfo().getOrgId(), status);
      if ((this.personList != null) && (this.personList.size() > 0))
        for (int i = 0; i < this.personList.size(); i++) {
          EmpTitleChangeBO bo = (EmpTitleChangeBO)this.personList.get(i);
          PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
          bo.setPersonCode(p.getPersonCode());
          bo.setPersonName(p.getName());
          bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
          bo.setZhicheng(CodeUtil.interpertCode(bo.getZhicheng()));
          bo.setIsMost(CodeUtil.interpertCode(bo.getIsMost()));
          bo.setIsPinren(CodeUtil.interpertCode(bo.getIsPinren()));
          this.personList.set(i, bo);
        }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public String getPageInit() {
    doQuery();
    return this.pageInit;
  }

  public void setPageInit(String pageInit) {
    this.pageInit = pageInit;
  }

  public List getPersonList() {
    return this.personList;
  }

  public void setPersonList(List personList) {
    this.personList = personList;
  }

  public PageVO getMypage() {
    return this.mypage;
  }

  public void setMypage(PageVO mypage) {
    this.mypage = mypage;
  }

  public List getRegTableList()
  {
    try {
      this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), "1365", UserRptVO.TYPE_REG);
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

  public IEmpTitleChangeUCC getEmpTitleChangeUcc() {
    return this.empTitleChangeUcc;
  }

  public void setEmpTitleChangeUcc(IEmpTitleChangeUCC empTitleChangeUcc) {
    this.empTitleChangeUcc = empTitleChangeUcc;
  }

  public String selPerson()
  {
    PersonBO[] pbos = (PersonBO[])(PersonBO[])super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
    String names = "";
    String ids = "";
    if ((pbos != null) && (pbos.length > 0)) {
      for (int i = 0; i < pbos.length; i++) {
        names = names + pbos[i].getName() + ",";
        ids = ids + pbos[i].getPersonId() + ",";
      }
    }
    this.personNames = names;
    this.personIds = ids;
    return "";
  }
  public String getPersonNames() {
    return this.personNames;
  }
  public void setPersonNames(String personNames) {
    this.personNames = personNames;
  }
  public String save() {
    try {
      String[] ids = this.personIds.split(",");
      for (int i = 0; i < ids.length; i++)
        if ((ids[i] != null) && (!ids[i].equals(""))) {
          EmpTitleChangeBO bo = new EmpTitleChangeBO();
          bo.setPersonId(ids[i]);
          bo.setApplyTitle(this.changeBo.getZhicheng());
          bo.setZhicheng(this.changeBo.getZhicheng());
          bo.setPinrenDate(this.changeBo.getPinrenDate());
          bo.setPinrenNum(this.changeBo.getPinrenNum());
          bo.setIsMost(this.changeBo.getIsMost());
          bo.setIsPinren(this.changeBo.getIsPinren());
          bo.setRemark(this.changeBo.getRemark());
          bo.setStatus("0");
          this.empTitleChangeUcc.saveEmpTitleChangeBO(bo);
          importWageItem(bo);
        }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return "success";
  }

  public String getInitEdit() {
    return this.initEdit;
  }
  public void setInitEdit(String initEdit) {
    this.initEdit = initEdit;
  }
  public String getPersonIds() {
    return this.personIds;
  }
  public void setPersonIds(String personIds) {
    this.personIds = personIds;
  }
  public EmpTitleChangeBO getChangeBo() {
    return this.changeBo;
  }
  public void setChangeBo(EmpTitleChangeBO changeBo) {
    this.changeBo = changeBo;
  }

  public IWageSetPersonUCC getWagesetpersonucc()
  {
    return this.wagesetpersonucc;
  }
  public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
    this.wagesetpersonucc = wagesetpersonucc;
  }
  public String deleteItem() {
    try {
      this.adjustucc.deleteWageAdjustDetailBO(this.itemId);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "";
  }

  private void importWageItem(EmpTitleChangeBO changebo) {
		try {
			WageAdjustBO adjust = this.adjustucc.getWageAdjustBOByLinkID(changebo.getTitleChangeId());
			if (adjust == null) {
				PersonBO pb = SysCacheTool.findPersonById(changebo.getPersonId());
				adjust = new WageAdjustBO();
				adjust.setPersonID(changebo.getPersonId());
				adjust.setOrgID(pb.getOrgId());
				adjust.setStatus(WageAdjustBO.STATUS_APPLY);
				adjust.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
				adjust.setLinkID(changebo.getTitleChangeId());
				adjust.setAdjustType("职称变动");
				this.adjustucc.saveWageAdjustBO(adjust);

				String item = "";
				List list = this.empTitleChangeUcc.getAllOrgTitleWageBO(super.getUserInfo().getOrgId());
				if ((list != null) && (list.size() > 0)) {
					for (int i = 0; i < list.size(); i++) {
						OrgTitleWageBO bo = (OrgTitleWageBO) list.get(i);
						if ("".equals(item)) {
							item = bo.getWageItem();
						} else {
							item = item + "," + bo.getWageItem();
						}
					}
				}
				if (!"".equals(item)){
					this.adjustucc.createAdjustDetail(changebo.getPersonId(),adjust.getItemID(), item.split(","));
				}
//				CommonUtil.setWageAdjust(adjust.getItemID(), changebo.getPersonId(), null, false);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

  public String getInitWageItem() {
    try {
      if (super.getRequestParameter("titleChangeId") != null) {
        this.titleChangeId = super.getRequestParameter("titleChangeId");
        EmpTitleChangeBO changebo = this.empTitleChangeUcc.findEmpTitleChangeBOById(this.titleChangeId);
        importWageItem(changebo);
      }
      doQueryWageItem();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return this.initWageItem;
  }

  public String doQueryWageItem() {
    try {
      WageAdjustBO adjustbo = this.adjustucc.getWageAdjustBOByLinkID(this.titleChangeId);
      this.wageItemList = this.adjustucc.getAdjustDetail(adjustbo.getItemID());
      if ((this.wageItemList != null) && (this.wageItemList.size() > 0)) {
        for (int i = 0; i < this.wageItemList.size(); i++) {
          WageAdjustDetailBO bo = (WageAdjustDetailBO)this.wageItemList.get(i);
          bo.setFieldName(CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, bo.getFieldID()));
          bo.setOldValue(CodeUtil.interpertCode(bo.getOldValue()));
          bo.setNewValue(CodeUtil.interpertCode(bo.getNewValue()));
        }
      }
    }
    catch (Exception e)
    {
    }

    return "";
  }
  public void setInitWageItem(String initWageItem) {
    this.initWageItem = initWageItem;
  }
  public List getWageItemList() {
    return this.wageItemList;
  }
  public void setWageItemList(List wageItemList) {
    this.wageItemList = wageItemList;
  }
  public String getItemId() {
    return this.itemId;
  }
  public void setItemId(String itemId) {
    this.itemId = itemId;
  }

  public String saveNewValue()
  {
    return "success";
  }
  public String getInitItemEdit() {
    try {
      if (super.getRequestParameter("itemId") == null);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return this.initItemEdit;
  }
  public void setInitItemEdit(String initItemEdit) {
    this.initItemEdit = initItemEdit;
  }

  public String saveOrgTitleChangeBO()
  {
    try
    {
      if ((this.baseFields != null) && (this.baseFields.size() > 0))
      {
        String fs = ((InfoItemBO)this.baseFields.get(0)).getItemId();
        List list = this.empTitleChangeUcc.getAllOrgTitleWageBO(super.getUserInfo().getOrgId());
        if ((list != null) && (list.size() > 0)) {
          for (int i = 0; i < list.size(); i++) {
            OrgTitleWageBO bo = (OrgTitleWageBO)list.get(i);
            this.empTitleChangeUcc.deleteOrgTitleWageBO(bo.getItemId());
          }
        }
        for (int i = 1; i < this.baseFields.size(); i++) {
          fs = fs + "," + ((InfoItemBO)this.baseFields.get(i)).getItemId();
        }
        this.orgchangebo.setWageItem(fs);
        String[] ids = fs.split(",");
        for (int i = 0; i < ids.length; i++)
        {
          OrgTitleWageBO wagebo = new OrgTitleWageBO();
          wagebo.setOrgUid(super.getUserInfo().getOrgId());
          wagebo.setWageItem(ids[i]);
          wagebo.setWageType("1");
          wagebo.setWageOrder(String.valueOf(i + 1));
          this.empTitleChangeUcc.saveOrgTitleWageBO(wagebo);
        }
      }
      else {
        this.orgchangebo.setWageItem("");
      }
      if ("new".equals(this.method))
        this.empTitleChangeUcc.saveOrgTitleChangeBO(this.orgchangebo);
      else
        this.empTitleChangeUcc.updateOrgTitleChangeBO(this.orgchangebo);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return "success";
  }

  public String getInitOrgEdit() {
    try {
      this.orgchangebo = this.empTitleChangeUcc.findOrgTitleChangeBOById(super.getUserInfo().getOrgId());

      if (this.orgchangebo != null) {
        this.orgchangebo.setOrgName(SysCacheTool.findOrgById(this.orgchangebo.getOrgUid()).getName());

        this.method = "update";
        find();
      } else {
        this.orgchangebo = new OrgTitleChangeBO();
        this.orgchangebo.setOrgUid(super.getUserInfo().getOrgId());
        this.orgchangebo.setOrgName(SysCacheTool.findOrgById(super.getUserInfo().getOrgId()).getName());

        this.method = "new";
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return this.initOrgEdit;
  }
  public void setInitOrgEdit(String initOrgEdit) {
    this.initOrgEdit = initOrgEdit;
  }
  public OrgTitleChangeBO getOrgchangebo() {
    return this.orgchangebo;
  }
  public void setOrgchangebo(OrgTitleChangeBO orgchangebo) {
    this.orgchangebo = orgchangebo;
  }
  public String getWageInfoItem() {
    return this.wageInfoItem;
  }
  public void setWageInfoItem(String wageInfoItem) {
    this.wageInfoItem = wageInfoItem;
  }
  public List getBaseFields() {
    return this.baseFields;
  }
  public void setBaseFields(List baseFields) {
    this.baseFields = baseFields;
  }
  public String getCopySet() {
    return this.copySet;
  }
  public void setCopySet(String copySet) {
    this.copySet = copySet;
  }
  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }
  public void setWagesetucc(IWageSetUCC wagesetucc) {
    this.wagesetucc = wagesetucc;
  }
  public String getUnitId() {
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
  public String getMethod() {
    return this.method;
  }
  public void setMethod(String method) {
    this.method = method;
  }

  public void find() {
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
    if ((this.wageInfoItem != null) && (!"".equals(this.wageInfoItem)))
    {
      String[] inf = this.wageInfoItem.replace('.', ',').split(",");
      InfoItemBO ib = SysCacheTool.findInfoItem("", inf[1]);
      ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, inf[0]));
      ib.setItemSequence(String.valueOf(this.baseFields.size() + 1));
      this.baseFields.add(ib);
    }
    return "";
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
    return "";
  }

  public String delfield() {
    if ((this.wageInfoItem != null) && (!"".equals(this.wageInfoItem)) && (this.baseFields != null))
    {
      int i = 0;

      while (i < this.baseFields.size())
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.wageInfoItem.equals(ib.getItemId()))
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
          try {
            this.empTitleChangeUcc.updateOrgTitleChangeBO(this.orgchangebo);
          } catch (SysException e) {
            e.printStackTrace();
          }
          break;
        }

        i++;
      }
    }
    return "";
  }

  public String movePre() {
    if ((this.wageInfoItem != null) && (!"".equals(this.wageInfoItem)) && (this.baseFields != null))
    {
      int i = 0;
      i = 0;

      while (i < this.baseFields.size())
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.wageInfoItem.equals(ib.getItemId()))
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

  public String moveNext() {
    if ((this.wageInfoItem != null) && (!"".equals(this.wageInfoItem)) && (this.baseFields != null))
    {
      int i = 0;
      i = 0;

      while (i < this.baseFields.size())
      {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.wageInfoItem.equals(ib.getItemId()))
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

  public String saveOrgWageItem()
  {
    try
    {
      this.empTitleChangeUcc.saveOrgTitleWageBO(this.orgTitleWagebo);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "success";
  }
  public OrgTitleWageBO getOrgTitleWagebo() {
    return this.orgTitleWagebo;
  }
  public void setOrgTitleWagebo(OrgTitleWageBO orgTitleWagebo) {
    this.orgTitleWagebo = orgTitleWagebo;
  }
  public String getInitOrgWageItemEdit() {
    try {
      if (super.getRequestParameter("itemId") != null) {
        this.itemId = super.getRequestParameter("itemId");
      }
      this.orgTitleWagebo = this.empTitleChangeUcc.findOrgTitleWageBOById(this.itemId);
      this.orgTitleWagebo.setWageItemDes(SysCacheTool.findInfoItem("", this.orgTitleWagebo.getWageItem()).getItemName());
    } catch (Exception e) {
      e.printStackTrace();
    }
    return this.initOrgWageItemEdit;
  }
  public void setInitOrgWageItemEdit(String initOrgWageItemEdit) {
    this.initOrgWageItemEdit = initOrgWageItemEdit;
  }
  public String getInitOrgWageList() {
    try {
      this.orgWageItemList = new ArrayList();
      this.orgWageItemList = this.empTitleChangeUcc.getAllOrgTitleWageBO(super.getUserInfo().getOrgId());
      if ((this.orgWageItemList != null) && (this.orgWageItemList.size() > 0))
        for (int i = 0; i < this.orgWageItemList.size(); i++) {
          OrgTitleWageBO wagebo = (OrgTitleWageBO)this.orgWageItemList.get(i);
          wagebo.setWageItemDes(SysCacheTool.findInfoItem("", wagebo.getWageItem()).getItemName());
          this.orgWageItemList.set(i, wagebo);
        }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return this.initOrgWageList;
  }
  public void setInitOrgWageList(String initOrgWageList) {
    this.initOrgWageList = initOrgWageList;
  }
  public List getOrgWageItemList() {
    return this.orgWageItemList;
  }
  public void setOrgWageItemList(List orgWageItemList) {
    this.orgWageItemList = orgWageItemList;
  }
}