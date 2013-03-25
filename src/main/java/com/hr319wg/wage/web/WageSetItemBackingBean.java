package com.hr319wg.wage.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ActionEvent;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageCostFieldBO;
import com.hr319wg.wage.pojo.bo.WageDateBO;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageSetItemChangeBO;
import com.hr319wg.wage.pojo.bo.WageStandardBO;
import com.hr319wg.wage.pojo.bo.WageStdItemBO;
import com.hr319wg.wage.ucc.IWageDateUCC;
import com.hr319wg.wage.ucc.IWageFormulaUCC;
import com.hr319wg.wage.ucc.IWageItemSetUCC;
import com.hr319wg.wage.ucc.IWageSetItemUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;
import com.hr319wg.wage.ucc.IWageStandardUCC;

public class WageSetItemBackingBean extends BaseBackingBean
{
  private WageSetItemBO item = new WageSetItemBO();
  private IWageSetItemUCC wagesetitemucc;
  private IWageFormulaUCC wageformulaucc;
  private IWageStandardUCC wagestandarducc;
  private IWageItemSetUCC wageitemsetucc;
  private IWageDateUCC wagedateucc;
  private IWageSetUCC wagesetucc;
  private List itemList;
  private List rsInfoItemList;
  private List formulaList;
  private List showList;
  private List standardList;
  private String setName;
  private String unitId;
  private String initView;
  private String[] countSeq;
  private String[] showSeq;
  private List changebos;
  private boolean operRight = true;
  private boolean flowFlag = true;
  private boolean orderByName;
  private String setId;
  private String itemID;
  private List itemtypeList;
  private boolean canAdjustSeq;

  public String getItemID()
  {
    return this.itemID;
  }
  public void setItemID(String id) {
    this.itemID = id;
  }

