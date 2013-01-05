package com.hr319wg.custom.ins.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

public interface IInsDataService {

	public Object getBOByID(Class c, String ID) throws SysException;

	public void saveOrUpdateBO(Object bo) throws SysException;
	
	public void deleteBO(Class c, String ID) throws SysException;

	public void deleteSet(String ID, String wageDate) throws SysException;
	
	public void calc(String setID, String wageDate, String orgID) throws SysException;

	public List getAllInsCalcSetBO(PageVO pageVO, String createOrgID, String createUserID, String wageDate) throws SysException;
	
	public List getAllInsMonthPayBO(PageVO pageVO, String setID, String wageDate, String orgID, String personType, String nameStr) throws SysException;
}
