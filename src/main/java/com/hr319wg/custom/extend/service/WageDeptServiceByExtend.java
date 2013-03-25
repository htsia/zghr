package com.hr319wg.custom.extend.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.wage.pojo.bo.WageDeptBO;
import com.hr319wg.wage.service.WageDeptService;

public class WageDeptServiceByExtend extends WageDeptService {

	public void updateData(String itemID) throws SysException {
		WageDeptBO deptbo = (WageDeptBO) this.getWagedeptdao().findBoById(WageDeptBO.class, itemID);
		if ((deptbo != null) && (deptbo.getLinkOrgs() != null) && (!"".equals(deptbo.getLinkOrgs())) && (deptbo.getName() != null)) {
			String sql = "update a001 set A001743='"+ deptbo.getName()+ "' where a001705 in (select b.orguid from b001 b,b001 b2 where b.b001003 like b2.b001003 || '%' and b2.orguid in ("+deptbo.getLinkOrgs()+"))" +
					" and (id in (select id from wage_set_pers_r where a815700='"+deptbo.getSetID()+"') or id in (select id from wage_set_pers_r_bak where a815700='"+deptbo.getSetID()+"'))";
			this.getWageapi().executeSql(sql);
		}
	}
}
