package com.hr319wg.org.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.pojo.vo.OrgChangeVO;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class OrgChangeBackingBean extends BaseBackingBean
{
  private String changeOrg;
  private String oldSuper;
  private String superOrg;
  private OrgChangeVO orgchangevo = new OrgChangeVO();
  private IOrgUCC orgucc;
  private PersonBO[] personlist;

  public IOrgUCC getOrgucc()
  {
    return this.orgucc;
  }
  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public String getChangeOrg() {
    return this.changeOrg;
  }
  public void setChangeOrg(String changeOrg) {
    this.changeOrg = changeOrg;
  }

  public String getSuperOrg() {
    return this.superOrg;
  }
  public void setSuperOrg(String superOrg) {
    this.superOrg = superOrg;
  }

  public String getOldSuper() {
    return this.oldSuper;
  }
  public void setOldSuper(String oldSuper) {
    this.oldSuper = oldSuper;
  }

  public OrgChangeVO getOrgchangevo() {
    if ((this.orgchangevo != null) && (
      (this.orgchangevo.getChangeType() == null) || (!"".equals(this.orgchangevo.getChangeType().trim())))) {
      this.orgchangevo.setChangeType("08904");
    }

    return this.orgchangevo;
  }
  public void setOrgchangevo(OrgChangeVO orgchangevo) {
    this.orgchangevo = orgchangevo;
  }

  public PersonBO[] getPersonlist() {
    return this.personlist;
  }
  public void setPersonlist(PersonBO[] personlist) {
    this.personlist = personlist;
  }

  public String saveChange() {
    try {
      User user = getUserInfo();
      OrgBO bo =SysCacheTool.findOrgById(this.changeOrg);
      
      String[] ids = getServletRequest().getParameterValues("chk");
      this.orgucc.updateOrgChange(this.changeOrg, user, this.superOrg, this.orgchangevo, ids);
      //同步财务系统,添加一条主管机构变更记录
	  SqlUtil.updateData("insert into b001_bd (change_date,change_type,old_mainDeptID,new_mainDeptID,dept_id,dept_type,dept_name) values " +
      					"(getdate(),'主管机构变更','"+bo.getSuperId()+"','"+this.superOrg+"','"+this.changeOrg+"','"+("089110".equals(bo.getorgType())?"单位":"部门")+"','"+bo.getName()+"')");
	  
	  SqlUtil.updateData("update b001 set b001003='"+bo.getTreeId()+"',b001002='"+this.superOrg+"',b001005='"+bo.getName()+"' where id='"+bo.getOrgId()+"'");
      
	  SysCache.loadOrgMap();

      this.changeOrg = "";
      this.superOrg = "";
      this.oldSuper = "";
      this.orgchangevo = new OrgChangeVO();
      this.orgchangevo.setChangeType("");
      this.personlist = new PersonBO[0];
      showMessageDetail("机构变更成功!");
    } catch (Exception e) {
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String delPerson() {
    String[] ids = getServletRequest().getParameterValues("chk");
    if ((ids != null) && (ids.length > 0)) {
      List newList = new ArrayList();
      for (int j = 0; j < this.personlist.length; j++) {
        int i = 0;
        while ((i < ids.length) && 
          (!ids[i].equals(this.personlist[j].getPersonId()))) {
          i++;
        }

        if (i < ids.length) continue; newList.add(this.personlist[j]);
      }
      this.personlist = new PersonBO[newList.size()];
      for (int j = 0; j < newList.size(); j++) {
        this.personlist[j] = ((PersonBO)newList.get(j));
      }
    }
    getHttpSession().setAttribute(Constants.SELPERSON_SESSION, this.personlist);
    return "";
  }
  public String selPerson() {
    try {
      this.personlist = ((PersonBO[])(PersonBO[])getHttpSession().getAttribute(Constants.SELPERSON_SESSION));
      if (this.personlist != null) {
        this.personlist = ((PersonBO[])(PersonBO[])CodeUtil.codeInterpret(this.personlist, "sex,orgId,deptId", "CODE,OU,OU"));
      }
      getServletRequest().setAttribute("flag", "show");
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String queryOldSuper() {
    if ((this.changeOrg != null) && (!"".equals(this.changeOrg.trim()))) {
      OrgBO org = SysCacheTool.findOrgById(this.changeOrg);
      if (org != null) {
        OrgBO superorg = SysCacheTool.findOrgById(org.getSuperId());
        if (superorg != null) {
          this.oldSuper = superorg.getName();
        }
      }
    }
    return null;
  }
}