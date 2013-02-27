package com.hr319wg.custom.attence.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.hr319wg.attence.pojo.bo.AttClassDetailBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttLeaveBO;
import com.hr319wg.custom.attence.pojo.bo.AttLogBO;
import com.hr319wg.custom.attence.pojo.bo.AttMachineBO;
import com.hr319wg.custom.attence.pojo.bo.AttOutBO;
import com.hr319wg.custom.attence.pojo.bo.AttOvertimeBO;
import com.hr319wg.custom.attence.pojo.bo.AttRestBO;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.jacob.com.Dispatch;

public interface IAttBusiService {

	public void saveClassDetail(List<AttClassDetailBO> list, String[] details)
			throws SysException;

	public String getPutoffSum() throws SysException;

	public void updatePutoff(String yearMonth) throws SysException;

	public List getAllAttPutoffDataBO(PageVO pageVO, String orgID,
			String nameStr, String personType) throws SysException;

	public List<UserBO> getAllCurrApprover(String[] userIDs)
			throws SysException;

	public abstract String updateCalcAttData(String orgId, String beginDate,
			String endDate, String year, String month, String id)
			throws SysException, ParseException;

	public abstract String clearData(List<AttMachineBO> list, String operType);

	public abstract String clearLog(List<AttMachineBO> list);

	public abstract String downloadLog(String orgID, List<AttMachineBO> mList)
			throws SysException;

	public abstract String uploadInfoToZKEM(List<AttMachineBO> mList,
			String userIDs);

	public abstract String downloadInfoFromZKEMByPersonCode(String IPStr,
			String personCode) throws SysException;

	public abstract String batchDownloadInfoFromZKEM(String ip);

	public abstract List batchDownloadInfoDetailFromZKEM(String ip)
			throws Exception;

	public abstract String uploadInfo(Dispatch myCom, AttMachineBO bo,
			List<Map> infolist);

	public abstract String getAndWriteKQUsersDataBypersonCode(Dispatch myCom,
			String ip, String personCode) throws SysException;

	public abstract String updateAllKQUsersData(Dispatch myCom, String ip)
			throws SysException;

	public abstract void deleteLeave(String id) throws SysException;

	public abstract void deleteOut(String id) throws SysException;

	public abstract void deleteOvertime(String id) throws SysException;

	public abstract void deleteRest(String id) throws SysException;

	public abstract void saveAttLeaveLogBO(AttLogBO bo) throws SysException;

	public abstract AttLogBO findAttLeaveLogBOById(String id)
			throws SysException;

	public abstract List getAttLogBOById(String leaveId) throws SysException;

	public abstract void deleteAttLeaveBO(String id) throws SysException;

	public abstract void deleteBO(Class c, String id) throws SysException;

	public abstract void saveAttLeaveBO(AttLeaveBO bo) throws SysException;

	public abstract Object findBOById(Class c, String id) throws SysException;

	public abstract AttLeaveBO findAttLeaveBOById(String id)
			throws SysException;

	public abstract AttRestBO findAttRestBOByProcessInstanceId(String processId)
			throws SysException;

	public abstract AttOvertimeBO findAttOvertimeBOByProcessInstanceId(
			String processId) throws SysException;

	public abstract AttOutBO findAttOutBOByProcessInstanceId(String processId)
			throws SysException;

	public abstract AttLeaveBO findAttLeaveBOByProcessInstanceId(
			String processId) throws SysException;

	public abstract List getAttRestBO(PageVO pagevo, String personId,
			String[] status, String beginDate, String endDate, String orgID,
			String personType, String nameStr, String createType,
			String inself, String isManager, String operUserID, boolean myAt)
			throws SysException;

	public abstract List getAttOvertimeBO(PageVO pagevo, String personId,
			String[] status, String beginDate, String endDate, String orgID,
			String personType, String nameStr, String createType,
			String inself, String isManager, String operUserID, boolean myAt)
			throws SysException;

	public abstract List getAttOutBO(PageVO pagevo, String personId,
			String[] status, String beginDate, String endDate, String orgID,
			String personType, String nameStr, String createType,
			String inself, String isManager, String operUserID, boolean myAt)
			throws SysException;

	public abstract List getAttLeaveBO(PageVO pagevo, String personId,
			String[] status, String beginDate, String endDate, String orgID,
			String personType, String nameStr, String createType,
			String inself, String isManager, String operUserID, boolean myAtt, String[]lTypes)
			throws SysException;

	public abstract void checkin(String userID, String date, String time)
			throws SysException;

	public abstract void saveOrUpdateBO(Object bo) throws SysException;

	public abstract List getAllLogBO(PageVO pageVo, String orgID,
			String nameStr, String personType, String createType,
			String beginDate, String endDate) throws SysException;

	public abstract List getMasterMachineIPs(String machineType)
			throws SysException;

	public abstract int getMasterMachineCount() throws SysException;

	public abstract int getMasterMachineExcludeSelfCount(String machineIP)
			throws SysException;

	public abstract List getMasterMachineExcludeSelf(String ip)
			throws SysException;

	public abstract List getMasterMachine() throws SysException;

	public abstract String getMasterMachineIP() throws SysException;

	public abstract List getAllMachineBO(PageVO pageVo, String machineType)
			throws SysException;

	public abstract List getAllFingerBO(PageVO pageVO, String orgID,
			String nameStr, String personType, boolean collected,
			boolean uncollected, boolean hasPwd, boolean notHasPwd)
			throws SysException;

	public abstract List getAllAttMonthBO(PageVO pageVO, String orgID,
			String nameStr, String personType, String yearMonth,
			String[] userIDs) throws SysException;

