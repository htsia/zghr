package com.hr319wg.custom.util;

import java.util.Comparator;

import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.wage.pojo.bo.WageUnitBO;

public class ComparatorWageUnitBO implements Comparator<WageUnitBO>{

	public int compare(WageUnitBO o1, WageUnitBO o2) {
		OrgBO org1=SysCacheTool.findOrgById(o1.getUnitId());
		OrgBO org2=SysCacheTool.findOrgById(o2.getUnitId());
		return org1.getOrgSort().compareTo(org2.getOrgSort());
	}

}
