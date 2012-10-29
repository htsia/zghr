package com.hr319wg.attence.service;

import java.text.ParseException;
import java.util.List;

import com.hr319wg.attence.dao.AttAnnualMgrDAO;
import com.hr319wg.attence.dao.AttDurationDAO;
import com.hr319wg.attence.dao.AttEvcctionStateDAO;
import com.hr319wg.attence.dao.AttFeastDAO;
import com.hr319wg.attence.dao.AttFurloughRecDAO;
import com.hr319wg.attence.dao.AttOutWorkDAO;
import com.hr319wg.attence.dao.AttOverTimeDAO;
import com.hr319wg.attence.dao.AttRestWeekDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;

public class AttDataCaclService {
    private AttDurationDAO attDurationDAO;
    private ActivePageAPI activeapi;
    private AttRestWeekDAO attrestweekDAO;
    private AttFeastDAO attfeastDAO;
    private AttEvcctionStateDAO attEvcctionStateDao;
    private AttOutWorkDAO attOutWorkDao;
    private AttOverTimeDAO attOverTimeDao;
    private AttFurloughRecDAO attFurloughRecDAO;
    private AttAnnualMgrDAO attAnnualMgrDao;
    
    /**
     * @param orgId
     * @param beginDate
     * @param endDate
     * @throws SysException 
     * @throws ParseException 
     */					
    public String calcAttData(String orgId, String beginDate, String endDate, String year, String month) throws SysException, ParseException{
    	return null;
    }
    
    
	public List getSelfSignInfo(String userID, String date) throws SysException{
		return this.attDurationDAO.getAllAttenceCurrLogBOByUserIDDate(userID, date);
	}

	public AttDurationDAO getAttDurationDAO() {
		return attDurationDAO;
	}

	public void setAttDurationDAO(AttDurationDAO attDurationDAO) {
		this.attDurationDAO = attDurationDAO;
	}

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public AttRestWeekDAO getAttrestweekDAO() {
		return attrestweekDAO;
	}

	public void setAttrestweekDAO(AttRestWeekDAO attrestweekDAO) {
		this.attrestweekDAO = attrestweekDAO;
	}

	public AttFeastDAO getAttfeastDAO() {
		return attfeastDAO;
	}

	public void setAttfeastDAO(AttFeastDAO attfeastDAO) {
		this.attfeastDAO = attfeastDAO;
	}

	public AttEvcctionStateDAO getAttEvcctionStateDao() {
		return attEvcctionStateDao;
	}

	public void setAttEvcctionStateDao(AttEvcctionStateDAO attEvcctionStateDao) {
		this.attEvcctionStateDao = attEvcctionStateDao;
	}

	public AttOutWorkDAO getAttOutWorkDao() {
		return attOutWorkDao;
	}

	public void setAttOutWorkDao(AttOutWorkDAO attOutWorkDao) {
		this.attOutWorkDao = attOutWorkDao;
	}

	public AttOverTimeDAO getAttOverTimeDao() {
		return attOverTimeDao;
	}

	public void setAttOverTimeDao(AttOverTimeDAO attOverTimeDao) {
		this.attOverTimeDao = attOverTimeDao;
	}

	public AttFurloughRecDAO getAttFurloughRecDAO() {
		return attFurloughRecDAO;
	}

	public void setAttFurloughRecDAO(AttFurloughRecDAO attFurloughRecDAO) {
		this.attFurloughRecDAO = attFurloughRecDAO;
	}

	public AttAnnualMgrDAO getAttAnnualMgrDao() {
		return attAnnualMgrDao;
	}

	public void setAttAnnualMgrDao(AttAnnualMgrDAO attAnnualMgrDao) {
		this.attAnnualMgrDao = attAnnualMgrDao;
	}
	
}
