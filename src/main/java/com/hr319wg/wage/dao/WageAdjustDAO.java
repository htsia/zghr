package com.hr319wg.wage.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
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

	public List getAdjustList(PageVO pagevo, boolean isAppro, boolean isNotAppro, User user) throws SysException {
		String sql = " from WageAdjustBO bo,UserBO u where bo.personID=u.userID and bo.approStatus='1' and bo.adjustType in ('岗位调整','转正')";
		if (!user.ischo()) {
			List hasList = user.getHaveOperateOrgScale();
			List noList = user.getHaveNoOperateOrgScale();
			
			String where = "";
			for (int i = 0; i < hasList.size(); i++) {
				OrgBO b = (OrgBO) hasList.get(i);
				if ("".equals(where)) {
					where = "u.deptSort like '" + b.getTreeId() + "%'";
				} else {
					where += " or u.deptSort like '" + b.getTreeId() + "%'";
				}
			}
			sql += " and ("+where+")";
			if(noList!=null && noList.size()>0){
				where = "";
				for (int i = 0; i < noList.size(); i++) {
					OrgBO b = (OrgBO) noList.get(i);
					if ("".equals(where)) {
						where = "u.deptSort not like '" + b.getTreeId() + "%'";
					} else {
						where += " and u.deptSort not like '" + b.getTreeId() + "%'";
					}
				}
				sql += " and ("+where+")";
			}
		}
		if(isAppro && isNotAppro){
			sql += " and bo.status in ('0','4')";
		}else if(isAppro){
			sql += " and bo.status ='4'";			
		}else if(isNotAppro){
			sql += " and bo.status ='0'";			
		}else{
			sql += " and 1=0";
		}
		String boSql = "select bo "+sql+" order by bo.applyDate desc,u.secDeptID,u.deptId";
		String countSql="select count(bo) "+sql;
		List list = pageQuery(pagevo, countSql, boSql);
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