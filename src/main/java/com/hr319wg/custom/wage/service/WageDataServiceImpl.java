package com.hr319wg.custom.wage.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.custom.wage.dao.WageDataDAO;
import com.hr319wg.custom.wage.pojo.bo.ClassWageBO;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetBO;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetUserBO;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetVerifyBO;
import com.hr319wg.custom.wage.pojo.bo.WageOthersDataSetBO;
import com.hr319wg.custom.wage.pojo.bo.WageOthersDataSetUserBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class WageDataServiceImpl implements IWageDataService{

	private WageDataDAO wageDataSetDAO;
	private ActivePageAPI activeapi;
	private JdbcTemplate jdbcTemplate;
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public WageDataDAO getWageDataSetDAO() {
		return wageDataSetDAO;
	}

	public void setWageDataSetDAO(WageDataDAO wageDataSetDAO) {
		this.wageDataSetDAO = wageDataSetDAO;
	}
	
	public void saveOrUpdateObject(Object obj) throws SysException{
		this.wageDataSetDAO.saveOrUpdateBo(obj);
	}
	
	public void setTotalMoney(String itemID) throws SysException{
		String sql = "update wage_dataset ds set ds.totalmoney= (select nvl(sum(du.money),0) from wage_dataset_user du where du.setid=ds.id) where ds.id='"+itemID+"'";
		this.activeapi.executeSql(sql);
	}
	
	public Object findBOById(Class c, String id) throws SysException{
		return this.wageDataSetDAO.findBoById(c, id);
	}
	
	//获取超课时
	public List getAllClassWageBO(PageVO pageVo, String orgID, String personType, String nameStr, String operUserID, String inself) throws SysException{
		return this.wageDataSetDAO.getAllClassWageBO(pageVo, orgID, personType, nameStr, operUserID, inself);
	}
	//获取导出超课时
	public List getAllClassWageBO() throws SysException{
		String sql = "select A001735 personcode,A001077 card,a001001 name,A001239 secdept,A001705 dept,A001054 persontype,A001243 zclevel,classNum,wage,reduce,realwage,A001242 bank from " +
				"a001 a, (select id,sum(a242200) classNum, sum(a242201) wage,sum(a242202) reduce,sum(a242203) realwage from a242 where a242205='"+CommonFuns.getSysDate("yyyy")+"' and a242203 is not null group by id) b " +
				"where a.id=b.id";
		return this.jdbcTemplate.queryForList(sql);
	}
	
	//添加超课时人员
	public void addClassUser(String[]selectedUserIDs, String operUserID) throws SysException{
		for(int i=0;i<selectedUserIDs.length;i++){
			ClassWageBO bo = new ClassWageBO();
			bo.setCreateUserID(operUserID);
			bo.setUserID(selectedUserIDs[i]);
			bo.setYear(CommonFuns.getSysDate("yyyy"));
			bo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			this.wageDataSetDAO.saveOrUpdateBo(bo);
		}
	}
	//删除超课时人员
	public void deleteClassUser(String subID) throws SysException{
		String sql = "delete from a242 where subid='"+subID+"'";
		this.activeapi.executeSql(sql);
	}
	//计算
	public void calcClassWage() throws SysException{
		this.activeapi.executeSql("BEGIN proc_calc_classwage(); END;");
	}

	/**
	 *加入到帐套
	 *type 0项目工资、1兼职教师 
	 */
	public int addToWageset(String personType, String wageSetID, String unitID) throws SysException{
		//删除数据
		String sql = "delete from wage_set_pers_r where id in (select id from a001 where a001054='"+personType+"')";
		this.activeapi.executeSql(sql);
		//判断帐套是否已经建立
		int result=-1;
		sql="select count(*) from dba_tables t,sys_parameter p where owner=p.para_value and p.para_key='SYS_DATABASE' and tablespace_name='DATA' and table_name='A815_SET_"+wageSetID+"'";
		result=this.activeapi.queryForInt(sql);
		if(result==1){
			sql = "delete from A815_SET_"+wageSetID+" where id in (select id from a001 where a001054='"+personType+"')";
			this.activeapi.executeSql(sql);
		}
		
		//添加数据
		sql = "insert into wage_set_pers_r (id,subid,a815000,a815700) select a.id,'0','00901','"+wageSetID+"' from a001 a,a239 w where a.id=w.id and a001054='"+personType+"' and a001201 ='0' and (w.a239200>0 or w.a239201>0)";
		this.activeapi.executeSql(sql);
		if(result==1){
			sql = "select s.a815701 ||','||s.a815702 from a815_set_"+wageSetID+" s where rownum=1";
			String wageInfo=this.activeapi.queryForString(sql);
			String[]wageInfos=null;
			if(wageInfo!=null && !"".equals(wageInfo)){
				wageInfos=wageInfo.split(",");
			}else{
				sql = "select create_date from wage_set where set_id='"+wageSetID+"'";
				wageInfos=new String[2];
				wageInfos[0]=this.activeapi.queryForString(sql);
				wageInfos[1]=UUID.randomUUID().toString().replace("-", "");
			}
			sql = "insert into a815_set_"+wageSetID+" (a815700,a815701,a815702,id,subid,a815000,a815705) " +
					"select '"+wageSetID+"','"+wageInfos[0]+"','"+wageInfos[1]+"',a.id,'0','00901','"+unitID+"' from a001 a,a239 w where a.id=w.id and a001054='"+personType+"' and a001201 ='0' and (w.a239200>0 or w.a239201>0)";
			this.activeapi.executeSql(sql);
		}
		sql = "select count(*) from a001 a,a239 w where a.id=w.id and a001054='"+personType+"' and a001201<>'1' and (w.a239200>0 or w.a239201>0)";
		return this.activeapi.queryForInt(sql);
	}
	
	
	//保存项目工兼职教师人员
	public void saveWageEmpPerson(UserBO user, String wage, String other) throws SysException{
		
		boolean isnew =user.getUserID()==null?true:false;
		if(isnew){
			String sql ="select personnum_sequence.nextval from dual";
			int code=this.jdbcTemplate.queryForInt(sql);
			user.setPersonSeq(code+"");
			user.setComeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		}
		PersonBO pEdit=null;
		if(!isnew){
			pEdit=SysCacheTool.findPersonById(user.getUserID());
		}
		OrgBO org = SysCacheTool.findOrgById(user.getDeptId());
		OrgBO superOrg = SysCacheTool.findOrgById(org.getSuperId());
		user.setDeptSort(org.getTreeId());
		user.setMainDeptSort(superOrg.getTreeId());
		user.setOrgId(superOrg.getOrgId());
		if(user.isHasCash()){
			user.setHasCashStr("1");
		}else{
			user.setHasCashStr("0");			
		}
		HibernateTemplate temp = (HibernateTemplate)SysContext.getBean("hibernateTemplate");
		temp.saveOrUpdate(user);
		temp.flush();
		
		//添加
		if(isnew){
			String sql="insert into sys_user_info s (s.person_id,s.login_name,login_pwd,s.is_use) values ('"+user.getUserID()+"','"+user.getName()+"','98f6bcd4621d373cade4e832627b4f6',0)";
			this.jdbcTemplate.execute(sql);
			String wageOrgId=superOrg.getOrgId();
			sql="insert into a795 (id,a795701,a795705,a795708,a795710,a795718,a795720,a795725) values ('"+user.getUserID()+"','"+user.getOrgId()+"','"+user.getOrgId()+"','"+user.getOrgId()+"','"+user.getOrgId()+"','"+user.getOrgId()+"','"+user.getOrgId()+"','"+user.getOrgId()+"')";
			this.jdbcTemplate.execute(sql);
			sql="insert into a239 (id,a239200,a239201) values ('"+user.getUserID()+"','"+wage+"','"+other+"')";
			this.jdbcTemplate.execute(sql);
		}else{
			String sql="update a239 set a239200='"+wage+"',a239201='"+other+"' where id='"+user.getUserID()+"'";
			this.jdbcTemplate.execute(sql);	
		}
	}
	//导入项目工兼职教师人员
	public void batchSaveWageEmpPerson(List<Map> list, String importType) throws SysException {
		String sql="update a239 set a239200=null,a239201=null where id in (select id from a001 where A001054='"+importType+"')";
		this.jdbcTemplate.execute(sql);
		for(Map m : list){
			UserBO bo = new UserBO();
			bo.setName(m.get("name").toString());
			bo.setDeptId(m.get("deptID").toString());
			bo.setPersonType(m.get("personType").toString());
			bo.setHasCashStr(m.get("hasCash").toString());
			bo.setCardNO(m.get("card").toString());
			bo.setBankNO(m.get("bank")==null?"":m.get("bank").toString());
			if(m.get("id")!=null){
				bo.setUserID(m.get("id").toString());
				bo.setPersonSeq(m.get("personCode").toString());
			}
			saveWageEmpPerson(bo, String.valueOf(m.get("wage")), String.valueOf(m.get("other")));
		}
	}
	//是否添加过人员1已经添加  0未添加
	public int getWageDataSetUserCount(String setID, String userID) throws SysException{
		String sql = "select count(*) from wage_dataset_user u where u.setid='"+setID+"' and u.userid='"+userID+"'";
		return this.activeapi.queryForInt(sql);
	}
	//是否添加过工资杂项人员1已经添加  0未添加
	public int getWageDataOthersSetUserCount(String setID, String userID) throws SysException{
		String sql = "select count(*) from wage_others_dataset_user u where u.setid='"+setID+"' and u.userid='"+userID+"'";
		return this.activeapi.queryForInt(sql);
	}
	
	public void deleteWageDataSetBOByID(String ID) throws SysException{
		this.wageDataSetDAO.deleteBo(WageDataSetBO.class, ID);
		String sql="delete from wage_dataset_user where setID ='"+ID+"'";
		this.activeapi.executeSql(sql);
	}
	
	//获取管辖的帐套
	public List getAllWagesetBOByUserID(String operUserID) throws SysException{
		return this.wageDataSetDAO.getAllWagesetBOByUserID(operUserID);
	}
	
	public void deleteWageDataSetUserBOByID(String ID) throws SysException{
		this.wageDataSetDAO.deleteBo(WageDataSetUserBO.class, ID);
	}
	
	public Object getObjectByID(Class c ,String ID) throws SysException{
		return this.wageDataSetDAO.findBoById(c, ID);
	}
	public List getAllWageEmpUserBO(PageVO pageVo, boolean hasWage, boolean noWage, boolean hasCash, boolean hasNoCash, String orgID, String personType, String nameStr) throws SysException{
		return this.wageDataSetDAO.getAllWageEmpUserBO(pageVo, hasWage, noWage, hasCash, hasNoCash, orgID, personType, nameStr);
	}
	
	public List getAllWageDataSetBO(String yearMonth, String selectedItemIDs, String itemType) throws SysException{
		return this.wageDataSetDAO.getAllWageDataSetBO(yearMonth, selectedItemIDs, itemType);
	}
	
	public List getAllWageDataSetBOByUserID(PageVO pageVo, String userID, String itemType, String beginDate, String endDate, String[]status, String operUserID) throws SysException{
		return this.wageDataSetDAO.getAllWageDataSetBOByUserID(pageVo, userID, itemType, beginDate, endDate, status, operUserID);
	}

	public List getAllWageDataSetUserBO(PageVO pageVo, WageDataSetBO item, String orgID, String personType, String nameStr, String inself, String operUserID) throws SysException{
		return this.wageDataSetDAO.getAllWageDataSetUserBO(pageVo, item, orgID, personType, nameStr, inself, operUserID);
	}

	public List getAllWageDataSetUserBOByInfo(PageVO pageVo,String yearMonth, String selectedItemIDs, String orgID, String itemType, String personType, String nameStr, String operUserID) throws SysException{
		return this.wageDataSetDAO.getAllWageDataSetUserBOByInfo(pageVo,yearMonth, selectedItemIDs, orgID, itemType, personType, nameStr, operUserID);
	}
	
	public List getAllWageDateSigleBO(PageVO pageVo, String orgID, String itemType, String isVerify, String yearMonth, String personType, String nameStr, boolean verifyFlag, String inself, String operUserID) throws SysException{
		return this.wageDataSetDAO.getAllWageDateSigleBO(pageVo, orgID, itemType, isVerify, yearMonth, personType, nameStr, verifyFlag, inself, operUserID);
	}
	
	public String getWageUserVerifyStatus(String datasetUserID, String yearMonth) throws SysException{
		String sql ="select status from wage_dataset_verify v1 where v1.dataset_user_id='"+datasetUserID+"' and v1.yearmonth='"+yearMonth+"'";
		return this.activeapi.queryForString(sql);
	}
	
	//修改扣房租房补暖气费金额
	public void modifyUserMoney(String userID, String money, String yearMonth, String itemType) throws SysException{
		String set = null;
		if("1".equals(itemType)){
			set="a225"; 
		}else if("2".equals(itemType)){
			set="a226"; 
		}else if("3".equals(itemType)){
			set="a227"; 
		}
		
		String sql = "update "+set+" set "+set+"201='"+money+"',"+set+"202='"+yearMonth+"' where id='"+userID+"'";
		this.activeapi.executeSql(sql);
	}
	
	//其他1项目已用总额
	public String getWageDataOther1SumByID(String setID) throws SysException{
		String sql = "select sum(money) from wage_data_record where setid='"+setID+"'";
		return this.activeapi.queryForString(sql);
	}
	
	//1加班费、2车公里补贴、5科研费
	//获取加班费、车公里补贴人员
	public List getAllWageLitleUserBO(PageVO pageVo, String itemType, String orgID, String personType, String nameStr, String operUserID) throws SysException{
		return this.wageDataSetDAO.getAllWageLitleUserBO(pageVo, itemType, orgID, personType, nameStr, operUserID);
	}
	
	//添加加班费、车公里补贴人员
	public void addWageLitleUser(String itemType,String selectedUserIDs, String operUserID) throws SysException{
		String set = "";
		if("1".equals(itemType)){
			set = "a229";//加班费
		}else if("2".equals(itemType)){
			set = "a233";//车公里补贴			
		}else if("5".equals(itemType)){
			set = "a228";//科研费			
		}
		String sql = "update "+set+" set "+set+"202 ='1' where "+CommonFuns.splitInSql(selectedUserIDs.split(","), "id");
//		sql += " and id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
	}
	//批量导入加班费、车公里补贴人员
	public void batchAddWageLitleUser(String itemType,String selectedUserIDs,String money, String operUserID) throws SysException{
		String set = "";
		if("1".equals(itemType)){
			set = "a229";//加班费
		}else if("2".equals(itemType)){
			set = "a233";//车公里补贴			
		}else if("5".equals(itemType)){
			set = "a228";//科研费			
		}
		String sql = "update "+set+" set "+set+"200 ='"+money+"',"+set+"202 ='1' where "+CommonFuns.splitInSql(selectedUserIDs.split(","), "id");
//		sql += " and id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
	}
	//删除加班费、车公里补贴人员
	public void deleteWageLitleUser(String itemType,String userID, String operType, String operUserID) throws SysException{
		String set = "";
		if("1".equals(itemType)){
			set = "a229";//加班费
		}else if("2".equals(itemType)){
			set = "a233";//车公里补贴			
		}else if("5".equals(itemType)){
			set = "a228";//科研费			
		}
		String sql = "update "+set+" set "+set+"200 =null,"+set+"202 ='0' where 1=1";
		if("0".equals(operType)){//删除单个
			sql += " and id='"+userID+"'";
		}
//		sql += " and id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
	}
	//更新加班费、车公里补贴人员
	public void updateWageLitleUser(String itemType,String money, String userID, String operUserID) throws SysException{
		String set = "";
		if("1".equals(itemType)){
			set = "a229";//加班费
		}else if("2".equals(itemType)){
			set = "a233";//车公里补贴			
		}else if("3".equals(itemType)){
		}else if("5".equals(itemType)){
			set = "a228";//科研费			
		}
		String sql = "update "+set+" set "+set+"200 ='"+money+"' where "+set+"202 ='1'";
		if(userID!=null && !"".equals(userID)){
			sql += " and id='"+userID+"'";
		}
//		sql += " and id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
	}
	//归档加班费、车公里补贴人员
	public void updateWageLitle(String itemType,String yearMonth, String operUserID) throws SysException{
		String set = "";
		if("1".equals(itemType)){
			set = "a229";//加班费
		}else if("2".equals(itemType)){
			set = "a233";//车公里补贴			
		}else if("3".equals(itemType)){
		}else if("5".equals(itemType)){
			set = "a228";//科研费			
		}
		String sql = "update "+set+" set "+set+"201 ='"+yearMonth+"',"+set+"202 ='2' where "+set+"202 ='1'";
//		sql += " and id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
	}
	
	/**
	 * 审核捐款其他2数据
	 * @throws SysException 
	 */
	public void updateWageData(String yearMonth, String userID, String orgID ,String itemType, String setID, String operType) throws SysException{
		String set = null;
		if("2".equals(itemType)){
			set = "a206"; 
		}else if("3".equals(itemType)){
			set = "a207";
		}
		String sql = "select du.id,du.userid,du.money from wage_dataset_user du,wage_dataset ds where du.setid=ds.id and '"+yearMonth+"' between begin_date and end_date and nvl(instr(exclude_date,'"+yearMonth+"'),0)=0" +
				" and ds.item_type='"+itemType+"' and du.id not in (select dataset_user_id from wage_dataset_verify where yearmonth='"+yearMonth+"')";
		if(setID!=null){
			sql +=" and ds.id='"+setID+"'";
		}
		if(userID!=null){
			sql +=" and du.userid='"+userID+"'";
		}
		List list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				Map m = (Map)list.get(i);
				String id = m.get("id").toString();
				WageDataSetVerifyBO bo = new WageDataSetVerifyBO();
				bo.setDatasetUserID(id);
				bo.setStatus(operType);
				bo.setYearMonth(yearMonth);
				this.wageDataSetDAO.saveOrUpdateBo(bo);
			}
		}
	}
	
	/**
	 * 更新其他1、扣其他1,捐款、其他2、扣其他2
	 * @throws SysException 
	 */
	public void updateWageDataOther1(String itemType, String yearMonth, String selectedItemIDs, String operUserID) throws SysException{
		String set = null;

		if("1".equals(itemType)){
			set = "a205"; //其他1
		}else if("2".equals(itemType)){
			set = "a206"; //捐款
		}else if("3".equals(itemType)){
			set = "a207"; //其他2		
		}else if("4".equals(itemType)){
			set = "a237"; //扣其他1
		}else if("5".equals(itemType)){
			set = "a230";//扣其他2
		}
		String sql ="update "+set+" set "+set+"201=null";
//				" where id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
		sql = "update "+set+" a set "+set+"201='"+yearMonth+"',"+set+"200=(select m from (select userid,sum(money) m from Wage_Dataset_User du where du.setid in " +
				"(select id from WAGE_DATASET where (exclude_date is null or exclude_date not like '%"+yearMonth+"%') and begin_date <='"+yearMonth+"' and end_date >='"+yearMonth+"' " +
						"and status in (1,2) and item_type='"+itemType+"' and "+CommonFuns.splitInSql(selectedItemIDs.split(","), "id")+") group by userid) b where a.id=b.userid)";
//		sql += " where id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
		//生成历史记录
		sql ="delete from wage_data_record where yearmonth='"+yearMonth+"' and "+CommonFuns.splitInSql(selectedItemIDs.split(","), "setId");
//				" and userid in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
		sql = "insert into wage_data_record select id || '"+yearMonth+"',setid,userid,money,usercode,username,orgname,deptname,remark,'"+yearMonth+"' from wage_dataset_user " +
				"where setid in (select id from WAGE_DATASET where (exclude_date is null or exclude_date not like '%"+yearMonth+"%') " +
						"and begin_date <='"+yearMonth+"' and end_date >='"+yearMonth+"' and status in (1,2) and item_type='"+itemType+"' and "+CommonFuns.splitInSql(selectedItemIDs.split(","), "id")+")";
//		sql += " and userid in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
		//更新项目状态
		List<WageDataSetBO> setList = this.getAllWageDataSetBO(yearMonth, selectedItemIDs, itemType);
		for(WageDataSetBO bo : setList){
			
			boolean isEnd=false;
			DateFormat df = new SimpleDateFormat("MM-dd");
			try {
				Date endMonth = df.parse(bo.getEndDate());
				Date operMonth = df.parse(yearMonth);
	            Calendar c1 = Calendar.getInstance();
	            Calendar c2 = Calendar.getInstance();
	            c1.setTime(endMonth);
	            c2.setTime(operMonth);
	            if(c1.getTimeInMillis()<=c2.getTimeInMillis()){
	            	isEnd=true;
	            }
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(bo.getUsedMonth()!=null && bo.getUsedMonth().indexOf(yearMonth)==-1){
				bo.setUsedMonth(bo.getUsedMonth()+","+yearMonth);
			}else if(bo.getUsedMonth()==null){
				bo.setUsedMonth(yearMonth);
			}
			String usedMoney = this.getWageDataOther1SumByID(bo.getID());
			bo.setUsedMoney(usedMoney);
			if(isEnd){
				bo.setStatus("2");
			}
			this.wageDataSetDAO.saveOrUpdateBo(bo);
		}
	}
	
	/**
	 * 同步扣房租房补暖气费数据
	 * @throws SysException 
	 */
	public void updateWageDataSigle(String yearMonth, String orgID ,String itemType, String userID, String operUserID) throws SysException{
		String set = null;
		if("1".equals(itemType)){
			set="a225"; 
		}else if("2".equals(itemType)){
			set="a226"; 
		}else if("3".equals(itemType)){
			set="a227";
		}
		String sql = "update "+set+" set "+set+"200="+set+"201,"+set+"201=null,"+set+"202=null where "+set+"202='"+yearMonth+"' and id in (select id from a001 where a001701='"+orgID+"')";
		if(userID!=null && !"".equals(userID)){
			sql+=" and id='"+userID+"'";
		}
//		sql += " and id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
	}
	//清空sigle数据
	public void deleteWageDataSigle(String itemType, String userID, String operUserID) throws SysException{
		String set = null;
		if("1".equals(itemType)){
			set="a225"; 
		}else if("2".equals(itemType)){
			set="a226"; 
		}else if("3".equals(itemType)){
			set="a227";
		}
		String sql = "update "+set+" set "+set+"201=null,"+set+"202=null where 1=1 ";
		if(userID!=null && !"".equals(userID)){
			 sql+=" and id='"+userID+"'";
		}
//		sql += " and id in ("+ CommonUtil.getSQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
		this.activeapi.executeSql(sql);
	}
	
	//帐套
	public List getWageSet(String operUserID){
		String sql = "select set_id,set_name from wage_set where oper_ids like '%"+operUserID+"%'";
		return this.jdbcTemplate.queryForList(sql);
	}
	public List getAllWageSetBO(String itemType, String wageDate){
		return this.wageDataSetDAO.getAllWageSetBO(itemType, wageDate);
	}
	
	
	//other项目总额
	public double getWageOtherItemSum(String itemType, String wageDate, String wageSetID){
		double r = 0.0;
		try {
			String sql = "select sum(money) from wage_data_record where yearmonth='"+wageDate+"' and setid in (select id from wage_dataset where item_type='"+itemType+"') " +
					"and userid in (select p.id from wage_set_pers_r p,wage_set w where p.A815700=w.set_id and w.set_id='"+wageSetID+"')";
			if("2".equals(itemType) || "3".equals(itemType)){
				sql+= " and id in (select concat(v.dataset_user_id,'"+wageDate+"') from wage_dataset_verify v where v.status=1 and v.yearmonth='"+wageDate+"')";				
			}
			String c = this.activeapi.queryForString(sql); 
			if(c!=null && !"".equals(c)){
				r = Double.valueOf(c);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return r;
	}
	//litle项目总额
	public double getWageLitleItemSum(String itemType, String wageDate, String wageSetID){
		String set = "";
		if("1".equals(itemType)){
			set = "a229";//加班费
		}else if("2".equals(itemType)){
			set = "a233";//车公里补贴			
		}else if("5".equals(itemType)){
			set = "a228";//科研费			
		}
		double r = 0.0;
		String sql = "select sum("+set+"200) m from "+set+" where "+set+"202=2 and id in (select p.id from wage_set_pers_r p,wage_set w where p.A815700=w.set_id and w.set_id='"+wageSetID+"')";
		List list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			Map m = (Map)list.get(0);
			if(m.get("m")!=null){
				r = Double.valueOf(m.get("m").toString());				
			}
		}
		return r;
	}
	//others项目总额
	public double getWageOthersItemSum(String itemType, String wageDate){
		double r = 0.0;
		
		return r;
	}
	
	//other项目明细
	public List getWageOtherItemDetail(String itemType, String itemId, String wageDate, String userID, String wageSetID) throws SysException{
		return this.wageDataSetDAO.getWageOtherItemDetail(itemType, itemId, wageDate, userID, wageSetID);
	}
	//litle项目明细
	public List getWageLitleItemDetail(String itemType, String wageDate, String userID, String wageSetID) throws SysException{
		return this.wageDataSetDAO.getWageLitleItemDetail(itemType, wageDate, userID, wageSetID);
	}
	//others项目明细
	public List getWageOthersItemDetail(String itemType, String wageDate){
		return null;
	}
	
	//other个人项目明细
	public List getSelfWageOtherItemDetail(String itemType, String wageDate, String userID) throws SysException{
		String sql ="select w.name,r.money,r.remark from wage_dataset w,wage_data_record r where w.id=r.setid and r.userid='"+userID+"' and w.item_type='"+itemType+"' and r.yearmonth='"+wageDate+"'";
		return this.jdbcTemplate.queryForList(sql);
	}
	//litle个人项目明细
	public double getSelfWageLitleItemDetail(String itemType, String userID) throws SysException{
		String set = "";
		if("1".equals(itemType)){
			set = "a229";//加班费
		}else if("2".equals(itemType)){
			set = "a233";//车公里补贴			
		}else if("5".equals(itemType)){
			set = "a228";//科研费			
		}
		String sql = "select "+set+"200 m from "+set+" where "+set+"202=2 and id ='"+userID+"'";
		double r = 0.0;
		List list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			Map m = (Map)list.get(0);
			if(m.get("m")!=null){
				r = Double.valueOf(m.get("m").toString());				
			}
		}
		return r;
	}
	
	public double getWageSigleSum(String itemType){
		String set = null;
		if("1".equals(itemType)){
			set="a225"; 
		}else if("2".equals(itemType)){
			set="a226"; 
		}else if("3".equals(itemType)){
			set="a227";
		}
		String sql = "select sum("+set+"200) from "+set+" where "+set+"200 is not null and "+set+"200<>0 and "+set+"200<>0.0";
		double r = 0.0;
		try {
			String c = this.activeapi.queryForString(sql); 
			if(c!=null && !"".equals(c)){
				r = Double.valueOf(c);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return r;
	}
	public List getWageSigleDetail(String itemType){
		return this.wageDataSetDAO.getWageSigleDetail(itemType);
	}
	
	public List getWageSetDetail(String setID){
		return this.wageDataSetDAO.getWageSetDetail(setID);
	}

	public List getAllWageOthersDataSetBOByUserID(PageVO pageVo, String operUserID, String beginDate, String endDate,boolean notReview,boolean Reviewed) throws SysException{
		return this.wageDataSetDAO.getAllWageOthersDataSetBOByUserID(pageVo, operUserID, beginDate, endDate, notReview, Reviewed);
	}
	public void deleteWageOthersDataSetBOByID(String ID) throws SysException{
		this.wageDataSetDAO.deleteBo(WageOthersDataSetBO.class, ID);
		String sql="delete from wage_others_dataset_user where setID ='"+ID+"'";
		this.activeapi.executeSql(sql);
	}
	public void deleteWageOthersDataSetUserBOByID(String ID) throws SysException{
		this.wageDataSetDAO.deleteBo(WageOthersDataSetUserBO.class, ID);
	}
	public List getAllWageOthersDataSetUserBO(PageVO pageVo, String setID, String orgID, String personType, String nameStr, String operUserID) throws SysException{
		return this.wageDataSetDAO.getAllWageOthersDataSetUserBO(pageVo, setID, orgID, personType, nameStr, operUserID);
	}
	public List getAllWageOthersDataSetUserBOByInfo(PageVO pageVo,String yearMonth, String orgID, String personType, String nameStr) throws SysException{
		return this.wageDataSetDAO.getAllWageOthersDataSetUserBOByInfo(pageVo,yearMonth, orgID, personType, nameStr);
	}
	public List getItemList(String setId){
		String sql="select item_id,item_name from sys_info_item where item_status =1 and item_type in ('1','2') and set_id='"+setId+"'";
		List itemList =(List<Map<String,Object>>)this.jdbcTemplate.queryForList(sql);
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		for(int i=0;i<itemList.size();i++){
			Map<String,Object> map=(Map<String, Object>) itemList.get(i);
			if(map.get("ITEM_ID").equals("ID")||map.get("ITEM_ID").equals("SUBID")||map.get("ITEM_ID").equals("A234000")){
		         list.add(map);
			}
		}
		itemList.removeAll(list);
				
		return itemList;
	}
	@SuppressWarnings("unchecked")
	public void confirm(String[]selectedItemIDs, String yearmonth, String operUserID) throws SysException{
		//找出符合日期的所有项目
		String hql="select bo from WageOthersDataSetBO bo where bo.beginDate='"+yearmonth+"' and bo.status='0' and "+CommonFuns.splitInSql(selectedItemIDs, "bo.ID");
		List<WageOthersDataSetBO> setList=(List<WageOthersDataSetBO>)this.wageDataSetDAO.getHibernatetemplate().find(hql);
		if(setList!=null){
			for(WageOthersDataSetBO bo : setList){
				String itemid=bo.getID();
				String targetdata=bo.getTargetData();
				String itemdate=bo.getBeginDate();
				hql="select bo from WageOthersDataSetUserBO bo where bo.setID='"+itemid+"'  and bo.userID in ("+CommonUtil.getHQLAllWageSetPersonIDsByOperUserID(operUserID)+")";
				List<WageOthersDataSetUserBO> userList=(List<WageOthersDataSetUserBO>)this.wageDataSetDAO.getHibernatetemplate().find(hql);
				
				//逐条加入数据到a234表
				if(userList!=null){
					for(WageOthersDataSetUserBO ubo : userList){
						String sql="select * from a234 where id='"+ubo.getUserID()+"' and a234200='"+yearmonth+"'";
						List list=this.jdbcTemplate.queryForList(sql);
						double money=ubo.getMoney();
						
						if(list==null || list.size()==0){ //不是本月归档先归零
							List itemList=getItemList("A234");
							if(itemList.size()>0){
								sql ="update a234 set ";
								for(int i=0;i<itemList.size();i++){
									Map map=(Map)itemList.get(i);
									if(i==0){
										sql+=map.get("ITEM_ID")+"='0' ";
									}else if(i>0){
										sql+=","+map.get("ITEM_ID")+"='0' ";
									}
								}
								sql+=" where id ='"+ubo.getUserID()+"'";
							}
							this.jdbcTemplate.execute(sql);
						}else{
							Object o=((Map)list.get(0)).get(targetdata);
							double d=0;
							if(o!=null){
								d=Double.parseDouble(o.toString());
								money+=d;
							}
						}
						sql="update a234 set "+targetdata+"=round('"+money+"',2),a234200='"+itemdate+"' where id='"+ubo.getUserID()+"'";
						this.jdbcTemplate.execute(sql);
					}
				}
				//将项目设置为已审核
				bo.setStatus("2");
				this.wageDataSetDAO.saveOrUpdateBo(bo);
			}
		}
	}
	
	public void averageMoney(String setID, String money) throws SysException{
		if(money==null||money.equals("")){
			money="0";
		}
		String sql = "update wage_others_dataset_user set money='"+money+"' where setid='"+setID+"'";
		this.activeapi.executeSql(sql);
	}
	public void modifyUserMoney1(String setID,String userID, String money) throws SysException{
		
		String sql = "select * from wage_others_dataset_user where setid='"+setID+"' and userid='"+userID+"'";
		List<Map<String,Object>> userlist=(List<Map<String,Object>>)this.jdbcTemplate.queryForList(sql);
		if(userlist.size()<=0){
			sql="insert into wage_others_dataset_user(id,setid,userid,money) values('";
			sql+=userID+"','"+setID+"','"+userID+"','"+money+"')";
			this.activeapi.executeSql(sql);
		}else{
			sql="update wage_others_dataset_user set money='"+money+"' where setid='"+setID+"' and userid='"+userID+"'";
			this.activeapi.executeSql(sql);
		}
	}

	@Override
	public void deleteWageEmpPerson(String userID) throws SysException {
		PersonBO p =SysCacheTool.findPersonById(userID);
		String sql="delete from a239 where id='"+userID+"'";
		this.jdbcTemplate.execute(sql);
		sql="delete from a795 where id='"+userID+"'";
		this.jdbcTemplate.execute(sql);
		sql="delete from a001 where id='"+userID+"'";
		this.jdbcTemplate.execute(sql);
	}

	@Override
	public void setOAEmail(String userID1, String userID2, String userID3, String url, String soa, String onoff)
			throws SysException {
		String sql = "update sys_oa_email set userid1='"+userID1+"',userid2='"+userID2+"',userid3='"+userID3+"',url='"+url+"',soa='"+soa+"',onoff='"+onoff+"'";
		this.jdbcTemplate.execute(sql);
	}
}
