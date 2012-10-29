package com.hr319wg.wage.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.vo.AdjustVO;

public class WageAdjustDAO extends BaseDAO {
	public WageAdjustBO getWageAdjustBOByLinkID(String linkID)
			throws SysException {
		String sql = "select bo from WageAdjustBO bo where bo.linkID='"
				+ linkID + "'";
		List list = this.hibernatetemplate.find(sql);
		if ((list == null) || (list.size() == 0))
			return null;
		return (WageAdjustBO) list.get(0);
	}

	public List getAdjustDetail(String itemID) throws SysException {
		return this.hibernatetemplate
				.find("select bo from WageAdjustDetailBO bo where bo.itemID='"
						+ itemID + "'");
	}

	public List getAdjustList(PageVO pagevo, User user) throws SysException {
		String countSql = "select count(bo) from WageAdjustBO bo ";
		String Sql = "select bo from WageAdjustBO bo ";
		if (RoleInfoBO.ORGTYPE_OWN.equals(user.getprocessUnit())) {
			Sql = Sql + " where bo.orgID='" + user.getOrgId() + "'";
			countSql = countSql + " where bo.orgID='" + user.getOrgId() + "'";
		} else if (RoleInfoBO.ORGTYPE_USD.equals(user.getprocessUnit())) {
			List list = user.getHaveOperateOrgScale();
			String where = "";
			for (int i = 0; i < list.size(); i++) {
				OrgBO b = (OrgBO) list.get(i);
				if ("".equals(where)) {
					where = "bo.orgID='" + b.getOrgId() + "'";
				} else {
					where = where + " or bo.orgID='" + b.getOrgId() + "'";
				}
			}
			Sql = Sql + " where (" + where + ")";
			countSql = countSql + " where (" + where + ")";
		}
		Sql += " order by bo.applyDate desc";
		List list = pageQuery(pagevo, countSql, Sql);
		List result = new ArrayList();
		for (int i = 0; i < list.size(); i++) {
			WageAdjustBO wb = (WageAdjustBO) list.get(i);
			AdjustVO vo = new AdjustVO();
			vo.setAdjustbo(wb);
			vo.setItemList(getAdjustDetail(wb.getItemID()));
			result.add(vo);
		}

		return result;
	}
}