  public String beginClear() {
    try {
      WageSetItemBO wb = this.wagesetitemucc.findItem(this.itemID);
      wb.setCanClear("1");
      this.wagesetitemucc.updateItem(wb);
      list();
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public String endClear() {
    try {
      WageSetItemBO wb = this.wagesetitemucc.findItem(this.itemID);
      wb.setCanClear("0");
      this.wagesetitemucc.updateItem(wb);
      list();
    }
    catch (Exception e)
    {
    }
    return "";
  }

  public String getSetId() {
    return this.setId;
  }
  public void setSetId(String id) {
    this.setId = id;
  }

  public void setOrderByName(boolean Order) {
    this.orderByName = Order;
  }
  public boolean getOrderByName() {
    return this.orderByName;
  }

  public List getChangebos() {
    try {
      if (super.getRequestParameter("setId") != null) {
        this.setId = super.getRequestParameter("setId");
      }
      this.changebos = this.wagesetitemucc.getChangeInfo(this.setId);
      for (int i = 0; i < this.changebos.size(); i++) {
        WageSetItemChangeBO bo = (WageSetItemChangeBO)this.changebos.get(i);
        bo.setOperateName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, bo.getOperateID()));
        bo.setFieldName(CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, bo.getField()));
      }
    }
    catch (Exception e)
    {
    }
    return this.changebos;
  }
  public void setChangebos(List list) {
    this.changebos = list;
  }
  public String getInitView() {
    try {
      String setID = super.getRequestParameter("setId");
      if ((setID != null) && (!"".equals(setID))) {
        this.item.setSetId(setID);
        this.setName = this.wagesetucc.findSetBySetId(setID).getName();
        list();
      }
    }
    catch (Exception e)
    {
    }
    return this.initView;
  }
  public void setInitView(String str) {
    this.initView = str;
  }
  public String getPageInit() {
    if (!"isPostback".equals(this.pageInit)) {
      this.orderByName = true;
      boolean flag = true;
      try {
        List list = this.wagedateucc.queryDateBySetIdStatus(this.item.getSetId(), "");
        WageDateBO date = new WageDateBO();
        if (list != null) {
          for (int i = 0; i < list.size(); i++) {
            date = (WageDateBO)list.get(i);
            if ((!date.getStatus().equals("1")) && (!date.getStatus().equals("2")) && (!date.getStatus().equals("3")))
              continue;
            this.operRight = false;
            flag = false;
            break;
          }
        }

        if (flag)
          this.operRight = true;
        this.pageInit = "isPostback";
      }
      catch (SysException e) {
      }
    }
    return this.pageInit;
  }

  private void editPageList() {
    SelectItem first = new SelectItem();
    first.setValue("");
    first.setLabel("----请选择----");
    int count = 0;
    try
    {
      List tempList = this.wageformulaucc.queryFormulaByUnitIdSetId(this.unitId, this.item.getSetId(), this.orderByName);
      this.formulaList = new ArrayList();
      this.formulaList.add(first);
      if (tempList != null)
        for (int i = 0; i < tempList.size(); i++) {
          WageFormulaBO fitem = (WageFormulaBO)tempList.get(i);
          SelectItem sitem = new SelectItem();
          sitem.setValue(fitem.getFormulaId() + "," + fitem.getRsField());
          String fName = "";
          if (WageFormulaBO.PUBLIC.equals(fitem.getUsualFlag())) {
            fName = "通用公式-" + fitem.getName();
          }
          else {
            fName = "私有公式-" + fitem.getName();
          }
          sitem.setLabel(fName);
          this.formulaList.add(sitem);
        }
      else {
        this.formulaList = new ArrayList();
      }

      this.standardList = new ArrayList();
      List issueStd = this.wagestandarducc.queryIssueStandard();
      if (issueStd != null) {
        count = issueStd.size();
        for (int i = 0; i < count; i++) {
          WageStandardBO item = (WageStandardBO)issueStd.get(i);
          WageStdItemBO rsItem = (WageStdItemBO)this.wagestandarducc.queryStdItemByType(item.getStdId(), "2").get(0);
          SelectItem sitem = new SelectItem();
          sitem.setValue(item.getStdId() + "," + rsItem.getField());
          sitem.setLabel(item.getName());
          this.standardList.add(sitem);
        }
      }
      List unitStd = this.wagestandarducc.queryStandardByUnitId(this.unitId);
      if (unitStd != null) {
        count = unitStd.size();
        for (int i = 0; i < count; i++) {
          WageStandardBO item = (WageStandardBO)unitStd.get(i);
          if ("00900".equals(item.getPublicFlag())) {
            WageStdItemBO rsItem = (WageStdItemBO)this.wagestandarducc.queryStdItemByType(item.getStdId(), "2").get(0);
            SelectItem sitem = new SelectItem();
            sitem.setValue(item.getStdId() + "," + rsItem.getField());
            sitem.setLabel(item.getName());
            this.standardList.add(sitem);
          }
        }
      }
      this.standardList.add(0, first);

      this.rsInfoItemList = new ArrayList();
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
  }

  public void changeCost(ActionEvent event) {
    String cost = this.item.getCost();
    SelectItem first = new SelectItem();
    first.setValue("");
    first.setLabel("----请选择----");

    this.rsInfoItemList = new ArrayList();
    try {
      String[] rs = this.wageitemsetucc.queryWageItemByCost(cost, this.orderByName);
      if ((rs != null) && (rs.length > 0)) {
        int count = rs.length;
        for (int i = 0; i < count; i++) {
          InfoItemBO bo = SysCacheTool.findInfoItem("", rs[i]);
          if (bo != null) {
            SelectItem sitem = new SelectItem();
            sitem.setValue(bo.getItemId());
            sitem.setLabel(bo.getItemName());
            this.rsInfoItemList.add(sitem);
          }
        }
      }
      this.rsInfoItemList.add(0, first);
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
  }

  public String list()
  {
    try
    {
      boolean addTaxfield = false;
      boolean addYearTaxfield = false;
      WageSetBO set = this.wagesetucc.findSetBySetId(this.item.getSetId());
      this.flowFlag = "00901".equals(set.getFlowFlag());

      this.itemList = this.wagesetitemucc.queryItemBySetId(this.item.getSetId());
      if (this.itemList != null) {
        for (int i = 0; i < this.itemList.size(); i++) {
          WageSetItemBO setitem = (WageSetItemBO)this.itemList.get(i);
          if (("A815713".equals(setitem.getField())) || ("A815711".equals(setitem.getField()))) {
            addTaxfield = true;
          }
          if ("A815755".equals(setitem.getField())) {
            addYearTaxfield = true;
          }
          setitem.setCost(SysCacheTool.interpertCode("", setitem.getCost()));
          InfoItemBO ib = SysCacheTool.findInfoItem("", setitem.getField());
          if (ib != null) {
            setitem.setFieldName(ib.getItemNameEx());
          }

          if ("1".equals(setitem.gettype())) {
            WageFormulaBO fla = this.wageformulaucc.findFormula(setitem.getLinkId());
            if ((fla != null) && (fla.getUnitId().equals(this.unitId))) {
              setitem.setCanModify(true);
            }
            else {
              setitem.setCanModify(false);
            }
          }
          this.itemList.set(i, setitem);
        }
        if (addTaxfield) {
          WageSetItemBO setitem = new WageSetItemBO();
          InfoItemBO ib = SysCacheTool.findInfoItem("", "A815714");
          setitem.setItemId("A815714");
          setitem.setField(ib.getItemId());
          setitem.setFieldName(ib.getItemNameEx());
          setitem.settype("3");
          setitem.settypeEx("扣税项目");
          this.itemList.add(setitem);
        }
        if (addYearTaxfield) {
          WageSetItemBO setitem = new WageSetItemBO();
          InfoItemBO ib = SysCacheTool.findInfoItem("", "A815756");
          setitem.setItemId("A815756");
          setitem.setField(ib.getItemId());
          setitem.setFieldName(ib.getItemNameEx());
          setitem.settype("3");
          setitem.settypeEx("扣税项目");
          this.itemList.add(setitem);
        }
      }
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "itemList";
  }

  public String create()
  {
    String setId = this.item.getSetId();
    this.item = new WageSetItemBO();
    this.item.setSetId(setId);
    editPageList();
    return "edit";
  }

  public String save()
  {
    try
    {
      this.item.setItemId("");
      if ("1".equals(this.item.gettype()))
        this.item.setLinkId(this.item.getFormulaId());
      else if ("0".equals(this.item.gettype())) {
        this.item.setLinkId(this.item.getStdId());
      }
      String str = this.item.getLinkId();
      if (str != null) {
        String[] array = str.split(",");
        if ((array != null) && (array.length == 2)) {
          this.item.setLinkId(array[0]);
          this.item.setField(array[1]);
        }
        WageCostFieldBO bo = this.wageitemsetucc.findWageItemSet(this.item.getField(), "3");
        if (bo != null) {
          this.item.setCost(bo.getCostType());
        }
      }
      this.wagesetitemucc.createItem(this.item);

      WageSetItemChangeBO bo = new WageSetItemChangeBO();
      bo.setAction(WageSetItemChangeBO.ACTION_ADD);
      bo.setField(this.item.getField());
      bo.setOperateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      bo.setOperateID(super.getUserInfo().getUserId());
      bo.setPopup("0");
      bo.setSetId(this.item.getSetId());
      this.wagesetitemucc.saveItemChange(bo);

      String setId = this.item.getSetId();
      this.item = new WageSetItemBO();
      this.item.setSetId(setId);
      
      super.showMessageDetail("添加薪资项成功");
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "edit";
  }

  public String delete()
  {
    try
    {
      String[] sel = super.getServletRequest().getParameterValues("selectItem");
      this.wagesetitemucc.batchDeleteItem(this.item.getSetId(), sel, super.getUserInfo());
      super.showMessageDetail("删除薪资项成功");
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return list();
  }

  //展示显示顺序
  public String listShowItem()
  {
    try
    {
      List list = this.wagesetitemucc.queryItemBySetId(this.item.getSetId());
      this.showList = new ArrayList();
      for (int i = 0; i < list.size(); i++) {
        WageSetItemBO setitem = (WageSetItemBO)list.get(i);
        SelectItem sitem = new SelectItem();
        InfoItemBO ib = SysCacheTool.findInfoItem("", setitem.getField());
        sitem.setLabel(ib.getItemName());
        sitem.setValue(setitem.getItemId());
        this.showList.add(sitem);
      }
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "itemSeqEdit";
  }
  //设置显示循序
  public String saveShowItemSequence() {
    try {
      if ((this.showSeq != null) && (this.showSeq.length > 0)) {
        this.wagesetitemucc.updateItemShowSequence(this.item.getSetId(), this.showSeq);
        this.wagesetitemucc.updateFormulaItemCountSequence(this.item.getSetId(), this.showSeq);
        WageSetBO setBO= this.wagesetucc.findSetBySetId(this.item.getSetId());
        if(setBO!=null){
        	String field=setBO.getShowField();
        	if(field==null || "".equals(field)){
        		setBO.setShowField(setBO.getAllField());
        		this.wagesetucc.updateSet(setBO);
        	}
        }
        super.showMessageDetail("设置显示顺序成功");
      }
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return listShowItem();
  }
  
  //展示计算顺序
  public String listFormulaItem() {
    try {
      this.formulaList = this.wagesetitemucc.queryFormulaItemBySetId(this.item.getSetId());
      if (this.formulaList == null) this.formulaList = new ArrayList();
      int count = this.formulaList.size();
      for (int i = 0; i < count; i++) {
        WageSetItemBO itemBO = (WageSetItemBO)this.formulaList.get(i);
        SelectItem sitem = new SelectItem();
        sitem.setLabel(SysCacheTool.interpertCode("INFOITEM", itemBO.getField()));
        sitem.setValue(itemBO.getItemId());
        this.formulaList.set(i, sitem);
      }
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "formulaSeqEdit";
  }

  //保存计算顺序
  public String saveFormulaItemSequence()
  {
    try
    {
      if ((this.countSeq != null) && (this.countSeq.length > 0)) {
        this.wagesetitemucc.updateFormulaItemCountSequence(this.item.getSetId(), this.countSeq);
        super.showMessageDetail("设置公式项计算顺序成功");
      }
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return listFormulaItem();
  }

  public WageSetItemBO getItem() {
    return this.item;
  }
  public void setItem(WageSetItemBO item) {
    this.item = item;
  }

  public List getItemtypeList() {
    if (this.itemtypeList == null) {
      this.itemtypeList = new ArrayList();
      SelectItem si = new SelectItem();
      si.setLabel("----请选择----");
      si.setValue("");
      this.itemtypeList.add(si);

      si = new SelectItem();
      si.setLabel("录入项目");
      si.setValue("2");
      this.itemtypeList.add(si);

      if (!"1".equals(Constants.WAGE_ONLY_INPUT_ITEM)) {
        si = new SelectItem();
        si.setLabel("计算项目");
        si.setValue("1");
        this.itemtypeList.add(si);

        si = new SelectItem();
        si.setLabel("查表项目");
        si.setValue("0");
        this.itemtypeList.add(si);
      }
    }
    return this.itemtypeList;
  }
  public void setItemtypeList(List itemtypeList) {
    this.itemtypeList = itemtypeList;
  }

  public IWageSetItemUCC getWagesetitemucc()
  {
    return this.wagesetitemucc;
  }
  public void setWagesetitemucc(IWageSetItemUCC wagesetitemucc) {
    this.wagesetitemucc = wagesetitemucc;
  }

  public List getItemList() {
    return this.itemList;
  }
  public void setItemList(List itemList) {
    this.itemList = itemList;
  }

  public String getSetName()
  {
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

  public List getRsInfoItemList() {
    return this.rsInfoItemList;
  }
  public void setRsInfoItemList(List rsInfoItemList) {
    this.rsInfoItemList = rsInfoItemList;
  }

  public List getShowList() {
    return this.showList;
  }
  public void setShowList(List formulaList) {
    this.showList = formulaList;
  }

  public List getFormulaList() {
    return this.formulaList;
  }
  public void setFormulaList(List formulaList) {
    this.formulaList = formulaList;
  }

  public List getStandardList() {
    return this.standardList;
  }
  public void setStandardList(List standardList) {
    this.standardList = standardList;
  }

  public IWageFormulaUCC getWageformulaucc() {
    return this.wageformulaucc;
  }
  public void setWageformulaucc(IWageFormulaUCC wageformulaucc) {
    this.wageformulaucc = wageformulaucc;
  }

  public IWageStandardUCC getWagestandarducc() {
    return this.wagestandarducc;
  }
  public void setWagestandarducc(IWageStandardUCC wagestandarducc) {
    this.wagestandarducc = wagestandarducc;
  }

  public String[] getShowSeq() {
    return this.showSeq;
  }
  public void setShowSeq(String[] countSeq) {
    this.showSeq = countSeq;
  }

  public String[] getCountSeq() {
    return this.countSeq;
  }
  public void setCountSeq(String[] countSeq) {
    this.countSeq = countSeq;
  }

  public boolean isOperRight() {
    return this.operRight;
  }
  public void setOperRight(boolean operRight) {
    this.operRight = operRight;
  }

  public IWageItemSetUCC getWageitemsetucc() {
    return this.wageitemsetucc;
  }
  public void setWageitemsetucc(IWageItemSetUCC wageitemsetucc) {
    this.wageitemsetucc = wageitemsetucc;
  }

  public IWageDateUCC getWagedateucc() {
    return this.wagedateucc;
  }
  public void setWagedateucc(IWageDateUCC wagedateucc) {
    this.wagedateucc = wagedateucc;
  }

  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }
  public void setWagesetucc(IWageSetUCC wagesetucc) {
    this.wagesetucc = wagesetucc;
  }

  public boolean isFlowFlag() {
    return this.flowFlag;
  }
  public void setFlowFlag(boolean flowFlag) {
    this.flowFlag = flowFlag;
  }

  public void viewsetitem(ValueChangeEvent event) {
    try {
      if (event.getNewValue().toString().equals("true")) {
        this.itemList = this.wagesetitemucc.queryItemBySetIdOrderByName(this.item.getSetId());
      }
      else {
        this.itemList = this.wagesetitemucc.queryItemBySetId(this.item.getSetId());
      }
      if (this.itemList != null) {
        int count = this.itemList.size();
        for (int i = 0; i < count; i++) {
          WageSetItemBO setitem = (WageSetItemBO)this.itemList.get(i);
          setitem.setCost(SysCacheTool.interpertCode("", setitem.getCost()));
          InfoItemBO ib = SysCacheTool.findInfoItem("", setitem.getField());
          if (ib != null) {
            setitem.setFieldName(ib.getItemNameEx());
          }

          if ("1".equals(setitem.gettype())) {
            WageFormulaBO fla = this.wageformulaucc.findFormula(setitem.getLinkId());
            if (fla != null)
              if (fla.getUnitId().equals(this.unitId)) {
                setitem.setCanModify(true);
              }
              else
                setitem.setCanModify(false);
          }
        }
      }
    }
    catch (SysException e)
    {
      super.showMessageDetail("错误:" + e.getMessage());
    }
  }

  public void outputByName(ValueChangeEvent event) {
    try {
      if (event.getNewValue().toString().equals("true")) {
        this.orderByName = true;
      }
      else {
        this.orderByName = false;
      }
      editPageList();

      changeCost(null);
    }
    catch (Exception e)
    {
    }
  }

  public boolean isCanAdjustSeq() {
    this.canAdjustSeq = ((this.operRight) && (!"1".equals(Constants.WAGE_ONLY_INPUT_ITEM)));
    return this.canAdjustSeq;
  }
  public void setCanAdjustSeq(boolean canAdjustSeq) {
    this.canAdjustSeq = canAdjustSeq;
  }
}