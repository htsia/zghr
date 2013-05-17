package com.hr319wg.custom.extend.ucc;

import java.util.ArrayList;
import java.util.Hashtable;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.ChangeInfoBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.PersonChangeVO;
import com.hr319wg.emp.ucc.impl.PersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.portal.IUUManager;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class PersonUCCByExtend extends PersonUCC {

	@Override
	public String queryInsChangePersonList(TableVO table, String name, String superId, int pageNum, int rowNum, User user) throws SysException {
		StringBuffer where = new StringBuffer();
		if ((superId != null) && (!"".equals(superId))) {
			where.append(" and B731.orguid ='").append(superId).append("'");
		}

		ArrayList liitems = SysCacheTool.queryInfoItemBySetId("B731");
		for (int i = 0; i < liitems.size(); i++) {
			InfoItemBO ib = (InfoItemBO) liitems.get(i);
			if (ib.getItemId().toLowerCase().equals("orguid")) {
				InfoItemBO ia = SysCacheTool.findInfoItem("A001", "ID");
				liitems.set(i, ia);
			}
		}
		CellVO[] c1 = new CellVO[liitems.size()];
		for (int i = 0; i < liitems.size(); i++) {
			c1[i] = new CellVO();
			CommonFuns.copyProperties(c1[i], liitems.get(i));
		}
		table.setHeader(c1);
		table.setSetType("A");
		StringBuffer sql = new StringBuffer("");
		sql.append("select ");
		for (int i = 0; i < liitems.size(); i++) {
			InfoItemBO b = (InfoItemBO) liitems.get(i);
			sql.append(b.getItemId());
			if (i == liitems.size() - 1)
				continue;
			sql.append(",");
		}
		sql.append(" from B731 left join A001 on B731.B731700=A001.ID");
		OrgBO org = SysCacheTool.findOrgById(superId);
		if (org != null && !"-1".equals(org.getSuperId())) {
			sql.append(" where B731.orguid ='").append(superId).append("'");
		}
		if ((name != null) && (!name.equals(""))) {
			sql.append(" and ( A001.A001001 like '%").append(name).append("%' or A001.A001735 like '%").append(name).append("%' or A001.A001002 like '%").append(name.toLowerCase()).append("%')");
		}
		sql.append(" order by B731.B731701 desc");
		getActivepageservice().querySql(table, sql.toString(), user, pageNum, rowNum, true);
		return sql.toString();
	}

	public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, User user, String qryID, String addConditon) throws SysException {
		try {
			StringBuffer where = new StringBuffer();

			name = CommonFuns.filterNull(name).trim();
			if ((name != null) && (!"".equals(name.trim()))) {
				String namecon = "1=0";
				String[] namestr = name.split(",");
				for (int i = 0; i < namestr.length; i++) {
					if (!"".equals(namestr[i])) {
						namecon = namecon + " or A001.A001001 LIKE '%" + namestr[i] + "%' or A001.A001735 like '%" + namestr[i] + "%' or A001002 like '%" + namestr[i] + "%' or A001999 like '%" + namestr[i] + "%'";
					}
				}
				namecon = " and (" + namecon + ")";
				where.append(namecon);
			}
			if ((perType != null) && (!"".equals(perType.trim()))) {
				String[] pers = perType.split(",");
				where.append(" and ").append(CommonFuns.splitInSql(pers, "A001.A001054"));
			}

			if ((superId != null) && (!"".equals(superId.trim()))) {
				OrgBO bo = SysCacheTool.findOrgById(superId);
				if (bo != null) {
					if (OrgBO.GROUPTYPE.equals(bo.getorgType())) {
						where.append(" and A001.A001706='" + bo.getOrgId() + "'");
					} else {
						where.append(" and A001.A001738 LIKE '" + bo.getTreeId() + "%'");
					}
				}
			}

			String addCondition = "";
			if (!"".equals(cancel)) {
				addCondition = "A001730 = '" + cancel + "'";
			}
			if ((qryID == null) || ("".equals(qryID))) {
				qryID = "156";
			}
			CellVO[] c1 = this.getQueryapi().queryInfoItem(qryID);

			table.setHeader(c1);
			table.setSetType("A");
			Hashtable hash = this.getQueryapi().getQuerySqlHash(user, qryID, addCondition);
			String select = CommonFuns.filterNull((String) hash.get("SQL_SELECT_PART"));
			String from = CommonFuns.filterNull((String) hash.get("SQL_FROM_PART"));
			String condition = CommonFuns.filterNull((String) hash.get("SQL_WHERE_PART"));
			String scale = CommonFuns.filterNull((String) hash.get("SQL_SCALE_PART"));
			String order = CommonFuns.filterNull((String) hash.get("SQL_ORDER_PART"));
			StringBuffer sql = new StringBuffer();
			if ((!"".equals(select)) && (!"".equals(from))) {
				sql.append("SELECT ").append(select).append(" FROM ").append(from).append(",b001 ");
				if ((!"".equals(condition)) || (!"".equals(scale)) || ((where != null) && (where.length() > 0))) {
					sql.append(" WHERE a001705=orguid ");
				}
				if (!"".equals(condition)) {
					sql.append(" and ").append(condition);
				}
				if (!"".equals(scale)) {
					sql.append(" and ").append(scale);
				}
				if ((where != null) && (where.length() > 0)) {
					sql.append(where);
				}
				if ((addConditon != null) && (!"".equals(addConditon))) {
					sql.append(" and ").append(addConditon);
				}

				if (!"".equals(order))
					sql.append(" order by B001715,A001.A001746,A001.A001054,").append(order);
				else {
					sql.append(" order by B001715,A001.A001746,A001.A001054");
				}
			}
			this.getActivepageservice().querySql(table, sql.toString(), user, pageNum, rowNum, true);
			return sql.toString();
		} catch (Exception e) {
			throw new SysException("", "查询失败", e, getClass());
		}
	}

	public void updatePersonCode(String perID, String add) throws SysException {
		String[] params = add.split(",");
		String sql = "update a001 set A001735='" + params[0] + "'||A001735,A001715='" + params[1] + "' where id='" + perID + "'";
		if ("SQL SERVER".equals(Constants.DB_TYPE)) {
			sql = "update a001 set A001735='" + params[0] + "'+A001735,A001715='" + params[1] + "' where id='" + perID + "'";
		}
		this.getActivepageservice().executeSql(sql);
	}

	public void ClearData(String pid) throws SysException {
		String sql = "delete from  sys_agent where agentfor='" + pid + "' or personid='" + pid + "'";
		this.getActivepageservice().executeSql(sql);

		sql = "delete from emp_chginfo where person_id='" + pid + "'";
		this.getActivepageservice().executeSql(sql);

		sql = "delete from emp_conpost where conpost_personid='" + pid + "'";
		this.getActivepageservice().executeSql(sql);

		sql = "delete from B730 where B730700='" + pid + "'";
		this.getActivepageservice().executeSql(sql);
	}

	public void chgDismiss(PersonChangeVO personchangevo, ChangeInfoBO changeinfo, String[] ids) throws RollbackableException {
		try {
			String depID = changeinfo.getToDepId();
			String postID = CommonFuns.filterNull(changeinfo.getToPostId());
			String postLevel = CommonFuns.filterNull(changeinfo.getToPostLevel());

			OrgBO orgx = null;
			String xt = "";
			String orgTreeid = "";
			String depTreeid = "";

			if ((depID != null) && (!depID.equals(""))) {
				OrgBO superOrg = OrgTool.getOrgByDept(depID);
				if (superOrg != null) {
					xt = superOrg.getOrgId();
					orgTreeid = superOrg.getTreeId();
					changeinfo.setToOrgId(xt);
				}
				orgx = SysCacheTool.findOrgById(depID);
				if (orgx != null) {
					depTreeid = orgx.getTreeId();

					ArrayList list = new ArrayList();
					for (int i = 0; i < ids.length; i++) {
						PersonBO po = SysCacheTool.findPersonById(ids[i]);
						if (po == null) {
							continue;
						}
						// 机构人员流动
						String b730subid = SequenceGenerator.getKeyId("B730");
						list.add("insert into B730(orguid,subid,B730000,B730700,B730701,B730702,B730703) values('" + po.getOrgId() + "','" + CommonFuns.filterNull(b730subid) + "','" + "00900" + "','" + ids[i] + "','" + personchangevo.getChangeDate() + "','" + personchangevo.getChangeType() + "','" + superOrg.getName() + "')");
						// 增减情况子集
						list.add("insert into A016(id,subid,A016010,A016020,A016030,A016040,A016045,A016050) values('" + ids[i] + "','" + SequenceGenerator.getKeyId("A016") + "','" + PersonChangeVO.CHANGE_TYPE_OUT + "','" + CommonFuns.filterNull(changeinfo.getApplyDate()) + "','" + CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, changeinfo.getFromOrgId())) + "','" + CommonFuns.filterNull(changeinfo.getApplyDate()) + "','" + CommonFuns.filterNull(changeinfo.getFromOperator()) + "','" + b730subid + "')");

						OrgBO or = SysCacheTool.findOrgById(po.getOrgId());
						b730subid = SequenceGenerator.getKeyId("B730");
						list.add("insert into B730(orguid,subid,B730000,B730700,B730701,B730702,B730703) values('" + xt + "','" + b730subid + "','" + "00900" + "','" + ids[i] + "','" + personchangevo.getChangeDate() + "','0200300008','" + or.getName() + "')");

						list.add("insert into A016(id,subid,A016010,A016020,A016030,A016040,A016045,A016050,A016200,A016201,A016202,A016203,A016204,A016205) values" + "('" + ids[i] + "','" + SequenceGenerator.getKeyId("A016") + "','" + PersonChangeVO.CHANGE_TYPE_IN + "','" + CommonFuns.filterNull(personchangevo.getChangeDate()) + "'," + "'" + CommonFuns.filterNull(superOrg.getName()) + "','" + CommonFuns.filterNull(personchangevo.getTractDate()) + "','" + CommonFuns.filterNull(personchangevo.getTractPerson()) + "','" + b730subid + "','" + po.getOrgId() + "','" + xt + "','" + po.getDeptId() + "','" + orgx.getOrgId() + "','" + po.getPostId() + "','" + postID + "')");
						// 工作简历子集
						list.add("update A019 set A019010='" + CommonFuns.filterNull(personchangevo.getTractDate()) + "' where id='" + ids[i] + "' and A019000='00901'");
						list.add("update A019 set A019000='00900' where id='" + ids[i] + "'");
						list.add("insert into A019(id,subid,A019000,A019005,A019015,A019020,A019025,A019700) values('" + ids[i] + "','" + SequenceGenerator.getKeyId("A019") + "','00901','" + CommonFuns.filterNull(personchangevo.getTractDate()) + "','" + CommonFuns.filterNull(superOrg.getName()) + "','" + CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, changeinfo.getToPostId())) + "','" + CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, personchangevo.getTractPerson())) + "','内部调动')");
					}

					if ((list != null) && (list.size() > 0)) {
						this.getActivepageservice().batchExecuteSql((String[]) (String[]) list.toArray(new String[0]));
					}

					String sql = "update A001 set A001701 = '" + xt + "',A001705='" + depID + "',A001728='" + orgTreeid + "',A001738='" + depTreeid + "',A001715='" + postID + "',A001716='" + postLevel + "' where  " + CommonFuns.splitInSql(ids, "ID");
					this.getActivepageservice().executeSql(sql);

					if (!"".equals(Constants.UUM_SERVICE_NAME))
						try {
							IUUManager uumanager = (IUUManager) SysContext.getBean(Constants.UUM_SERVICE_NAME);
							if (uumanager != null)
								for (int i = 0; i < ids.length; i++) {
									String[] id = new String[1];
									id[0] = ids[i];
									SysCache.setMap(id, 2, 6);
									uumanager.userModify(id[0], personchangevo.getTractPerson(), "1");
								}
						} catch (Exception e) {
							e.printStackTrace();
						}
				}
			}
		} catch (Exception e) {
			throw new RollbackableException("E070001", "同步信息子集出错！" + e.getMessage(), e, getClass());
		}
	}
}
