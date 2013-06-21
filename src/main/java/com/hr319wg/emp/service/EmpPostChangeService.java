package com.hr319wg.emp.service;

import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.dao.EmpPostChangeDAO;
import com.hr319wg.emp.pojo.bo.EmpPostChangeBO;
import com.hr319wg.emp.pojo.bo.OrgPostChangeBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.portal.IUUManager;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class EmpPostChangeService implements IWFFunction
{
  private EmpPostChangeDAO emppostchangeDao;
  private ActivePageAPI activeapi;
  private PersonService personservice;

  public PersonService getPersonservice()
  {
    return this.personservice;
  }

  public void setPersonservice(PersonService personservice) {
    this.personservice = personservice;
  }

  public List findAllEmpPostChangeBO(String personID)
    throws SysException
  {
    return this.emppostchangeDao.findAllEmpPostChangeBO(personID); }

  public List findAllEmpPostChangeBO(PageVO pagevo, String orgId, User user, String name, List status, String time, String time2) throws SysException {
    return this.emppostchangeDao.findAllEmpPostChangeBO(pagevo, orgId, user, name, status, time, time2); }

  public List findAllEmpPostChangeBO(PageVO pagevo, String orgId, String operId, boolean sellApply) throws SysException {
    return this.emppostchangeDao.findAllEmpPostChangeBO(pagevo, orgId, operId, sellApply); }

  public EmpPostChangeBO findEmpPostChangeBOById(String changId) throws SysException {
    return ((EmpPostChangeBO)this.emppostchangeDao.findBoById(EmpPostChangeBO.class, changId)); }

  public void saveEmpPostChangeBO(EmpPostChangeBO bo) throws SysException {
    this.emppostchangeDao.saveOrUpdateBo(bo); }

  public void deleteEmpPostChangeBO(String changeId) throws SysException {
    this.emppostchangeDao.deleteBo(EmpPostChangeBO.class, changeId); }

  public void saveOrgPostChangeBO(OrgPostChangeBO bo) throws SysException {
    this.emppostchangeDao.createBo(bo); }

  public void updateOrgPostChangeBO(OrgPostChangeBO bo) throws SysException {
    this.emppostchangeDao.updateOrgPostChangeBO(bo); }

  public OrgPostChangeBO findOrgPostChangeBO(String orgId) throws SysException {
    return ((OrgPostChangeBO)this.emppostchangeDao.findBoById(OrgPostChangeBO.class, orgId)); }

  public void personMessageChange(User user, EmpPostChangeBO bo) throws SysException {
    String now = bo.getHrValidDate();

    String xt = "";
    String orgTreeid = "";
    String xtName = "";

    OrgBO orgx = null;
    String deptName = "";
    String postName = "";

    String depTreeid = "";
    String sql = "";

    if ((bo.getNewDept() != null) && (!(bo.getNewDept().equals("")))) {
      OrgBO newDeptBO = SysCacheTool.findOrgById(bo.getNewDept());
      if (OrgBO.GROUPTYPE.equals(newDeptBO.getorgType())) {
//        sql = "update A001 set A001706 = '" + newDeptBO.getOrgId() + "' where  id='" + bo.getPersonId() + "'";
//        this.activeapi.executeSql(sql);
        orgx = OrgTool.getDeptByGroup(bo.getNewDept());
      }
      else {
//        sql = "update A001 set A001706 = '' where  id='" + bo.getPersonId() + "'";
//        this.activeapi.executeSql(sql);
        orgx = SysCacheTool.findOrgById(bo.getNewDept());
      }

      OrgBO superOrg = OrgTool.getOrgByDept(bo.getNewDept());
      if (superOrg != null) {
        xt = superOrg.getOrgId();
        orgTreeid = superOrg.getTreeId();
        xtName = superOrg.getName();
      }

      if (orgx != null) {
        depTreeid = orgx.getTreeId();
        PersonBO pb = SysCacheTool.findPersonById(bo.getPersonId());
        sql = "insert into B733(orguid,subid,b733000,b733001,b733702,b733700,b733701) values('" + xt + "','" + CommonFuns.filterNull(SequenceGenerator.getKeyId("B733")) + "','" + "00900" + "','" + bo.getPersonId() + "','" + now + "','" + SysCacheTool.findOrgById(pb.getDeptId()).getName() + "','" + orgx.getName() + "')";
        this.activeapi.executeSql(sql);

        sql = "update A001 set A001701 = '" + xt + "',A001705='" + orgx.getOrgId() + "',A001728='" + orgTreeid + "',A001738='" + depTreeid + "' where  id='" + bo.getPersonId() + "'";
        this.activeapi.executeSql(sql);
        deptName = orgx.getName();
      }
    }

    if ((bo.getNewPost() != null) && (!(bo.getNewPost().equals("")))) {
      sql = "update a001 set A001715='" + bo.getNewPost() + "' where id='" + bo.getPersonId() + "'";
      PostBO post = SysCacheTool.findPost(bo.getNewPost());
      if (post != null)
        postName = post.getName();

      this.activeapi.executeSql(sql);
    }
    this.personservice.synDeptInfo(bo.getPersonId());

    //岗位变化子集
    sql = "update A017 set A017000='00900' where id='" + bo.getPersonId() + "'";
    this.activeapi.executeSql(sql);
    
    OrgBO superOldOrg = OrgTool.getOrgByDept(bo.getOldDept());
    String oldOrgID="";
    if(superOldOrg!=null){
    	oldOrgID=superOldOrg.getOrgId();
    }
    sql = "insert into A017(subid,id,a017000,a017015,a017702,a017705,a017710,a017801,A017005,A017701,A017715,A017720,A017200,A017201) values" +
    		"('" + SequenceGenerator.getKeyId("A017") + "','" + bo.getPersonId() + "','00901','" + now + "','" + CommonFuns.filterNull(bo.getNewPost()) + "'," +
    				"'" + bo.getOldDept() + "','" + bo.getNewDept() + "','" + CommonFuns.filterNull(bo.getOldPost()) + "','" + CommonFuns.filterNull(bo.getChangeType()) + "'," +
    						"'" + CommonFuns.filterNull(bo.getChangeReason()) + "','" + CommonFuns.filterNull(bo.getChangeBase()) + "','" + CommonFuns.filterNull(bo.getChangeLetterNO()) + "','"+CommonFuns.filterNull(xt)+"','"+CommonFuns.filterNull(oldOrgID)+"')";

    this.activeapi.executeSql(sql);

    //任职情况子集
    if ((bo.getNewJob() != null) && (!(bo.getNewJob().equals("")))) {
      sql = "update a705 set a705000='00900' where id='" + bo.getPersonId() + "' and a705000='00901'";
      this.activeapi.executeSql(sql);

      sql = "insert into a705(subid,id,a705000,a705705,a705722) values('" + SequenceGenerator.getKeyId("A705") + "','" + bo.getPersonId() + "','00901','" + bo.getNewJob() + "','" + now + "')";
      this.activeapi.executeSql(sql);
    }

    //简历子集
    if ("1".equals(bo.getAddResume())) {
      sql = "update a019 set a019000='00900',a019010='" + now + "' where id='" + bo.getPersonId() + "' and a019000='00901'";
      this.activeapi.executeSql(sql);

      sql = "insert into a019(subid,id,a019000,a019005,a019705,A019015,A019020,A019025,A019700) values('" + SequenceGenerator.getKeyId("A019") + "','" + bo.getPersonId() + "','00901','" + now + "','" + CodeUtil.interpertCode(bo.getNewJob()) + "','" + xtName + deptName + "','" + postName + "','" + user.getName() + "','" + CodeUtil.interpertCode(bo.getChangeType()) + "')";
      this.activeapi.executeSql(sql);
    }

    if (!("".equals(Constants.UUM_SERVICE_NAME)))
      try {
        IUUManager uumanager = (IUUManager)SysContext.getBean(Constants.UUM_SERVICE_NAME);
        if (uumanager != null)
        {
          String[] id = new String[1];
          id[0] = bo.getPersonId();
          SysCache.setMap(id, 2, 6);
          uumanager.userModify(bo.getPersonId(), user.getUserId(), "1");
        }
      }
      catch (Exception e)
      {
      }
  }

  public EmpPostChangeDAO getEmppostchangeDao()
  {
    return this.emppostchangeDao;
  }

  public void setEmppostchangeDao(EmpPostChangeDAO emppostchangeDao) {
    this.emppostchangeDao = emppostchangeDao; }

  public ActivePageAPI getActiveapi() {
    return this.activeapi; }

  public void setActiveapi(ActivePageAPI activeapi) {
    this.activeapi = activeapi; }

  public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine) throws SysException {
    EmpPostChangeBO pb = findEmpPostChangeBOById(wt.getLinkID());
    if (pb == null) return false;
    String sql = wfdefine.getSql();
    if ((sql == null) || ("".equals(sql))) return true;
    sql = sql.replaceAll("\\$K\\$", pb.getPersonId());
    String con = this.activeapi.queryForString(sql);

    return (wfdefine.getConValue().indexOf(con) >= 0);
  }

  public void whenStart(WFTransaction wt)
    throws SysException
  {
  }

  public void whenEnd(WFTransaction wt) throws SysException
  {
    EmpPostChangeBO pb;
    if ("1".equals(wt.getStatusValue())) {
      pb = findEmpPostChangeBOById(wt.getLinkID());
      pb.setStatus(EmpPostChangeBO.APPROVED);
      saveEmpPostChangeBO(pb);
    }
    else if ("2".equals(wt.getStatusValue())) {
      pb = findEmpPostChangeBOById(wt.getLinkID());
      pb.setStatus(EmpPostChangeBO.REFUSE);
      saveEmpPostChangeBO(pb); }
  }

  public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException {
    EmpPostChangeBO pb = findEmpPostChangeBOById(wt.getLinkID());
    if (pb != null) {
      if ("1352".equals(node.getOperID())) {
        pb.setAuditResult("0");
      }
      else if ("1353".equals(node.getOperID())) {
        pb.setAuditResult1("0");
      }
      else if ("1354".equals(node.getOperID())) {
        pb.setAuditResult2("0");
      }
      else if ("1377".equals(node.getOperID())) {
        pb.setAuditResult3("0");
      }
      else if ("1378".equals(node.getOperID())) {
        pb.setAuditResult4("0");
      }
      else if ("1379".equals(node.getOperID()))
        pb.setAuditResult5("0");

      saveEmpPostChangeBO(pb);
    }
  }
}