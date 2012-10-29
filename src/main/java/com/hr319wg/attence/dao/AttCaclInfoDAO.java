package com.hr319wg.attence.dao;

import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttCaclInfoDAO extends BaseDAO {
	public List getAttClassGroupVO(PageVO mypage,String orgId,String personType) throws SysException {
		String hsql="";
		String countsql="";
        String treeId="";
        if(orgId!=null&&!orgId.equals("")){
              treeId= SysCacheTool.findOrgById(orgId).getTreeId();
        }
    	hsql = "select bo from AttClassGroupVO bo where bo.id not like '@%' and bo.id not like '#%' and bo.deptTreeId like '%"+treeId+"%' and (bo.card is not null or bo.card<>'') ";
    	countsql = "select count(bo) from AttClassGroupVO bo where bo.id not like '@%' and bo.id not like '#%' and  bo.deptTreeId like '%"+treeId+"%' and (bo.card is not null or bo.card<>'') ";
        if(personType!=null && !"".equals(personType)){
        	hsql+=" and bo.personType in ("+personType+")";
        	countsql+=" and bo.personType in ("+personType+")";
        }
        
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAttClassGroupVO(String orgID) throws SysException{
		String hsql = "select bo from AttClassGroupVO bo where bo.orgId='"+orgID+"'";
		return this.hibernatetemplate.find(hsql);
   	}
	
	public List getAttenceMonthBO(String userid, String duraYearMonth) throws SysException {
		String hsql="select bo from AttenceDayMonthBO bo where bo.personId in ";
		hsql+="(select vo.id from AttClassGroupVO vo where  vo.orgId like '"+userid+"') and bo.attenceDate='"+duraYearMonth+"'";
		return this.hibernatetemplate.find(hsql);

	}
	
	public List getAttCaclInfoBO(String duraId) throws SysException {
		String hsql = "select bo from AttCaclInfoBO bo where bo.duraId='"+ duraId + "' order by bo.attDate";
		return this.hibernatetemplate.find(hsql);

	}
	
	public List getAttCaclRuleBO(String orgID) throws SysException {
		String hsql = "select bo from AttCaclRuleBO bo where bo.orgID='"+ orgID + "'";
		return this.hibernatetemplate.find(hsql);

	}
}
