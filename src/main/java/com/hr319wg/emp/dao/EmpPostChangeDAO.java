package com.hr319wg.emp.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.OrgPostChangeBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class EmpPostChangeDAO extends BaseDAO
{
  public List findAllEmpPostChangeBO(String personID)
    throws SysException
  {
    String hql = "select bo from EmpPostChangeBO bo where bo.personId='" + personID + "' order by bo.applyDate desc";
    return this.hibernatetemplate.find(hql);
  }

  public List findAllEmpPostChangeBO(PageVO pagevo, String orgId, User user, String name, List statuses, String time, String time2) throws SysException {
    String hql = "from EmpPostChangeBO bo,UserBO u where bo.personId=u.userID";
    OrgBO org=SysCacheTool.findOrgById(orgId);
    hql+=" and u.deptSort like '"+org.getTreeId()+"%'";
    if ((name != null) && (!"".equals(name))) {
      hql += " and ( u.name like '%" + name + "%' or u.shortName like '%" + name + "%' or u.personSeq like '%" + name + "%') ";
    }
    if ((statuses != null) && (statuses.size() > 0)) {
    	String[]status1= (String[]) statuses.toArray(new String[0]);
    	hql+=" and "+CommonFuns.splitInSql(status1, "bo.status");
    }

    if ((time != null) && (!time.equals(""))) {
      hql = hql + " and bo.hrValidDate >='" + time + "'";
    }
    if ((time2 != null) && (!time2.equals(""))) {
      hql = hql + " and bo.hrValidDate <= '" + time2 + "'";
    }
    
    List noList = user.getHaveNoOperateOrgScale();
	String where = "";
	if(noList!=null && noList.size()>0){
		for (int i = 0; i < noList.size(); i++) {
			OrgBO b = (OrgBO) noList.get(i);
			if ("".equals(where)) {
				where = "u.deptSort not like '" + b.getTreeId() + "%'";
			} else {
				where += " and u.deptSort not like '" + b.getTreeId() + "%'";
			}
		}
		hql += " and ("+where+")";
	}
	
	String counthql = "select count(*) "+hql;
    hql = "select bo "+hql+" order by bo.hrValidDate desc,u.deptSort";
    return pageQuery(pagevo, counthql, hql);
  }
  public void updateOrgPostChangeBO(OrgPostChangeBO bo) throws SysException {
    this.hibernatetemplate.update(bo);
  }
  public List findAllEmpPostChangeBO(PageVO pagevo, String orgId, String operId, boolean sellApply) throws SysException {
    OrgBO orgbo = SysCacheTool.findOrgById(orgId);
    String status = sellApply ? "('0','1','2')" : "('0')";
    String hql = "select bo from EmpPostChangeBO bo where bo.personId in (select vo.personId from PersonBO vo where vo.deptTreeId like '%" + orgbo.getTreeId() + "%')";
    String counthql = "select count(bo) from EmpPostChangeBO bo where bo.personId in (select vo.personId from PersonBO vo where vo.deptTreeId like '%" + orgbo.getTreeId() + "%')";
    if ("1352".equals(operId)) {
      hql = hql + " and bo.auditResult in " + status;
      counthql = counthql + " and bo.auditResult in " + status;
    }
    else if ("1353".equals(operId)) {
      hql = hql + " and bo.auditResult1 in " + status;
      counthql = counthql + " and bo.auditResult1 in " + status;
    }
    else if ("1354".equals(operId)) {
      hql = hql + " and bo.auditResult2 in " + status;
      counthql = counthql + " and bo.auditResult2 in " + status;
    }
    else if ("1377".equals(operId)) {
      hql = hql + " and bo.auditResult3 in " + status;
      counthql = counthql + " and bo.auditResult3 in " + status;
    }
    else if ("1378".equals(operId)) {
      hql = hql + " and bo.auditResult4 in " + status;
      counthql = counthql + " and bo.auditResult4 in " + status;
    }
    else if ("1379".equals(operId)) {
      hql = hql + " and bo.auditResult5 in " + status;
      counthql = counthql + " and bo.auditResult5 in " + status;
    }

    return pageQuery(pagevo, counthql, hql);
  }
}