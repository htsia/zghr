package com.hr319wg.user.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.user.pojo.bo.RoleDataBO;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.pojo.bo.RoleOperateBO;
import com.hr319wg.user.pojo.bo.RoleOrgScaleBO;
import com.hr319wg.user.pojo.bo.RolePartyScaleBO;
import com.hr319wg.util.CommonFuns;

public class RoleInfoDAO extends BaseDAO {
	
	public List QueryAllRoleInfos(List<RoleInfoBO> roleList) throws SysException {
		StringBuffer sb = new StringBuffer();
		boolean isMAJORDOMO=false;
		String sysRoleId=null;
		for(RoleInfoBO r : roleList){
			if(r.getRoleId().equals(RoleInfoBO.MAJORDOMO_ROLE_ID)){
				isMAJORDOMO=true;
				sysRoleId=r.getRoleId();
				break;
			}
		}
		if(sysRoleId==null){
			sysRoleId=roleList.get(0).getRoleId();
		}
		if (sysRoleId.equals(RoleInfoBO.MAJORDOMO_ROLE_ID)) {
			sb.append("from RoleInfoBO rd where rd.creator='").append(sysRoleId).append("' or rd.creator='system' order by rd.roleName");
		} else {
			sb.append("from RoleInfoBO rd where rd.creator='").append(sysRoleId).append("' order by rd.roleName");
		}

		return this.hibernatetemplate.find(sb.toString());
	}

	public List QueryAllRoleInfos(List<RoleInfoBO> roleList, String OperID)
			throws SysException {
		StringBuffer sb = new StringBuffer();
		boolean isMAJORDOMO=false;
		String sysRoleId=null;
		for(RoleInfoBO r : roleList){
			if(r.getRoleId().equals(RoleInfoBO.MAJORDOMO_ROLE_ID)){
				isMAJORDOMO=true;
				sysRoleId=r.getRoleId();
				break;
			}
		}
		if(sysRoleId==null){
			sysRoleId=roleList.get(0).getRoleId();
		}
		if (isMAJORDOMO) {
			sb.append("from RoleInfoBO rd where (rd.creator='").append(sysRoleId).append("' or rd.creator='system')");
		} else {
			sb.append("from RoleInfoBO rd where rd.creator='").append(sysRoleId).append("'");
		}

		sb.append(" and rd.roleId in (select bo.roleId from RoleOperateBO bo where bo.operateId='" + OperID + "')");
		sb.append(" order by rd.roleName");
		return this.hibernatetemplate.find(sb.toString());
	}

	public boolean checkCurrentUserBySysRoleId(String sysRoleId)
			throws SysException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("select count(*) from User u where u.belongRoleId='")
					.append(sysRoleId).append("'");

			List list = this.hibernatetemplate.find(sb.toString());
			String s = list.get(0).toString();
			int count = Integer.parseInt(s);
			return count > 0;
		} catch (Exception e) {
			throw new SysException("", "读取数据错误!", e, RoleInfoDAO.class);
		}
	}

	public boolean checkSubRoleBySysRoleId(String sysRoleId)
			throws SysException {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("select count(*) from RoleInfoBO rd where rd.creator='")
					.append(sysRoleId).append("'");

			List list = this.hibernatetemplate.find(sb.toString());
			String s = list.get(0).toString();
			int count = Integer.parseInt(s);
			return count > 0;
		} catch (Exception e) {
			throw new SysException("", "读取数据错误!", e, RoleInfoDAO.class);
		}
	}

	public void deleteRoleInfo(String roleId) throws SysException {
		try {
			deleteBo(RoleInfoBO.class, roleId);
			List list = this.hibernatetemplate
					.find("from RoleOperateBO r where r.roleId='" + roleId
							+ "'");
			if ((list != null) && (list.size() > 0))
				this.hibernatetemplate.deleteAll(list);
			list = this.hibernatetemplate
					.find("from RoleDataBO r where r.roleId='" + roleId + "'");
			if ((list != null) && (list.size() > 0))
				this.hibernatetemplate.deleteAll(list);
			list = this.hibernatetemplate
					.find("from RolePartyScaleBO r where r.roleId='" + roleId
							+ "'");
			if ((list != null) && (list.size() > 0))
				this.hibernatetemplate.deleteAll(list);
			list = this.hibernatetemplate
					.find("from RoleOrgScaleBO r where r.roleId='" + roleId
							+ "'");
			if ((list != null) && (list.size() > 0))
				this.hibernatetemplate.deleteAll(list);
		} catch (Exception e) {
			throw new SysException("", "删除权限信息失败!", e, RoleInfoDAO.class);
		}
	}

	public void saveAsRoleInfo(String newRoleName, String sourceRoleId)
			throws SysException {
		try {
			List list = this.hibernatetemplate
					.find("from RoleInfoBO r where r.roleId = '" + sourceRoleId
							+ "'");
			RoleInfoBO sRole = (RoleInfoBO) list.get(0);
			RoleInfoBO dRole = new RoleInfoBO();
			CommonFuns.copyProperties(dRole, sRole);
			dRole.setRoleId("");
			dRole.setRoleName(newRoleName);
			String newRoleId = (String) this.hibernatetemplate.save(dRole);

			list = this.hibernatetemplate
					.find("from RoleOperateBO r where r.roleId = '"
							+ sourceRoleId + "'");
			if ((list != null) && (list.size() > 0)) {
				for (int i = 0; i < list.size(); i++) {
					RoleOperateBO oper = new RoleOperateBO();
					CommonFuns.copyProperties(oper, list.get(i));
					oper.setRoleId(newRoleId);
					oper.setRoleOperateId("");
					this.hibernatetemplate.save(oper);
				}
			}

			list = this.hibernatetemplate
					.find("from RoleDataBO r where r.roleId = '" + sourceRoleId
							+ "'");
			if ((list != null) && (list.size() > 0)) {
				for (int i = 0; i < list.size(); i++) {
					RoleDataBO data = new RoleDataBO();
					CommonFuns.copyProperties(data, list.get(i));
					data.setRoleId(newRoleId);
					data.setRoleDataId("");
					this.hibernatetemplate.save(data);
				}
			}

			list = this.hibernatetemplate
					.find("from RoleOrgScaleBO r where r.roleId = '"
							+ sourceRoleId + "'");
			if ((list != null) && (list.size() > 0)) {
				for (int i = 0; i < list.size(); i++) {
					RoleOrgScaleBO orgscale = new RoleOrgScaleBO();
					CommonFuns.copyProperties(orgscale, list.get(i));
					orgscale.setRoleId(newRoleId);
					orgscale.setOrgScaleId("");
					this.hibernatetemplate.save(orgscale);
				}

			}

			list = this.hibernatetemplate
					.find("from RolePartyScaleBO r where r.roleId = '"
							+ sourceRoleId + "'");
			if ((list != null) && (list.size() > 0)) {
				for (int i = 0; i < list.size(); i++) {
					RolePartyScaleBO partyscale = new RolePartyScaleBO();
					CommonFuns.copyProperties(partyscale, list.get(i));
					partyscale.setRoleId(newRoleId);
					partyscale.setPartyScaleId("");
					this.hibernatetemplate.save(partyscale);
				}
			}
		} catch (Exception e) {
			throw new RollbackableException("", "角色复制失败!", e, RoleInfoDAO.class);
		}
	}
}