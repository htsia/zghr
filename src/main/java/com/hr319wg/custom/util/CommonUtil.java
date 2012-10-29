package com.hr319wg.custom.util;

import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.dao.CommonDAO;
import com.hr319wg.custom.pojo.bo.WageSetPersonBO;
import com.hr319wg.emp.pojo.bo.EmpPostChangeBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.user.pojo.bo.OperateBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;

public class CommonUtil {
	private CommonDAO commonDAO;
	
	public CommonDAO getCommonDAO() {
		return commonDAO;
	}

	public void setCommonDAO(CommonDAO commonDAO) {
		this.commonDAO = commonDAO;
	}

	public static Object findBOById(Class c, String id){
		try {
			CommonDAO commonDAO = (CommonDAO)SysContext.getBean("commondao");
			return commonDAO.findBoById(c, id);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 获取默认人员类别
	 * @param user
	 * @return
	 * @throws SysException
	 */
	public static String getAllPersonTypes(User user) throws SysException{
		String personType="";
		String[]values = Constants.IN_SERVICE_TYPE.split(",");
		UserAPI userapi = (UserAPI)SysContext.getBean("user_pmsAPI");
		
		Hashtable ht = userapi.getPMSQueryCode(user, "0135");
		if(ht!=null && ht.size()!=0){
			Iterator it = ht.keySet().iterator();
			while (it.hasNext()) {
				CodeItemBO cb = (CodeItemBO)ht.get(it.next());
				boolean flag=false;
				for(int i=0;i<values.length;i++){
					if(values[i].equals(cb.getItemId())){
						flag=true;
						break;
					}
				}
				if(flag){
					personType+=cb.getItemId();
					if(it.hasNext()){
						personType+=",";
					}
				}
			}
		}
		return personType;
	}
	
	
	/**
	 * 获取薪资帐套人员数组
	 * @param userID
	 * @return
	 * @throws SysException 
	 */
	public static String[] getAllWageSetPersonIDsByOperUserID(String operUserID) throws SysException{
		CommonDAO commonDAO = (CommonDAO)SysContext.getBean("commondao");
		List<WageSetPersonBO> list = commonDAO.getAllWageSetPersonsByUserID(operUserID);
		if(list!=null){
			String[]userIDs = new String[list.size()];
			for(int i=0;i<list.size();i++){
				userIDs[i]=list.get(i).getID();
			}
			return userIDs;
		}
		return null;
	}
	/**
	 * 获取薪资帐套人员hql语句
	 * @param userID
	 * @return
	 * @throws SysException 
	 */
	public static String getHQLAllWageSetPersonIDsByOperUserID(String operUserID) throws SysException{
		return "select bo.ID from WageSetPersonBO bo,WageSetBO w where bo.wageSetID=w.setId and w.operPersons like '%"+operUserID+"%'";
	}
	/**
	 * 获取薪资帐套人员sql语句
	 * @param userID
	 * @return
	 * @throws SysException 
	 */
	public static String getSQLAllWageSetPersonIDsByOperUserID(String operUserID) throws SysException{
		return "select p.id from wage_set_pers_r p,wage_set w where p.A815700=w.set_id and w.oper_ids like '%"+operUserID+"%'";
	}
	
	/**
	 * 获取所在部门排序hql语句
	 * @param userID
	 * @return
	 * @throws SysException 
	 */
	public static String getSecDeptTreeId(String operUserID) throws SysException{
		CommonDAO commonDAO = (CommonDAO)SysContext.getBean("commondao");
		return commonDAO.getHQLSecDeptTreeId(operUserID);
	}
	
	/**
	 * 获取所在部门排序sql语句
	 * @param userID
	 * @return
	 * @throws SysException 
	 */
	public static String getSQLSecDeptTreeId1(String operUserID) throws SysException{
		return "select A001738 from a001 where id= '"+operUserID+"'";
	}
	
	/**
	 * 工资变动子集填入新值
	 * @param itemID
	 * @param userID
	 * @param bo
	 * @param isZhuanzheng
	 * @throws SysException
	 */
	public static void setWageAdjust(String itemID, String userID, EmpPostChangeBO bo, boolean isZhuanzheng) throws SysException{
		CommonDAO cDao = (CommonDAO)SysContext.getBean("commondao");
		ActivePageAPI activeapi = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
		List<WageAdjustDetailBO> detailList = cDao.getAllWageAdjustBO(itemID);
    	if(detailList!=null){
    		for(WageAdjustDetailBO dBo : detailList){
    			String fieldID = dBo.getFieldID();//	        			
    			if("A223200".equals(fieldID)){ //薪级
    				String sql = null;
    				if(bo==null){
    					sql = "select C001203 from a001 a,c001 c where a.A001715=c.postid and a.id='"+userID+"'";
    				}else{
    					sql = "select C001203 from c001 c where c.postid = '"+bo.getNewPost()+"'";    					
    				}
    				dBo.setNewValue(activeapi.queryForString(sql));
    			}else if("A223204".equals(fieldID)){//变动时间
    				if(dBo.getOldValue()!=null){
    					dBo.setNewValue(dBo.getOldValue());
    				}else{
    					dBo.setNewValue(CommonFuns.getSysDate("yyyy-MM-dd"));
    				}
    			}else if("A223205".equals(fieldID)){//人员状态
    				if(isZhuanzheng){
    					dBo.setNewValue("0145700284");
    				}else{
    					if(dBo.getOldValue()!=null){
    						dBo.setNewValue(dBo.getOldValue());
    					}  					
    				}
    			}else{
    				if(dBo.getOldValue()!=null){
    					dBo.setNewValue(dBo.getOldValue());
    				}
    			}
    			cDao.saveOrUpdateBo(dBo);
    		}
    	}
	}
	
	//添加工资变动子集记录
	public static void addWageChange(String userID, String currStatus) throws SysException{
		String sql = "select C001203 from a001 a,c001 c where a.A001715=c.postid and a.id='"+userID+"'";
		ActivePageAPI activeapi = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
		String xinji = activeapi.queryForString(sql);
		String subid = SequenceGenerator.getKeyId("A223");
		sql = "insert into a223 (id,subid,A223000,A223200,A223205) values ('"+userID+"','"+subid+"','00901','"+xinji+"','"+currStatus+"')";
		activeapi.executeSql(sql);
	}
	
	//获取所有下级岗位
	public static String getAllSubPostIDs(String operUserID) throws SysException{
		String postIDs="";
		String subpostIDs="";
		boolean hasNext=true;
		JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
		String sql = "select A001715 from a001 where id = '"+operUserID+"'";
		List list = jdbc.queryForList(sql);
		if(list!=null && list.size()>0){
			Map m = (Map)list.get(0);
			if(m.get("A001715")==null || "".equals(m.get("A001715").toString())){
				return null;
			}
			subpostIDs=m.get("A001715")+",";
		}else{
			return null;
		}
		do {
			sql = "select postid from c001 where "+CommonFuns.splitInSql(subpostIDs.split(","), "C001015");
			subpostIDs="";
			list = jdbc.queryForList(sql);
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					Map m = (Map)list.get(i);
					subpostIDs+=m.get("postid")+",";
				}
				postIDs+=subpostIDs;
			}else{
				hasNext=false;
			}
		} while (hasNext);
		return postIDs;
	}
	
	//判断是否拥有指定权限
	public static int getRoleCount(String roleID, String userID) throws SysException{
		String sql = "select count(*) from sys_role_user_r r where r.role_id='"+roleID+"' and r.person_id='"+userID+"'";
		ActivePageAPI activeapi = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
		return activeapi.queryForInt(sql);
	}
	
	//获取所有在自助中的大模块
	public static List<OperateBO> getAllModulesInSelf() throws SysException{
		CommonDAO commonDAO = (CommonDAO)SysContext.getBean("commondao");
		return commonDAO.getAllModulesInSelf();
	}

	//是否有审批
	public static int getAttLogCount(String ID) throws SysException{
		String sql = "select count(*) from att_log where leave_id='"+ID+"'";
		ActivePageAPI activeapi = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
		return activeapi.queryForInt(sql);
	}
	/**
	 * 获取已审批人员hql语句
	 * @param userID
	 * @return
	 * @throws SysException 
	 */
	public static String getHQLAllAttLog(String attBO, String operUserID) throws SysException{
		return "select bo.personId from "+attBO+" bo,AttLogBO l where bo.Id=l.leaveId and l.personId= '"+operUserID+"'";
	}
}
