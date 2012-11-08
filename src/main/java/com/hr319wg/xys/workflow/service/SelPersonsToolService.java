package com.hr319wg.xys.workflow.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.task.Task;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.attence.util.AttConstants;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class SelPersonsToolService {
	private JdbcTemplate jdbcTemplate;
	private ActivePageAPI activePageAPI;
	private ActivitiToolsService activitiToolService;
	private static final String defaultRoleName="集团HR业务总监";
	
	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}

	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}

	/**
	 * 获取所有审批人列表
	 * @param operUserID
	 * @param keyId
	 * @param map
	 * @return
	 * @throws SysException
	 */
	public String getAllApprUserNames(String operUserID, String keyId, Map map) throws SysException{
		
		// 为流程配置参数并启动流程
		String processInstanceId = this.activitiToolService.startProcessInstance(keyId, ""+System.currentTimeMillis(), map);

		//自动流转流程，获得所有审批人
		boolean finished = activitiToolService.checkProcessIsFinish(processInstanceId);
		List<String> userIds = new ArrayList<String>();
		while(!finished){
			//获得当前审批人
			List<String> owners = activitiToolService.getOwners(processInstanceId);
			userIds.addAll(owners);
	
			//流转
			Task task = activitiToolService.getTaskByInstanceId(processInstanceId);
			Map map1 = new HashMap();
			map1.put("doAudit", new Boolean(true));
			map1.put("currPersonId", owners.get(0));
			activitiToolService.completeTask(task.getId(), map1);
			finished = activitiToolService.checkProcessIsFinish(processInstanceId);
		}
		String userNames="";
		for(String u : userIds){
			PersonBO p = SysCacheTool.findPersonById(u);
			userNames+=p.getName()+",";
		}
		return userNames;
	}
	
	/**
	 * 根据角色名称返回符合条件的用户
	 * @param roleNames 角色名称（多个以“，”间隔）
	 * @param deptId 部门标识
	 * @param excFlag 是否排除其他部门 true 排除 false 不排除
	 * @return  包含 员工ID的list
	 * @throws SysException
	 */
	public List getPersonIdsByRoleId(String roleNames, String deptId, String leave, boolean filterDept)throws SysException{
		List list=null;
		String roleName[]=roleNames.split(",");
		String sql="select person_id from sys_role_user_r where sys_role_user_r.role_id " +
				"in(select sys_roleinfo.role_id from sys_roleinfo where "+CommonFuns.splitInSql(roleName, "role_name")+")";
		if(filterDept&&deptId!=null&&!deptId.equals("")){
			String treeId=SysCacheTool.findOrgById(deptId).getTreeId();
			if("1".equals(leave)){
//				treeId=treeId.substring(0, endIndex)
			}
			sql+=" and sys_role_user_r.person_id in (select id from A001 where A001738 like '"+treeId+"%')";
		}
		list=this.jdbcTemplate.query(sql,new PersonIdRowMapper());
		if(list==null||list.size()<=0){
			sql="select person_id from sys_role_user_r where sys_role_user_r.role_id " +
			"in(select sys_roleinfo.role_id from sys_roleinfo where role_name='"+defaultRoleName+"')";
			list=jdbcTemplate.query(sql,new PersonIdRowMapper());
		}
		return list;
	}
	
	/**
	 * 根据二级部门编号获取符合条件人员
	 * @param secDeptCode
	 * @return
	 */
	public List getPersonIdsBySecDeptCode(String secDeptCode){
		List list=null;
		try {
			String postId = AttConstants.getPostIdBySecDeptCode(secDeptCode);
			if(postId!=null){
				String sql = "select id person_id from a001 where a001715='"+postId+"'";
				list=this.jdbcTemplate.query(sql,new PersonIdRowMapper());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 返回团队标识
	 * @param personId 用户标识
	 * @return
	 * @throws SysException
	 */
	public String getGroupCodeByPersonId(String personId)throws SysException{
		String sql="select A001750 from A001 where id='"+personId+"'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * 获得岗位级别
	 * @param personId 用户标识
	 * @return
	 * @throws SysException
	 */
	public String getPostLevel(String personId)throws SysException{
		String sql="select a001217 from A001 where id='"+personId+"'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * 获得岗位代码
	 * @param personId 用户标识
	 * @return
	 * @throws SysException
	 */
	public String getPostCode(String personId)throws SysException{
		String sql="select A001715 from A001 where id='"+personId+"'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * 获得校长
	 * @param personId 用户标识
	 * @return
	 * @throws SysException
	 */
	public String getXiaoZhang()throws SysException{
		String sql="select a.id  from a001 a,c001 c where a.A001715=c.postid and c.postid = '68625'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * 判断指定人员是否校长或者董事长
	 * @param personId
	 * @return
	 * @throws SysException
	 */
	public boolean isXiaoZhangOrLiShiZhang(String personId)throws SysException{
		String postCode = this.getPostCode(personId);
		if("68624".equals(postCode) || "68625".equals(postCode)){
			return true;
		}
		return false;
	}
	
	/**
	 * 获得上级领导ID
	 * @param personId 用户标识
	 * @return
	 * @throws SysException
	 */
	public List getLeaderIds(String personId)throws SysException{
		List list=null;
		try {
				String sql="select id person_id from a001 where a001715= ( select c.c001015 from a001 a,c001 c where a.A001715=c.postid and a.id = '"+personId+"')";
				list=this.jdbcTemplate.query(sql,new PersonIdRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			throw new SysException("查找目标人员失败");
		}
		if(list == null || list.size() == 0){
			throw new SysException("未找到目标人员，请确认当前人员的上级岗位是否关联有人员");
		}
		return list;
	}
	
	
	/**
	 * 获得上级领导类别，用于一般人员考勤流程审批
	 * @param personId 用户标识
	 * @return 1：上级为室主任或上级为实验中心主任，2：上级为系主任，3：上级为处级，4：上级为校级,999：其他
	 * @throws SysException
	 */
	public int getLeaderType(String personId)throws SysException{
		
		//获得当前用户上级岗位的岗位级别和岗位名称
		String sql="select C001020||','||C001005 from c001 where c001.postid = ( select c.c001015 from a001 a,c001 c where a.A001715=c.postid and a.id = '"+personId+"')";
		String[] postInfo = activePageAPI.queryForString(sql).split(",");
		if(postInfo == null || postInfo.length < 2){
			throw new SysException("上级岗位异常，请联系管理员");
		}
		
		String postLevel = postInfo[0];//上级岗位级别
		String postName = postInfo[1];//上级岗位名称
		
		if(postName != null && (postName.contains("教研室主任") || postName.contains("实验中心主任"))){
			return 1;
		}
		if(postName != null && postName.contains("系主任")){
			return 2;
		}
		//判断是否为处级
		if("3018700415".equals(postLevel)
				||"3018700416".equals(postLevel)
				||"3018700568".equals(postLevel)
				){
			 return 3;
		 }
		//判断是否为校级
		if("3018700422".equals(postLevel)
				||"3018700425".equals(postLevel)
				||"3018700418".equals(postLevel)
				){
			 return 4;
		 }
		//其他统一返回999
		return 999;
	}
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}

	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}
	
}
