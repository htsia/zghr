package com.hr319wg.sys.dao;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.util.CommonFuns;

public class CodeSetDAO extends BaseDAO {
	public void makeStatus(String codeSetID, String status) throws SysException {
		String sName = null;
		try {
			CodeSetBO cSet = (CodeSetBO) this.hibernatetemplate.get(
					CodeSetBO.class, codeSetID);
			sName = cSet.getSetName();
			cSet.setSetStatus(status);
			this.hibernatetemplate.update(cSet);
		} catch (Exception e) {
			throw new RollbackableException("", "修改代码集" + sName + "状态时出现错误！",
					e, getClass());
		}
	}

	public List queryCodeSets() throws SysException {
		return queryCodeSets(false, null, null);
	}

	public List queryCodeSets(boolean orderByName, String moudleID, String orgID) throws SysException {
		try {
			StringBuffer sb = new StringBuffer("from CodeSetBO c ");
			if("wage".equals(moudleID)){
				sb.append(" where c.createUnit='"+orgID+"' or c.publicFlag=1 ");
			}
			if (orderByName) {
				sb.append(" order by c.setName");
			} else {
				sb.append(" order by c.setId");
			}
			List list = this.hibernatetemplate.find(sb.toString());
			if(list==null){
				list=new ArrayList();
			}
			return list;
		} catch (Exception e) {
			throw new SysException("", "读取代码集数据错误！", e, getClass());
		}
	}

	public String checkUsing(String[] setIds) throws SysException {
		String str = "";
		String instr = "";
		if (setIds == null)
			return "";
		for (int i = 0; i < setIds.length; i++) {
			instr = instr + "'" + setIds[i] + "',";
		}

		instr = instr.substring(0, instr.length() - 1);
		try {
			String sql = "select c from InfoItemBO i ,CodeSetBO c where i.itemCodeSet=c.setId and c.setId in ("
					+ instr + ")";
			List list = this.hibernatetemplate.find(sql);
			Hashtable hash = new Hashtable();
			if ((list != null) && (list.size() > 0)) {
				for (int i = 0; i < list.size(); i++) {
					CodeSetBO sbo = (CodeSetBO) list.get(i);
					if (!hash.containsKey(sbo.getSetId())) {
						hash.put(sbo.getSetId(), sbo);
						if ("".equals(str))
							str = str + "{" + sbo.getSetName() + "}";
						else {
							str = str + ",{" + sbo.getSetName() + "}";
						}
					}
				}
			}

			if (instr.indexOf("2001") != -1) {
				if ("".equals(str))
					str = str + "{指标集类别代码}";
				else {
					str = str + ",{指标集类别代码}";
				}
			}
			return str;
		} catch (Exception e) {
			throw new SysException("", "检索信息项失败", e, getClass());
		}
	}

	public String getNewSetId() throws SysException {
		try {
			List list = this.hibernatetemplate
					.find("select b.setId from CodeSetBO b where b.setId+0>3000");

			if ((list != null) && (list.size() > 0)) {
				for (int i = 3001; i < 10000; i++) {
					String newSetId = Integer.toString(i);
					if (list.indexOf(newSetId) == -1) {
						return newSetId;
					}
				}

				return "";
			}
			return "3001";
		} catch (Exception e) {
			throw new SysException("", "读取指标集数据时出错！", e, getClass());
		}
	}

	public List getCodeRelationList(String sourceField, String desField)
			throws SysException {
		String sql = "";
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			sql = "select bo from CodeRelation bo ,CodeItemBO co  where  bo.desCode=co.itemId(+) and bo.desField='"
					+ desField
					+ "' and bo.sourceField='"
					+ sourceField
					+ "' order by len(co.treeId),co.treeId";
		} else {
			sql = "select bo from CodeRelation bo ,CodeItemBO co  where  bo.desCode*=co.itemId and bo.desField='"
					+ desField
					+ "' and bo.sourceField='"
					+ sourceField
					+ "' order by len(co.treeId),co.treeId";
		}
		return this.hibernatetemplate.find(sql);
	}

	public List getCodeRelationList() throws SysException {
		String sql = "select bo from CodeRelation bo";
		return this.hibernatetemplate.find(sql);
	}

	public List getCodeRelationListByResult(String setID) throws SysException {
		String sql = "select bo from CodeRelation bo,InfoItemBO ib where bo.desField=ib.itemId and ib.setId='"
				+ setID + "'";
		return this.hibernatetemplate.find(sql);
	}

	public List getCodeRelationListBySource(String setID) throws SysException {
		String sql = "select bo from CodeRelation bo,InfoItemBO ib where bo.sourceField=ib.itemId and ib.setId='"
				+ setID + "'";
		return this.hibernatetemplate.find(sql);
	}
}