package com.hr319wg.custom.ins.service;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.ins.dao.InsDataDAO;
import com.hr319wg.custom.ins.pojo.bo.InsCalcSetBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

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
	
	public void updateMonthPayStatus(String itemID) throws SysException {
		String sql="update a243 set status=case when status=1 then null else 1 end where subid='"+itemID+"'";
		this.jdbcTemplate.execute(sql);
	}

	public void batchUpdateMonthPay(String setID, String itemID, String value)
			throws SysException {
		String sql="update a243 set "+itemID+"='"+value+"' where a243211='"+setID+"'";
		this.jdbcTemplate.execute(sql);
	}
	
	public String getLockUserIDs(String setID) throws SysException {
		String sql="select wm_concat(id) from a243 where status=1 and a243211='"+setID+"'";
		return this.activeapi.queryForString(sql);
	}
	
	public List getAllInsCalcSetBO(PageVO pageVO, String createOrgID, String createUserID, String wageDate) throws SysException{
		return this.insDataDAO.getAllInsCalcSetBO(pageVO, createOrgID, createUserID, wageDate);
	}

	public void deleteBO(Class c, String ID) throws SysException {
		this.insDataDAO.deleteBo(c, ID);
	}

	public String saveSet(InsCalcSetBO bo) throws SysException {
		if(bo.getID()==null){//新建
			String sql="select count(*) from ins_calc_set where createuserid='"+bo.getCreateUserID()+"' and status<>1";
			int c=this.jdbcTemplate.queryForInt(sql);
			if(c>0){
				return "上个计算未归档";
			}
			sql="select count(*) from ins_calc_set where createuserid='"+bo.getCreateUserID()+"' and wagedate='"+bo.getWageDate()+"'";
			c=this.jdbcTemplate.queryForInt(sql);
			if(c>0){
				return "已存在适用月份为"+bo.getWageDate()+"的计算";
			}
		}else{
			String sql="select count(*) from ins_calc_set where createuserid='"+bo.getCreateUserID()+"' and wagedate='"+bo.getWageDate()+"' and id<>'"+bo.getID()+"'";
			int c=this.jdbcTemplate.queryForInt(sql);
			if(c>0){
				return "已存在适用月份为"+bo.getWageDate()+"的计算";
			}
			sql="update a243 set a243200='"+bo.getWageDate()+"' where a243211='"+bo.getID()+"'";
			this.jdbcTemplate.execute(sql);
		}
		this.insDataDAO.saveOrUpdateBo(bo);
		return null;
	}
	
	public void deleteSet(String ID, String wageDate)
			throws SysException {
		String sql = "delete from a243 where A243211 ='"+ID+"'";
		this.jdbcTemplate.execute(sql);
		sql = "delete from ins_calc_set where id ='"+ID+"'";
		this.jdbcTemplate.execute(sql);
	}

	public void endSet(String ID) throws SysException{
		String sql="update a243 set a243000='00900' where id in (select id from a243 where a243211='"+ID+"')";
		this.jdbcTemplate.execute(sql);
		sql="update a243 set a243000='00901' where a243211='"+ID+"'";
		this.jdbcTemplate.execute(sql);
		sql="update ins_calc_set set status=1 where id='"+ID+"'";
		this.jdbcTemplate.execute(sql);
	}
	
	public List getAllInsMonthPayBO(PageVO pageVO, String setID, String wageDate, String orgID, String personType, String nameStr)
			throws SysException {
		return this.insDataDAO.getAllInsMonthPayBO(pageVO, setID, wageDate, orgID, personType, nameStr);
	}

	public void calc(String setID, String wageDate, String orgID, String selectedUserIDs)
			throws SysException {
		this.jdbcTemplate.execute("BEGIN proc_calc_ins('"+setID+"','"+wageDate+"','"+orgID+"','"+selectedUserIDs+"'); END;");
	}

	public void saveInsBaseData(String id, String tablename, String value,
			String date) throws SysException {
			if ("A755".equals(tablename)) {
		      String sql1 = "update A755 set A755000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A755(id,subid,A755000,A755715,A755705,A755701) values('" + id + "','" + SequenceGenerator.getKeyId("A755") + "','" + "00901" + "','" + value + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    } else if ("A760".equals(tablename)) {
		      String sql1 = "update A760 set A760000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A760(id,subid,A760000,A760710,A760705,A760701) values('" + id + "','" + SequenceGenerator.getKeyId("A760") + "','" + "00901" + "','" + value + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    } else if ("A765".equals(tablename)) {
		      String sql1 = "update A765 set A765000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A765(id,subid,A765000,A765705,A765701) values('" + id + "','" + SequenceGenerator.getKeyId("A765") + "','" + "00901" + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    } else if ("A770".equals(tablename)) {
		      String sql1 = "update A770 set A770000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A770(id,subid,A770000,A770710,A770705,A770701) values('" + id + "','" + SequenceGenerator.getKeyId("A770") + "','" + "00901" + "','" + value + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    } else if ("A775".equals(tablename)) {
		      String sql1 = "update A775 set A775000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A775(id,subid,A775000,A775704,A775701) values('" + id + "','" + SequenceGenerator.getKeyId("A775") + "','" + "00901" + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    } else if ("A780".equals(tablename)) {
		      String sql1 = "update A780 set A780000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A780(id,subid,A780000,A780708,A780705,A780701) values('" + id + "','" + SequenceGenerator.getKeyId("A780") + "','" + "00901" + "','" + value + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    } else if ("A786".equals(tablename)) {
		      String sql1 = "update A786 set A786000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A786(id,subid,A786000,A786700,A786706) values('" + id + "','" + SequenceGenerator.getKeyId("A786") + "','" + "00901" + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    }
		    else if ("A785".equals(tablename)) {
		      String sql1 = "update A785 set A785000='00900' where id='" + id + "'";
		      this.jdbcTemplate.execute(sql1);
		      String sql2 = "insert into A785(id,subid,A785000,A785708,A785701) values('" + id + "','" + SequenceGenerator.getKeyId("A785") + "','" + "00901" + "','" + value + "','"+date+"')";
		      this.jdbcTemplate.execute(sql2);
		    }
	}

	public void updateInsurceChangeInfo(String[] ids, String ChangeType,
			String ChangeDate, String changReason, String DepName, String[] inputInsurace)
			throws SysException {
		for (int i = 0; i < ids.length; i++) {
			PersonBO po = SysCacheTool.findPersonById(ids[i]);
			if (po == null) {
				continue;
			}

			for (int j = 0; j < inputInsurace.length; j++) {
				String baseType = "";
				if ("A755715".equals(inputInsurace[j]) || "A754010".equals(inputInsurace[j])) {
					baseType = "224501";//养老
				} else if ("A760710".equals(inputInsurace[j]) || "A754015".equals(inputInsurace[j])) {
					baseType = "224502";//医疗
				} else if ("A765705".equals(inputInsurace[j]) || "A754025".equals(inputInsurace[j])) {
					baseType = "224503";//工伤
				} else if ("A770710".equals(inputInsurace[j]) || "A754020".equals(inputInsurace[j])) {
					baseType = "224504";//失业
				} else if ("A775704".equals(inputInsurace[j]) || "A754030".equals(inputInsurace[j])) {
					baseType = "224505";//生育
				} else if ("A786700".equals(inputInsurace[j]) || "A754200".equals(inputInsurace[j])) {
					baseType = "224506";//大额
				} else if ("A780708".equals(inputInsurace[j]) || "A754035".equals(inputInsurace[j])) {
					baseType = "224508";//公积金
				}

				String sql="insert into B731(subid,B731000,orguid,B731700,B731701,B731702,B731703,B731704,B731209,B731205,B731213,B731203,B731204) values " +
						"('" + CommonFuns.filterNull(SequenceGenerator.getKeyId("B731")) + "','" + "00900" + "','"+po.getOrgId()+"','" + ids[i] + "','" +
						CommonFuns.filterNull(ChangeDate) + "','" + CommonFuns.filterNull(ChangeType) + "','"+CommonFuns.filterNull(DepName)+"','" + 
						CommonFuns.filterNull(baseType) + "','"+CommonFuns.filterNull(changReason)+"','"+CommonFuns.filterNull(po.getPersonCode())+"','"+
						CommonFuns.filterNull(po.getPersonType())+"','"+CommonFuns.filterNull(po.getOrgId())+"','"+CommonFuns.filterNull(po.getDeptId())+"')";
				this.jdbcTemplate.execute(sql);
			}
		}
	}

	public List getInsMonthPaySum(String setID, String wageDate, String orgID,
			String personType, String nameStr) throws SysException {
		String sql="select sum(A243201) A243201,sum(A243218) A243218,sum(A243202) A243202,sum(A243203) A243203,sum(A243204) A243204,sum(A243205) A243205,sum(A243206) A243206,sum(A243207) A243207,sum(A243208) A243208,sum(A243209) A243209,sum(A243210) A243210,sum(A243201+A243218+A243202+A243203+A243204+A243205+A243206+A243207+A243208+A243209+A243210) total  from a243 w,a001 a where a.id=w.id and a243211='"+setID+"' and a243200='"+wageDate+"'";
		if(orgID!=null && !"".equals(orgID)){
			OrgBO org = SysCacheTool.findOrgById(orgID);
			sql+=" and (a001738 like '"+org.getTreeId()+"%') ";
		}
		if(personType!=null && !"".equals(personType)){
			sql += " and "+CommonFuns.splitInSql(personType.split(","), "a001054");
		}
		
		if(nameStr!=null && !"".equals(nameStr)){
			sql += " and (a001001 like '%"+nameStr+"%' or a001735 like '%"+nameStr+"%' or a001002 like '%"+nameStr+"%')";
		}
		return this.jdbcTemplate.queryForList(sql);
	}
}
