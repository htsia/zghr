package com.hr319wg.user.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.ucc.IPortalFunUCC;
import com.hr319wg.user.pojo.bo.AgentBO;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.ucc.IRoleManageUCC;
import com.hr319wg.user.ucc.IUserManageUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class UserPmsManagerBackingBean extends BaseBackingBean
{
  private String ConsQueryType = "querytype2";
  private IUserManageUCC usermanageucc;
  private IRoleManageUCC rolemanageucc;
  private IPortalFunUCC portalfunucc;
  private List personList;
  private String selOrgId;
  private String condiValue;
  private String condiType;
  private String queryType;
  private String selRoleId;
  private String orgId;
  private String personType;
  private String personTypeDes;
  private String personID;
  private String personName;
  private String initAgent;
  private String itemID;
  private PersonBO person = new PersonBO();
  private List agentList;
  private PageVO pagevo = new PageVO();
  private boolean canAgent;

  public PageVO getPagevo()
  {
    return this.pagevo;
  }

  public void setPagevo(PageVO pagevo) {
    this.pagevo = pagevo;
  }

  public boolean isCanAgent()
  {
    this.canAgent = "1".equals(Constants.CAN_SET_AGENT);
    return this.canAgent;
  }
  public void setCanAgent(boolean canAgent) {
    this.canAgent = canAgent;
  }

  public String getPersonTypeDes()
  {
    if ((this.personType == null) || ("".equals(this.personType))) {
      this.personTypeDes = "全部人员";
    }
    else {
      this.personTypeDes = "";
      String[] str = this.personType.split(",");
      for (int i = 0; i < str.length; i++) {
        this.personTypeDes = (this.personTypeDes + " " + CodeUtil.interpertCode("0135", str[i]));
      }
    }
    return this.personTypeDes;
  }
  public void setPersonTypeDes(String des) {
    this.personTypeDes = des;
  }

  public String getItemID() {
    return this.itemID;
  }
  public void setItemID(String id) {
    this.itemID = id;
  }

  public String addAgent() {
    try {
      AgentBO ab = new AgentBO();
      ab.setPersonID(this.personID);
      ab.setAgentID(this.person.getPersonId());
      ab.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      if (!this.usermanageucc.checkDup(ab)) {
        this.usermanageucc.SaveAgentSet(ab);
      }
    }
    catch (Exception e)
    {
    }
    return null;
  }
  public String Delete() {
    try {
      this.usermanageucc.DeleteAgentSet(this.itemID);
    }
    catch (Exception e)
    {
    }
    return null;
  }
  public String getInitAgent() {
    if (super.getRequestParameter("personId") != null) {
      this.person = SysCacheTool.findPersonById(super.getRequestParameter("personId"));
    }
    return this.initAgent;
  }
  public void setInitAgent(String id) {
    this.initAgent = id;
  }

  public PersonBO getPerson() {
    return this.person;
  }
  public void setPerson(PersonBO pb) {
    this.person = pb;
  }

  public void setPersonName(String name) {
    this.personName = name;
  }
  public String getPersonName() {
    return this.personName;
  }

  public void setPersonID(String id) {
    this.personID = id;
  }
  public String getPersonID() {
    return this.personID;
  }

  public List getAgentList() {
    try {
      this.agentList = this.usermanageucc.getAgentPerson(this.person.getPersonId());
      for (int i = 0; i < this.agentList.size(); i++) {
        AgentBO ab = (AgentBO)this.agentList.get(i);
        PersonBO pb = SysCacheTool.findPersonById(ab.getPersonID());
        ab.setPersonName(pb.getName());
        ab.setPersonCode(pb.getPersonCode());
      }
    }
    catch (Exception e) {
      this.agentList = new ArrayList();
    }
    return this.agentList;
  }
  public void setAgentList(List list) {
    this.agentList = list;
  }

  public String getPersonType() {
    return this.personType;
  }

  public void setPersonType(String personType) {
    this.personType = personType;
  }

  public String getOrgId() {
    return this.orgId;
  }

  public void setOrgId(String orgId) {
    this.orgId = orgId;
  }

  public IRoleManageUCC getRolemanageucc() {
    return this.rolemanageucc;
  }

  public void setRolemanageucc(IRoleManageUCC rolemanageucc) {
    this.rolemanageucc = rolemanageucc;
  }

  public String getQueryType() {
    return this.queryType;
  }

  public void setQueryType(String queryType) {
    this.queryType = queryType;
  }

  public String getSelOrgId() {
    return this.selOrgId;
  }

  public void setSelOrgId(String selOrgId) {
    this.selOrgId = selOrgId;
  }

  public String getSelRoleId() {
    return this.selRoleId;
  }

  public void setSelRoleId(String selRoleId) {
    this.selRoleId = selRoleId;
  }

  public String getCondiValue() {
    return this.condiValue;
  }

  public void setCondiValue(String condiValue) {
    this.condiValue = condiValue;
  }

  public String getCondiType() {
    return this.condiType;
  }

  public void setCondiType(String condiType) {
    this.condiType = condiType;
  }

  public List getPersonList() {
    return this.personList;
  }

  public void setPersonList(List personList) {
    this.personList = personList;
  }

  public IUserManageUCC getUsermanageucc() {
    return this.usermanageucc;
  }

  public void setUsermanageucc(IUserManageUCC usermanageucc) {
    this.usermanageucc = usermanageucc;
  }

  public String getPageInit()
  {
    try {
      HttpServletRequest request = super.getServletRequest();
      if (request.getParameter("personType") != null) {
        this.personType = request.getParameter("personType");
      }
      String tmporg = request.getParameter("orgId");
      if ((tmporg != null) && (!"".equals(tmporg))) {
        this.orgId = tmporg;
        doQuery();
      }
    }
    catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return this.pageInit;
  }

  public String doQuery() {
    try {
      this.condiValue = CommonFuns.filterNull(this.condiValue);
      String treeId = "";
      if ((this.orgId != null) && (!this.orgId.equals(""))) {
        OrgBO org = SysCacheTool.findOrgById(this.orgId);
        treeId = org.getTreeId();
      }
      User user = super.getUserInfo();

      if (this.pagevo.getCurrentPage() == 0) this.pagevo.setCurrentPage(1);
      if ("personName".equals(this.condiType))
        this.personList = this.usermanageucc.queryUserPmsInfo(this.condiValue, "", treeId, this.pagevo, this.personType, querySysRoleId(), user, true);
      else {
        this.personList = this.usermanageucc.queryUserPmsInfo("", this.condiValue, treeId, this.pagevo, this.personType, querySysRoleId(), user, true);
      }
    }
    catch (Exception e)
    {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String first() {
    this.pagevo.setCurrentPage(1);
    doQuery();
    return null;
  }
  public String last() {
    this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
    doQuery();
    return null;
  }
  public String pre() {
    if (this.pagevo.getCurrentPage() >= 2) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
      doQuery();
    }
    return null;
  }
  public String next() {
    if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
      doQuery();
    }
    return null;
  }

  private String querySysRoleId()
    throws SysException
  {
    List<RoleInfoBO> list= this.usermanageucc.queryUserRoleInfo(super.getUserInfo().getUserId());
    boolean isMAJORDOMO=false;
	String sysRoleId=null;
	for(RoleInfoBO r : list){
		if(r.getRoleId().equals(RoleInfoBO.MAJORDOMO_ROLE_ID)){
			isMAJORDOMO=true;
			sysRoleId=r.getRoleId();
			break;
		}
	}
	if(sysRoleId==null){
		sysRoleId=list.get(0).getRoleId();
	}
    return sysRoleId;
  }

  public String assignAgent() {
    try {
      String[] ids = this.selRoleId.split(",");
      HttpServletRequest request = super.getServletRequest();
      String[] userids = request.getParameterValues("selectItem");
      if ((ids != null) && (ids.length > 0) && (userids != null) && (userids.length > 0))
      {
        String[] items = ids[0].split(":");
        String sysOperFlag = items[1];

        for (int i = 0; i < ids.length; i++) {
          ids[i] = ids[i].split(":")[0];
        }
        this.usermanageucc.assignRole(userids, ids);
      }
      doQuery();
    }
    catch (SysException e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String assignSelfOper()
  {
    try
    {
      String[] userids = super.getServletRequest().getParameterValues("selectItem");
      if ((userids != null) && (userids.length > 0))
        this.usermanageucc.saveUserSelf(userids[0], this.selRoleId);
    }
    catch (SysException e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String batchAssignPortal() {
    try {
      String[] ids = this.selRoleId.split(",");
      HttpServletRequest request = super.getServletRequest();
      String[] userids = request.getParameterValues("selectItem");
      if ((ids != null) && (ids.length > 0) && (userids != null) && (userids.length > 0))
        this.portalfunucc.batchAssign(userids, ids);
    }
    catch (SysException e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String assignRole() {
    try {
      String[] ids = this.selRoleId.split(",");
      HttpServletRequest request = super.getServletRequest();
      String[] userids = request.getParameterValues("selectItem");
      if ((ids != null) && (ids.length > 0) && (userids != null) && (userids.length > 0))
      {
        String[] items = ids[0].split(":");
        String sysOperFlag = items[1];

        for (int i = 0; i < ids.length; i++) {
          ids[i] = ids[i].split(":")[0];
        }
        this.usermanageucc.assignRole(userids, ids);
      }
      doQuery();
    } catch (SysException e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String clearRole()
  {
    try
    {
      HttpServletRequest request = super.getServletRequest();
      String[] userids = request.getParameterValues("selectItem");
      if (userids == null) return null;
      this.usermanageucc.clearRole(userids);
      doQuery();
    }
    catch (SysException e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public IPortalFunUCC getPortalfunucc() {
    return this.portalfunucc;
  }
  public void setPortalfunucc(IPortalFunUCC portalfunucc) {
    this.portalfunucc = portalfunucc;
  }
}