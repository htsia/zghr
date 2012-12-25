package com.hr319wg.custom.impl;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.dao.CommonDAO;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.portal.IUUManager;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;

public class UUCustomManager implements IUUManager{
	private CommonDAO commonDAO;
	private JdbcTemplate jdbcTemplate;
	private ActivePageAPI activeapi;

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public CommonDAO getCommonDAO() {
		return commonDAO;
	}

	public void setCommonDAO(CommonDAO commonDAO) {
		this.commonDAO = commonDAO;
	}

	public void organizationAdd(String arg0, String arg1, String arg2)
			throws SysException {
		//ˢ�´��뼯
		SysCache.loadCodeSetMap();
        SysCache.loadCodeItemMap();
        //ͬ������ϵͳ,���һ������������¼
        OrgBO bo= SysCacheTool.findOrgById(arg0);
        SqlUtil.updateData("insert into b001_bd (change_date,change_type,new_mainDeptID,dept_id,dept_type,dept_name) values " +
        		"(getdate(),'����','"+bo.getSuperId()+"','"+bo.getOrgId()+"','"+("089110".equals(bo.getorgType())?"��λ":"����")+"','"+bo.getName()+"')");
        SqlUtil.updateData("insert into b001 (id,b001003,b001002,b001075,b001005) values " +
        		"('"+bo.getOrgId()+"','"+bo.getTreeId()+"','"+bo.getSuperId()+"','"+bo.getorgType()+"','"+bo.getName()+"')");
	}

	public void organizationModify(String arg0, String arg1, String arg2)
			throws SysException {
	}
	
	public void organizationRemove(String arg0, String arg1, String arg2)
			throws SysException {
		//ˢ�´��뼯
		SysCache.loadCodeSetMap();
        SysCache.loadCodeItemMap();
	}
	
	public void organizationSort(String arg0) throws SysException {
		//ˢ�´��뼯
		SysCache.loadCodeSetMap();
        SysCache.loadCodeItemMap();
	}
	
	//�����Ա��
	public void userAdd(String arg0, String arg1, String arg2)
			throws SysException {

	}
	
	public void userModify(String arg0, String arg1, String arg2)
			throws SysException {

	}

	public void userModifyOrganization(String arg0, String arg1, String arg2)
			throws SysException {
		
	}

	public void userRemove(String arg0, String arg1, String arg2)
			throws SysException {
		
	}
	
	public void userSort(String arg0) throws SysException {
		
	}

}
