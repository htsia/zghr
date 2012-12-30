package com.hr319wg.org.web;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.pojo.vo.OrgChangeVO;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class OrgUniteBackingBean extends BaseBackingBean
{
  private String uniteOrgId;
  private String orgId;
  private PersonBO[] personlist;
  private OrgChangeVO orgchangevo = new OrgChangeVO();
  private IOrgUCC orgucc;

  public String getUniteOrgId()
  {
    return this.uniteOrgId;
  }

  public void setUniteOrgId(String uniteOrgId) {
    this.uniteOrgId = uniteOrgId;
  }

  public String getOrgId() {
    return this.orgId;
  }

  public void setOrgId(String orgId) {
    this.orgId = orgId;
  }

  public IOrgUCC getOrgucc() {
    return this.orgucc;
  }

  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public OrgChangeVO getOrgchangevo() {
    if ((this.orgchangevo != null) && (
      (this.orgchangevo.getChangeType() == null) || (!"".equals(this.orgchangevo.getChangeType().trim())))) {
      this.orgchangevo.setChangeType("08907");
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

	public String saveUnite() {
		String[] orgs = { this.uniteOrgId };
		OrgBO bo = SysCacheTool.findOrgById(this.uniteOrgId);
		try {
			this.orgucc.checkOrgSubOrg(orgs);
		} catch (SysException e) {
			super.showMessageDetail("被合并机构有子部门");
			return null;
		}
		String[] ids = getServletRequest().getParameterValues("chk");
		try {
			this.orgucc.updateOrgUnite(this.uniteOrgId, super.getUserInfo(),
					this.orgId, this.orgchangevo, ids);
			SysCache.setMap(new String[] { this.uniteOrgId }, 3, 5);
			//同步财务系统,添加一条机构合并记录
			SqlUtil.updateData("insert into b001_bd (change_date,change_type,old_mainDeptID,new_mainDeptID,dept_id,dept_type,dept_name,appendToDeptID) values " +
		      					"(getdate(),'合并','"+bo.getSuperId()+"','"+bo.getSuperId()+"','"+bo.getOrgId()+"','"+("089110".equals(bo.getorgType())?"单位":"部门")+"','"+bo.getName()+"','"+this.orgId+"')");
			//增加人员变动信息
			SqlUtil.updateData("insert into a001_bd (user_id,change_date,change_type,old_dept_id,new_dept_id,user_type,name,user_code) " +
					"select id,getdate(),'部门变动','"+bo.getOrgId()+"' dept,'"+this.orgId+"',a001054,a001001,a001735 from a001 where a001705='"+bo.getOrgId()+"'");			
			//人员信息修改
			SqlUtil.updateData("update a001 set a001705='"+this.orgId+"' where a001705='"+bo.getOrgId()+"'");
			//删除被合并部门
			SqlUtil.updateData("delete from b001 where id='"+bo.getOrgId()+"'");
			
			this.uniteOrgId = null;
			this.orgId = null;
			this.orgchangevo = null;
			showMessageDetail("机构合并成功");
		} catch (SysException e) {
			super.showMessageDetail(e.getMessage());
		}
		return null;
	}

  public String selPerson()
  {
    try
    {
      this.personlist = ((PersonBO[])(PersonBO[])getHttpSession().getAttribute(Constants.SELPERSON_SESSION));
      this.personlist = ((PersonBO[])(PersonBO[])CodeUtil.codeInterpret(this.personlist, "sex,orgId,deptId", "CODE,OU,OU"));
      getServletRequest().setAttribute("flag", "show");
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }
}