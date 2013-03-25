package com.hr319wg.custom.ins.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.ins.pojo.bo.InsCalcSetBO;

public interface IInsDataService {

	public Object getBOByID(Class c, String ID) throws SysException;

	public String getLockUserIDs(String setID) throws SysException;

	public void saveOrUpdateBO(Object bo) throws SysException;

	public void updateMonthPayStatus(String itemID) throws SysException;

	public void batchUpdateMonthPay(String setID, String itemID, String value) throws SysException;
	
	public void deleteBO(Class c, String ID) throws SysException;

	public String saveSet(InsCalcSetBO bo) throws SysException;
	
	public void deleteSet(String ID, String wageDate) throws SysException;
	
	public void endSet(String ID) throws SysException;
	
	public void calc(String setID, String wageDate, String orgID, String selectedUserIDs) throws SysException;

	public List getAllInsCalcSetBO(PageVO pageVO, String createOrgID, String createUserID, String wageDate) throws SysException;
	
	public List getAllInsMonthPayBO(PageVO pageVO, String setID, String wageDate, String orgID, String personType, String nameStr) throws SysException;
	
	public List getInsMonthPaySum(String setID, String wageDate, String orgID, String personType, String nameStr) throws SysException;
	
	public void saveInsBaseData(String id,String tablename,String value, String date) throws SysException ;
	
	public void updateInsurceChangeInfo(String[] ids, String ChangeType, String ChangeDate, String changReason, String DepName, String[] inputInsurace) throws SysException;
}
