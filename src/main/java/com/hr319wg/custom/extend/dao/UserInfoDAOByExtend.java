package com.hr319wg.custom.extend.dao;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.user.dao.UserInfoDAO;
import com.hr319wg.user.pojo.bo.RoleInfoBO;

public class UserInfoDAOByExtend extends UserInfoDAO {

	/**
	 * flag 1有,0排除
	 * type 1操作,0查询
	 */
	public List queryUserOrgScaleByLoginCall(User user, String flag, String type)
			throws SysException {
		String userId = user.getUserId();
		StringBuffer sf = new StringBuffer();
		List list = new ArrayList();

		if ((MAJORDOMO.equals(isSysManager(user.getUserId())))
				|| (SUPERMAN.equals(isSysManager(user.getUserId())))
				|| (RoleInfoBO.ORGTYPE_ALL.equals(user.getprocessUnit()))) {
			if ("1".equals(type)){
				sf.append("select org.orgId from OrgBO org where org.superId='-1'");
			}else{
				return list;
			}
		} else {
			if ((RoleInfoBO.ORGTYPE_DEPT.equals(user.getprocessUnit()))
					|| (RoleInfoBO.ORGTYPE_OWN.equals(user.getprocessUnit()))
					|| (RoleInfoBO.ORGTYPE_SUPER_DEPT.equals(user
							.getprocessUnit()))) {
				PersonBO person = SysCacheTool.findPersonById(userId);
				OrgBO[] obo = null;
				if (RoleInfoBO.ORGTYPE_DEPT.equals(user.getprocessUnit())) {
					obo = this.getOrgdao().queryAllOrgBySuperSelfTopToDown(
							person.getDeptTreeId());
				} else if (RoleInfoBO.ORGTYPE_SUPER_DEPT.equals(user
						.getprocessUnit())) {
					OrgBO superDept = SysCacheTool.findOrgById(SysCacheTool
							.findOrgById(person.getDeptId()).getSuperId());
					if (OrgBO.DEPTTYPE.equals(superDept.getorgType())) {
						obo = this.getOrgdao().queryAllOrgBySuperSelfTopToDown(
								superDept.getTreeId());
					} else{
						obo = this.getOrgdao().queryAllOrgBySuperSelfTopToDown(person.getDeptTreeId());
					}
				} else {
					obo = this.getOrgdao().queryAllOrgBySuperSelfTopToDown(person.getOrgTreeId());
				}

				Hashtable superOrg = new Hashtable();
				if (type.equals("1")) {
					for (int j = 0; j < obo.length; j++) {
						if ((j != 0) && (!user.ischo()) && (OrgBO.UNITTYPE.equals(obo[j].getorgType()))) {
							superOrg.put(obo[j].getOrgId(), obo[j]);
						} else if (!superOrg.containsKey(obo[j].getSuperId())) {
							list.add(obo[j]);
						} else {
							superOrg.put(obo[j].getOrgId(), obo[j]);
						}
					}

					return list;
				}

				for (int j = 0; j < obo.length; j++) {
					if ((j != 0) && (!user.ischo()) && (OrgBO.UNITTYPE.equals(obo[j].getorgType()))) {
						superOrg.put(obo[j].getOrgId(), obo[j]);
						list.add(obo[j]);
					} else if (superOrg.containsKey(obo[j].getSuperId())) {
						superOrg.put(obo[j].getOrgId(), obo[j]);
						list.add(obo[j]);
					}
				}

				return list;
			}

			sf.append("select rorg.condId from  RoleOrgScaleBO rorg, UserRoleBO urole  ")
					.append("where   rorg.roleId = urole.roleId and rorg.codeId='DEPT' ");
			if (("0".equals(type)) && ("1".equals(flag))) {
				sf.append(" and rorg.pmsType='0'");
			} else{
				sf.append(" and rorg.scaleFlag='").append(flag).append("' ").append(" and rorg.pmsType='").append(type).append("'");
			}

			sf.append(" and urole.personId='").append(userId).append("'").append(" order by rorg.condId");
		}

		try {
			Hashtable hashOrg = new Hashtable();
			List tmplst = this.hibernatetemplate.find(sf.toString());
			int len = tmplst.size();

			for (int i = 0; i < len; i++) {
				String orgId = tmplst.get(i).toString();
				if (hashOrg.containsKey(orgId)){
					continue;
				}
				OrgBO org = SysCacheTool.findOrgById(orgId);
				if (org != null) {
					list.add(org);
					hashOrg.put(orgId, org);
				}
			}

			return list;
		} catch (Exception e) {
			throw new SysException("", "读取数据错误！", e, UserInfoDAO.class);
		}
	}
	
	public Hashtable queryPmsCode(String userId, String flag)
			throws SysException {
		String sql=null;
		String isSysManager = isSysManager(userId);
		if ((MAJORDOMO.equals(isSysManager)) || (SUPERMAN.equals(isSysManager))) {
			sql="select codeitem.setId,codeitem.itemId from CodeItemBO codeitem where codeitem.setId in ('0110','0135','0391') and codeitem.itemStatus='1' order by codeitem.setId,codeitem.treeId";
		} else {
			sql="select rorg.codeId,rorg.condId from  RoleOrgScaleBO rorg, UserRoleBO urole,CodeItemBO cb where cb.itemId=rorg.condId and rorg.roleId = urole.roleId and rorg.codeId<>'DEPT' and urole.personId='"+userId+
					"' and rorg.scaleFlag='"+flag+"' and rorg.codeId in ('0110','0135','0391') order by rorg.codeId,cb.treeId";
		}

		Hashtable hash = new Hashtable();
		try {
			List tmplst = this.hibernatetemplate.find(sql);
			if (tmplst == null)
				return null;
			int len = tmplst.size();
			String setId = "";
			List list = null;
			for (int i = 0; i < len; i++) {
				Object[] obj = (Object[]) (Object[]) tmplst.get(i);
				String tmpSetId = (String) obj[0];
				String tmpItemId = (String) obj[1];
				if (!setId.equals(tmpSetId)) {
					list = new ArrayList();
					setId = tmpSetId;
					hash.put(setId, list);
				}

				CodeItemBO cItem = SysCacheTool.findCodeItem(tmpSetId,
						tmpItemId);
				list.add(cItem);
			}
			return hash;
		} catch (Exception e) {
			throw new SysException("", "读取数据错误！", e, UserInfoDAO.class);
		}
	}
}
