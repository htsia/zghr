package com.hr319wg.rpt.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;

public class RptSetUserDAO extends BaseDAO {
	public List getRptList(String roleID) throws SysException {
		String sql = "select bo from RptSetUserBO bo where bo.roleID='" + roleID + "'";
		return this.hibernatetemplate.find(sql);
	}

	public boolean checkRptSetUserBO(String roleID, String rptSetID)
			throws SysException {
		String sql = "select bo from RptSetUserBO bo where bo.roleID='" + roleID + "' and bo.setId='" + rptSetID + "'";
		List list = this.hibernatetemplate.find(sql);
		return (list == null) || (list.size() == 0);
	}
}