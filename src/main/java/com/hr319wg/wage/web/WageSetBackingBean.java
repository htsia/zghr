package com.hr319wg.wage.web;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageCessBO;
import com.hr319wg.wage.pojo.bo.WageOrgInsuraceBO;
import com.hr319wg.wage.pojo.bo.WagePostLinkBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.ucc.IWageCessUCC;
import com.hr319wg.wage.ucc.IWageComputeUCC;
import com.hr319wg.wage.ucc.IWageSetItemUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;
import com.hr319wg.wage.ucc.IWageUnitUCC;

public class WageSetBackingBean extends BaseBackingBean
{
  private WageSetBO wageset = new WageSetBO();
  private WageOrgInsuraceBO orgins = new WageOrgInsuraceBO();
  private List setlist;
  private List b732cessList;
  private IWageSetUCC wagesetucc;
  private IWageSetItemUCC wagesetitemucc;
  private IWageCessUCC wagecessucc;
  private IWageComputeUCC wagecomputeucc;
  private IWageUnitUCC unitucc;
  private String unitName;
  private List selitem;
  private List selUnititem;
  private List cessList;
  private List actcessList;
  private List filterList;
  private String setMB;
  private boolean canCopyset;
  private List baseFields;
  private List orgsumFields;
  private String pid;
  private List operPersons;
  private List personList;
  private String infoItem;
  private String deptItem;
  private WageAPI wageapi;
  private boolean canTestSet;
  private String copySet;
  private String initOrgIns;
  private List baseField;
  private List postLinkList;
  private String linkID;
  private String postIDs;
  private boolean showOnlyUse = true;
  private String initAddset;
  private String initPersonPower;
  private boolean oper063102;
  private boolean oper063103;
  private boolean oper063104;
  private boolean oper063105;
  private boolean oper063106;
  private boolean oper063107;
  private boolean oper063108;
  private boolean oper063109;
  private boolean oper063110;
  private boolean oper063111;
  private boolean oper063112;
  private boolean oper063113;

  public boolean isShowOnlyUse()
  {
    return this.showOnlyUse;
  }

  public void setShowOnlyUse(boolean showOnlyUse) {
    this.showOnlyUse = showOnlyUse;
  }

  public String getPostIDs()
  {
    return this.postIDs;
  }
  public void setPostIDs(String postIDs) {
    this.postIDs = postIDs;
  }

  public String getLinkID() {
    return this.linkID;
  }
  public void setLinkID(String linkID) {
    this.linkID = linkID;
  }

