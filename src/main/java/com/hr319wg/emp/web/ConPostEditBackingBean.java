package com.hr319wg.emp.web;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.ConPostBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.ConPostVO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.portal.IUUManager;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class ConPostEditBackingBean extends BaseBackingBean
{
  private String cancelInit;
  private List personList;
  private ConPostVO cpvo = new ConPostVO();
  private ConPostVO cancelvo = new ConPostVO();
  private IPersonUCC personucc;
  private String deptid;
  private String postID;
  private String personID;
  private WageAPI wageapi;

  public String getPostID() {
	return postID;
  }
  public void setPostID(String postID) {
	this.postID = postID;
  }
  public WageAPI getWageapi()
  {
    return this.wageapi;
  }
  public void setWageapi(WageAPI api) {
    this.wageapi = api;
  }

  public String getCancelInit() {
    try {
      if (super.getRequestParameter("ID") != null) {
        this.personID = super.getRequestParameter("ID");
        PersonBO pb = SysCacheTool.findPersonById(this.personID);
        this.cancelvo.setPersonID(this.personID);
        this.cancelvo.setPersonName(pb.getName());
        this.cancelvo.setPersonCode(pb.getPersonCode());
        this.cancelvo.setMainOrguid(pb.getOrgId());
        this.cancelvo.setMainOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.cancelvo.getMainOrguid()));
        this.cancelvo.setMainDeptid(pb.getDeptId());
        this.cancelvo.setMainDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.cancelvo.getMainDeptid()));

        ConPostBO cb = this.personucc.getConPostInfo(this.personID);
        if ((cb != null) && (cb.getConPostID() != null)) {
          this.cancelvo.setConPostID(cb.getConPostID());
        }
        else {
          this.cancelvo.setConPostID(null);
        }
        if ((cb != null) && (cb.getConOrguid1() != null)) {
          this.cancelvo.setConOrguid1(cb.getConOrguid1());
          this.cancelvo.setConOrguid1Name(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getConOrguid1()));
          PersonBO bb = SysCacheTool.findPersonById("@" + this.personID);
          if (bb != null) {
            this.cancelvo.setConDeptid1(bb.getDeptId());
            this.cancelvo.setConDeptid1Name(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.cancelvo.getConDeptid1()));
          }
        }
        else {
          this.cancelvo.setConOrguid1("");
        }

        if ((cb != null) && (cb.getConOrguid2() != null)) {
          this.cancelvo.setConOrguid2(cb.getConOrguid2());
          this.cancelvo.setConOrguid2Name(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getConOrguid2()));
          PersonBO bb = SysCacheTool.findPersonById("@@" + this.personID);
          if (bb != null) {
            this.cancelvo.setConDeptid2(bb.getDeptId());
            this.cancelvo.setConDeptid2Name(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.cancelvo.getConDeptid2()));
          }
        }
        else {
          this.cancelvo.setConOrguid2("");
        }
      }
    }
    catch (Exception e)
    {
    }
    return this.cancelInit;
  }
  public void setCancelInit(String id) {
    this.cancelInit = id;
  }

  public String getPersonID() {
    return this.personID;
  }
  public void setPersonID(String id) {
    this.personID = id;
  }

  public String getDeptid() {
    return this.deptid;
  }
  public void setDeptid(String id) {
    this.deptid = id;
  }

  public ConPostVO getCpvo() {
    return this.cpvo;
  }
  public void setCpvo(ConPostVO vo) {
    this.cpvo = vo;
  }

  public ConPostVO getCancelvo() {
    return this.cancelvo;
  }
  public void setCancelvo(ConPostVO vo) {
    this.cancelvo = vo;
  }
  public String Cancel1() {
    try {
      String personid = "@" + this.cancelvo.getPersonID();
      String[] sets = this.wageapi.queryAllSetByPersonID(personid);
      if ((sets != null) && (sets.length > 0)) {
        super.showMessageDetail("该人员还在帐套中，请退出帐套，才能取消兼职!");
        return "";
      }

      if ((this.cancelvo.getConOrguid1() != null) && (!"".equals(this.cancelvo.getConOrguid1()))) {
        ConPostBO cb = new ConPostBO();
        cb.setConPostID(this.cancelvo.getConPostID());
        cb.setPersonID(this.cancelvo.getPersonID());
        cb.setMainOrguid(this.cancelvo.getMainOrguid());
        cb.setConOrguid1("");

        this.personucc.DeletePerson(personid);
        this.personucc.setConEndTime(this.cancelvo.getPersonID(), this.cancelvo.getConOrguid1());

        if ((this.cancelvo.getConOrguid2() != null) && (!"".equals(this.cancelvo.getConOrguid2()))) {
          cb.setConOrguid2(this.cancelvo.getConOrguid2());
          this.personucc.SaveConPostBO(cb);
        }
        else {
          this.personucc.DeleteConPostBO(cb);
        }

        if (!"".equals(Constants.UUM_SERVICE_NAME))
          try {
            IUUManager uumanager = (IUUManager)SysContext.getBean(Constants.UUM_SERVICE_NAME);
            if (uumanager != null)
            {
              String[] id = new String[1];
              id[0] = personid;
              SysCache.setMap(id, 2, 6);
              uumanager.userModify(personid, super.getUserInfo().getUserId(), "1");
            }
          }
          catch (Exception e)
          {
          }
      }
    }
    catch (Exception e)
    {
      super.showMessageDetail("取消兼职失败,错误:" + e.getMessage());
      return "";
    }
    return "success";
  }
  public String Cancel2() {
    try {
      String personid = "@@" + this.cancelvo.getPersonID();
      String[] sets = this.wageapi.queryAllSetByPersonID(personid);
      if ((sets != null) && (sets.length > 0)) {
        super.showMessageDetail("该人员还在帐套中，请退出帐套，才能取消兼职!");
        return "";
      }
      if ((this.cancelvo.getConOrguid2() != null) && (!"".equals(this.cancelvo.getConOrguid2()))) {
        ConPostBO cb = new ConPostBO();
        cb.setConPostID(this.cancelvo.getConPostID());
        cb.setPersonID(this.cancelvo.getPersonID());
        cb.setMainOrguid(this.cancelvo.getMainOrguid());
        cb.setConOrguid2("");

        this.personucc.DeletePerson(personid);
        this.personucc.setConEndTime(this.cancelvo.getPersonID(), this.cancelvo.getConOrguid2());

        if ((this.cancelvo.getConOrguid1() != null) && (!"".equals(this.cancelvo.getConOrguid1()))) {
          cb.setConOrguid1(this.cancelvo.getConOrguid1());
          this.personucc.SaveConPostBO(cb);
        }
        else {
          this.personucc.DeleteConPostBO(cb);
        }

        if (!"".equals(Constants.UUM_SERVICE_NAME)) {
          try {
            IUUManager uumanager = (IUUManager)SysContext.getBean(Constants.UUM_SERVICE_NAME);
            if (uumanager != null)
            {
              String[] id = new String[1];
              id[0] = personid;
              SysCache.setMap(id, 2, 6);
              uumanager.userModify(personid, super.getUserInfo().getUserId(), "1");
            }
          }
          catch (Exception e)
          {
          }
        }
      }
    }
    catch (Exception e)
    {
    }

    return "success";
  }

  public String doFind() {
    try {
      PersonBO pb = SysCacheTool.findPersonById(this.cpvo.getPersonID());
      this.cpvo.setPersonName(pb.getName());
      this.cpvo.setPersonCode(pb.getPersonCode());
      this.cpvo.setMainOrguid(pb.getOrgId());
      this.cpvo.setMainOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.cpvo.getMainOrguid()));
      this.cpvo.setMainDeptid(pb.getDeptId());
      this.cpvo.setMainDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.cpvo.getMainDeptid()));

      ConPostBO cb = this.personucc.getConPostInfo(this.cpvo.getPersonID());
      if ((cb != null) && (cb.getConPostID() != null)) {
        this.cpvo.setConPostID(cb.getConPostID());
      }
      else {
        this.cpvo.setConPostID(null);
      }
      if ((cb != null) && (cb.getConOrguid1() != null)) {
        this.cpvo.setConOrguid1(cb.getConOrguid1());
        this.cpvo.setConOrguid1Name(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getConOrguid1()));
      }
      else {
        this.cpvo.setConOrguid1(null);
      }
      if ((cb != null) && (cb.getConOrguid2() != null)) {
        this.cpvo.setConOrguid2(cb.getConOrguid2());
        this.cpvo.setConOrguid1Name(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, cb.getConOrguid2()));
      }
      else {
        this.cpvo.setConOrguid2(null);
      }
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public String save() {
    try {
      this.postID=this.postID==null?"":this.postID;
      String personid = "";
      OrgBO orgbo = OrgTool.getOrgByDept(this.deptid);

      ConPostBO cb = new ConPostBO();
      cb.setConPostID(this.cpvo.getConPostID());
      cb.setPersonID(this.cpvo.getPersonID());
      cb.setMainOrguid(this.cpvo.getMainOrguid());
      if ((this.cpvo.getConOrguid1() != null) && (!"".equals(this.cpvo.getConOrguid1()))) {
        cb.setConOrguid1(this.cpvo.getConOrguid1());
        cb.setConPostID1(cb.getConPostID1());
        cb.setConPostID2(this.postID);
        if ((this.cpvo.getConOrguid2() == null) || ("".equals(this.cpvo.getConOrguid2()))) {
          cb.setConOrguid2(orgbo.getOrgId());
          personid = "@@" + this.cpvo.getPersonID();
          this.personucc.CopyPerson(this.cpvo.getPersonID(), personid, this.deptid);
          this.personucc.insertAllSingleSet(super.getUserInfo(), personid);
          this.personucc.updatePersonCode(personid, "@@,"+this.postID);
          this.personucc.SaveConPostBO(cb);

          TableVO tmp = this.personucc.findNewPage("A704", super.getUserInfo());
          Hashtable tmphash = tmp.getRowData()[0].cellArray2Hash();
          ((CellVO)tmphash.get("ID")).setValue(this.cpvo.getPersonID());
          ((CellVO)tmphash.get("A704701")).setValue(orgbo.getOrgId());
          ((CellVO)tmphash.get("A704702")).setValue(this.deptid);
          ((CellVO)tmphash.get("A704703")).setValue(CommonFuns.getSysDate("yyyy-MM-dd"));
          this.personucc.addPageInfo(tmp, super.getUserInfo());
        }
        else {
          super.showMessageDetail("最多可以兼职两个!");
        }
      }
      else {
        cb.setConOrguid1(orgbo.getOrgId());
        cb.setConPostID1(this.postID);
        personid = "@" + this.cpvo.getPersonID();
        this.personucc.CopyPerson(this.cpvo.getPersonID(), personid, this.deptid);
        this.personucc.insertAllSingleSet(super.getUserInfo(), personid);
        this.personucc.updatePersonCode(personid, "@,"+this.postID);
        this.personucc.SaveConPostBO(cb);

        TableVO tmp = this.personucc.findNewPage("A704", super.getUserInfo());
        Hashtable tmphash = tmp.getRowData()[0].cellArray2Hash();
        ((CellVO)tmphash.get("ID")).setValue(this.cpvo.getPersonID());
        ((CellVO)tmphash.get("A704701")).setValue(orgbo.getOrgId());
        ((CellVO)tmphash.get("A704702")).setValue(this.deptid);
        ((CellVO)tmphash.get("A704703")).setValue(CommonFuns.getSysDate("yyyy-MM-dd"));
        this.personucc.addPageInfo(tmp, super.getUserInfo());
      }

      if (!"".equals(Constants.UUM_SERVICE_NAME)) {
        try {
          IUUManager uumanager = (IUUManager)SysContext.getBean(Constants.UUM_SERVICE_NAME);
          if (uumanager != null)
          {
            String[] id = new String[1];
            id[0] = this.cpvo.getPersonID();
            SysCache.setMap(id, 2, 6);
            uumanager.userModify(this.cpvo.getPersonID(), super.getUserInfo().getUserId(), "1");
          }
        }
        catch (Exception e)
        {
        }
      }
    }
    catch (Exception e)
    {
    }

    return "success";
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public List getPersonList() {
    return this.personList;
  }
  public void setPersonList(List list) {
    this.personList = list;
  }
}