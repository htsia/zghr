package com.hr319wg.sys.dao;

import java.util.List;

import com.hr319wg.common.exception.SysException;

public class RemResultSpring3DAO extends RemResultDAO {

	public boolean findIsRemindResultExist(String orguid, String RemindId)
			throws SysException {
		List tlist;
		String strHQL = "";
		if (orguid == null || "".equals(orguid))
			strHQL = (new StringBuilder()).append(
					"select count(*) from RemResultBO rrbo where rrbo.remId='")
					.append(RemindId).append("'").toString();
		else
			strHQL = (new StringBuilder()).append(
					"select count(*) from RemResultBO rrbo where rrbo.remId='")
					.append(RemindId).append("' and rrbo.orguid='").append(
							orguid).append("'").toString();
		tlist = hibernatetemplate.find(strHQL);
		if (tlist == null || tlist.isEmpty())
			return false;
	    int tt =  Integer.valueOf(String.valueOf(tlist.get(0))) ;
		if (tt == 0)
			return false;
		return true;
	}

}
