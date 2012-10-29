package com.hr319wg.custom.eva.service;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.eva.dao.EvaWageDao;
import com.hr319wg.custom.eva.pojo.bo.EvaWageBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class EvaWageService {

	private EvaWageDao evaWageDao;
	private ActivePageAPI activeapi;
	private JdbcTemplate jdbcTemplate;
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	public EvaWageDao getEvaWageDao() {
		return evaWageDao;
	}
	public void setEvaWageDao(EvaWageDao evaWageDao) {
		this.evaWageDao = evaWageDao;
	}
	public ActivePageAPI getActiveapi() {
		return activeapi;
	}
	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}
	
	public Object findBOById(Class c, String Id) throws SysException{
		return this.evaWageDao.findBoById(c, Id);
	}
	public void saveOrUpdateBO(Object bo) throws SysException{
		this.evaWageDao.saveOrUpdateBo(bo);
	}
	
	public List getAllEvaWageBO() throws SysException{
		return this.evaWageDao.getAllEvaWageBO();
	}
	
	public List getworkday(){
		String sql = "select id,A001044 from a001 where A001044 between '2011-09-01' and '2012-08-31'";
		return this.jdbcTemplate.queryForList(sql);
	}
	public void setworkday(int d, String userID) throws SysException{
		String sql = "update a001 set A001247='"+d+"' where id='"+userID+"'";
		this.activeapi.executeSql(sql);
	}
	
	//获取所有考核人员
	public List getAllEvaWageBO(PageVO pageVo, String orgID, String personType, String nameStr) throws SysException{
		return this.evaWageDao.getAllEvaWageBO(pageVo, orgID, personType, nameStr);
	}
	//获取所有未考核人员
	public List getAllNotinEvaUserBO(PageVO pageVo, String orgID, String personType, String nameStr) throws SysException{
		return this.evaWageDao.getAllNotinEvaUserBO(pageVo, orgID, personType, nameStr);
	}
	//添加未考核人员
	public void addEvaUser(String userID) throws SysException{
		String key = SequenceGenerator.getKeyId("A746");
		String sql = "insert into a746(id,subid,A746000,A746735,A746755) values ('"+userID+"','"+key+"','00901','合格','1')";
		this.activeapi.executeSql(sql);
	}
	//获取所有绩效系数
	public List getAllEvaWageXishu(){
		String sql = "select id,resultlevel,xishu from evawagexishu";
		return this.jdbcTemplate.queryForList(sql);
	}
	//重载所有系数
	public void reloadEvaWageXishu(){
		String sql = "delete from evawagexishu";
		this.jdbcTemplate.execute(sql);
		sql = "insert into evawagexishu(id,resultlevel) select rownum,a746735 from ( select a746735 from a746 group by a746735)";
		this.jdbcTemplate.execute(sql);
	}
	
	//更新所有系数
	public void updateEvaWageXishu(String xishuIDs, String xishus) throws SysException{
		String[]xishuIDs1=xishuIDs.split(",");
		String[]xishus1=xishus.split(",");
		for(int i=0;i<xishuIDs1.length;i++){
			String sql = "update evawagexishu set xishu='"+xishus1[i]+"' where id='"+xishuIDs1[i]+"'";
			this.activeapi.executeSql(sql);
		}
	}
	
	//获取绩效扣税
	public List getEvaWageKoushui(){
		String sql = "select koushuitype,koushui from evawagekoushui";
		return this.jdbcTemplate.queryForList(sql);
	}
	//更新扣税
	public void updateEvaWageKoushui(String type, String koushui) throws SysException{
		String sql = "update evawagekoushui set koushuitype='"+type+"',koushui='"+koushui+"'";
		this.activeapi.executeSql(sql);
	}
	//更新出勤率
	public void updateEvaWageChuqinlv(String userID, String level, String chuqinlv) throws SysException{
		String sql = "update A746 set A746735='"+level+"',A746200='"+chuqinlv+"' where a746000='00901' and id='"+userID+"'";
		this.activeapi.executeSql(sql);
	}
	//计算绩效工资
	public void updateEvaWage() throws SysException{
		this.activeapi.executeSql("BEGIN proc_set_eva_wage(); END;");
	}
}
