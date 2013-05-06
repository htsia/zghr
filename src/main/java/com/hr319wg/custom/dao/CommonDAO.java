
package com.hr319wg.custom.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.pojo.bo.WageSetPersonBO;
import com.hr319wg.emp.pojo.bo.EmpPostChangeBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.user.pojo.bo.OperateBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;

public class CommonDAO extends BaseDAO{
	
	public String getHQLSecDeptTreeId(String operUserID) throws SysException{
		String hql = "select bo from UserBO bo where bo.userID= '"+operUserID+"'";
		List<UserBO> list = this.hibernatetemplate.find(hql);
		if(list!=null && list.size()>0){
			return list.get(0).getDeptSort().substring(0,9);
		}
		return "-1";
	}
	
	public List<EmpPostChangeBO> getAllEmpPostChangeBO(){
		String hql = "select bo from EmpPostChangeBO bo where bo.status=0";
		return this.hibernatetemplate.find(hql);
	}
	
	public List<WageAdjustDetailBO> getAllWageAdjustBO(String itemID){
		String hql = "select bo from WageAdjustDetailBO bo where bo.itemID='"+itemID+"'";
		return this.hibernatetemplate.find(hql);
	}
	
	//��ȡ������Ա
	public List<WageSetPersonBO> getAllWageSetPersonsByUserID(String userID){
		String hql = "select bo from WageSetPersonBO bo,WageSetBO w where bo.wageSetID=w.setId and w.operPersons like '%"+userID+"%'";
		return this.hibernatetemplate.find(hql);
	}
	
	//��ȡ�����������еĴ�ģ��
	public List<OperateBO> getAllModulesInSelf(){
		String hql = "select bo from OperateBO bo where bo.inSelf='1' and bo.superId='-1'";
		return this.hibernatetemplate.find(hql);	
	}
	
//	5a9ded4739fc2c3a0139fcc986940338	����--�в��쵼
//	5a9ded473a35b8f7013a3e1c57e51488	����--У���쵼
//	08	Ա��

	//��ȡ����ģ������˵�
	public List<OperateBO> getAllSubOperateBOInSelf(String superID, String userID) throws SysException{
		String hql = "select bo from OperateBO bo where bo.inSelf=1 and bo.superId='"+superID+"' and bo.operateId in (select f.operateId from OperateBO f,OperateBO s,UserSelfOperBO op where f.operateId=s.superId and s.operateId =op.OperateID and op.PersonID='"+userID+"') order by bo.treeId";
		return this.hibernatetemplate.find(hql);
	}
	//�����ϼ��˵���ȡ����ģ�������˵�
	public List<OperateBO> getAllOperateBOBySuperID(String superID, String userID, String bylevel) throws SysException{
		String hql = "select bo from OperateBO bo where bo.inSelf=1 and bo.superId='"+superID+"' and bo.operateId in (select op.OperateID from UserSelfOperBO op where op.PersonID='"+userID+"')";
		
		if("1".equals(bylevel)){
			//У���쵼
			String leavelSql = "select count(*) from sys_role_user_r where person_id='"+userID+"' and role_id='5a9ded4739fc2c3a0139fcc986940338'";
			ActivePageAPI activeapi = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
			int count = activeapi.queryForInt(leavelSql);
			if(count>0){
				hql += "  and bo.operateId in (select rs.OperateID from RoleSelfOperBO rs where rs.roleID='5a9ded4739fc2c3a0139fcc986940338')";
			}else{
				//Ա��
				leavelSql = "select count(*) from sys_role_user_r where person_id='"+userID+"' and role_id='08'";
				count = activeapi.queryForInt(leavelSql);
				if(count>0){
					hql += "  and bo.operateId in (select rs.OperateID from RoleSelfOperBO rs where rs.roleID='08')";
				}
			}
		}
		hql += " order by bo.treeId";
		return this.hibernatetemplate.find(hql);	
	}
	//��ȡ����ģ��˵�
	public List<OperateBO> getAllOperateBO(String moduleID, String userID, String bylevel) throws SysException{
		String hql = "select bo from OperateBO bo where bo.inSelf=1 and bo.moduleID='"+moduleID+"' and bo.operateId in (select op.OperateID from UserSelfOperBO op where op.PersonID='"+userID+"')";
		
		if("1".equals(bylevel)){
			//У���쵼
			String leavelSql = "select count(*) from sys_role_user_r where person_id='"+userID+"' and role_id='5a9ded4739fc2c3a0139fcc986940338'";
			ActivePageAPI activeapi = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
			int count = activeapi.queryForInt(leavelSql);
			if(count>0){
				hql += "  and bo.operateId in (select rs.OperateID from RoleSelfOperBO rs where rs.roleID='5a9ded4739fc2c3a0139fcc986940338')";
			}else{
				//Ա��
				leavelSql = "select count(*) from sys_role_user_r where person_id='"+userID+"' and role_id='08'";
				count = activeapi.queryForInt(leavelSql);
				if(count>0){
					hql += "  and bo.operateId in (select rs.OperateID from RoleSelfOperBO rs where rs.roleID='08')";
				}
			}
		}
		hql += " order by bo.treeId";
		return this.hibernatetemplate.find(hql);	
	}
	
	public List getRptList(String userID) throws SysException {
		String sql = "select bo from RptSetUserBO bo,RoleUserBO u where bo.roleID=u.roleID and u.personID='" + userID + "'";
		return this.hibernatetemplate.find(sql);
	}
	
	public List getSetFile(String setID, String itemID, String personID) throws SysException{
		String sql="select bo from SetFileBO bo where bo.setID='"+setID+"' and bo.itemID='"+itemID+"' and bo.personID='"+personID+"'";
		return this.hibernatetemplate.find(sql);
	}
}
