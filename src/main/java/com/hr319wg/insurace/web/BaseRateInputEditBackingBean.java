package com.hr319wg.insurace.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.insurace.ucc.IBaseSetUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.ucc.IWageItemPowerUCC;

public class BaseRateInputEditBackingBean extends BaseBackingBean
{
  private boolean autoCalc = false;
  private String[] selectFields;
  private List fieldsList = new ArrayList();
  private Object[] personlist;
  private String pageInit;
  private IBaseSetUCC basesetucc;
  private IWageItemPowerUCC wagepowerucc;

  public IWageItemPowerUCC getWagepowerucc()
  {
    return this.wagepowerucc;
  }
  public void setWagepowerucc(IWageItemPowerUCC wagepowerucc) {
    this.wagepowerucc = wagepowerucc;
  }

  public boolean getAutoCalc() {
    return this.autoCalc;
  }
  public void setAutoCalc(boolean b) {
    this.autoCalc = b;
  }

  public IBaseSetUCC getBasesetucc() {
    return this.basesetucc;
  }

  public void setBasesetucc(IBaseSetUCC basesetucc) {
    this.basesetucc = basesetucc;
  }

  public String getPageInit() {
    try {
      if ((super.getRequestParameter("PerStr") != null) && (!super.getRequestParameter("PerStr").equals(""))) {
        super.getHttpSession().removeAttribute("field");
        super.getHttpSession().removeAttribute("persId");

        String str = super.getServletRequest().getParameter("PerStr").replaceAll("~", "#");
        String[] pId = str.split(",");
        String[] persId = new String[pId.length];
        this.personlist = new PersonBO[pId.length];
        for (int i = 0; i < pId.length; i++) {
          PersonBO pb = SysCacheTool.findPersonById(pId[i]);
          pb.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId()));
          pb.setOrgId(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId()));
          this.personlist[i] = pb;
          persId[i] = pb.getPersonId();
        }
        super.getHttpSession().setAttribute("pkIDs", pId);
        super.getHttpSession().setAttribute("persId", persId);

        this.fieldsList = new ArrayList();
        String[] fs = { "A755715", "A770710", "A765705", "A760710", "A775704", "A786700", "A780708", "A785708" };
        String SetID = super.getRequestParameter("SetID");
        String select = this.wagepowerucc.getInsuraceBaseFields(super.getUserInfo().getUserId(), SetID);
        for (int i = 0; i < fs.length; i++)
          if (select.indexOf(fs[i]) >= 0) {
            InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
            SelectItem s6 = new SelectItem();
            s6.setLabel(ib.getItemName());
            s6.setValue(ib.getItemId());
            this.fieldsList.add(s6);
          }
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return this.pageInit;
  }

  public void setPageInit(String pageInit) {
    this.pageInit = pageInit;
  }

  public Object[] getPersonlist() {
    return this.personlist;
  }

  public void setPersonlist(Object[] personlist) {
    this.personlist = personlist;
  }

  public List getFieldsList() {
    return this.fieldsList;
  }

  public void setFieldsList(List fieldsList) {
    this.fieldsList = fieldsList;
  }

  public String[] getSelectFields() {
    return this.selectFields;
  }

  public void setSelectFields(String[] selectFields) {
    this.selectFields = selectFields;
  }
  public String queryPersonInput() {
    try {
      super.getHttpSession().setAttribute("field", this.selectFields);
      String[] persId = (String[])(String[])super.getHttpSession().getAttribute("persId");
      String[] field = (String[])(String[])super.getHttpSession().getAttribute("field");
      HashMap hash = this.basesetucc.BaseRateInputEditSelectData(persId, field);
      super.getHttpSession().removeAttribute("value");
      super.getServletRequest().setAttribute("value", hash);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "inputEdit";
  }
  public String savePersonBase() {
    try {
      String[] persId = (String[])(String[])super.getHttpSession().getAttribute("persId");
      String[] inputField = (String[])(String[])super.getHttpSession().getAttribute("field");
      int col = inputField.length;
      int row = persId.length;
      for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
          String id = persId[i].trim();
          String tablename = inputField[j].trim().substring(0, 4);
          String value = CommonFuns.filterNullToZero(super.getRequestParameter(persId[i] + "|" + inputField[j]));
          System.out.println("id=" + id);
          System.out.println("tablename=" + tablename);
          System.out.println("value=" + value);
          this.basesetucc.BaseRateInputEditSelect(id, tablename, value);
        }
      }
      if (this.autoCalc) {
        this.basesetucc.importUnitSet(persId);
        this.basesetucc.CountInsurce(persId);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "success";
  }
}