package com.hr319wg.wage.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ActionEvent;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.service.Send;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageConstBO;
import com.hr319wg.wage.pojo.bo.WageCostFieldBO;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.pojo.bo.WageFormulaChangeBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.ucc.IWageConstUCC;
import com.hr319wg.wage.ucc.IWageFormulaUCC;
import com.hr319wg.wage.ucc.IWageItemSetUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;
import com.hr319wg.wage.util.WageFormulaTools;

public class WageFormulaBackingBean extends BaseBackingBean
{
  private WageFormulaBO formula = new WageFormulaBO();
  private String unitId;
  private String popEdit;
  private List rsInfoItem;
  private List formulaList;
  private List setList;
  private List constList;
  private String unitName;
  private boolean operRight = false;
  private boolean orderByName;
  private boolean showPublic = false;
  private IWageFormulaUCC wageformulaucc;
  private IWageSetUCC wagesetucc;
  private IWageItemSetUCC wageitemsetucc;
  private IWageConstUCC wageconstucc;
  private List changebos;
  private String costId;

  public List getChangebos()
  {
    try
    {
      if (super.getRequestParameter("FormularID") != null) {
        this.changebos = this.wageformulaucc.getFormularChange(super.getRequestParameter("FormularID"));
      }
      if (super.getRequestParameter("setId") != null) {
        this.changebos = this.wageformulaucc.getSetFormularChange(super.getRequestParameter("setId"));
      }
      for (int i = 0; i < this.changebos.size(); i++) {
        WageFormulaChangeBO wb = (WageFormulaChangeBO)this.changebos.get(i);
        wb.setCreatorName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, wb.getCreator()));
        WageFormulaBO fo = this.wageformulaucc.findFormula(wb.getFormulaId());
        wb.setRsFieldname(CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, fo.getRsField()));
      }
    }
    catch (Exception e)
    {
    }
    return this.changebos;
  }
  public void setChangebos(List bos) {
    this.changebos = bos;
  }

  public boolean getOrderByName() {
    return this.orderByName;
  }
  public void setOrderByName(boolean b) {
    this.orderByName = b;
  }

  public boolean getShowPublic() {
    return this.showPublic;
  }
  public void setShowPublic(boolean b) {
    this.showPublic = b;
  }

  public String getPageInit()
  {
    String act = super.getServletRequest().getParameter("act");
    if ("list".equals(act)) {
      this.unitId = super.getServletRequest().getParameter("unitId");

      WageUnitBO paraUnit = SysCacheTool.findWageUnit(this.unitId);

      String persId = super.getUserInfo().getUserId();
      PersonBO person = SysCacheTool.findPersonById(persId);
      String userUnitId = person.getGongZiGX();
      WageUnitBO userUnit = SysCacheTool.findWageUnit(userUnitId);
      if (userUnit == null) {
        super.showMessageDetail("错误：用户没有发薪单位");
        return "";
      }

      if ("00901".equals(userUnit.getManageFlag())) {
        if (paraUnit.getTreeId().length() <= userUnit.getTreeId().length() - 3)
          this.unitId = userUnit.getUnitId();
      }
      else {
        this.unitId = userUnit.getUnitId();
      }
      this.operRight = this.unitId.equals(userUnit.getUnitId());

      if (this.formula == null) this.formula = new WageFormulaBO();
      this.formula.setUnitId(this.unitId);
      list();
    }
    this.unitName = CodeUtil.interpertCode("OU", this.formula.getUnitId());

    return this.pageInit;
  }
  public WageFormulaBO getFormula() {
    return this.formula;
  }

  public boolean isOperRight() {
    return this.operRight;
  }
  public void setOperRight(boolean operRight) {
    this.operRight = operRight;
  }

  public void setFormula(WageFormulaBO formula) {
    this.formula = formula;
  }

  public List getRsInfoItem() {
    return this.rsInfoItem;
  }
  public void setRsInfoItem(List rsInfoItem) {
    this.rsInfoItem = rsInfoItem;
  }

  public String getPopEdit() {
    try {
      if (super.getRequestParameter("formulaID") != null) {
        this.popEdit = "1";
        String id = super.getRequestParameter("formulaID");
        this.unitId = super.getRequestParameter("unitId");
        this.formula = this.wageformulaucc.findFormula(id);
        if ("USASCII7".equals(Constants.DB_CHAR_SET)) {
          try {
            if ((this.formula.getExpress() != null) && (!"".equals(this.formula.getExpress()))) {
              this.formula.setExpress(new String(this.formula.getExpress().getBytes("iso-8859-1"), "GBK"));
            }
            if ((this.formula.getChnDesc() != null) && (!"".equals(this.formula.getChnDesc()))) {
              this.formula.setChnDesc(new String(this.formula.getChnDesc().getBytes("iso-8859-1"), "GBK"));
            }
            if ((this.formula.getHtmlDesc() != null) && (!"".equals(this.formula.getHtmlDesc()))) {
              this.formula.setHtmlDesc(new String(this.formula.getHtmlDesc().getBytes("iso-8859-1"), "GBK"));
            }
          }
          catch (Exception e)
          {
            throw new SysException("字符集变换失败");
          }
        }

        WageCostFieldBO field = this.wageitemsetucc.findWageItemSet(this.formula.getRsField(), "3");
        this.costId = field.getCostType();
        rsInfoItemByCost(field.getCostType());
      }
    }
    catch (Exception e)
    {
    }
    return this.popEdit;
  }
  public void setPopEdit(String edit) {
    this.popEdit = edit;
  }

  public String getUnitName() {
    return this.unitName;
  }
  public void setUnitName(String unitName) {
    this.unitName = unitName;
  }

  public List getFormulaList() {
    return this.formulaList;
  }
  public void setFormulaList(List formulaList) {
    this.formulaList = formulaList;
  }

  public IWageFormulaUCC getWageformulaucc() {
    return this.wageformulaucc;
  }
  public void setWageformulaucc(IWageFormulaUCC wageformulaucc) {
    this.wageformulaucc = wageformulaucc;
  }

  public IWageItemSetUCC getWageitemsetucc() {
    return this.wageitemsetucc;
  }
  public void setWageitemsetucc(IWageItemSetUCC wageitemsetucc) {
    this.wageitemsetucc = wageitemsetucc;
  }

  public String list()
  {
    try
    {
      String unitId = this.formula.getUnitId();
      User user = super.getUserInfo();
      if ((user.ischo()) && (User.AllUNIT.equals(user.getprocessUnit()))) {
        this.formulaList = this.wageformulaucc.queryFormulaByUnitId(unitId, this.orderByName);
      }
      else if (this.showPublic) {
        this.formulaList = this.wageformulaucc.queryFormulaByUnitIdAndPublic(unitId, this.orderByName);
      }
      else {
        this.formulaList = this.wageformulaucc.queryFormulaByUnitId(unitId, this.orderByName);
      }

      if (this.formulaList != null)
        for (int i = 0; i < this.formulaList.size(); i++) {
          WageFormulaBO fla = (WageFormulaBO)this.formulaList.get(i);

          if (WageFormulaBO.PRIVATE.equals(fla.getUsualFlag())) {
            if (fla.getSetId() != null) {
              WageSetBO set = this.wagesetucc.findSetBySetId(fla.getSetId());
              fla.setSetId(set.getName());
            }
            fla.setUsualFlag("否");
          }
          else {
            fla.setUsualFlag("是");
          }
          if (fla.getName().startsWith("副本")) {
            fla.setName("<font color=red>" + fla.getName() + "</font>");
          }

          InfoItemBO ib = SysCacheTool.findInfoItem("", fla.getRsField());
          fla.setRsField(ib.getItemNameEx());

          fla.setUnitName(SysCacheTool.findOrgById(fla.getUnitId()).getName());

          if ((user.ischo()) && (User.AllUNIT.equals(user.getprocessUnit()))) {
            fla.setCanModify(true);
          }
          else if (fla.getUnitId().equals(this.unitId)) {
            fla.setCanModify(true);
          }
          else {
            fla.setCanModify(false);
          }

          this.formulaList.set(i, fla);
        }
    }
    catch (Exception e)
    {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "list";
  }

  public String create()
  {
    this.costId = "";
    String unitId = this.formula.getUnitId();
    this.formula = new WageFormulaBO();
    this.formula.setUnitId(unitId);
    this.rsInfoItem = new ArrayList();
    this.rsInfoItem.add(0, new SelectItem("", "---请选择---"));
    return "edit";
  }

  public String find()
  {
    try
    {
      this.formula = this.wageformulaucc.findFormula(this.formula.getFormulaId());
      if ("USASCII7".equals(Constants.DB_CHAR_SET)) {
        try {
          if ((this.formula.getExpress() != null) && (!"".equals(this.formula.getExpress()))) {
            this.formula.setExpress(new String(this.formula.getExpress().getBytes("iso-8859-1"), "GBK"));
          }
          if ((this.formula.getChnDesc() != null) && (!"".equals(this.formula.getChnDesc()))) {
            this.formula.setChnDesc(new String(this.formula.getChnDesc().getBytes("iso-8859-1"), "GBK"));
          }
          if ((this.formula.getHtmlDesc() != null) && (!"".equals(this.formula.getHtmlDesc()))) {
            this.formula.setHtmlDesc(new String(this.formula.getHtmlDesc().getBytes("iso-8859-1"), "GBK"));
          }
        }
        catch (Exception e)
        {
          throw new SysException("字符集变换失败");
        }
      }

      WageCostFieldBO field = this.wageitemsetucc.findWageItemSet(this.formula.getRsField(), "3");
      this.costId = field.getCostType();
      rsInfoItemByCost(field.getCostType());
    }
    catch (Exception e) {
    }
    return "edit";
  }

  public String view()
  {
    try
    {
      this.formula = this.wageformulaucc.findFormula(this.formula.getFormulaId());
    }
    catch (Exception e) {
    }
    return "view";
  }
  public String send() {
    try {
      String[] id = super.getServletRequest().getParameterValues("selectItem");
      if ((id == null) || (id.length == 0)) return "";
      List sendList = new ArrayList();
      for (int i = 0; i < id.length; i++) {
        for (int j = 0; j < this.formulaList.size(); j++) {
          WageFormulaBO formula = (WageFormulaBO)this.formulaList.get(j);
          if (formula.getFormulaId().equals(id[i])) {
            sendList.add(formula);
          }
        }
      }
      Send.SendWageFormulaBO("c:\\a.xml", sendList);
      super.showMessageDetail("发送公式成功");
    } catch (Exception e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "";
  }

  public String delete()
  {
    try
    {
      String[] id = super.getServletRequest().getParameterValues("selectItem");
      if ((id == null) || (id.length == 0)) return "";
      for (int i = 0; i < id.length; i++) {
        if (this.wageformulaucc.checkUsing(id[i])) {
          for (int j = 0; j < this.formulaList.size(); j++) {
            WageFormulaBO formula = (WageFormulaBO)this.formulaList.get(j);
            if (formula.getFormulaId().equals(id[i])) {
              super.showMessageDetail(formula.getName() + "正在使用，不允许删除！");
              return "";
            }
          }
        }
      }
      this.wageformulaucc.batchDeleteFormula(super.getUserInfo(), id);
      super.showMessageDetail("删除公式成功");
    }
    catch (Exception e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return list();
  }

  public String copy()
  {
    try {
      String[] id = super.getServletRequest().getParameterValues("selectItem");
      if ((id == null) || (id.length == 0)) return "";
      for (int i = 0; i < id.length; i++) {
        WageFormulaBO bo = this.wageformulaucc.findFormula(id[i]);
        WageFormulaBO newbo = new WageFormulaBO();
        newbo.setFormulaId("");
        newbo.setName("副本" + bo.getName());
        newbo.setUnitId(this.unitId);
        newbo.setCreator(super.getUserInfo().getUserId());
        newbo.setChnDesc(bo.getChnDesc());
        newbo.setCreateDate(bo.getCreateDate());
        newbo.setDesc(bo.getDesc());
        newbo.setExpress(bo.getExpress());
        newbo.setHtmlDesc(bo.getHtmlDesc());
        newbo.setRsField(bo.getRsField());
        newbo.setRsTable(bo.getRsTable());
        newbo.setSetId(bo.getSetId());
        newbo.setshowque(bo.getshowque());
        newbo.setUsualFlag(bo.getUsualFlag());
        this.wageformulaucc.createFormula(newbo);
      }
      super.showMessageDetail("另存公式成功");
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getSysMsg().getMessage());
    }
    catch (Exception e)
    {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return list();
  }

  public String save()
  {
    try
    {
      if (this.formula.getRsField().equals("A815714")) {
        super.showMessageDetail("计税请采用税率表!");
        return "";
      }
      this.formula.setName(this.formula.getName().trim());

      this.formula.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      this.formula.setCreator(super.getUserInfo().getUserId());
      this.formula.setRsTable(this.formula.getRsField().substring(0, 4));
      WageFormulaTools formulaCommonFuns = new WageFormulaTools();
      this.formula.setExpress(this.formula.getExpress().trim());

      String checkExp = this.formula.getExpress().replaceAll("PREV", "");
      formulaCommonFuns.checkFormula(checkExp, this.formula.getRsTable() + "." + this.formula.getRsField());

      WageFormulaBO fa = new WageFormulaBO();
      CommonFuns.copyProperties(fa, this.formula);
      if ("USASCII7".equals(Constants.DB_CHAR_SET)) {
        try {
          if ((fa.getExpress() != null) && (!"".equals(fa.getExpress()))) {
            fa.setExpress(new String(fa.getExpress().getBytes("GBK"), "iso-8859-1"));
          }
          if ((fa.getChnDesc() != null) && (!"".equals(fa.getChnDesc()))) {
            fa.setChnDesc(new String(fa.getChnDesc().getBytes("GBK"), "iso-8859-1"));
          }
          if ((fa.getHtmlDesc() != null) && (!"".equals(fa.getHtmlDesc())))
            fa.setHtmlDesc(new String(fa.getHtmlDesc().getBytes("GBK"), "iso-8859-1"));
        }
        catch (Exception e)
        {
          throw new SysException("字符集变换失败");
        }
      }

      if ((fa.getFormulaId() == null) || ("".equals(fa.getFormulaId()))) {
        this.wageformulaucc.createFormula(fa);
        super.showMessageDetail("新建公式成功");
      } else {
        this.wageformulaucc.updateFormula(fa);
        super.showMessageDetail("保存公式成功");
      }
      if (!"1".equals(this.popEdit)) return list();
      return "success";
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }return "";
  }

  public void changeCost(ActionEvent event)
  {
    rsInfoItemByCost(this.costId);
  }

  private void rsInfoItemByCost(String cost) {
    SelectItem first = new SelectItem();
    first.setValue("");
    first.setLabel("----请选择----");
    this.rsInfoItem = new ArrayList();
    try {
      String[] rs = this.wageitemsetucc.queryWageItemByCost(cost);
      if ((rs != null) && (rs.length > 0)) {
        int count = rs.length;
        for (int i = 0; i < count; i++) {
          InfoItemBO bo = SysCacheTool.findInfoItem("", rs[i]);
          if (bo != null) {
            SelectItem sitem = new SelectItem();
            sitem.setValue(bo.getItemId());
            sitem.setLabel(bo.getItemName());
            this.rsInfoItem.add(sitem);
          }
        }
      }
      this.rsInfoItem.add(0, first);
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
  }

  public String getCostId() {
    return this.costId;
  }
  public void setCostId(String costId) {
    this.costId = costId;
  }

  public List getSetList() {
    try {
      List list = this.wagesetucc.querySetByUnitId(this.unitId);
      this.setList = new ArrayList();
      this.setList.add(new SelectItem("", "---请选择---"));
      if (list != null)
        for (int i = 0; i < list.size(); i++) {
          WageSetBO set = (WageSetBO)list.get(i);
          this.setList.add(new SelectItem(set.getSetId(), CommonFuns.filterNull(set.getName())));
        }
    }
    catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return this.setList;
  }
  public void setSetList(List setList) {
    this.setList = setList;
  }

  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }
  public void setWagesetucc(IWageSetUCC wagesetucc) {
    this.wagesetucc = wagesetucc;
  }

  public IWageConstUCC getWageconstucc() {
    return this.wageconstucc;
  }
  public void setWageconstucc(IWageConstUCC ucc) {
    this.wageconstucc = ucc;
  }

  public String getUnitId() {
    return this.unitId;
  }
  public void setUnitId(String unitId) {
    this.unitId = unitId;
  }

  public List getConstList() {
    try {
      List li = null;
      if (this.formula.getUsualFlag().equals("1")) {
        li = this.wageconstucc.queryAll("PUBLIC");
      }
      else {
        li = this.wageconstucc.queryAll(this.formula.getSetId());
      }
      this.constList = new ArrayList();
      for (int i = 0; i < li.size(); i++) {
        WageConstBO wb = (WageConstBO)li.get(i);
        SelectItem si = new SelectItem();
        si.setLabel(wb.getConstName());
        si.setValue(wb.getConstID());
        this.constList.add(si);
      }
    }
    catch (Exception e) {
      this.constList = new ArrayList();
    }
    return this.constList;
  }
  public void setConstList(List li) {
    this.constList = li;
  }

  public void outputByName(ValueChangeEvent e) {
    try {
      if (e.getNewValue().toString().equals("true")) {
        this.orderByName = true;
      }
      else {
        this.orderByName = false;
      }
      list();
    }
    catch (Exception ee) {
    }
  }

  public void changePublic(ValueChangeEvent e) {
    try {
      if (e.getNewValue().toString().equals("true")) {
        this.showPublic = true;
      }
      else {
        this.showPublic = false;
      }
      list();
    }
    catch (Exception ee)
    {
    }
  }
}