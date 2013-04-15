package com.hr319wg.custom.extend.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.wage.dao.WageSetDAO;

public class WageSetDAOByExtend extends WageSetDAO {

	public List queryAllSet() throws SysException {
		String hql="select set from WageSetBO set,OrgBO org where set.unitId=org.orgId order by org.orgSort,set.showseq";
		return this.hibernatetemplate.find(hql);
	}

	public List queryAllSet(User user) throws SysException {
		List list = user.getHaveOperateOrgScale();
		if ((list == null) || (list.size() == 0))
			return new ArrayList();
		String condition = " 1=0 ";
		for (int i = 0; i < list.size(); i++) {
			OrgBO bo = (OrgBO) list.get(i);
			condition = condition + " or o.treeId like '" + bo.getTreeId() + "%'";
		}
		PersonBO pb = SysCacheTool.findPersonById(user.getUserId());
		if ((pb != null) && (pb.getGongZiGX() != null)) {
			condition = condition + " or o.orgId='" + pb.getGongZiGX() + "'";
		}
		String sql = "select bo from WageSetBO bo,OrgBO org where bo.unitId=org.orgId and bo.unitId in (select o.orgId from OrgBO o where "+ condition + " ) order by org.orgSort,bo.showseq";
		return this.hibernatetemplate.find(sql);
	}
}
