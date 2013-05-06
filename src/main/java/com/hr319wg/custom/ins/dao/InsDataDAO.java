
package com.hr319wg.custom.ins.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class InsDataDAO extends BaseDAO{
	
	public List getAllInsCalcSetBO(PageVO pageVO, String createOrgID, String createUserID, String wageDate) throws SysException{
		String hql = " from InsCalcSetBO bo where (bo.createOrgID='"+createOrgID+"')";
		if(wageDate!=null && !"".equals(wageDate)){
			hql+=" and bo.wageDate='"+wageDate+"'";
		}
		String boHql = "select bo "+hql +" order by bo.wageDate desc";
		String countHql = "select count(bo) "+hql;
		
		return this.pageQuery(pageVO, countHql, boHql);
	}
	
	public List getAllInsMonthPayBO(PageVO pageVO, String setID, String wageDate, String orgID, String personType, String nameStr) throws SysException{
		String hql = " from InsMonthPayBO bo,UserBO u where bo.userID=u.userID and bo.calcSetID='"+setID+"' and bo.wageDate='"+wageDate+"' ";
		if(orgID!=null && !"".equals(orgID)){
			hql+=" and (bo.secDeptID = '"+orgID+"' or bo.orgID ='"+orgID.substring(4)+"') ";
		}
		if(nameStr!=null && !"".equals(nameStr)){
			hql += " and (u.name like '%"+nameStr+"%' or u.personSeq like '%"+nameStr+"%' or u.shortName like '%"+nameStr+"%')";
		}
		String boHql = "select bo "+hql +" order by u.secDeptID,u.deptId";
		String countHql = "select count(bo) "+hql;
		
		return this.pageQuery(pageVO, countHql, boHql);
	}
}
