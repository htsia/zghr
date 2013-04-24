package com.hr319wg.train.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.train.pojo.bo.CourceWareItemBO;
import com.hr319wg.train.ucc.ICourceWareUCC;
import com.hr319wg.util.CommonFuns;

public class CourceWareBackingBean extends BaseBackingBean
{
  private int COUNT = 10;
  private List courceList;
  private List manCourceList;
  private List moreCourceList;
  private ICourceWareUCC courceUCC;
  private String superID;
  private String browMore;
  private String status = "-1";

  public String getStatus() {
    return this.status;
  }
  public void setStatus(String st) {
    this.status = st;
  }

  public List getMoreCourceList() {
    return this.moreCourceList;
  }
  public void setMoreCourceList(List list) {
    this.moreCourceList = list;
  }
  public void changeStatus(ValueChangeEvent event) {
    this.status = event.getNewValue().toString();
    getBrowMore();
  }

  public String getBrowMore() {
    try {
      if (super.getRequestParameter("superID") != null) {
        this.superID = super.getRequestParameter("superID");
      }
      List list = this.courceUCC.getAllItemInfo(this.superID);
      String strToday = CommonFuns.getSysDate("yyyy-MM-dd");
      this.moreCourceList = new ArrayList();
      for (int i = 0; i < list.size(); i++) {
        CourceWareItemBO bo = (CourceWareItemBO)list.get(i);
        if ((("0".equals(this.status)) && (bo.getEndDate() != null) && (strToday.compareTo(bo.getEndDate()) < 0)) || (
          ("1".equals(this.status)) && (bo.getEndDate() != null) && (strToday.compareTo(bo.getEndDate()) > 0))) continue;
        if ("-1".equals(bo.getOrgID())) {
          bo.setOrgID("集团发布");
        }
        else {
          bo.setOrgID("本单位发布");
        }
        this.moreCourceList.add(bo);
      }
    }
    catch (Exception e)
    {
    	e.printStackTrace();
    }
    return "";
  }
  public void setBrowMore(String more) {
    this.browMore = more;
  }

  public ICourceWareUCC getCourceUCC() {
    return this.courceUCC;
  }
  public void setCourceUCC(ICourceWareUCC ucc) {
    this.courceUCC = ucc;
  }

  public String getSuperID() {
    return this.superID;
  }
  public void setSuperID(String ID) {
    this.superID = ID;
  }

  public String getPageInit() {
    try {
      if (super.getRequestParameter("superId") != null) {
        this.superID = super.getRequestParameter("superId");
      }
    }
    catch (Exception e)
    {
    }
    return this.pageInit;
  }

  public List getManCourceList() {
    try {
    	this.manCourceList = this.courceUCC.getAllFileInfoByType(this.superID, super.getUserInfo());
    }
    catch (Exception e)
    {
    	e.printStackTrace();
    }
    return this.manCourceList;
  }
  public void setManCourceList(List list) {
    this.manCourceList = list;
  }

  public List getCourceList() {
    try {
      List list = this.courceUCC.getAllValidItemInfo(super.getUserInfo().getOrgId());
      this.courceList = new ArrayList();
      if ((list == null) || (list.size() == 0)) {
        CourceWareItemBO cib = new CourceWareItemBO();
        cib.setTitle("暂时没有培训课件");
        cib.setCreateDate("");
        this.courceList.add(cib);
      }
      else {
        for (int i = 0; (i < this.COUNT) && (i < list.size()); i++)
        {
          CourceWareItemBO bo = (CourceWareItemBO)list.get(i);
          if (bo.getNewEndDate() != null) {
            if (CommonFuns.betweenDays(bo.getNewEndDate()) >= 0L) {
              bo.setNewCource(true);
            }
            else {
              bo.setNewCource(false);
            }
          }
          else {
            bo.setNewCource(false);
          }
          this.courceList.add(bo);
        }
      }
    }
    catch (Exception e) {
      this.courceList = new ArrayList();
    }
    return this.courceList;
  }
  public void setCourceList(List list) {
    this.courceList = list;
  }
}