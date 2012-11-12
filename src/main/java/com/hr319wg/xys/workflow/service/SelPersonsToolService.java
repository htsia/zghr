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
	private static final String defaultRoleName="����HRҵ���ܼ�";
	
	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}

	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}

	/**
	 * ��ȡ�����������б�
	 * @param operUserID
	 * @param keyId
	 * @param map
	 * @return
	 * @throws SysException
	 */
	public String getAllApprUserNames(String operUserID, String keyId, Map map) throws SysException{
		
		// Ϊ�������ò�������������
		String processInstanceId = this.activitiToolService.startProcessInstance(keyId, ""+System.currentTimeMillis(), map);

		//�Զ���ת���̣��������������
		boolean finished = activitiToolService.checkProcessIsFinish(processInstanceId);
		List<String> userIds = new ArrayList<String>();
		while(!finished){
			//��õ�ǰ������
			List<String> owners = activitiToolService.getOwners(processInstanceId);
			userIds.addAll(owners);
	
			//��ת
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
	 * ���ݽ�ɫ���Ʒ��ط����������û�
	 * @param roleNames ��ɫ���ƣ�����ԡ����������
	 * @param deptId ���ű�ʶ
	 * @param excFlag �Ƿ��ų��������� true �ų� false ���ų�
	 * @return  ���� Ա��ID��list
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
	 * ���ݶ������ű�Ż�ȡ����������Ա
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
	 * �����Ŷӱ�ʶ
	 * @param personId �û���ʶ
	 * @return
	 * @throws SysException
	 */
	public String getGroupCodeByPersonId(String personId)throws SysException{
		String sql="select A001750 from A001 where id='"+personId+"'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * ��ø�λ����
	 * @param personId �û���ʶ
	 * @return
	 * @throws SysException
	 */
	public String getPostLevel(String personId)throws SysException{
		String sql="select a001217 from A001 where id='"+personId+"'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * ��ø�λ����
	 * @param personId �û���ʶ
	 * @return
	 * @throws SysException
	 */
	public String getPostCode(String personId)throws SysException{
		String sql="select A001715 from A001 where id='"+personId+"'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * ���У��
	 * @param personId �û���ʶ
	 * @return
	 * @throws SysException
	 */
	public String getXiaoZhang()throws SysException{
		String sql="select a.id  from a001 a,c001 c where a.A001715=c.postid and c.postid = '68625'";
		return activePageAPI.queryForString(sql);
	}
	
	/**
	 * �ж�ָ����Ա�Ƿ�У�����߶��³�
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
	 * ����ϼ��쵼ID
	 * @param personId �û���ʶ
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
			throw new SysException("����Ŀ����Աʧ��");
		}
		if(list == null || list.size() == 0){
			throw new SysException("δ�ҵ�Ŀ����Ա����ȷ�ϵ�ǰ��Ա���ϼ���λ�Ƿ��������Ա");
		}
		return list;
	}
	
	
	/**
	 * ����ϼ��쵼�������һ����Ա������������
	 * @param personId �û���ʶ
	 * @return 1���ϼ�Ϊ�����λ��ϼ�Ϊʵ���������Σ�2���ϼ�Ϊϵ���Σ�3���ϼ�Ϊ������4���ϼ�ΪУ��,999������
	 * @throws SysException
	 */
	public int getLeaderType(String personId)throws SysException{
		
		//��õ�ǰ�û��ϼ���λ�ĸ�λ����͸�λ����
		String sql="select C001020||','||C001005 from c001 where c001.postid = ( select c.c001015 from a001 a,c001 c where a.A001715=c.postid and a.id = '"+personId+"')";
		String[] postInfo = activePageAPI.queryForString(sql).split(",");
		if(postInfo == null || postInfo.length < 2){
			throw new SysException("�ϼ���λ�쳣������ϵ����Ա");
		}
		
		String postLevel = postInfo[0];//�ϼ���λ����
		String postName = postInfo[1];//�ϼ���λ����
		
		if(postName != null && (postName.contains("����������") || postName.contains("ʵ����������"))){
			return 1;
		}
		if(postName != null && postName.contains("ϵ����")){
			return 2;
		}
		//�ж��Ƿ�Ϊ����
		if("3018700415".equals(postLevel)
				||"3018700416".equals(postLevel)
				||"3018700568".equals(postLevel)
				){
			 return 3;
		 }
		//�ж��Ƿ�ΪУ��
		if("3018700422".equals(postLevel)
				||"3018700425".equals(postLevel)
				||"3018700418".equals(postLevel)
				){
			 return 4;
		 }
		//����ͳһ����999
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
