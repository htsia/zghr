package com.hr319wg.custom.ins.service;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.ins.dao.InsDataDAO;
import com.hr319wg.sys.api.ActivePageAPI;

public class InsDataServiceImpl implements IInsDataService {

	private InsDataDAO insDataDAO;
	private ActivePageAPI activeapi;
	private JdbcTemplate jdbcTemplate;

	public InsDataDAO getInsDataDAO() {
		return insDataDAO;
	}

	public void setInsDataDAO(InsDataDAO insDataDAO) {
		this.insDataDAO = insDataDAO;
	}

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

	public Object getBOByID(Class c, String ID) throws SysException {
		return this.insDataDAO.findBoById(c, ID);
	}

	public void saveOrUpdateBO(Object bo) throws SysException {
		this.insDataDAO.saveOrUpdateBo(bo);
	}

	public List getAllInsCalcSetBO(PageVO pageVO, String createOrgID, String createUserID, String wageDate) throws SysException{
		return this.insDataDAO.getAllInsCalcSetBO(pageVO, createOrgID, createUserID, wageDate);
	}

	public void deleteBO(Class c, String ID) throws SysException {
		this.insDataDAO.deleteBo(c, ID);
	}

	public void deleteSet(String ID, String wageDate)
			throws SysException {
		String sql = "delete from ins_calc_set where id ='"+ID+"'";
		this.jdbcTemplate.execute(sql);
		sql = "delete from a243 where a243000='00901' and a243200='"+wageDate+"' and A243211 ='"+ID+"'";
		this.jdbcTemplate.execute(sql);
	}

	public List getAllInsMonthPayBO(PageVO pageVO, String setID, String wageDate, String orgID, String personType, String nameStr)
			throws SysException {
		return this.insDataDAO.getAllInsMonthPayBO(pageVO, setID, wageDate, orgID, personType, nameStr);
	}

	public void calc(String setID, String wageDate, String orgID)
			throws SysException {
		this.jdbcTemplate.execute("BEGIN proc_calc_ins('"+setID+"','"+wageDate+"','"+orgID+"'); END;");
	}

}