  public List getPostLinkList() {
    try {
      this.postLinkList = this.wagesetucc.getPostList(this.copySet);
      for (int i = 0; i < this.postLinkList.size(); i++) {
        WagePostLinkBO bo = (WagePostLinkBO)this.postLinkList.get(i);
        PostBO pb = SysCacheTool.findPost(bo.getPostID());
        if (pb != null) {
          bo.setPostName(pb.getName());
          bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId()));
        }
      }
    }
    catch (Exception e)
    {
    }
    return this.postLinkList;
  }

  public String deletePostLink() {
    try {
      this.wagesetucc.deleteWagePostLinkBO(this.linkID);
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public String savePostLink() {
    try {
      String[] postid = this.postIDs.split(",");
      for (int i = 0; i < postid.length; i++) {
        if (this.wagesetucc.getLinkBO(this.copySet, postid[i]) == null) {
          WagePostLinkBO bo = new WagePostLinkBO();
          bo.setSetID(this.copySet);
          bo.setPostID(postid[i]);
          this.wagesetucc.saveWagePostLinkBO(bo);
        }
      }
    }
    catch (Exception e)
    {
    }
    return "";
  }

  public void setPostLinkList(List postLinkList) {
    this.postLinkList = postLinkList;
  }

  public List getBaseField() {
    return this.baseField;
  }
  public void setBaseField(List list) {
    this.baseField = list;
  }

  public List getFilterList() {
    if (this.filterList == null) {
      this.filterList = new ArrayList();

      SelectItem si = new SelectItem();
      si.setLabel("--不设范围--");
      si.setValue("");
      this.filterList.add(si);

      String[] fs = Constants.WAGE_CESS_FILTER_FIELDS.split(",");
      for (int i = 0; i < fs.length; i++) {
        InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
        SelectItem si0 = new SelectItem();
        si0.setLabel(ib.getItemName());
        si0.setValue(ib.getItemId());
        this.filterList.add(si0);
      }
    }
    return this.filterList;
  }
  public void setFilterList(List list) {
    this.filterList = list;
  }

  public String getInitOrgIns() {
    try {
      if (super.getRequestParameter("setID") != null) {
        this.orgins = this.wagesetucc.findOrgInsBO(super.getRequestParameter("setID"));
        if (this.orgins == null) {
          this.orgins = new WageOrgInsuraceBO();
          this.copySet = super.getRequestParameter("setID");
        }
        WageSetBO wb = this.wagesetucc.findSetBySetId(super.getRequestParameter("setID"));
        WageUnitBO unit = this.unitucc.findUnitByID(wb.getUnitId());
        this.orgins.setHouseRate(unit.getHousing_unit());
        this.orgins.setEndowmentRate(unit.getEndowment_unit());
        this.orgins.setUnemployRate(unit.getUnemployment_unit());
        this.orgins.setProcreateRate(unit.getProcreate_unit());
        this.orgins.setAnnuityRate(unit.getAnnuity_Unit());
        this.orgins.setCompoRate(unit.getCompo_unit());
        this.orgins.setMedicareRate(unit.getMedicare_unit());
        String[] list = Constants.WAGE_ORGINSURACE_FIELDS.split(",");
        this.baseField = new ArrayList();
        SelectItem si = new SelectItem();
        si.setLabel("");
        si.setValue("");
        this.baseField.add(si);
        for (int i = 0; i < list.length; i++) {
          InfoItemBO ib = SysCacheTool.findInfoItem("", list[i]);
          si = new SelectItem();
          si.setLabel(ib.getItemName());
          si.setValue(ib.getItemId());
          this.baseField.add(si);
        }
      }
    }
    catch (Exception e)
    {
    }
    return this.initOrgIns;
  }
  public void setInitOrgIns(String init) {
    this.initOrgIns = init;
  }

  public String saveOrgIns() {
    try {
      if (this.orgins.getSetID() == null) {
        this.orgins.setSetID(this.copySet);
        this.wagesetucc.createOrgInsBO(this.orgins);
      }
      else {
        this.wagesetucc.saveOrgInsBO(this.orgins);
      }
    }
    catch (Exception e)
    {
    }
    return "success";
  }

  public WageOrgInsuraceBO getOrgins() {
    return this.orgins;
  }
  public void setOrgins(WageOrgInsuraceBO bo) {
    this.orgins = bo;
  }
  public boolean isCanTestSet() {
    if (Constants.WAGE_SET_TEST.indexOf(super.getUserInfo().getUserId()) >= 0) {
      this.canTestSet = true;
    }
    else {
      this.canTestSet = false;
    }
    return this.canTestSet;
  }
  public void setCanTestSet(boolean b) {
    this.canTestSet = b;
  }

  public String getCopySet() {
    if (super.getRequestParameter("setID") != null) {
      this.copySet = super.getRequestParameter("setID");
    }
    return this.copySet;
  }
  public void setCopySet(String set) {
    this.copySet = set;
  }

  public String saveCopyDeptItem() {
    try {
      WageSetBO wb = this.wagesetucc.findSetBySetId(this.copySet);
      this.orgsumFields = new ArrayList();
      if ((wb.getDeptField() != null) && (!"".equals(wb.getDeptField()))) {
        String[] fs = wb.getDeptField().split(",");
        for (int i = 0; i < fs.length; i++) {
          InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
          ib.setItemSequence(String.valueOf(i + 1));
          ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, ib.getSetId()));
          this.orgsumFields.add(ib);
        }
      }
    }
    catch (Exception e)
    {
    }

    return "";
  }
  public String saveCopyPersonItem() {
    try {
      WageSetBO wb = this.wagesetucc.findSetBySetId(this.copySet);
      this.baseFields = new ArrayList();
      if ((wb.getBaseinfo() != null) && (!"".equals(wb.getBaseinfo()))) {
        String[] fs = wb.getBaseinfo().split(",");
        for (int i = 0; i < fs.length; i++) {
          InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
          ib.setItemSequence(String.valueOf(i + 1));
          ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, ib.getSetId()));
          this.baseFields.add(ib);
        }
      }
    }
    catch (Exception e)
    {
    }
    return "";
  }

  public IWageUnitUCC getUnitucc() {
    return this.unitucc;
  }
  public void setUnitucc(IWageUnitUCC ucc) {
    this.unitucc = ucc;
  }

  public WageAPI getWageapi() {
    return this.wageapi;
  }
  public void setWageapi(WageAPI api) {
    this.wageapi = api;
  }

  public IWageComputeUCC getWagecomputeucc() {
    return this.wagecomputeucc;
  }
  public void setWagecomputeucc(IWageComputeUCC wagecomputeucc) {
    this.wagecomputeucc = wagecomputeucc;
  }

  public String getPid() {
    return this.pid;
  }
  public void setPid(String id) {
    this.pid = id;
  }

  public String getDeptItem() {
    return this.deptItem;
  }
  public void setDeptItem(String info) {
    this.deptItem = info;
  }

  public String getInfoItem() {
    return this.infoItem;
  }
  public void setInfoItem(String info) {
    this.infoItem = info;
  }

  public List getOrgsumFields() {
    return this.orgsumFields;
  }
  public void setOrgsumFields(List fs) {
    this.orgsumFields = fs;
  }

  public List getOperPersons() {
    return this.operPersons;
  }
  public void setOperPersons(List fs) {
    this.operPersons = fs;
  }

  public List getBaseFields() {
    return this.baseFields;
  }
  public void setBaseFields(List fs) {
    this.baseFields = fs;
  }

  public String addfield() {
    if ((this.infoItem != null) && (!"".equals(this.infoItem))) {
      String[] inf = this.infoItem.replace('.', ',').split(",");
      InfoItemBO ib = SysCacheTool.findInfoItem("", inf[1]);
      ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, inf[0]));
      ib.setItemSequence(String.valueOf(this.baseFields.size() + 1));
      this.baseFields.add(ib);
    }
    return "";
  }
  public String delfield() {
    if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null)) {
      for (int i = 0; i < this.baseFields.size(); i++) {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.infoItem.equals(ib.getItemId())) {
          this.baseFields.remove(i);
          break;
        }
      }
    }
    return "";
  }
  public String addPerson() {
    if ((this.pid != null) && (!"".equals(this.pid))) {
      String ids = "";
      for (int i = 0; i < this.operPersons.size(); i++) {
        ids = "," + ((PersonBO)this.operPersons.get(i)).getPersonId();
      }
      if (ids.indexOf(this.pid) < 0) {
        PersonBO pb = SysCacheTool.findPersonById(this.pid);
        this.operPersons.add(pb);
      }
    }
    return "";
  }

  public String delPerson() {
    if ((this.pid != null) && (!"".equals(this.pid)) && (this.operPersons != null)) {
      for (int i = 0; i < this.operPersons.size(); i++) {
        PersonBO ib = (PersonBO)this.operPersons.get(i);
        if (this.pid.equals(ib.getPersonId())) {
          this.operPersons.remove(i);
          break;
        }
      }
    }
    return "";
  }

  public List getPersonList() {
    if (this.personList == null) {
      this.personList = new ArrayList();
      try {
        String[] pids = this.wageapi.getWageSetUser(this.wageset.getSetId());

        for (int i = 0; i < pids.length; i++) {
          if (i == 0) this.pid = pids[0];
          SelectItem si = new SelectItem();
          si.setLabel(SysCacheTool.findPersonById(pids[i]).getName());
          si.setValue(pids[i]);
          this.personList.add(si);
        }
      }
      catch (Exception e)
      {
      }
    }
    return this.personList;
  }
  public void setPersonList(List li) {
    this.personList = li;
  }

  public String adddeptfield() {
    if ((this.deptItem != null) && (!"".equals(this.deptItem))) {
      String[] inf = this.deptItem.replace('.', ',').split(",");
      InfoItemBO ib = SysCacheTool.findInfoItem("", inf[1]);
      ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, inf[0]));
      ib.setItemSequence(String.valueOf(this.orgsumFields.size() + 1));
      this.orgsumFields.add(ib);
    }
    return "";
  }
  public String deldeptfield() {
    if ((this.deptItem != null) && (!"".equals(this.deptItem)) && (this.orgsumFields != null)) {
      for (int i = 0; i < this.orgsumFields.size(); i++) {
        InfoItemBO ib = (InfoItemBO)this.orgsumFields.get(i);
        if (this.deptItem.equals(ib.getItemId())) {
          this.orgsumFields.remove(i);
          break;
        }
      }
    }
    return "";
  }

  public List getB732cessList()
  {
    if (this.b732cessList != null) return this.b732cessList;
    List list = SysCacheTool.queryInfoItemBySetId("B732");
    this.b732cessList = new ArrayList();
    SelectItem si = new SelectItem();
    si.setLabel("--请选择--");
    si.setValue("-1");
    this.b732cessList.add(si);
    for (int i = 0; i < list.size(); i++) {
      InfoItemBO ib = (InfoItemBO)list.get(i);
      if ((ib.getItemId().equals("ORGUID")) || (ib.getItemId().equals("SUBID")) || (ib.getItemId().equals("B732000")) || (ib.getItemId().equals("B732001")) || (ib.getItemId().equals("B732002")))
      {
        continue;
      }

      SelectItem si1 = new SelectItem();
      si1.setLabel(ib.getItemNameEx());
      si1.setValue(ib.getItemId());
      this.b732cessList.add(si1);
    }

    return this.b732cessList;
  }

  public void setB732cessList(List li) {
    this.b732cessList = li;
  }

  public List getActcessList() {
    try {
      List li = this.wagecessucc.queryAll();
      this.actcessList = new ArrayList();
      SelectItem si = new SelectItem();
      si.setLabel("不关联税率表");
      si.setValue("");
      this.actcessList.add(si);
      for (int i = 0; i < li.size(); i++) {
        WageCessBO wb = (WageCessBO)li.get(i);
        if ("1".equals(wb.getTaxType())) {
          SelectItem si1 = new SelectItem();
          si1.setLabel(wb.getDescription());
          si1.setValue(wb.getCessID());
          this.actcessList.add(si1);
        }
      }
    }
    catch (Exception e) {
      this.actcessList = new ArrayList();
    }
    return this.actcessList;
  }

  public void setActcessList(List actcessList) {
    this.actcessList = actcessList;
  }

  public List getCessList() {
    try {
      List li = this.wagecessucc.queryAll();
      this.cessList = new ArrayList();
      SelectItem si = new SelectItem();
      si.setLabel("不关联税率表");
      si.setValue("");
      this.cessList.add(si);
      for (int i = 0; i < li.size(); i++) {
        WageCessBO wb = (WageCessBO)li.get(i);
        if (!"1".equals(wb.getTaxType())) {
          SelectItem si1 = new SelectItem();
          si1.setLabel(wb.getDescription());
          si1.setValue(wb.getCessID());
          this.cessList.add(si1);
        }
      }
    } catch (Exception e) {
      this.cessList = new ArrayList();
    }
    return this.cessList;
  }
  public void setCessList(List li) {
    this.cessList = li;
  }

  public IWageSetItemUCC getwagesetitemucc() {
    return this.wagesetitemucc;
  }
  public void setwagesetitemucc(IWageSetItemUCC mb) {
    this.wagesetitemucc = mb;
  }

  public IWageCessUCC getWagecessucc() {
    return this.wagecessucc;
  }
  public void setWagecessucc(IWageCessUCC mb) {
    this.wagecessucc = mb;
  }

  public boolean getCanCopyset() {
    this.canCopyset = ((this.wageset.getSetId() == null) || (this.wageset.getSetId().equals("")));
    return this.canCopyset;
  }
  public void setCanCopyset(boolean mb) {
    this.canCopyset = mb;
  }

  public String getSetMB()
  {
    return this.setMB;
  }
  public void setSetMB(String mb) {
    this.setMB = mb;
  }

  public List getSelitem() {
    this.selitem = new LinkedList();
    this.selitem.add(new SelectItem("", "---请选择---"));
    try {
      List wagelist = this.wagesetucc.queryAllSet();
      for (int i = 0; i < wagelist.size(); i++) {
        WageSetBO wb = (WageSetBO)wagelist.get(i);
        SelectItem si = new SelectItem();
        si.setLabel(wb.getName());
        si.setValue(wb.getSetId());
        this.selitem.add(si);
      }
    }
    catch (Exception e)
    {
    }
    return this.selitem;
  }
  public void setSelitem(List li) {
    this.selitem = li;
  }

  public List getSelUnititem() {
    this.selUnititem = new LinkedList();
    this.selUnititem.add(new SelectItem("", "---请选择---"));
    try {
      String UnitID = super.getRequestParameter("UnitID");
      String SetID = super.getRequestParameter("SetID");
      List wagelist = this.wagesetucc.querySetByUnitId(UnitID);
      for (int i = 0; i < wagelist.size(); i++) {
        WageSetBO wb = (WageSetBO)wagelist.get(i);
        if (!SetID.equals(wb.getSetId())) {
          SelectItem si = new SelectItem();
          si.setLabel(wb.getName());
          si.setValue(wb.getSetId());
          this.selUnititem.add(si);
        }
      }
    }
    catch (Exception e)
    {
    }
    return this.selUnititem;
  }

  public void setSelUnititem(List li) {
    this.selUnititem = li;
  }
  private void queryWageSetList() {
    try {
      this.setlist = this.wagesetucc.querySetByUnitId(this.wageset.getUnitId());
      this.setlist = CodeUtil.codeInterpret(this.setlist, "flowFlag", "CODE");
      if (this.showOnlyUse)
        for (int i = 0; i < this.setlist.size(); i++) {
          WageSetBO bo = (WageSetBO)this.setlist.get(i);
          if ("1".equals(bo.getNoUse())) {
            this.setlist.remove(i);
            i--;
          }
        }
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
  }

  public void changeUseAll(ValueChangeEvent event) {
    if ("true".equals(event.getNewValue().toString())) {
      this.showOnlyUse = true;
    }
    else {
      this.showOnlyUse = false;
    }
    queryWageSetList();
  }
  public String getPageInit() {
    String act = super.getServletRequest().getParameter("act");
    if ("list".equals(act)) {
      String unitId = super.getServletRequest().getParameter("unitId");
      User us = super.getUserInfo();
      if ((unitId == null) || ("".equals(unitId))) {
        PersonBO person = SysCacheTool.findPersonById(us.getUserId());
        WageUnitBO userUnit = SysCacheTool.findWageUnit(person.getGongZiGX());

        if (userUnit == null) {
          super.showMessageDetail("错误：用户没有发薪单位");
          return "";
        }
        unitId = userUnit.getUnitId();
      }
      if (this.wageset == null)
        this.wageset = new WageSetBO();
      this.wageset.setUnitId(unitId);
    }
    this.unitName = CodeUtil.interpertCode("OU", this.wageset.getUnitId());
    queryWageSetList();
    return this.pageInit;
  }

  public WageSetBO getWageset() {
    return this.wageset;
  }
  public void setWageset(WageSetBO wageset) {
    this.wageset = wageset;
  }

  public List getSetlist() {
    return this.setlist;
  }
  public void setSetlist(List setlist) {
    this.setlist = setlist;
  }

  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }
  public void setWagesetucc(IWageSetUCC wagesetucc) {
    this.wagesetucc = wagesetucc;
  }

  public String getUnitName() {
    return this.unitName;
  }
  public void setUnitName(String unitName) {
    this.unitName = unitName;
  }

  public String savePower()
  {
    try
    {
      if ((this.operPersons != null) && (this.operPersons.size() > 0)) {
        String fs = ((PersonBO)this.operPersons.get(0)).getPersonId();
        for (int i = 1; i < this.operPersons.size(); i++) {
          fs = fs + "," + ((PersonBO)this.operPersons.get(i)).getPersonId();
        }
        this.wageset.setOperPersons(fs);
      }
      else {
        this.wageset.setOperPersons("");
      }
      this.wagesetucc.updateSet(this.wageset);
      super.showMessageDetail("保存账套成功");
    }
    catch (Exception e)
    {
    }
    return list();
  }
  public String save() {
    try {
      this.wageset.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      if ("-1".equals(this.wageset.getParaToField1())) {
        this.wageset.setParaToField1("");
      }
      if ("-1".equals(this.wageset.getParaToField2())) {
        this.wageset.setParaToField2("");
      }

      if ((this.baseFields != null) && (this.baseFields.size() > 0)) {
        String fs = ((InfoItemBO)this.baseFields.get(0)).getItemId();
        for (int i = 1; i < this.baseFields.size(); i++) {
          fs = fs + "," + ((InfoItemBO)this.baseFields.get(i)).getItemId();
        }
        this.wageset.setBaseinfo(fs);
      }
      else {
        this.wageset.setBaseinfo("");
      }

      if ((this.orgsumFields != null) && (this.orgsumFields.size() > 0)) {
        String fs = ((InfoItemBO)this.orgsumFields.get(0)).getItemId();
        for (int i = 1; i < this.orgsumFields.size(); i++) {
          fs = fs + "," + ((InfoItemBO)this.orgsumFields.get(i)).getItemId();
        }
        this.wageset.setDeptField(fs);
      }
      else {
        this.wageset.setDeptField("");
      }

      String setId = this.wageset.getSetId();
      if ((setId == null) || ("".equals(setId))) {
        if (!this.setMB.equals("")) {
          WageSetBO wt = this.wagesetucc.findSetBySetId(this.setMB);
          this.wageset.setAllField(wt.getAllField());
          this.wageset.setShowField(wt.getShowField());
        }

        this.wagesetucc.createSet(this.wageset);
        setId = this.wageset.getSetId();

        if (!this.setMB.equals("")) {
          this.wagesetitemucc.copyset(setId, this.setMB);
        }
      }
      else
      {
        WageSetItemBO itembo = this.wagesetitemucc.querySetItemBySetIdAndField(this.wageset.getSetId(), "A815714");
        if ((itembo != null) && ("2".equals(itembo.gettype()))) {
          super.showMessageDetail("已存在纳税的录入项目，不可以关联税率表！");
          return "";
        }
        this.wagesetucc.updateSet(this.wageset);
      }
      super.showMessageDetail("保存账套成功");
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "success";
  }

  public void setInitAddset(String s)
  {
    this.initAddset = s;
  }
  public String getInitAddset() {
    if (super.getRequestParameter("unitID") != null) {
      String unitId = super.getRequestParameter("unitID");
      this.wageset.initPara();
      this.wageset.setUnitId(unitId);
      this.baseFields = new ArrayList();
    }
    if (super.getRequestParameter("setID") != null) {
      this.wageset.setSetId(super.getRequestParameter("setID"));
      find();
    }
    return this.initAddset;
  }

  public String deptmovePre() {
    if ((this.deptItem != null) && (!"".equals(this.deptItem)) && (this.orgsumFields != null)) {
      int i = 0;
      for (i = 0; i < this.orgsumFields.size(); i++) {
        InfoItemBO ib = (InfoItemBO)this.orgsumFields.get(i);
        if (this.deptItem.equals(ib.getItemId())) {
          break;
        }
      }
      if ((i < this.orgsumFields.size()) && (i > 0)) {
        InfoItemBO ib = (InfoItemBO)this.orgsumFields.get(i);
        this.orgsumFields.set(i, this.orgsumFields.get(i - 1));
        this.orgsumFields.set(i - 1, ib);
      }
    }
    return "";
  }
  public String deptmoveNext() {
    if ((this.deptItem != null) && (!"".equals(this.deptItem)) && (this.orgsumFields != null)) {
      int i = 0;
      for (i = 0; i < this.orgsumFields.size(); i++) {
        InfoItemBO ib = (InfoItemBO)this.orgsumFields.get(i);
        if (this.deptItem.equals(ib.getItemId())) {
          break;
        }
      }
      if (i < this.baseFields.size() - 1) {
        InfoItemBO ib = (InfoItemBO)this.orgsumFields.get(i + 1);
        this.orgsumFields.set(i + 1, this.orgsumFields.get(i));
        this.orgsumFields.set(i, ib);
      }
    }

    return "";
  }

  public String movePre() {
    if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null)) {
      int i = 0;
      for (i = 0; i < this.baseFields.size(); i++) {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.infoItem.equals(ib.getItemId())) {
          break;
        }
      }
      if ((i < this.baseFields.size()) && (i > 0)) {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        this.baseFields.set(i, this.baseFields.get(i - 1));
        this.baseFields.set(i - 1, ib);
      }
    }
    return "";
  }
  public String moveNext() {
    if ((this.infoItem != null) && (!"".equals(this.infoItem)) && (this.baseFields != null)) {
      int i = 0;
      for (i = 0; i < this.baseFields.size(); i++) {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i);
        if (this.infoItem.equals(ib.getItemId())) {
          break;
        }
      }
      if (i < this.baseFields.size() - 1) {
        InfoItemBO ib = (InfoItemBO)this.baseFields.get(i + 1);
        this.baseFields.set(i + 1, this.baseFields.get(i));
        this.baseFields.set(i, ib);
      }
    }
    return "";
  }

  public String getInitPersonPower() {
    if (super.getRequestParameter("setID") != null) {
      findtoPower(super.getRequestParameter("setID"));
      this.personList = null;
    }
    return this.initPersonPower;
  }

  public void setInitPersonPower(String initPersonPower) {
    this.initPersonPower = initPersonPower;
  }

  public String findtoPower(String setID)
  {
    try
    {
      this.wageset = this.wagesetucc.findSetBySetId(setID);
      this.operPersons = new ArrayList();
      if ((this.wageset.getOperPersons() != null) && (!"".equals(this.wageset.getOperPersons()))) {
        String[] fs = this.wageset.getOperPersons().split(",");
        for (int i = 0; i < fs.length; i++) {
          PersonBO ib = SysCacheTool.findPersonById(fs[i]);
          this.operPersons.add(ib);
        }
      }
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "editPower";
  }
  public String find() {
    try {
      this.wageset = this.wagesetucc.findSetBySetId(this.wageset.getSetId());
      if (this.wageset.getNoUse() == null) {
        this.wageset.setNoUse("0");
      }
      this.baseFields = new ArrayList();
      if ((this.wageset.getBaseinfo() != null) && (!"".equals(this.wageset.getBaseinfo()))) {
        String[] fs = this.wageset.getBaseinfo().split(",");
        for (int i = 0; i < fs.length; i++) {
          InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
          ib.setItemSequence(String.valueOf(i + 1));
          ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, ib.getSetId()));
          this.baseFields.add(ib);
        }
      }
      this.orgsumFields = new ArrayList();
      if ((this.wageset.getDeptField() != null) && (!"".equals(this.wageset.getDeptField()))) {
        String[] fs = this.wageset.getDeptField().split(",");
        for (int i = 0; i < fs.length; i++) {
          InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
          ib.setItemSequence(String.valueOf(i + 1));
          ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, ib.getSetId()));
          this.orgsumFields.add(ib);
        }
      }
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "edit";
  }

  public String list()
  {
    try
    {
      this.setlist = this.wagesetucc.querySetByUnitId(this.wageset.getUnitId());
      this.setlist = CodeUtil.codeInterpret(this.setlist, "flowFlag", "CODE");

      String unitId = this.wageset.getUnitId();
      WageUnitBO paraUnit = SysCacheTool.findWageUnit(unitId);

      User us = super.getUserInfo();
      String persId = us.getUserId();
      PersonBO person = SysCacheTool.findPersonById(persId);
      String userUnitId = person.getGongZiGX();
      WageUnitBO userUnit = SysCacheTool.findWageUnit(userUnitId);

      if ("00901".equals(userUnit.getManageFlag())) {
        if (paraUnit.getTreeId().length() <= userUnit.getTreeId().length() - 3)
          unitId = userUnit.getUnitId();
      }
      else
        unitId = userUnit.getUnitId();
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "list";
  }

  public String delete()
  {
    try
    {
      String[] sel = super.getServletRequest().getParameterValues("selectItem");
      this.wagesetucc.batchDeleteSet(sel);
      super.showMessageDetail("删除账套成功");
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return list();
  }

  public String cancelTry() {
    try {
      this.wagesetucc.modiWageSetStatus(this.setMB, WageSetBO.TRY_STATUS_NO);
      this.wagecomputeucc.dropTryTmpTable(this.setMB);
      this.wagecomputeucc.dropGatherData(this.setMB);
      return list();
    }
    catch (Exception e)
    {
    }
    return "";
  }

  public String beginTry() {
    try {
      this.wagesetucc.modiWageSetStatus(this.setMB, WageSetBO.TRY_STATUS_YES);
      this.wagecomputeucc.createTryTmpTable(this.setMB);
      return list();
    }
    catch (Exception e)
    {
    }
    return "";
  }

  public IWageSetItemUCC getWagesetitemucc() {
    return this.wagesetitemucc;
  }

  public void setWagesetitemucc(IWageSetItemUCC wagesetitemucc) {
    this.wagesetitemucc = wagesetitemucc;
  }

  public boolean isOper063102() {
    this.oper063102 = UserAPI.checkButtonOperate(super.getUserInfo(), "063102");
    return this.oper063102;
  }
  public void setOper063102(boolean oper063102) {
    this.oper063102 = oper063102;
  }

  public boolean isOper063103() {
    this.oper063103 = UserAPI.checkButtonOperate(super.getUserInfo(), "063103");
    return this.oper063103;
  }
  public void setOper063103(boolean oper063103) {
    this.oper063103 = oper063103;
  }

  public boolean isOper063104() {
    this.oper063104 = UserAPI.checkButtonOperate(super.getUserInfo(), "063104");
    return this.oper063104;
  }
  public void setOper063104(boolean oper063104) {
    this.oper063104 = oper063104;
  }

  public boolean isOper063105() {
    this.oper063105 = UserAPI.checkButtonOperate(super.getUserInfo(), "063105");
    return this.oper063105;
  }
  public void setOper063105(boolean oper063105) {
    this.oper063105 = oper063105;
  }

  public boolean isOper063106() {
    this.oper063106 = UserAPI.checkButtonOperate(super.getUserInfo(), "063106");
    return this.oper063106;
  }
  public void setOper063106(boolean oper063106) {
    this.oper063106 = oper063106;
  }

  public boolean isOper063107() {
    this.oper063107 = UserAPI.checkButtonOperate(super.getUserInfo(), "063107");
    return this.oper063107;
  }
  public void setOper063107(boolean oper063107) {
    this.oper063107 = oper063107;
  }

  public boolean isOper063108() {
    this.oper063108 = UserAPI.checkButtonOperate(super.getUserInfo(), "063108");
    return this.oper063108;
  }
  public void setOper063108(boolean oper063108) {
    this.oper063108 = oper063108;
  }

  public boolean isOper063109() {
    this.oper063109 = UserAPI.checkButtonOperate(super.getUserInfo(), "063109");
    return this.oper063109;
  }
  public void setOper063109(boolean oper063109) {
    this.oper063109 = oper063109;
  }

  public boolean isOper063110() {
    this.oper063110 = UserAPI.checkButtonOperate(super.getUserInfo(), "063110");
    return this.oper063110;
  }
  public void setOper063110(boolean oper063110) {
    this.oper063110 = oper063110;
  }

  public boolean isOper063111() {
    this.oper063111 = UserAPI.checkButtonOperate(super.getUserInfo(), "063111");
    return this.oper063111;
  }
  public void setOper063111(boolean oper063111) {
    this.oper063111 = oper063111;
  }

  public boolean isOper063112() {
    this.oper063112 = UserAPI.checkButtonOperate(super.getUserInfo(), "063112");
    return this.oper063112;
  }

  public void setOper063112(boolean oper063112) {
    this.oper063112 = oper063112;
  }

  public boolean isOper063113() {
    this.oper063113 = UserAPI.checkButtonOperate(super.getUserInfo(), "063113");
    return this.oper063113;
  }
  public void setOper063113(boolean oper063113) {
    this.oper063113 = oper063113;
  }
}