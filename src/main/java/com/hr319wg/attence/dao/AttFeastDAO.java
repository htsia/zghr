package com.hr319wg.attence.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

public class AttFeastDAO extends BaseDAO {
	public List getAttFeastBO(String orgid, String date) throws SysException {
		String hql = "select bo from AttFeastBO bo where (bo.orgID='-1' or bo.orgID='"
				+ orgid
				+ "') and bo.feastDate like '%"
				+ date
				+ "%' and bo.year='-1'";
		return this.hibernatetemplate.find(hql);

	}

	public List getAllAttFeast(String orgid) throws SysException {
		String hsql = "select bo from AttFeastBO bo where bo.orgID='" + orgid
				+ "'";
		return this.hibernatetemplate.find(hsql);

	}
	
	public List getAllEqualsAttFeast(String orgid) throws SysException {
		String hsql = "select bo from AttFeastBO bo where bo.orgID='" + orgid
				+ "' or bo.orgID='-1'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttFeast(PageVO pagevo, String orgid) throws SysException {
		String hsql = "select bo from AttFeastBO bo where bo.orgID='-1' or bo.orgID='"
				+ orgid + "'";
		String countsql = "select count(bo) from AttFeastBO bo where bo.orgID='-1' or bo.orgID='"
				+ orgid + "'";
        hsql+=" order by bo.regTime desc";
		return this.pageQuery(pagevo, countsql, hsql);
	}

	public List getAllAttWorkDate(String feastID, String orgid)
			throws SysException {
		String hsql = "select bo from AttWorkDateBO bo where bo.feastId='"
				+ feastID + "' and bo.orgId='" + orgid + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAllAttWorkDate(String orgid) throws SysException {
		String hsql = "select bo from AttWorkDateBO bo where  bo.orgId='-1' or bo.orgId='"
				+ orgid + "'";
		return this.hibernatetemplate.find(hsql);

	}

	public List getAttFeastBOByOrgId(String orgid, String date)
			throws SysException {
		String hql = "select bo from AttFeastBO bo where (bo.orgID='-1' or bo.orgID='"
				+ orgid + "') and bo.feastDate like '%" + date + "%'";
		return this.hibernatetemplate.find(hql);

	}
	//找出某个人相关的所有节假日
	public List getFeastsByUserId(String userId)throws SysException{
		String hql="select bo from AttFeastBO bo,UserBO u where u.userID='"+userId+"' and charindex(bo.postLeiXing,u.leixing,0)=0 ";
		return this.hibernatetemplate.find(hql);
	}
}
