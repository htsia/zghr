package com.hr319wg.wage.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.wage.dao.WageFormulaDAO;
import com.hr319wg.wage.dao.WageSetItemDAO;
import com.hr319wg.wage.dao.WageStandardDAO;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageSetItemChangeBO;
import java.util.List;

public class WageSetItemService
{
  private WageSetItemDAO wagesetitemdao;
  private WageFormulaDAO wfdao;
  private WageStandardDAO wsdao;

  public void setWsdao(WageStandardDAO wd)
  {
    this.wsdao = wd; }

  public WageStandardDAO getWsdao() {
    return this.wsdao;
  }

  public void setWfdao(WageFormulaDAO wd) {
    this.wfdao = wd; }

  public WageFormulaDAO getWfdao() {
    return this.wfdao;
  }

  public WageSetItemDAO getWagesetitemdao() {
    return this.wagesetitemdao; }

  public void setWagesetitemdao(WageSetItemDAO wagesetitemdao) {
    this.wagesetitemdao = wagesetitemdao;
  }

  public void createItem(WageSetItemBO item)
    throws SysException
  {
    this.wagesetitemdao.createBo(item);
  }

  public void saveItemChange(WageSetItemChangeBO item) throws SysException {
    this.wagesetitemdao.createBo(item);
  }

  public List getChangeInfo(String setId) throws SysException {
    return this.wagesetitemdao.getChangeInfo(setId);
  }

  public void updateItem(WageSetItemBO item)
    throws SysException
  {
    this.wagesetitemdao.updateBo(item.getItemId(), item);
  }

  public void deleteItem(String itemId)
    throws SysException
  {
    this.wagesetitemdao.deleteBo(WageSetItemBO.class, itemId);
  }

  public WageSetItemBO findItem(String itemId)
    throws SysException
  {
    return ((WageSetItemBO)this.wagesetitemdao.findBoById(WageSetItemBO.class, itemId));
  }

  public void deleteItemBySetId(String setId)
    throws SysException
  {
    this.wagesetitemdao.deleteSetItemBySetId(setId);
  }

  public void batchDeleteItem(String[] itemId)
    throws SysException
  {
    if (itemId == null) return;
    int count = itemId.length;
    for (int i = 0; i < count; ++i)
      if (!("A815714".equals(itemId[i])))
        this.wagesetitemdao.deleteBo(WageSetItemBO.class, itemId[i]);
  }

  public WageSetItemBO querySetItemBySetIdAndField(String setId, String field)
    throws SysException
  {
    return this.wagesetitemdao.querySetItemBySetIdAndField(setId, field); }

  public List queryItemBySetId(String setId) throws SysException {
    List li = this.wagesetitemdao.querySetItemBySetId(setId);
    if (li != null)
      for (int i = 0; i < li.size(); ++i) {
        WageSetItemBO item = (WageSetItemBO)li.get(i);
        if ("2".equals(item.gettype())) {
          if ("1".equals(item.getCanClear())) {
            item.settypeEx("录入项目[<font color=red>允许清空操作</font>]");
          }
          else
            item.settypeEx("录入项目[不允许清空操作]");
        }
        else if ("1".equals(item.gettype())) {
          WageFormulaBO wfb = this.wfdao.queryFormulaById(item.getLinkId());
          if (wfb != null) {
            item.settypeEx("公式项[" + wfb.getName() + "]");
          }
          else
            item.settypeEx("公式项[该公式不存在]");
        }
        else {
          item.settypeEx("查表项");
        }
      }

    return li; }

  public List queryItemBySetIdOrderByName(String setId) throws SysException {
    List li = this.wagesetitemdao.queryItemBySetIdOrderByName(setId);
    if (li != null)
      for (int i = 0; i < li.size(); ++i) {
        WageSetItemBO item = (WageSetItemBO)li.get(i);
        if ("2".equals(item.gettype())) {
          item.settypeEx("输入项");
        } else if ("1".equals(item.gettype())) {
          WageFormulaBO wfb = this.wfdao.queryFormulaById(item.getLinkId());
          if (wfb != null) {
            item.settypeEx("公式项[" + wfb.getName() + "]");
          }
          else
            item.settypeEx("公式项[该公式不存在]");
        }
        else {
          item.settypeEx("标准项");
        }
      }

    return li;
  }

  public void updateItemShowSequence(String setId, String[] itemId)
    throws SysException
  {
    this.wagesetitemdao.updateItemShowSequence(setId, itemId); }

  public void updateItemCountSequence(String setId, String[] itemId) throws SysException {
    this.wagesetitemdao.updateItemCountSequence(setId, itemId);
  }

  public List queryItemByType(String setId, String type)
    throws SysException
  {
    return queryItemByType(setId, type, false); }

  public List queryItemByType(String setId, String type, boolean orderByName) throws SysException {
    List li = this.wagesetitemdao.querySetItemByType(setId, type, orderByName);
    if (li != null)
      for (int i = 0; i < li.size(); ++i) {
        WageSetItemBO item = (WageSetItemBO)li.get(i);
        if ("2".equals(item.gettype())) {
          item.settypeEx("输入项");
        } else if ("1".equals(item.gettype())) {
          WageFormulaBO wfb = this.wfdao.queryFormulaById(item.getLinkId());
          item.settypeEx("公式项[" + wfb.getName() + "]");
        } else {
          item.settypeEx("标准项");
        }
      }

    return li;
  }

  public List queryItemByCost(String setId, String cost)
    throws SysException
  {
    return this.wagesetitemdao.querySetItemByCost(setId, cost);
  }

  public void updateItemCost(String infoItemId, String costId) throws SysException {
    this.wagesetitemdao.updateItemCost(infoItemId, costId);
  }
}