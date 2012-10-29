package com.hr319wg.attence.dao;

import java.util.List;
import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.pojo.bo.WFProcessBO;

public class AttPersonServiceDAO extends BaseDAO {
	public WFProcessBO findWFProcessBO(String linkID) throws SysException {
		WFProcessBO wfprocessbo=null;
		String hsql = "select bo from WFProcessBO bo where bo.linkID='"+linkID+"'";
		List list=this.hibernatetemplate.find(hsql);
		if(list!=null && list.size()>0){
			wfprocessbo=(WFProcessBO)list.get(0);
		}
		return wfprocessbo;
	}
	
}
