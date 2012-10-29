package com.hr319wg.attence.dao;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttRestOfWeekBO;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;

public class AttRestWeekDAO extends BaseDAO {
	public AttRestOfWeekBO getAttRestOfWeekBOByOrgid(String orgid)throws SysException{
		String hql="select bo from AttRestOfWeekBO bo where bo.orgId='"+orgid+"'";
		List list=this.hibernatetemplate.find(hql);
		if(list!=null&&list.size()>0){
			return (AttRestOfWeekBO)list.get(0);
		}else{
			return null;
		}
	}
}
