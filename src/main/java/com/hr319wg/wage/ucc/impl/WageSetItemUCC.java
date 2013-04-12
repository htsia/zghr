package com.hr319wg.wage.ucc.impl;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageSetItemChangeBO;
import com.hr319wg.wage.service.WageComputeService;
import com.hr319wg.wage.service.WageSetItemService;
import com.hr319wg.wage.service.WageSetPersonService;
import com.hr319wg.wage.service.WageSetService;
import com.hr319wg.wage.ucc.IWageSetItemUCC;

public class WageSetItemUCC
  implements IWageSetItemUCC
{
  private WageSetItemService wagesetitemservice;
  private WageSetService wagesetservice;
  private WageSetPersonService wagesetpersonservice;
  private WageComputeService wagecomputeservice;

  public WageSetItemService getWagesetitemservice()
  {
    return this.wagesetitemservice;
  }
  public void setWagesetitemservice(WageSetItemService wagesetitemservice) {
    this.wagesetitemservice = wagesetitemservice;
  }

  public WageSetService getWagesetservice() {
    return this.wagesetservice;
  }
  public void setWagesetservice(WageSetService wagesetservice) {
    this.wagesetservice = wagesetservice;
  }

  public void createItem(WageSetItemBO item)
    throws SysException
  {
    WageSetBO set = this.wagesetservice.findSetBySetId(item.getSetId());
    String allItem = set.getAllField();
    if (("A815714".equals(item.getField())) && (set.getCessID() != null) && (!"".equals(set.getCessID()))) {
      throw new SysException("关联税率时不可以再增加为录入项目!");
    }
    if ((allItem != null) && (allItem.trim().length() > 0) && !"0".equals(item.gettype())) {
      if (allItem.indexOf(item.getField()) > -1) {
        throw new SysException("薪资项添加重复");
      }
      allItem = allItem + item.getField() + ",";
    }
    else {
      allItem = item.getField() + ",";
    }
    set.setAllField(allItem);
    this.wagesetitemservice.createItem(item);
    this.wagesetservice.updateSet(set);
    if ((item.gettype().equals("2")) && (!"".equals(item.getDefaultValue()))) {
      this.wagesetpersonservice.updateInputItemValue(item.getSetId(), item.getField(), item.getDefaultValue());
      this.wagecomputeservice.updateInputItemValue(item.getSetId(), item.getField(), item.getDefaultValue());
    }
  }

  public void saveItemChange(WageSetItemChangeBO item) throws SysException {
    this.wagesetitemservice.saveItemChange(item);
  }
  public void createCopyedItem(WageSetItemBO item) throws SysException {
    this.wagesetitemservice.createItem(item);
    if ((item.gettype().equals("2")) && (!"".equals(item.getDefaultValue()))) {
      this.wagesetpersonservice.updateInputItemValue(item.getSetId(), item.getField(), item.getDefaultValue());
      this.wagecomputeservice.updateInputItemValue(item.getSetId(), item.getField(), item.getDefaultValue());
    }
  }

  public List getChangeInfo(String setId) throws SysException {
    return this.wagesetitemservice.getChangeInfo(setId);
  }
  public int getSetitemNewChange(String setid) throws SysException {
    return this.wagesetservice.getSetitemNewChange(setid);
  }
  public int getSetFormularNewChange(String setid) throws SysException {
    return this.wagesetservice.getSetFormularNewChange(setid);
  }
  public void doPopupItemChange(String setid) throws SysException {
    this.wagesetservice.doPopupItemChange(setid);
  }

  public void batchDeleteItem(String setId, String[] itemId, User user)
    throws SysException
  {
    if (itemId == null) return;
    int count = itemId.length;
    List wageSetItemBOList = new ArrayList();
    WageSetBO set = this.wagesetservice.findSetBySetId(setId);
    String allItem = CommonFuns.filterNull(set.getAllField());
    String showItem = CommonFuns.filterNull(set.getShowField());
    for (int i = 0; i < count; i++) {
      WageSetItemBO item = this.wagesetitemservice.findItem(itemId[i]);
      allItem = allItem.replaceAll(item.getField() + ",", "");
      showItem = showItem.replaceAll(item.getField() + ",", "");
      if ("A815713".equals(item.getField())) {
        allItem = allItem.replaceAll("A815714,", "");
        showItem = showItem.replaceAll("A815714,", "");
      }

      this.wagesetitemservice.deleteItem(itemId[i]);

      WageSetItemChangeBO bo = new WageSetItemChangeBO();
      bo.setAction(WageSetItemChangeBO.ACTION_DELETE);
      bo.setField(item.getField());
      bo.setOperateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      bo.setOperateID(user.getUserId());
      bo.setPopup("0");
      bo.setSetId(item.getSetId());
      this.wagesetitemservice.saveItemChange(bo);
      wageSetItemBOList.add(item);
    }
    set.setAllField(allItem);
    set.setShowField(showItem);
    this.wagesetservice.updateSet(set);

    if (wageSetItemBOList.size() > 0) {
      String[] wageSetItemId = new String[wageSetItemBOList.size()];
      for (int i = 0; i < wageSetItemId.length; i++) {
        wageSetItemId[i] = ((WageSetItemBO)wageSetItemBOList.get(i)).getField();
      }
      this.wagesetpersonservice.clearInputItemToZero(setId, wageSetItemId);
    }
  }

  public void updateItem(WageSetItemBO item)
    throws SysException
  {
    this.wagesetitemservice.updateItem(item);
  }

  public WageSetItemBO querySetItemBySetIdAndField(String setId, String field)
    throws SysException
  {
    return this.wagesetitemservice.querySetItemBySetIdAndField(setId, field);
  }
  public List queryItemBySetId(String setId) throws SysException {
    return this.wagesetitemservice.queryItemBySetId(setId);
  }
  public List queryItemBySetIdOrderByName(String setId) throws SysException {
    return this.wagesetitemservice.queryItemBySetIdOrderByName(setId);
  }

  public List queryFormulaItemBySetId(String setId)
    throws SysException
  {
    return this.wagesetitemservice.queryItemByType(setId, "1");
  }
  public List queryFormulaItemBySetId(String setId, boolean orderByName) throws SysException {
    return this.wagesetitemservice.queryItemByType(setId, "1", orderByName);
  }

  public List queryInputItemBySetId(String setId, boolean orderByname)
    throws SysException
  {
    return this.wagesetitemservice.queryItemByType(setId, "2", orderByname);
  }
  public List queryInputItemBySetId(String setId) throws SysException {
    return this.wagesetitemservice.queryItemByType(setId, "2");
  }

  public List queryStdItemBySetId(String setId)
    throws SysException
  {
    return this.wagesetitemservice.queryItemByType(setId, "0");
  }

  public void updateItemShowSequence(String setId, String[] itemId)
    throws SysException
  {
    this.wagesetitemservice.updateItemShowSequence(setId, itemId);
  }

  public void updateFormulaItemCountSequence(String setId, String[] itemId) throws SysException {
    this.wagesetitemservice.updateItemCountSequence(setId, itemId);
  }

  public void updateFinanceItem(String setId, String[] itemId)
    throws SysException
  {
    String str = CommonFuns.StrArray2String(itemId, ",");
    WageSetBO set = this.wagesetservice.findSetBySetId(setId);
    set.setFinanceField(str);
    this.wagesetservice.updateSet(set);
  }

  public String[] queryFinanceItem(String setId)
    throws SysException
  {
    WageSetBO set = this.wagesetservice.findSetBySetId(setId);
    if ((set != null) && (set.getFinanceField() != null) && (set.getFinanceField().trim().length() > 0)) {
      return CommonFuns.filterNull(set.getFinanceField()).split(",");
    }
    return null;
  }

  public WageSetPersonService getWagesetpersonservice()
  {
    return this.wagesetpersonservice;
  }

  public void setWagesetpersonservice(WageSetPersonService wagesetpersonservice) {
    this.wagesetpersonservice = wagesetpersonservice;
  }

  public WageComputeService getWagecomputeservice() {
    return this.wagecomputeservice;
  }

  public void setWagecomputeservice(WageComputeService wagecomputeservice) {
    this.wagecomputeservice = wagecomputeservice;
  }

  public void copyset(String des, String source)
  {
    try
    {
      List li = queryItemBySetId(source);
      for (int i = 0; i < li.size(); i++) {
        WageSetItemBO ws = (WageSetItemBO)li.get(i);
        ws.setSetId(des);
        createCopyedItem(ws);
      }
    }
    catch (Exception e) {
    }
  }

  public WageSetItemBO findItem(String itemId) throws SysException {
    return this.wagesetitemservice.findItem(itemId);
  }
}