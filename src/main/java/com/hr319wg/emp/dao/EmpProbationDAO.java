package com.hr319wg.emp.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class EmpProbationDAO extends BaseDAO
{
  public List getMyProbation(String personID)
    throws SysException
  {
    String hsql = "select bo from EmpProbationBO bo where bo.personId='" + personID + "'";
    return this.hibernatetemplate.find(hsql);
  }
  public List findNoPassPerson(PageVO pagevo, String orgId, List statuses, String time1, String time2, String name) throws SysException {
    String hql = "select bo from EmpProbationBO bo,UserBO u where bo.personId=u.id and bo.personId in (select vo.personId from PersonBO vo where vo.orgId='" + orgId + "' ";
    String counthql = "select count(bo) from EmpProbationBO bo where bo.personId in(select vo.personId from PersonBO vo where vo.orgId='" + orgId + "'";
    if ((name != null) && (!"".equals(name))) {
      hql = hql + " and ( vo.name like '%" + name + "%' or vo.shortName like '%" + name + "%' or vo.personCode like '%" + name + "%') ";
      counthql = counthql + " and ( vo.name like '%" + name + "%' or vo.shortName like '%" + name + "%' or vo.personCode like '%" + name + "%') ";
    }
    hql = hql + " )";
    counthql = counthql + " )";
    if ((statuses != null) && (statuses.size() > 0)) {
      for (int i = 0; i < statuses.size(); i++) {
        String status = (String)statuses.get(i);
        if (statuses.size() == 1) {
          hql = hql + " and bo.status='" + status + "'";
          counthql = counthql + " and bo.status='" + status + "'";
        }
        else if (i == 0) {
          hql = hql + " and (bo.status='" + status + "'";
          counthql = counthql + " and (bo.status='" + status + "'";
        } else if (i == statuses.size() - 1) {
          hql = hql + " or bo.status='" + status + "')";
          counthql = counthql + " or bo.status='" + status + "')";
        } else {
          hql = hql + " or bo.status='" + status + "'";
          counthql = counthql + " or bo.status='" + status + "'";
        }
      }
    }

    if ((time1 != null) && (!time1.equals(""))) {
      hql = hql + " and bo.planPassDate >= '" + time1 + "'";
      counthql = counthql + " and bo.planPassDate >= '" + time1 + "'";
    }
    if ((time2 != null) && (!time2.equals(""))) {
      hql = hql + " and bo.planPassDate <= '" + time2 + "'";
      counthql = counthql + " and bo.planPassDate <= '" + time2 + "'";
    }
    hql+=" order by u.comeDate desc";
    return pageQuery(pagevo, counthql, hql);
  }
  public List findAllPerson(PageVO pagevo, String orgId, String operId, boolean selall, String filter) throws SysException {
    OrgBO orgbo = SysCacheTool.findOrgById(orgId);
    String hql = "select bo from EmpProbationBO bo where bo.personId in (select vo.personId from PersonBO vo where vo.deptTreeId like '%" + orgbo.getTreeId() + "%')";
    String counthql = "select count(bo) from EmpProbationBO bo where bo.personId in (select vo.personId from PersonBO vo where vo.deptTreeId like '%" + orgbo.getTreeId() + "%')";
    if ((filter != null) && (!"".equals(filter))) {
      hql = "select bo from EmpProbationBO bo where bo.personId in (select vo.personId from PersonBO vo where vo.deptTreeId like '%" + orgbo.getTreeId() + "%' and " + filter + ")";
      counthql = "select count(bo) from EmpProbationBO bo where bo.personId in (select vo.personId from PersonBO vo where vo.deptTreeId like '%" + orgbo.getTreeId() + "%' and " + filter + ")";
    }
    String status = selall ? "('0','1','2')" : "('0')";
    if ("0347".equals(operId)) {
      hql = hql + " and bo.auditResult in " + status;
      counthql = counthql + " and bo.auditResult in " + status;
    }
    else if ("0348".equals(operId)) {
      hql = hql + " and bo.auditResult2 in " + status;
      counthql = counthql + " and bo.auditResult2 in " + status;
    }
    else if ("0349".equals(operId)) {
      hql = hql + " and bo.auditResult3 in " + status;
      counthql = counthql + " and bo.auditResult3 in " + status;
    }
    else if ("0352".equals(operId)) {
      hql = hql + " and bo.auditResult4 in " + status;
      counthql = counthql + " and bo.auditResult4 in " + status;
    }
    else if ("0353".equals(operId)) {
      hql = hql + " and bo.auditResult5 in " + status;
      counthql = counthql + " and bo.auditResult5 in " + status;
    }
    else if ("0354".equals(operId)) {
      hql = hql + " and bo.auditResult6 in " + status;
      counthql = counthql + " and bo.auditResult6 in " + status;
    }
    return pageQuery(pagevo, counthql, hql);
  }
  public List getAllProbationStatusPerson(String orgId, String status) throws SysException {
    String hql = "select bo from EmpProbationBO bo where "+CommonFuns.splitInSql(status.split(","), "bo.status")+" and bo.personId in(select vo.personId from PersonBO vo where vo.orgId='" + orgId + "')";
    return this.hibernatetemplate.find(hql);
  }
  public List getAllProbationPersonForPageByStatus(PageVO mypage, String orgId, String status) throws SysException {
    String hql = "select bo from EmpProbationBO bo where bo.status='" + status + "' and bo.personId in(select vo.personId from PersonBO vo where vo.orgId='" + orgId + "')";
    String counthql = "select count(bo) from EmpProbationBO bo where bo.status='" + status + "' and bo.personId in(select vo.personId from PersonBO vo where vo.orgId='" + orgId + "')";
    return pageQuery(mypage, counthql, hql);
  }
  public List getAllProbationWage(PageVO pagevo, String personId) throws SysException {
    String hql = "select bo from EmpProbationWageBO bo where bo.personId='" + personId + "'";
    String counthql = "select count(bo) from EmpProbationWageBO bo where bo.personId='" + personId + "'";
    return pageQuery(pagevo, counthql, hql);
  }

  public List getAllProbationWageByPid(String personId) throws SysException {
    String hql = "select bo from EmpProbationWageBO bo where bo.personId='" + personId + "'";
    return this.hibernatetemplate.find(hql);
  }
}