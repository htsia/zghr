package com.hr319wg.attence.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttMachineMgrChildDAO extends BaseDAO {
	public List getAllAttMachine(PageVO pagevo,String orgid) throws SysException{
		String hsql = "select bo from attMachineBO bo where bo.orgID='"+orgid+"'";
		String countsql = "select count(bo) from attMachineBO bo where bo.orgID='"+orgid+"'";
		//List list111=this.getHibernatetemplate().find(hsql);
		return this.pageQuery(pagevo, countsql, hsql);
   
	}
	public List findAllAttMachine() throws SysException{
		String hsql = "select bo from attMachineBO bo";
		//List list111=this.getHibernatetemplate().find(hsql);
		return this.hibernatetemplate.find(hsql);
   
	}
}
