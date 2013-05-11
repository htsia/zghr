package com.hr319wg.wage.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
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

	public List getAdjustList(PageVO pagevo, boolean isAppro, User user, String orgID, String name, String time, String time2) throws SysException {
		String hql = " from WageAdjustBO bo,UserBO u where bo.personID=u.userID and bo.approStatus='1' and bo.adjustType in ('岗位调整','转正','人员类别调整')";
		OrgBO org=SysCacheTool.findOrgById(orgID);
	    hql+=" and u.deptSort like '"+org.getTreeId()+"%'";
	    if ((name != null) && (!"".equals(name))) {
	    	hql += " and ( u.name like '%" + name + "%' or u.shortName like '%" + name + "%' or u.personSeq like '%" + name + "%') ";
		}
	    List noList = user.getHaveNoOperateOrgScale();
		String where = "";
		if(noList!=null && noList.size()>0){
			for (int i = 0; i < noList.size(); i++) {
				OrgBO b = (OrgBO) noList.get(i);
				if ("".equals(where)) {
					where = "u.deptSort not like '" + b.getTreeId() + "%'";
				} else {
					where += " and u.deptSort not like '" + b.getTreeId() + "%'";
				}
			}
			hql += " and ("+where+")";
		}
		if(isAppro){
			hql += " and bo.status in ('0','4')";
		}else{
			hql += " and bo.status ='0'";			
		}
		if ((time != null) && (!time.equals(""))) {
			hql += " and bo.applyDate >='" + time + "'";
	    }
	    if ((time2 != null) && (!time2.equals(""))) {
	    	hql += " and bo.applyDate <= '" + time2 + "'";
	    }
		String boSql = "select bo "+hql+" order by bo.applyDate desc,u.secDeptID,u.deptId";
		String countSql="select count(bo) "+hql;
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