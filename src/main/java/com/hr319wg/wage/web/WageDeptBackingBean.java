package com.hr319wg.wage.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.wage.pojo.bo.WageDeptBO;
import com.hr319wg.wage.pojo.bo.WageDeptPowerBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.ucc.IWageDeptUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;

public class WageDeptBackingBean extends BaseBackingBean
{
  private String setID;
  private String unitId;
  private String curSetId;
  private String personID;
  private String setName;
  private List list;
  private List personList = null;
  private List grouppersonList = null;
  private List personPowerList = null;
  private IWageDeptUCC wagedeptucc;
  private IWageSetUCC wagesetucc;
  private WageAPI wageapi;
  private String itemID;

  public String getItemID()
  {
    return this.itemID;
  }
  public void setItemID(String itemID) {
    this.itemID = itemID;
  }

  public WageAPI getWageapi()
  {
    return this.wageapi;
  }
  public void setWageapi(WageAPI api) {
    this.wageapi = api;
  }

  public String copyDept() {
    try {
      this.wagedeptucc.copyDept(this.setID, this.curSetId);
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public String copyDeptPower() {
    try {
      this.wagedeptucc.DeletePowerItem(this.setID, this.personID);
      this.wagedeptucc.copyPowerDefine(this.setID, this.curSetId, this.personID);
    }
    catch (Exception e)
    {
    }
    return "";
  }

  public String getCurSetId()
  {
    return this.curSetId;
  }
  public void setCurSetId(String id) {
    this.curSetId = id;
  }

  public String getUnitId() {
    return this.unitId;
  }
  public void setUnitId(String id) {
    this.unitId = id;
  }

  public String getSetID() {
    return this.setID;
  }
  public void setSetID(String id) {
    this.setID = id;
  }

  public String getSetName() {
    return this.setName;
  }
  public void setSetName(String id) {
    this.setName = id;
  }

  public String getPersonID() {
    return this.personID;
  }
  public void setPersonID(String id) {
    this.personID = id;
  }

  public List getGrouppersonList() {
    if (this.grouppersonList == null) {
      this.grouppersonList = new ArrayList();
      try {
        String[] pids = this.wageapi.getGroupPayUser(this.setID);

        for (int i = 0; i < pids.length; i++) {
          if (i == 0) this.personID = pids[0];
          SelectItem si = new SelectItem();
          si.setLabel(SysCacheTool.findPersonById(pids[i]).getName());
          si.setValue(pids[i]);
          this.grouppersonList.add(si);
        }
      }
      catch (Exception e)
      {
      }
    }
    return this.grouppersonList;
  }
  public void setGrouppersonList(List grouppersonList) {
    this.grouppersonList = grouppersonList;
  }

  public List getPersonList() {
    if (this.personList == null) {
      this.personList = new ArrayList();
      try {
        String[] pids = this.wageapi.getWageSetUser(this.setID);

        for (int i = 0; i < pids.length; i++) {
          if (i == 0) this.personID = pids[0];
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

  public List getPersonPowerList() {
    try {
      if (this.personID != null) {
        this.personPowerList = this.wagedeptucc.getAllPowerByPerson(this.personID, this.setID);
        for (int i = 0; i < this.personPowerList.size(); i++) {
          WageDeptPowerBO wdp = (WageDeptPowerBO)this.personPowerList.get(i);
          WageDeptBO wd = this.wagedeptucc.getDeptBOByID(wdp.getDeptID());
          wdp.setDeptName(wd.getName());
        }
      }
      else {
        this.personPowerList = new ArrayList();
      }
    }
    catch (SysException e) {
      e.printStackTrace();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return this.personPowerList;
  }
  public void setPersonPowerList(List li) {
    this.personPowerList = li;
  }

  public String getPageInit() {
    try {
      if (super.getRequestParameter("setID") != null) {
        this.setID = super.getRequestParameter("setID");
        WageSetBO wb = this.wagesetucc.findSetBySetId(this.setID);
        this.setName = wb.getName();
        this.unitId = wb.getUnitId();
        this.personList = null;
      }
    }
    catch (Exception e)
    {
    }
    return this.pageInit;
  }

  public void updateData() {
    try {
    	this.wagedeptucc.updateData(this.itemID);
    	super.showMessageDetail("同步完成");
    }
    catch (Exception e)
    {
    	super.showMessageDetail("同步失败");
    }
  }
  public List getList() {
    try {
      this.list = this.wagedeptucc.getAllDept(this.setID);
      for (int i = 0; i < this.list.size(); i++) {
        WageDeptBO wb = (WageDeptBO)this.list.get(i);
        if ((wb.getA001758() != null) && (!"".equals(wb.getA001758()))) {
          wb.setA001758(CodeUtil.interpertCode("2209", wb.getA001758()));
        }
        if(wb.getLinkOrgs()!=null && !"".equals(wb.getLinkOrgs())){
        	wb.setLinkOrgNames(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, wb.getLinkOrgs()));
        }
      }
      return this.list;
    } catch (SysException e) {
      this.list = new ArrayList();
    }
    return this.list;
  }
  public void setList(List li) {
    this.list = li;
  }

  public void changePerson(ValueChangeEvent event) {
    this.personID = event.getNewValue().toString();
  }

  public IWageDeptUCC getWagedeptucc() {
    return this.wagedeptucc;
  }
  public void setWagedeptucc(IWageDeptUCC ucc) {
    this.wagedeptucc = ucc;
  }

  public IWageSetUCC getWagesetucc() {
    return this.wagesetucc;
  }
  public void setWagesetucc(IWageSetUCC ucc) {
    this.wagesetucc = ucc;
  }
}