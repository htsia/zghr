package com.hr319wg.custom.emp.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class EmpTypeChangeDAO extends BaseDAO{

	public List getEmpTypeChangeBO(PageVO pagevo, String orgId, User user,
			String name, boolean apprived, String time, String time2)
			throws SysException {
		String hql = "from EmpPersonTypeChangeBO bo,UserBO u where bo.personID=u.userID";
	    OrgBO org=SysCacheTool.findOrgById(orgId);
	    hql+=" and u.deptSort like '"+org.getTreeId()+"%'";
	    if ((name != null) && (!"".equals(name))) {
	      hql += " and ( u.name like '%" + name + "%' or u.shortName like '%" + name + "%' or u.personSeq like '%" + name + "%') ";
	    }
	    
	    if(apprived){
	    	hql+=" and bo.status in ('0', '1')";
	    }else{
	    	hql+=" and bo.status ='0'";	    	
	    }

	    if ((time != null) && (!time.equals(""))) {
	      hql = hql + " and bo.changeDate >='" + time + "'";
	    }
	    if ((time2 != null) && (!time2.equals(""))) {
	      hql = hql + " and bo.changeDate <= '" + time2 + "'";
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
		
		String counthql = "select count(bo) "+hql;
	    hql = "select bo "+hql+" order by bo.changeDate desc,u.deptSort";
	    return pageQuery(pagevo, counthql, hql);
	}
}
