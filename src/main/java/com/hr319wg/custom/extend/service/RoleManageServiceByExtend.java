package com.hr319wg.custom.extend.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.service.RoleManageService;

public class RoleManageServiceByExtend extends RoleManageService {

	public List queryAllRoleInfos(String userId) throws SysException {
		List<RoleInfoBO> list = this.getUserroledao().queryUserRole(userId);
		if ((list != null) && (list.size() > 0)) {
			return this.getRoleinfodao().QueryAllRoleInfos(list);
		}
		return null;
	}

	public List queryAllRoleInfos(String userId, String OperID)
			throws SysException {
		List<RoleInfoBO> list = this.getUserroledao().queryUserRole(userId);
		if ((list != null) && (list.size() > 0)) {
			return this.getRoleinfodao().QueryAllRoleInfos(list, OperID);
		}
		return null;
	}
}
