package com.hr319wg.user.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.util.CommonFuns;

public class UserRptDAO extends BaseDAO {
	public List queryUserRpt(String userID, String OperID) throws SysException {
		try {
			StringBuffer sb = new StringBuffer();
			
			if ("SQL SERVER".equals(Constants.DB_TYPE)) {
				sb.append(
						"select r from UserRptVO r,RoleUserBO u where r.roleID=u.roleID and r.rptName is not null and r.rptName<>'' and r.personID='")
						.append(userID).append("' and r.operateID='")
						.append(OperID).append("' order by r.showQue");
			} else {
				sb.append(
						"select r from UserRptVO r,RoleUserBO u where r.roleID=u.roleID and r.rptName is not null  and r.personID='")
						.append(userID).append("' and r.operateID='")
						.append(OperID).append("' order by r.showQue");
			}

			List list = this.hibernatetemplate.find(sb.toString());
			List list2 = new ArrayList();
			int len = list.size();
			for (int i = 0; i < len; i++) {
				UserRptVO role = new UserRptVO();
				CommonFuns.copyProperties(role, list.get(i));
				list2.add(role);
			}
			return list2;
		} catch (Exception e) {
			throw new SysException("", "读取数据错误!", e, UserRoleDAO.class);
		}
	}

	public List queryUserRpt(String userID, String OperID, String type)
			throws SysException {
		try {
			StringBuffer sb = new StringBuffer();
			if ("SQL SERVER".equals(Constants.DB_TYPE)) {
				sb.append(
						"select r from UserRptVO r,RoleUserBO u where r.roleID=u.roleID and r.rptName is not null and r.rptName<>'' and r.personID='")
						.append(userID).append("' and r.operateID='")
						.append(OperID).append("' and r.rpttype='")
						.append(type).append("' order by r.showQue");
			} else {
				sb.append(
						"select r from UserRptVO r,RoleUserBO u where r.roleID=u.roleID and r.rptName is not null  and u.personID='")
						.append(userID).append("' and r.operateID='")
						.append(OperID).append("' and r.rpttype='")
						.append(type).append("' order by r.showQue");
			}

			List list = this.hibernatetemplate.find(sb.toString());
			List list2 = new ArrayList();
			int len = list.size();
			for (int i = 0; i < len; i++) {
				UserRptVO role = new UserRptVO();
				CommonFuns.copyProperties(role, list.get(i));
				list2.add(role);
			}
			return list2;
		} catch (Exception e) {
			throw new SysException("", "读取数据错误!", e, UserRoleDAO.class);
		}
	}

	public List queryUserRptDir(String userID, String OperID)
			throws SysException {
		try {
			StringBuffer sb = new StringBuffer();
			if ("SQL SERVER".equals(Constants.DB_TYPE)) {
				sb.append(
						"select r from UserRptVO r,RoleUserBO u where r.roleID=u.roleID and r.rptName is not null and r.rptName<>'' and r.personID='")
						.append(userID).append("' and r.operateID='")
						.append(OperID).append("' order by r.showQue");
			} else {
				sb.append(
						"select r from UserRptVO r,RoleUserBO u where r.roleID=u.roleID and r.rptName is not null  and r.personID='")
						.append(userID).append("' and r.operateID='")
						.append(OperID).append("' order by r.showQue");
			}

			List list = this.hibernatetemplate.find(sb.toString());
			List list2 = new ArrayList();
			int len = list.size();
			for (int i = 0; i < len; i++) {
				UserRptVO role = new UserRptVO();
				CommonFuns.copyProperties(role, list.get(i));

				int j = 0;
				for (; j < list2.size(); j++) {
					UserRptVO temp = (UserRptVO) list2.get(j);
					if (temp.getRptDir().equals(role.getRptDir()))
						break;
				}
				if (j < list2.size())
					continue;
				list2.add(role);
			}
			return list2;
		} catch (Exception e) {
			throw new SysException("", "读取数据错误!", e, UserRoleDAO.class);
		}
	}
}