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

	public void organizationAdd(String arg0, String userID, String arg2)
			throws SysException {
		//刷新代码集
		SysCache.loadCodeSetMap();
        SysCache.loadCodeItemMap();
	}

	public void organizationModify(String arg0, String userID, String arg2)
			throws SysException {
	}
	
	public void organizationRemove(String arg0, String userID, String arg2)
			throws SysException {
		//刷新代码集
		SysCache.loadCodeSetMap();
        SysCache.loadCodeItemMap();
	}
	
	public void organizationSort(String arg0) throws SysException {

	}
	
	//添加人员后
	public void userAdd(String arg0, String userID, String arg2)
			throws SysException {
		//人员添加后执行存储过程
		String sql="select count(*) from sys_parameter where para_key='USER_TRIGGER' and para_value like '%ADD%'";
		int result=this.jdbcTemplate.queryForInt(sql);
		if(result==1){
			this.jdbcTemplate.execute("BEGIN PROC_USER_ADD('"+arg0+"', '"+userID+"', '"+arg2+"'); END;");
		}
	}
	
	public void userModify(String arg0, String userID, String arg2)
			throws SysException {
		//人员更新后执行存储过程
		String sql="select count(*) from sys_parameter where para_key='USER_TRIGGER' and para_value like '%UPDATE%'";
		int result=this.jdbcTemplate.queryForInt(sql);
		if(result==1){
			this.jdbcTemplate.execute("BEGIN PROC_USER_UPDATE('"+arg0+"', '"+userID+"', '"+arg2+"'); END;");
		}
	}

	public void userModifyOrganization(String arg0, String userID, String arg2)
			throws SysException {
		
	}

	public void userRemove(String arg0, String userID, String arg2)
			throws SysException {
		//人员更新后执行存储过程
		String sql="select count(*) from sys_parameter where para_key='USER_TRIGGER' and para_value like '%DELETE%'";
		int result=this.jdbcTemplate.queryForInt(sql);
		if(result==1){
			this.jdbcTemplate.execute("BEGIN PROC_USER_DELETE('"+arg0+"', '"+userID+"', '"+arg2+"'); END;");
		}
	}
	
	public void userSort(String arg0) throws SysException {
		
	}

}
