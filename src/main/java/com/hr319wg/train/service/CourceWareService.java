package com.hr319wg.train.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.train.dao.CourceWareDAO;
import com.hr319wg.train.pojo.bo.CourceWareItemBO;
import com.hr319wg.train.pojo.bo.CourceWareTypeBO;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

public class CourceWareService {
	private CourceWareDAO courcedao;
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List getAllValidItemInfo(String orgid) throws SysException {
		return this.courcedao.getAllValidItemInfo(orgid);
	}

	public List getAllPrivateCourceItem(String orgId) throws SysException {
		return this.courcedao.getAllPrivateCourceItem(orgId);
	}

	public List getAllItemInfo(String orgid) throws SysException {
		return this.courcedao.getAllItemInfo(orgid);
	}

	public List getAllFileInfoByType(String type) throws SysException {
		return this.courcedao.getAllFileInfoByType(type);
	}

	public List getAllFileInfoByType(String type, String id)
			throws SysException {
		return this.courcedao.getAllFileInfoByType(type, id);
	}

	public List getAllChildType(String typeid) throws SysException {
		return this.courcedao.getAllChildType(typeid);
	}

	public void DeleteType(String id) throws SysException {
		this.courcedao.deleteBo(CourceWareTypeBO.class, id);
	}

	public void DeleteItem(String id) throws SysException {
		this.courcedao.deleteBo(CourceWareItemBO.class, id);
	}

	public CourceWareTypeBO getTypeBO(String id) throws SysException {
		return (CourceWareTypeBO) this.courcedao.findBoById(
				CourceWareTypeBO.class, id);
	}

	public CourceWareItemBO getItemBO(String id) throws SysException {
		return (CourceWareItemBO) this.courcedao.findBoById(
				CourceWareItemBO.class, id);
	}

	public void saveType(CourceWareTypeBO bo) throws SysException {
		this.courcedao.saveOrUpdateBo(bo);
	}

	public void saveItem(CourceWareItemBO bo) throws SysException {
		this.courcedao.saveOrUpdateBo(bo);
		if("1".equals(bo.getTop())){
			String sql="update train_courcewareitem set top=null where item_id <>'"+bo.getItemID()+"'";
			this.jdbcTemplate.execute(sql);
		}
	}

	public CourceWareDAO getCourcedao() {
		return this.courcedao;
	}

	public void setCourcedao(CourceWareDAO dao) {
		this.courcedao = dao;
	}
}