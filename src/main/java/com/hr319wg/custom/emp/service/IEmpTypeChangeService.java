package com.hr319wg.custom.emp.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;

public interface IEmpTypeChangeService {

	public List getEmpTypeChangeBO(PageVO pagevo, String orgId, User user,
			String name, boolean apprived, String time, String time2)
			throws SysException;
	
	public void batchSaveTypeChange(String[]IDs, String newType, User user) throws SysException;
	
	public void deleteTypeChange(String ID) throws SysException;
	
	public Object getObjByID(Class c, String ID) throws SysException;

	public void saveObj(Object obj) throws SysException;
	
	public void batchUpdateTypeChange(String[]typeChangeIDs) throws SysException;
}