	public abstract List getAttMonthBO(String userID, String yearMonth)
			throws SysException;

	public abstract List getAllAttMachineBO() throws SysException;

	public abstract List getAllMachineBOByIPs(String IPs) throws SysException;

	public abstract List getAllAttMonthBOByOrgIDs(PageVO pageVO, String orgID,
			String nameStr, String personType, String yearMonth, String inself,
			String operUserID) throws SysException;

	public abstract List getAllVerifyAttMonthBO(PageVO pageVO, String orgID,
			String nameStr, String personType, String yearMonth)
			throws SysException;

	public abstract List getAllAttClassUserBOByClassID(PageVO pageVO,
			String orgID, String nameStr, String personType, String classID)
			throws SysException;

	public abstract List getAllAttClassUserBOByClassID(String classID)
			throws SysException;

	public abstract List getCurrAttDurationBO() throws SysException;

	/**
	 * @param id
	 * @return
	 * @throws SysException
	 */
	public abstract List getDays(String id) throws SysException;

	public abstract void updateLeaveDays(String type, String days,
			String personId) throws SysException;

	public abstract void saveAudit(String result, AttLeaveBO leave,
			String reason, String taskId, String currentUserId)
			throws SysException;
	
	public abstract void batchSaveAudit(String selectedItemIDs, String result,
			String reason, String currentUserId)
					throws SysException;

	public abstract void saveRestAudit(String result, AttRestBO rest,
			String reason, String taskId, String currentUserId)
			throws SysException;

	public abstract void batchRestAudit(String selectedItemIDs, String result,
			String reason, String currentUserId)
					throws SysException;
	
	public abstract void saveOvertimeAudit(String result,
			AttOvertimeBO overtime, String reason, String taskId,
			String currentUserId) throws SysException;

	public abstract void batchOvertimeAudit(String selectedItemIDs, String result,
			String reason, String currentUserId)
					throws SysException;
	
	public abstract void saveOvertimeInput(String beginDate, String endDate, String reason, String applyDays, String applyTime, String[]userIDs) throws SysException;
	
	public abstract void batchOvertimeInput(List<Map> list)
					throws SysException;
	
	public abstract void saveOutAudit(String result, AttOutBO out,
			String reason, String taskId, String currentUserId)
			throws SysException;

	public abstract void batchOutAudit(String selectedItemIDs, String result,
			String reason, String currentUserId)
					throws SysException;
	
	// public abstract String calcAttData1(String orgId, String beginDate,
	// String endDate, String year, String month)
	// throws SysException, ParseException;
	public abstract void cleanData1() throws SysException, ParseException;

	public abstract void cleanData2() throws SysException, ParseException;

	public abstract void modifyData(String userid) throws SysException,
			ParseException;

	// 计算一年的应出勤天数
	public abstract void getYearAttence(String beginDate, String endDate)
			throws SysException, ParseException;

	public void updateResetData(String orgid) throws SysException,
			ParseException;

	public void updateLeaveBackDate(String id, String date)
			throws SysException, ParseException;

	public void updateDimissionDate(String subid, String dimission, String date)
			throws SysException, ParseException;

	public void rollBackLeave(AttLeaveBO bo) throws SysException,
			ParseException;

	public void updateOvertimePay(String id, String hours, String selectMonth,
			String overtimePay) throws SysException, ParseException;

	// 显示一段时间内的考勤
	public abstract List getAndShowAllAttMonthBO(PageVO pageVO, String orgID,
			String nameStr, String personType, String beginYearMonth,
			String endYearMonth, String inself, String operUserID)
			throws SysException;

	public abstract List<AttOvertimeBO> queryOvertimeAuditTask(String userId)
			throws SysException;

	public abstract List<AttOutBO> queryOutAuditTask(String userId)
			throws SysException;

	public abstract List<AttRestBO> queryRestAuditTask(String userId)
			throws SysException;

	public abstract List<AttLeaveBO> queryLeaveAuditTask(String userId)
			throws SysException;

	public abstract double getRealDays(String userId, String beginTime,
			String endTime) throws SysException;

	public abstract Map<String, Object> getUndoneDays(String personId)
			throws SysException;

	public abstract String applyLeave(String userId, String leaveId)
			throws SysException;

	public abstract String applyOvertime(String userId, String id)
			throws SysException;

	public abstract String applyRest(String userId, String id)
			throws SysException;

	public abstract String applyOut(String userId, String id)
			throws SysException;

	public List getOvertimePayBO(PageVO pageVO, String orgID, String nameStr,
			String personType, String yearMonth) throws SysException;

	public List getYearBO(PageVO pageVO, String orgID, String nameStr,
			String personType, String yearStr) throws SysException;

	public void rollbackLeaveDays(String string, String applyDays,
			String personId);

	public void deleteInputLeave(String operItemID) throws SysException;

	public void deleteInputOvertime(String operItemID) throws SysException;

	public void deleteInputRest(String operItemID) throws SysException;

	public String updateCalcAttTempData(String orgId, String beginDate,
			String endDate) throws SysException, ParseException;

	public void updateAttTempDate(String tempBeginDate, String tempEndDate)
			throws SysException;

	public List getAttTempDataBO(PageVO pageVO, String orgID, String nameStr,
			String personType) throws SysException;

	public List getAttTempDataBO(String orgID, String nameStr, String personType, String selectedUserIDs)
			throws SysException;

	public void batchSendEmail(List<Map> list) throws SysException;

	public boolean isFeast(String day, String personId) throws SysException;

	public void saveBingjia(AttLeaveBO leave) throws SysException;

	public void updateToShow(String duraID) throws SysException;

	public Map getAttDetailForSomebody(String personId, String yearMonth)  throws SysException;

}
