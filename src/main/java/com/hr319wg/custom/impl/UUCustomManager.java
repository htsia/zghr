package com.hr319wg.custom.impl;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.dao.CommonDAO;
import com.hr319wg.portal.IUUManager;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;

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
		//刷新代码集
		SysCache.loadCodeSetMap();
        SysCache.loadCodeItemMap();
	}

	public void organizationModify(String arg0, String arg1, String arg2)
			throws SysException {
		//刷新代码集
		SysCache.loadCodeSetMap();
        SysCache.loadCodeItemMap();
	}
	
	public void organizationRemove(String arg0, String arg1, String arg2)
			throws SysException {

	}
	
	public void organizationSort(String arg0) throws SysException {
		// TODO Auto-generated method stub
		
	}
	
	//添加人员后
	public void userAdd(String arg0, String arg1, String arg2)
			throws SysException {

	}
	
	public void userModify(String arg0, String arg1, String arg2)
			throws SysException {

	}

	public void userModifyOrganization(String arg0, String arg1, String arg2)
			throws SysException {
		// TODO Auto-generated method stub
		
	}

	public void userRemove(String arg0, String arg1, String arg2)
			throws SysException {
		// TODO Auto-generated method stub
		
	}
	
	public void userSort(String arg0) throws SysException {
		// TODO Auto-generated method stub
		
	}

}
