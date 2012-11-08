package com.hr319wg.custom.attence.service;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.activiti.engine.task.Task;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.attence.dao.AttDurationDAO;
import com.hr319wg.attence.dao.AttFeastDAO;
import com.hr319wg.attence.dao.AttRestWeekDAO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassDetailBO;
import com.hr319wg.attence.pojo.bo.AttFeastBO;
import com.hr319wg.attence.pojo.bo.AttRestOfWeekBO;
import com.hr319wg.attence.pojo.bo.AttWorkDateBO;
import com.hr319wg.attence.util.DateUtil;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.attence.dao.AttBusiDAO;
import com.hr319wg.custom.attence.pojo.bo.AttFingerBO;
import com.hr319wg.custom.attence.pojo.bo.AttLeaveBO;
import com.hr319wg.custom.attence.pojo.bo.AttLogBO;
import com.hr319wg.custom.attence.pojo.bo.AttMachineBO;
import com.hr319wg.custom.attence.pojo.bo.AttOutBO;
import com.hr319wg.custom.attence.pojo.bo.AttOvertimeBO;
import com.hr319wg.custom.attence.pojo.bo.AttRestBO;
import com.hr319wg.custom.attence.util.AttConstants;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.SysInProcessBO;
import com.hr319wg.sys.ucc.ISysInProcessUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;
import com.hr319wg.xys.workflow.service.SelPersonsToolService;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.sun.xml.internal.bind.CycleRecoverable.Context;

public class AttBusiServiceImpl implements IAttBusiService {

	private AttDurationDAO attDurationDAO;
	private AttRestWeekDAO attrestweekDAO;
	private AttFeastDAO attfeastDAO;
	private AttBusiDAO attBusiDAO;
	private ActivePageAPI activeapi;
	private QueryAPI queryapi;
	private JdbcTemplate jdbcTemplate;
	private ActivitiToolsService activitiToolService;
	private SelPersonsToolService selPersonTool;

	public SelPersonsToolService getSelPersonTool() {
		return selPersonTool;
	}

	public void setSelPersonTool(SelPersonsToolService selPersonTool) {
		this.selPersonTool = selPersonTool;
	}

	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}

	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public AttDurationDAO getAttDurationDAO() {
		return attDurationDAO;
	}

	public void setAttDurationDAO(AttDurationDAO attDurationDAO) {
		this.attDurationDAO = attDurationDAO;
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

	public AttBusiDAO getAttBusiDAO() {
		return attBusiDAO;
	}

	public void setAttBusiDAO(AttBusiDAO attBusiDAO) {
		this.attBusiDAO = attBusiDAO;
	}

	public ActivePageAPI getActiveapi() {
		return activeapi;
	}

	public void setActiveapi(ActivePageAPI activeapi) {
		this.activeapi = activeapi;
	}

	public QueryAPI getQueryapi() {
		return queryapi;
	}

	public void setQueryapi(QueryAPI queryapi) {
		this.queryapi = queryapi;
	}

	@Override
	public String getPutoffSum() throws SysException {
		String sql = "select count(*) from att_putoff";
		return this.activeapi.queryForString(sql);
	}

	@Override
	public void updatePutoff(String yearMonth) throws SysException {
		String sql = "update a235 a set A235201='"
				+ yearMonth
				+ "',A235202='00901',A235200=(select totalTime from att_putoff p where a.id=p.id)";
		this.activeapi.executeSql(sql);
		sql = "delete from att_putoff";
		this.activeapi.executeSql(sql);
	}

	@Override
	public List getAllAttPutoffDataBO(PageVO pageVO, String orgID,
			String nameStr, String personType) throws SysException {
		// return this.jdbcTemplate.queryForList("select * from a236");
		return this.attBusiDAO.getAllAttPutoffDataBO(pageVO, orgID, nameStr,
				personType);
	}

	@Override
	public List<UserBO> getAllCurrApprover(String[] userIDs)
			throws SysException {
		return this.attBusiDAO.getAllCurrApprover(userIDs);
	}

	@Override
	public List getCurrAttDurationBO() throws SysException {
		return this.attBusiDAO.getCurrAttDurationBO();
	}

	@Override
	public List getAllAttClassUserBOByClassID(String classID)
			throws SysException {
		return this.attBusiDAO.getAllAttClassUserBOByClassID(classID);
	}

	@Override
	public List getAllAttClassUserBOByClassID(PageVO pageVO, String orgID,
			String nameStr, String personType, String classID)
			throws SysException {
		return this.attBusiDAO.getAllAttClassUserBOByClassID(pageVO, orgID,
				nameStr, personType, classID);
	}

	@Override
	public List getAllVerifyAttMonthBO(PageVO pageVO, String orgID,
			String nameStr, String personType, String yearMonth)
			throws SysException {
		return this.attBusiDAO.getAllVerifyAttMonthBO(pageVO, orgID, nameStr,
				personType, yearMonth);
	}

	@Override
	public List getAllAttMonthBOByOrgIDs(PageVO pageVO, String orgID,
			String nameStr, String personType, String yearMonth, String inself,
			String operUserID) throws SysException {
		return this.attBusiDAO.getAllAttMonthBOByOrgIDs(pageVO, orgID, nameStr,
				personType, yearMonth, inself, operUserID);
	}

	@Override
	public List getAllMachineBOByIPs(String IPs) throws SysException {
		return this.attBusiDAO.getAllMachineBOByIPs(IPs);
	}

	@Override
	public List getAllAttMachineBO() throws SysException {
		return this.attBusiDAO.getAllAttMachineBO();
	}

	@Override
	public List getAttMonthBO(String userID, String yearMonth)
			throws SysException {
		return this.attBusiDAO.getAllAttMonthBO(userID, yearMonth);
	}

	@Override
	public List getAllAttMonthBO(PageVO pageVO, String orgID, String nameStr,
			String personType, String yearMonth, String[] userIDs)
			throws SysException {
		return this.attBusiDAO.getAllAttMonthBO(pageVO, orgID, nameStr,
				personType, yearMonth, userIDs);
		// return this.attBusiDAO.getAndShowAllAttMonthBO(pageVO, orgID,
		// nameStr, personType, "2011-08", "2012-10", userIDs);
	}

	@Override
	public List getAllFingerBO(PageVO pageVO, String orgID, String nameStr,
			String personType, boolean collected, boolean uncollected,
			boolean hasPwd, boolean notHasPwd) throws SysException {
		return this.attBusiDAO.getAllFingerInfo(pageVO, orgID, nameStr,
				personType, collected, uncollected, hasPwd, notHasPwd);
	}

	@Override
	public List getAllMachineBO(PageVO pageVo, String machineType)
			throws SysException {
		return this.attBusiDAO.getAllMachineBO(pageVo, machineType);
	}

	@Override
	public String getMasterMachineIP() throws SysException {
		String sql = "select machine_ip from att_machine where machine_type=0";
		return this.activeapi.queryForString(sql);
	}

	@Override
	public List getMasterMachine() throws SysException {
		return this.attBusiDAO.getMasterMachineBO();
	}

	@Override
	public List getMasterMachineExcludeSelf(String ip) throws SysException {
		return this.attBusiDAO.getMasterMachineBOExcludeSelf(ip);
	}

	@Override
	public int getMasterMachineExcludeSelfCount(String machineIP)
			throws SysException {
		String sql = "select count(*) from att_machine where machine_type=0 and machine_id<>'"
				+ machineIP + "'";
		return this.activeapi.queryForInt(sql);
	}

	@Override
	public int getMasterMachineCount() throws SysException {
		String sql = "select count(*) from att_machine where machine_type=0";
		return this.activeapi.queryForInt(sql);
	}

	@Override
	public List getMasterMachineIPs(String machineType) throws SysException {
		String sql = "select machine_ip from att_machine where machine_type='"
				+ machineType + "'";
		return this.jdbcTemplate.queryForList(sql);
	}

	@Override
	public List getAllLogBO(PageVO pageVo, String orgID, String nameStr,
			String personType, String createType, String beginDate,
			String endDate) throws SysException {
		return this.attBusiDAO.getAllLogBO(pageVo, orgID, nameStr, personType,
				createType, beginDate, endDate);
	}

	@Override
	public void saveOrUpdateBO(Object bo) throws SysException {

		this.attBusiDAO.saveOrUpdateBo(bo);
		// ***************************************************************************************************
	}

	@Override
	public void checkin(String userID, String date, String time)
			throws SysException {
		String id = UUID.randomUUID().toString();
		String sql = "insert into a808 (id,subid,a808000,a808700,a808701,a808704) values('"
				+ userID
				+ "','"
				+ id
				+ "','00901','"
				+ date
				+ "','"
				+ time
				+ "','1') ";
		this.activeapi.executeSql(sql);
	}

	@Override
	public List getAttLeaveBO(PageVO pagevo, String personId, String[] status,
			String beginDate, String endDate, String orgID, String personType,
			String nameStr, String createType, String inself, String isManager,
			String operUserID, boolean myAtt) throws SysException {
		return this.attBusiDAO.getAttLeaveBO(pagevo, personId, status,
				beginDate, endDate, orgID, personType, nameStr, createType,
				inself, isManager, operUserID, myAtt);
	}

	@Override
	public List getAttOutBO(PageVO pagevo, String personId, String[] status,
			String beginDate, String endDate, String orgID, String personType,
			String nameStr, String createType, String inself, String isManager,
			String operUserID, boolean myAtt) throws SysException {
		return this.attBusiDAO.getAttOutBO(pagevo, personId, status, beginDate,
				endDate, orgID, personType, nameStr, createType, inself,
				isManager, operUserID, myAtt);
	}

	@Override
	public List getAttOvertimeBO(PageVO pagevo, String personId,
			String[] status, String beginDate, String endDate, String orgID,
			String personType, String nameStr, String createType,
			String inself, String isManager, String operUserID, boolean myAtt)
			throws SysException {
		return this.attBusiDAO.getAttOvertimeBO(pagevo, personId, status,
				beginDate, endDate, orgID, personType, nameStr, createType,
				inself, isManager, operUserID, myAtt);
	}

	@Override
	public List getAttRestBO(PageVO pagevo, String personId, String[] status,
			String beginDate, String endDate, String orgID, String personType,
			String nameStr, String createType, String inself, String isManager,
			String operUserID, boolean myAtt) throws SysException {
		return this.attBusiDAO.getAttRestBO(pagevo, personId, status,
				beginDate, endDate, orgID, personType, nameStr, createType,
				inself, isManager, operUserID, myAtt);
	}

	@Override
	public AttLeaveBO findAttLeaveBOByProcessInstanceId(String processId)
			throws SysException {
		return this.attBusiDAO.findAttLeaveBOByProcessInstanceId(processId);
	}

	@Override
	public AttOutBO findAttOutBOByProcessInstanceId(String processId)
			throws SysException {
		return this.attBusiDAO.findAttOutBOByProcessInstanceId(processId);
	}

	@Override
	public AttOvertimeBO findAttOvertimeBOByProcessInstanceId(String processId)
			throws SysException {
		return this.attBusiDAO.findAttOvertimeBOByProcessInstanceId(processId);
	}

	@Override
	public AttRestBO findAttRestBOByProcessInstanceId(String processId)
			throws SysException {
		return this.attBusiDAO.findAttRestBOByProcessInstanceId(processId);
	}

	@Override
	public AttLeaveBO findAttLeaveBOById(String id) throws SysException {
		return (AttLeaveBO) this.attBusiDAO.findBoById(AttLeaveBO.class, id);
	}

	@Override
	public Object findBOById(Class c, String id) throws SysException {
		return this.attBusiDAO.findBoById(c, id);
	}

	@Override
	public void saveAttLeaveBO(AttLeaveBO bo) throws SysException {
		this.attBusiDAO.saveOrUpdateBo(bo);
	}

	@Override
	public void deleteBO(Class c, String id) throws SysException {
		this.attBusiDAO.deleteBo(c, id);
	}

	@Override
	public void deleteAttLeaveBO(String id) throws SysException {
		this.attBusiDAO.deleteBo(AttLeaveBO.class, id);
	}

	@Override
	public List getAttLogBOById(String leaveId) throws SysException {
		return this.attBusiDAO.getAttLogBOById(leaveId);
	}

	@Override
	public AttLogBO findAttLeaveLogBOById(String id) throws SysException {
		return (AttLogBO) this.attBusiDAO.findBoById(AttLogBO.class, id);
	}

	@Override
	public void saveAttLeaveLogBO(AttLogBO bo) throws SysException {
		this.attBusiDAO.saveOrUpdateBo(bo);
	}

	/**
	 * 考勤机管理
	 */
	private static int port = 4370;
	private static int iMachineNumber = 1;

	/**
	 * 从考勤机中把用户的信息读取出来(包括用户的指纹信息)保存到人力资源系统中
	 * 
	 * @param myCom
	 * @param ip
	 * @param personCode
	 * @throws SysException
	 */
	@Override
	public String updateAllKQUsersData(Dispatch myCom, String ip)
			throws SysException {
		Variant dwMachineNumber = new Variant(0, true);// 机器号
		Variant dwEnrollNumber = new Variant("", true);// 用户号
		Variant Name = new Variant("", true);// 用户姓名
		Variant Password = new Variant("", true);// 用户密码
		Variant Privilege = new Variant(0, true);// 用户权限，3为管理员，0为普通用户
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// 用户启用标志，1为启用，0为禁用
		Variant dwFingerIndex = new Variant(0, true);// 手指索引
		Variant TmpData = new Variant("", true);// string 指纹信息
		Variant TmpLength = new Variant(0, true);// TmpLength
		String err = "";
		String colectFail = "";
		String noInfo = "";
		List<AttFingerBO> list = new ArrayList<AttFingerBO>();
		// 连接
		Boolean isConnected = Dispatch.call(myCom, "Connect_Net", ip, port)
				.getBoolean();
		// 判断连接结果
		if (isConnected == true) {
			int idwErrorCode = 0;
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// 使机器处于不可用状态

			if (!Dispatch.call(myCom, "ReadAllTemplate", dwMachineNumber)
					.getBoolean()) {
				return "考勤机连接成功,读取指纹信息失败";
			}

			if (Dispatch.call(myCom, "ReadAllUserID", iMachineNumber)
					.getBoolean()) {// read all the attendance records to the
									// memory
				while (Dispatch.call(myCom, "SSR_GetAllUserInfo",
						dwMachineNumber, dwEnrollNumber, Name, Password,
						Privilege, Enabled).getBoolean()) {
					// 因为打卡的手指可以是十个手指中的任意一个,所以要进行读 10 次。
					PersonBO p = SysCacheTool.findPersonByCode(dwEnrollNumber
							.toString().trim());
					if (p != null) {
						AttFingerBO bo = new AttFingerBO();
						bo.setPrivilege(String.valueOf(Privilege));
						bo.setPassword(String.valueOf(Password));
						bo.setPersonCode(String.valueOf(dwEnrollNumber));
						bo.setName(String.valueOf(Name));
						bo.setID(p.getPersonId());
						for (int i = Integer.valueOf(String
								.valueOf(dwFingerIndex)); i < 10; i++) {
							if (Dispatch.call(myCom, "SSR_GetUserTmpStr",
									dwMachineNumber, dwEnrollNumber, i,
									TmpData, TmpLength).getBoolean()) {
								if (i == 0) {
									bo.setFinger0(String.valueOf(TmpData));
								} else if (i == 1) {
									bo.setFinger1(String.valueOf(TmpData));
								} else if (i == 2) {
									bo.setFinger2(String.valueOf(TmpData));
								} else if (i == 3) {
									bo.setFinger3(String.valueOf(TmpData));
								} else if (i == 4) {
									bo.setFinger4(String.valueOf(TmpData));
								} else if (i == 5) {
									bo.setFinger5(String.valueOf(TmpData));
								} else if (i == 6) {
									bo.setFinger6(String.valueOf(TmpData));
								} else if (i == 7) {
									bo.setFinger7(String.valueOf(TmpData));
								} else if (i == 8) {
									bo.setFinger8(String.valueOf(TmpData));
								} else if (i == 9) {
									bo.setFinger9(String.valueOf(TmpData));
								}
							}
						}
						list.add(bo);
					}
				}
			} else {
				Dispatch.call(myCom, "GetLastError", idwErrorCode);
				if (idwErrorCode != 0) {
					colectFail += dwEnrollNumber + ",";
				} else {
					noInfo += dwEnrollNumber + ",";
				}
			}
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// enable
																		// the
																		// device
		} else {
			err += "主考勤机连接失败";
		}
		if (!"".equals(colectFail)) {
			err += "以下编号员工" + colectFail + "指纹采集失败。";
		}
		if (!"".equals(noInfo)) {
			err += "以下编号员工" + colectFail + "暂无指纹信息。";
		}
		if (list.size() > 0) {
			for (AttFingerBO bo : list) {
				this.attBusiDAO.saveOrUpdateBo(bo);
			}
		}
		return err;
	}

	/**
	 * 从考勤机上读取指定用户的信息 包括指纹信息和密码信息权限信息
	 * 
	 * @param myCom
	 * @param ip
	 *            考勤机IP
	 * @param personCode
	 *            员工编号
	 * @throws SysException
	 */
	@Override
	public String getAndWriteKQUsersDataBypersonCode(Dispatch myCom, String ip,
			String personCode) throws SysException {
		Variant dwMachineNumber = new Variant(0, true);// 机器号
		Variant dwEnrollNumber = new Variant("", true);// 用户号
		Variant Name = new Variant("", true);// 用户姓名
		Variant Password = new Variant("", true);// 用户密码
		Variant Privilege = new Variant(0, true);// 用户权限，3为管理员，0为普通用户
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// 用户启用标志，1为启用，0为禁用
		Variant dwFingerIndex = new Variant(0, true);// 手指索引
		Variant TmpData = new Variant("", true);// string 指纹信息
		Variant TmpLength = new Variant(0, true);// TmpLength
		String err = "";
		// 连接
		Boolean isConnected = Dispatch.call(myCom, "Connect_Net", ip, port)
				.getBoolean();
		// 判断连接结果
		if (isConnected == true) {
			int idwErrorCode = 0;
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// 使机器处于不可用状态
			if (Dispatch.call(myCom, "SSR_GetUserInfo", dwMachineNumber,
					personCode, Name, Password, Privilege, Enabled)
					.getBoolean()) {
				// 因为打卡的手指可以是十个手指中的任意一个,所以要进行读 10 次。
				for (int i = Integer.valueOf(String.valueOf(dwFingerIndex)); i < 10; i++) {
					if (Dispatch.call(myCom, "SSR_GetUserTmpStr",
							dwMachineNumber, personCode, i, TmpData, TmpLength)
							.getBoolean()) {
						String sql = "update a232 a set a.a23220"
								+ i
								+ " = '"
								+ TmpData
								+ "' ,  a.A232210 = '"
								+ Privilege
								+ "',a.A232211 = '"
								+ Password
								+ "' where id = (select id from a001 where A001735='"
								+ personCode + "')";
						try {
							activeapi.executeSql(sql);
						} catch (Exception e) {
							err += "人员编号" + personCode + "指纹信息保存失败";
						}
					}
				}
			} else {
				Dispatch.call(myCom, "GetLastError", idwErrorCode);
				if (idwErrorCode != 0) {
					err += "考勤机已连接读取指纹信息失败";
				} else {
					err += "考勤机暂无该人员指纹信息";
				}
			}
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// 使机器处于可用状态
		} else {
			err += "考勤机连接失败";
		}
		return err;
	}

	/**
	 * 单个上传信息包括指纹到考勤机上
	 * 
	 * @param ip
	 *            考勤机 IP 地址
	 * @param personCode
	 *            员工编号
	 */
	@Override
	public String uploadInfo(Dispatch myCom, AttMachineBO bo,
			List<Map> infolist) {
		String err="";
		Variant dwMachineNumber = new Variant(0, true);// 机器号
		Variant dwEnrollNumber = new Variant("", true);// 用户号
		Variant Name = new Variant("", true);// 用户姓名
		Variant Password = new Variant("", true);// 用户密码
		Variant Privilege = new Variant(0, true);// 用户权限，3为管理员，0为普通用户
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)),
				true);// 用户启用标志，1为启用，0为禁用
		Variant dwFingerIndex = new Variant(0, true);// 手指索引
		Variant TmpData = new Variant("", true);// string 指纹信息
		Variant TmpLength = new Variant(0, true);// TmpLength
		
		ActiveXComponent objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
		Dispatch myCon = (Dispatch) objArchSend.getObject();
		// 连接
		Boolean isConnected = Dispatch.call(myCon, "Connect_Net", bo.getMachineIP(), 4370).getBoolean();
		// 判断连接结果
		if (isConnected == true) {
			Dispatch.call(myCon, "EnableDevice", 1, false);// 使机器处于不可用状态
			Dispatch.call(myCon, "BeginBatchUpdate", 1, 1);
			for (Map m : infolist) {
				dwEnrollNumber = new Variant(m.get("a001735"));
				Name = new Variant(m.get("a001001"));
				if (m.get("A232210") != null
						&& !"".equals(m.get("A232210"))) {
					Privilege = new Variant(m.get("A232210"));
				} else {
					Privilege = new Variant(0);
				}
				if (m.get("A232211") != null
						&& !"".equals(m.get("A232211"))) {
					Password = new Variant(m.get("A232211"));
				} else {
					Password = new Variant("");
				}
				Enabled = new Variant(1);
				// 先把用户添加上去
				if (Dispatch.call(myCon, "SSR_SetUserInfo",
						dwMachineNumber, dwEnrollNumber, Name, Password,
						Privilege, Enabled).getBoolean()) {
					for (int j = 0; j < 10; j++) {
						if (m.get("A23220" + j) != null
								&& !"".equals(m.get("A23220" + j))) {
							TmpData = new Variant(m.get("A23220" + j));
							Dispatch.call(myCon, "SetUserTmpExStr",
									dwMachineNumber, dwEnrollNumber,
									new Variant(j), 1, TmpData)
									.getBoolean();
						}
					}
				}
			}
			//for-end
			Dispatch.call(myCon, "BatchUpdate", 1);
			Dispatch.call(myCon, "RefreshData", 1);
			Dispatch.call(myCon, "EnableDevice", 1, true);
		}else{
			err+=bo.getMachineName()+",";
		}
		return err;
	}

	/**
	 * 从考勤机上批量读取用户指纹信息
	 * 
	 * @param myCom
	 * @param IPStr
	 *            从哪一个IP考勤机上读取用户信息
	 * @throws Exception
	 */
	@Override
	public List batchDownloadInfoDetailFromZKEM(String ip) throws Exception {
		Variant dwMachineNumber = new Variant(0, true);// 机器号
		Variant dwEnrollNumber = new Variant("", true);// 用户号
		Variant Name = new Variant("", true);// 用户姓名
		Variant Password = new Variant("", true);// 用户密码
		Variant Privilege = new Variant(0, true);// 用户权限，3为管理员，0为普通用户
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// 用户启用标志，1为启用，0为禁用
		Variant dwFingerIndex = new Variant(0, true);// 手指索引
		Variant TmpData = new Variant("", true);// string 指纹信息
		Variant TmpLength = new Variant(0, true);// TmpLength

		List list = new ArrayList();
		String readFail = "";
		String noFinger = "";
		String err = "";
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			throw new Exception("考勤机驱动注册失败");
		}
		// 连接
		Boolean isConnected = Dispatch.call(myCom, "Connect_Net", ip, port)
				.getBoolean();
		// 判断连接结果
		if (isConnected == true) {
			int idwErrorCode = 0;
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// 使机器处于不可用状态

			if (!Dispatch.call(myCom, "ReadAllTemplate", dwMachineNumber)
					.getBoolean()) {
				throw new Exception("考勤机连接成功,读取指纹信息失败");
			}

			if (Dispatch.call(myCom, "ReadAllUserID", iMachineNumber)
					.getBoolean()) {// read all the attendance records to the
									// memory
				while (Dispatch.call(myCom, "SSR_GetAllUserInfo",
						dwMachineNumber, dwEnrollNumber, Name, Password,
						Privilege, Enabled).getBoolean()) {
					// 因为打卡的手指可以是十个手指中的任意一个,所以要进行读 10 次。
					Map map = new HashMap();
					int fingerCount = 0;
					for (int i = Integer.valueOf(String.valueOf(dwFingerIndex)); i < 10; i++) {
						if (Dispatch.call(myCom, "SSR_GetUserTmpStr",
								dwMachineNumber, dwEnrollNumber, i, TmpData,
								TmpLength).getBoolean()) {
							fingerCount++;
						}
					}
					String personCode = dwEnrollNumber.toString();
					map.put("personCode", personCode);
					map.put("fingerCount", fingerCount);
					map.put("Privilege", Privilege.toString());
					list.add(map);
				}

			} else {
				Dispatch.call(myCom, "GetLastError", idwErrorCode);
				if (idwErrorCode != 0) {
					readFail += dwEnrollNumber + ",";
				} else {
					noFinger += dwEnrollNumber + ",";
				}
			}
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// enable
																		// the
																		// device
		} else {
			throw new Exception("考勤机连接失败");
		}
		if (!"".equals(readFail)) {
			err += "以下编号员工" + readFail + "指纹信息读取失败。";
		}
		if (!"".equals(readFail)) {
			err += "以下编号员工" + noFinger + "没有指纹信息。";
		}
		if (!"".equals(err) && err.length() != 0) {
			throw new Exception(err);
		}

		return list;
	}

	/**
	 * 从考勤机上批量读取用户信息并且添加到 a232表中
	 * 
	 * @param myCom
	 * @param IPStr
	 *            从哪一个IP考勤机上读取用户信息
	 */
	@Override
	public String batchDownloadInfoFromZKEM(String ip) {
		String err = "";
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "考勤机驱动注册失败";
		}
		try {
			err = updateAllKQUsersData(myCom, ip);
		} catch (SysException e) {
			err = e.getMessage();
		}
		return err;
	}

	/**
	 * 从考勤机上读取特定用户信息()并且添加到 a232表中
	 * 
	 * @param myCom
	 * @param IPStr
	 *            从哪一个IP考勤机上读取用户信息
	 * @param personCode
	 *            员工用户编号
	 * @throws SysException
	 */
	@Override
	public String downloadInfoFromZKEMByPersonCode(String IPStr,
			String personCode) throws SysException {
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "考勤机驱动注册失败";
		}
		return getAndWriteKQUsersDataBypersonCode(myCom, IPStr, personCode);
	}

	/**
	 * 把HR表中的用户数据上传到 哪些IP考勤机中
	 * 
	 * @param IPStr
	 * @param personCode
	 */
	@Override
	public String uploadInfoToZKEM(List<AttMachineBO> mList,
			String operUserIDs) {
		String err = "";
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "考勤机驱动注册失败";
		}
		String sql = "select a.a001735, a.a001001 ,b.A232210 ,b.A232211 , "
				+ "b.A232200,b.A232201,b.A232202,b.A232203,b.A232204,b.A232205,b.A232206,b.A232207,b.A232208,b.A232209 "
				+ "from a001 a,a232 b where a.ID = b.ID and a.A001054 not in ('013520','013521','013522','013523','013524','013525')";
		if(operUserIDs!=null){//多人分发
			sql = "select a.a001735, a.a001001 ,b.A232210 ,b.A232211 , "
					+ "b.A232200,b.A232201,b.A232202,b.A232203,b.A232204,b.A232205,b.A232206,b.A232207,b.A232208,b.A232209 "
					+ "from a001 a,a232 b where a.ID = b.ID and "+CommonFuns.splitInSql(operUserIDs.split(","), "a.ID");
		}
		List infolist = this.jdbcTemplate.queryForList(sql);
		if(infolist!=null){
			for (AttMachineBO bo : mList) {
				err += uploadInfo(myCom, bo, infolist);
			}
			if(!"".equals(err)){
				err="以下考勤机："+err+"连接失败";
			}
		}
		return err;
	}

	/**
	 * 读写考勤机记录
	 */
	@Override
	public String downloadLog(String orgID, List<AttMachineBO> mList)
			throws SysException {
		// 建立连接对象
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "考勤机驱动注册失败";
		}
		String msg = "";
		String noExsit = "";
		int success = 0;
		for (AttMachineBO bo : mList) {
			Boolean isConnected = Dispatch.call(myCom, "Connect_Net",
					bo.getMachineIP(), port).getBoolean();
			// 判断连接结果
			if (isConnected == true) {
				// 读取记录
				Variant sdwMachineNumber = new Variant("", true);
				Variant sdwEnrollNumber = new Variant("", true); // 工号
				Variant idwVerifyMode = new Variant(0, true);
				Variant idwInOutMode = new Variant(0, true);
				Variant idwYear = new Variant(0, true);
				Variant idwMonth = new Variant(0, true);
				Variant idwDay = new Variant(0, true);
				Variant idwHour = new Variant(0, true);
				Variant idwMinute = new Variant(0, true);
				Variant idwSecond = new Variant(0, true);//
				Variant idwWorkcode = new Variant(new Integer(0), true);

				int idwErrorCode = 0;

				Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// 使机器处于不可用状态
				if (Dispatch.call(myCom, "ReadGeneralLogData", iMachineNumber)
						.getBoolean())// read all the attendance records to the
										// memory
				{
					// 循环读取记录并保存到数据库
					while (Dispatch.call(myCom, "SSR_GetGeneralLogData",
							iMachineNumber, sdwEnrollNumber, idwVerifyMode,
							idwInOutMode, idwYear, idwMonth, idwDay, idwHour,
							idwMinute, idwSecond, idwWorkcode).getBoolean())// get
																			// records
																			// from
																			// the
																			// memory
					{
						String month = idwMonth.toString();
						String day = idwDay.toString();
						String hour = idwHour.toString();
						String minute = idwMinute.toString();
						String second = idwSecond.toString();
						if (Integer.valueOf(month) < 10) {
							month = "0" + month;
						}
						if (Integer.valueOf(day) < 10) {
							day = "0" + day;
						}
						if (Integer.valueOf(hour) < 10) {
							hour = "0" + hour;
						}
						if (Integer.valueOf(minute) < 10) {
							minute = "0" + minute;
						}
						if (Integer.valueOf(second) < 10) {
							second = "0" + second;
						}
						String date = idwYear.toString() + "-" + month + "-"
								+ day;
						String time = hour + ":" + minute;

						// 是否存在相同考勤记录
						String sql = "select count(*) from a808 r,a001 a where a.id=r.id and A001735='"
								+ sdwEnrollNumber.toString()
								+ "' and A808700='"
								+ date
								+ "' and A808701='"
								+ time + "'";
						int count = this.activeapi.queryForInt(sql);
						if (count == 0) {
							String key = SequenceGenerator.getKeyId("A808");
							PersonBO p = SysCacheTool
									.findPersonByCode(sdwEnrollNumber
											.toString());
							if (p != null) {
								sql = "insert into A808(ID,SUBID,A808000,A808700,A808701) values('"
										+ p.getPersonId()
										+ "', '"
										+ key
										+ "','00901','"
										+ date
										+ "','"
										+ time
										+ "') ";// 时间(A808701) 日期(A808700)
								this.activeapi.executeSql(sql);
								success++;
							} else {
								noExsit += sdwEnrollNumber.toString() + ",";
							}
						}
					}
				} else {
					Dispatch.call(myCom, "GetLastError", idwErrorCode);
					if (idwErrorCode != 0) {
						msg += "考勤机" + bo.getMachineName() + "读取考勤记录失败,";
					}
				}
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// 使考勤机可用
			} else {
				msg += "考勤机" + bo.getMachineName() + "连接失败,";
			}
		}
		if (!"".equals(noExsit)) {
			msg += "以下编号员工" + noExsit + "不存在。";
		}
		msg = "新增考勤记录" + success + "条。" + msg;
		return msg;
	}

	/**
	 * 删除考勤数据
	 * 
	 * @param list
	 * @param operType
	 * @return
	 */
	@Override
	public String clearLog(List<AttMachineBO> list) {
		Variant dwMachineNumber = new Variant(0, true);// 机器号
		Variant dwEnrollNumber = new Variant("", true);// 用户号
		Variant Name = new Variant("", true);// 用户姓名
		Variant Password = new Variant("", true);// 用户密码
		Variant Privilege = new Variant(0, true);// 用户权限，3为管理员，0为普通用户
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// 用户启用标志，1为启用，0为禁用
		Variant dwFingerIndex = new Variant(0, true);// 手指索引
		Variant TmpData = new Variant("", true);// string 指纹信息
		Variant TmpLength = new Variant(0, true);// TmpLength

		String err = "";
		String clearFail = "";
		String connFail = "";
		// 建立连接对象
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "考勤机驱动注册失败";
		}
		for (AttMachineBO bo : list) {
			Boolean isConnected = Dispatch.call(myCom, "Connect_Net",
					bo.getMachineIP(), port).getBoolean();
			// 判断连接结果
			if (isConnected == true) {
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// 使机器处于不可用状态
				if (!Dispatch.call(myCom, "ClearGLog", dwMachineNumber)
						.getBoolean()) {
					clearFail += bo.getMachineName() + ",";
				}
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// 使考勤机调成可用状态
			} else {
				connFail += bo.getMachineName() + ",";
			}
		}
		if (!"".equals(clearFail)) {
			err += "以下考勤机" + clearFail + "连接成功删除失败。";
		}
		if (!"".equals(connFail)) {
			err += "以下考勤机" + clearFail + "连接失败。";
		}
		return err;
	}

	/**
	 * 删除考勤机数据 1考勤记录 5人员
	 * 
	 * @param list
	 * @param operType
	 * @return
	 */
	@Override
	public String clearData(List<AttMachineBO> list, String operType) {
		Variant dwMachineNumber = new Variant(0, true);// 机器号
		Variant dwEnrollNumber = new Variant("", true);// 用户号
		Variant Name = new Variant("", true);// 用户姓名
		Variant Password = new Variant("", true);// 用户密码
		Variant Privilege = new Variant(0, true);// 用户权限，3为管理员，0为普通用户
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// 用户启用标志，1为启用，0为禁用
		Variant dwFingerIndex = new Variant(0, true);// 手指索引
		Variant TmpData = new Variant("", true);// string 指纹信息
		Variant TmpLength = new Variant(0, true);// TmpLength

		String err = "";
		String clearFail = "";
		String connFail = "";
		// 建立连接对象
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "考勤机驱动注册失败";
		}
		for (AttMachineBO bo : list) {
			Boolean isConnected = Dispatch.call(myCom, "Connect_Net",
					bo.getMachineIP(), port).getBoolean();
			// 判断连接结果
			if (isConnected == true) {
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// 使机器处于不可用状态
				if (Dispatch.call(myCom, "ReadAllUserID", iMachineNumber)
						.getBoolean()) {// read all the attendance records to
										// the memory
					if (Dispatch.call(myCom, "SSR_GetAllUserInfo",
							dwMachineNumber, dwEnrollNumber, Name, Password,
							Privilege, Enabled).getBoolean()) {
						if (!Dispatch.call(myCom, "ClearData", dwMachineNumber,
								operType).getBoolean()) {
							clearFail += bo.getMachineName() + ",";
						}
					}
				}
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// 使机器处于可用状态
			} else {
				connFail += bo.getMachineName() + ",";
			}
		}
		if (!"".equals(clearFail)) {
			err += "以下考勤机" + clearFail + "连接成功删除失败。";
		}
		if (!"".equals(connFail)) {
			err += "以下考勤机" + clearFail + "连接失败。";
		}
		return err;
	}

	// 更新带薪假存休子集的数据,处理审批结束或者录入的情况
	public void updateLeaveDays(String type, String days, String personId) {
		String sql = "update a236 set ";
		// 处理请假的七种类型
		if (type.equals("1")) {
			// 正常事假
			sql += "a236201=nvl(a236201,0)+" + Double.parseDouble(days);
		} else if (type.equals("2")) {
			/*
			 * // 病假 病假要处理5天的带薪病假和其他的 // 算法:统计病假，先用假条天数减去剩余的带薪病假得到数字day
			 * 有两种可能，结果大于等于0，或者小于0 //
			 * 算法:day大于等于0的话，说明这次请假过后，有day天需要扣钱；day小于0的话，说明这次请假过后， //
			 * 还剩余-day的带薪病假 sql += "a236202=" + Double.parseDouble(days) +
			 * "-a236202 where id='" + personId + "'";
			 * this.jdbcTemplate.execute(sql); // ////day大于等于0的情况 // 将出去带薪病假的
			 * 病假天数累加到年请假天数 sql =
			 * "update a236 set a236201=a236201+a236202 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); // 将带薪病假清0
			 * sql = "update a236 set a236202=0 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); //
			 * ////day小于0的情况 sql =
			 * "update a236 set a236202=0-a236202 where id='" + personId +
			 * "' and a236202<0"; this.jdbcTemplate.execute(sql);
			 */
		} else if (type.equals("3")) {
			// 婚假
			sql += "a236203=nvl(a236203,0)-" + Double.parseDouble(days);
		} else if (type.equals("4")) {
			// 丧假
			sql += "a236204=nvl(a236204,0)-" + Double.parseDouble(days);
		} else if (type.equals("5")) {
			// 产假
			sql += "a236205=nvl(a236205,0)-" + Double.parseDouble(days);
		} else if (type.equals("6")) {
			// 难产产假
			sql += "a236206=nvl(a236206,0)-" + Double.parseDouble(days);
		} else if (type.equals("7")) {
			// 带薪事假
			sql += "a236207=nvl(a236207,0)-" + Double.parseDouble(days);
		}
		// 处理加班和调休
		else if (type.equals("0")) {
			//处理加班时间
			double doubleDays=Double.parseDouble(days);
			if(doubleDays<1){
				doubleDays=0.5;
			}else if(doubleDays<1.5){
				doubleDays=1.0;
			}else if(doubleDays<2){
				doubleDays=1.5;
			}else{
				doubleDays=2.0;
			}
			sql += "a236200=nvl(a236200,0)+" + doubleDays * 8;
		} else if (type.equals("-1")) {
			sql += "a236200=nvl(a236200,0)-" + Double.parseDouble(days) * 8;

		}
		if (!type.equals("2")) {
			sql += " where id='" + personId + "'";
			this.jdbcTemplate.execute(sql);
		}
	}

	// 更新带薪假存休子集的数据,处理录入单删除的情况
	public void rollbackLeaveDays(String type, String days, String personId) {
		String sql = "update a236 set ";
		// 处理请假的七种类型
		if (type.equals("1")) {
			// 正常事假
			sql += "a236201=nvl(a236201,0)+" + Double.parseDouble(days);
		} else if (type.equals("2")) {
			/*
			 * // 病假 病假要处理5天的带薪病假和其他的 // 算法:统计病假，先用假条天数减去剩余的带薪病假得到数字day
			 * 有两种可能，结果大于等于0，或者小于0 //
			 * 算法:day大于等于0的话，说明这次请假过后，有day天需要扣钱；day小于0的话，说明这次请假过后， //
			 * 还剩余-day的带薪病假 sql += "a236202=" + Double.parseDouble(days) +
			 * "-a236202 where id='" + personId + "'";
			 * this.jdbcTemplate.execute(sql); // ////day大于等于0的情况 // 将出去带薪病假的
			 * 病假天数累加到年请假天数 sql =
			 * "update a236 set a236201=a236201+a236202 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); // 将带薪病假清0
			 * sql = "update a236 set a236202=0 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); //
			 * ////day小于0的情况 sql =
			 * "update a236 set a236202=0-a236202 where id='" + personId +
			 * "' and a236202<0"; this.jdbcTemplate.execute(sql);
			 */
		} else if (type.equals("3")) {
			// 婚假
			sql += "a236203=nvl(a236203,0)+" + Double.parseDouble(days);
		} else if (type.equals("4")) {
			// 丧假
			sql += "a236204=nvl(a236204,0)+" + Double.parseDouble(days);
		} else if (type.equals("5")) {
			// 产假
			sql += "a236205=nvl(a236205,0)+" + Double.parseDouble(days);
		} else if (type.equals("6")) {
			// 难产产假
			sql += "a236206=nvl(a236206,0)+" + Double.parseDouble(days);
		} else if (type.equals("7")) {
			// 带薪事假
			sql += "a236207=nvl(a236207,0)+" + Double.parseDouble(days);
		}
		// 处理加班和调休
		else if (type.equals("0")) {
			//处理加班
			//处理加班时间
			double doubleDays=Double.parseDouble(days);
			if(doubleDays<1){
				doubleDays=0.5;
			}else if(doubleDays<1.5){
				doubleDays=1.0;
			}else if(doubleDays<2){
				doubleDays=1.5;
			}else{
				doubleDays=2.0;
			}
			sql += "a236200=nvl(a236200,0)-" + doubleDays * 8;
		} else if (type.equals("-1")) {
			sql += "a236200=nvl(a236200,0)+" + Double.parseDouble(days) * 8;

		}
		if (!type.equals("2")) {
			sql += " where id='" + personId + "'";
			this.jdbcTemplate.execute(sql);
		}
	}

	/*
	 * (non-Javadoc) 计算各种带薪假期的日子
	 * 
	 * @see
	 * com.hr319wg.custom.attence.service.IAttBusiService#getDays(java.lang.
	 * String)
	 */
	@Override
	public List getDays(String personId) {
		String sql = "select * from a236 where id='" + personId + "'";
		List<Map<String, Object>> list = this.jdbcTemplate.queryForList(sql);

		if (list.size() > 0) {
			return list;
		}
		return null;
	}

	/**
	 * 计算某个人未批准的各种带薪假
	 * 
	 * @param personId
	 * @return
	 */
	@Override
	public Map<String, Object> getUndoneDays(String personId) {
		String sql = "select leave_type as type,sum(apply_days) as day from att_leave a "
				+ "where person_id='"
				+ personId
				+ "' and a.status='1' group by person_id,leave_type";
		List<Map<String, Object>> list = this.jdbcTemplate.queryForList(sql);
		Map<String, Object> map = new HashMap<String, Object>();
		// 添加各种带薪假类型3 4 5 6 7依次为婚，丧，病，产，难产
		for (int i = 3; i < 8; i++) {
			for (int j = 0; j < list.size(); j++) {
				Map<String, Object> tempMap = list.get(j);
				if (tempMap.get("type").equals(i + "")) {
					map.put("a" + i, tempMap.get("day"));
					break;
				}
			}
			if (!map.containsKey("a" + i)) {
				map.put("a" + i, "0");
			}
		}

		return map;
	}

	@Override
	public void saveAudit(String result, AttLeaveBO leave, String reason,
			String taskId, String currentUserId) throws SysException {
		AttLogBO bo = new AttLogBO();
		if (result != null && !result.equals("")) {

			Map map = new HashMap();
			if (result.equals("1")) {
				map.put("doAudit", new Boolean(true));
			} else {
				map.put("doAudit", new Boolean(false));
				leave.setStatus(AttConstants.STATUS_AUDIT_LOSE);
			}
			map.put("currPersonId", currentUserId);
			this.activitiToolService.completeTask(taskId, map);
			if (this.activitiToolService.checkProcessIsFinish(leave
					.getProcessId())) {
				leave.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
				// ////流程结束,请假单获得批准
				// 将请假单的信息更新到--带薪假存休子集的记录
				String days = String.valueOf(leave.getApplyDays());// 请假天数
				String type = leave.getLeaveType();// 请假类型
				String personId = leave.getPersonId();// 请假人ID
				this.updateLeaveDays(type, days, personId);
				// 如果流程未结束，添加或者更新待办事宜
				// TODO 待补充
			} else {
				// insertTask(leave,taskId,currentUserId);
			}
			this.saveAttLeaveBO(leave);

			bo.setAuditTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			bo.setLeaveId(leave.getId());
			bo.setPersonId(currentUserId);
			bo.setAuditResult(result);
			bo.setAuditxplan(reason);
			this.saveAttLeaveLogBO(bo);

		}
	}

	@Override
	public void saveRestAudit(String result, AttRestBO rest, String reason,
			String taskId, String currentUserId) throws SysException {
		// TODO Auto-generated method stub
		AttLogBO bo = new AttLogBO();
		if (result != null && !result.equals("")) {

			Map map = new HashMap();
			if (result.equals("1")) {
				map.put("doAudit", new Boolean(true));
			} else {
				map.put("doAudit", new Boolean(false));
				rest.setStatus(AttConstants.STATUS_AUDIT_LOSE);
			}
			map.put("currPersonId", currentUserId);
			this.activitiToolService.completeTask(taskId, map);
			if (this.activitiToolService.checkProcessIsFinish(rest
					.getProcessId())) {
				rest.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
				// ////流程结束,请假单获得批准
				// 将调休信息更新到--带薪假存休子集的记录
				String days = rest.getApplyDays();// 请假天数
				String type = "-1";// 请假类型
				String personId = rest.getPersonId();// 请假人ID
				this.updateLeaveDays(type, days, personId);

			}
			this.saveOrUpdateBO(rest);

			bo.setAuditTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			bo.setLeaveId(rest.getId());
			bo.setPersonId(currentUserId);
			bo.setAuditResult(result);
			bo.setAuditxplan(reason);
			this.saveAttLeaveLogBO(bo);

		}
	}

	@Override
	public void saveOvertimeAudit(String result, AttOvertimeBO overtime,
			String reason, String taskId, String currentUserId)
			throws SysException {
		// TODO Auto-generated method stub
		AttLogBO bo = new AttLogBO();
		if (result != null && !result.equals("")) {

			Map map = new HashMap();
			if (result.equals("1")) {
				map.put("doAudit", new Boolean(true));
			} else {
				map.put("doAudit", new Boolean(false));
				overtime.setStatus(AttConstants.STATUS_AUDIT_LOSE);
			}
			map.put("currPersonId", currentUserId);
			this.activitiToolService.completeTask(taskId, map);
			if (this.activitiToolService.checkProcessIsFinish(overtime
					.getProcessId())) {
				overtime.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
				// ////流程结束,请假单获得批准
				// 将加班的信息更新到--带薪假存休子集的记录
				String days = overtime.getApplyDays();// 加班天数
				String type = "0";// 加班类型设置为0
				String personId = overtime.getPersonId();// 请假人ID
				// 处理加班时间，4-7小时作为0.5天 8-11小时算作1天 12-15小时1.5天 16-算2天。
				// 法定节假日按照双倍
				String day = overtime.getBeginTime();
                if(isFeast(day, personId)){
                	if(Double.parseDouble(days)<1){
                		days="1.0";
                	}else{
                		days="2.0";
                	}
                }
				this.updateLeaveDays(type, days, personId);

			}
			this.saveOrUpdateBO(overtime);

			bo.setAuditTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			bo.setLeaveId(overtime.getId());
			bo.setPersonId(currentUserId);
			bo.setAuditResult(result);
			bo.setAuditxplan(reason);
			this.saveAttLeaveLogBO(bo);

		}
	}

	@Override
	public void saveOutAudit(String result, AttOutBO out, String reason,
			String taskId, String currentUserId) throws SysException {
		// TODO Auto-generated method stub
		AttLogBO bo = new AttLogBO();
		if (result != null && !result.equals("")) {

			Map map = new HashMap();
			if (result.equals("1")) {
				map.put("doAudit", new Boolean(true));
			} else {
				map.put("doAudit", new Boolean(false));
				out.setStatus(AttConstants.STATUS_AUDIT_LOSE);
			}
			map.put("currPersonId", currentUserId);
			this.activitiToolService.completeTask(taskId, map);
			if (this.activitiToolService.checkProcessIsFinish(out
					.getProcessId())) {
				out.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
				// ////流程结束,请假单获得批准
				// 将请假单的信息更新到--带薪假存休子集的记录
				// String days=overtime.getApplyDays();//请假天数
				// String type=overtime.getType();//请假类型
				// String personId=overtime.getPersonId();//请假人ID
				// this.updateLeaveDays(type,days,personId);

			}
			this.saveOrUpdateBO(out);

			bo.setAuditTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			bo.setLeaveId(out.getId());
			bo.setPersonId(currentUserId);
			bo.setAuditResult(result);
			bo.setAuditxplan(reason);
			this.saveAttLeaveLogBO(bo);

		}
	}

	/**
	 * 考勤数据汇总
	 * 
	 * @param orgId
	 * @param beginDate
	 * @param endDate
	 * @throws SysException
	 * @throws ParseException
	 */
	@Override
	public String updateCalcAttData(String orgId, String beginDate,
			String endDate, String year, String month, String dId)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		// 生成临时数据
		updateCalcAttTempData(orgId, beginDate, endDate);

		// ///////////////////////将迟到和旷工的记录更新到月汇总表///////////////////////////
		// 首先清除本次计算涉及到的人
		// 查出本次查询涉及人员的语句:
		String err = "";
		String yearMonth = year + "-" + month;
		Hashtable hash = this.queryapi.getQuerySqlHash(null, dId);
		String renyuansql = (String) hash.get("SQL_FULL");
		String sql = "delete from a810 a where a810700 ='" + yearMonth
				+ "' and exists(select 1 from (" + renyuansql
				+ ") b where a.id=b.id) ";
		this.activeapi.executeSql(sql);
		// sql="select nvl(max(subid),0) from a810";
		// int subid=this.activeapi.queryForInt(sql);
		// 将其他记录设为00900
		sql = "update a810 set a810000='00900'";
		this.activeapi.executeSql(sql);
		// 插入月汇总表
		sql = "insert into a810(id,subid,a810000,a810700,a810701,a810702,a810707,a810704,a810706)"
				+ "select a.userid,('"
				+ yearMonth
				+ "'||a.userid||rownum),'00901','"
				+ yearMonth
				+ "',a.yinggai,a.shiji,'0' as leavedays,a.later as later,a.away as away "
				+ "from ("
				+ "    select t.userid as userid,sum(t.yinggai) as yinggai,sum(t.shiji) as shiji,sum(t.later) as later,sum(t.away) as away "
				+ "    from att_sign_detail t where exists( "
				+ "         select 1 from ( "
				+ renyuansql
				+ "         ) n "
				+ "         where t.userid = n.id   "
				+ "    ) and t.ignore='0' group by t.userid) a ";
		this.activeapi.executeSql(sql);
		// //----补充人员，有些人考勤的日子全部请假了，或者别的原因考勤表遗漏统计了，补充他们进月汇总表
		sql = "insert into a810(id,subid,a810000,a810700,a810701,a810702,a810707,a810704,a810706)"
				+ "select a.id,('"
				+ yearMonth
				+ "'||a.id||rownum),'00901','"
				+ yearMonth
				+ "','0','0','0','0','0' "
				+ " from ("
				+ renyuansql
				+ "         ) a where not exists (select 1 from a810 where a810.id=a.id  and a810.a810700='"
				+ yearMonth + "')";
		this.activeapi.executeSql(sql);
		// 更新请假天数，从请假单中统计出当月请假天数
		sql = "update a810 a set a.a810707=(select nvl(sum(to_number(b.apply_days)),0) from att_leave b where a.id=b.person_id and b.leave_type='1' and b.status='2'"
				+ " and to_date(b.begin_time,'yyyy-mm-dd hh24:mi')>=to_date('2012-09-01','yyyy-mm-dd')   and to_date(b.begin_time,'yyyy-mm-dd hh24:mi')<=to_date('2012-09-30','yyyy-mm-dd') )";
		this.activeapi.executeSql(sql);
		// 调用生成考勤扣款函数 传递orgId，公休日列表，人员获取sql和年月
		List days = DateUtil.getAllBetweenDates(beginDate, endDate);
		attDeduction(orgId, days, renyuansql, yearMonth);
		// 汇总考勤扣款(分为迟到扣款(日工资*0.2*迟到天数))
		// 旷工扣款(日工资*旷工天数)
		// 事假扣款（日工资*事假天数）
		// 病假扣款（30%扣款+50%扣款+80%扣款+100%扣款）(扣款为各自类型病假天数*日工资)
		// 产假扣款(日工资*产假天数)
		// 难产产假扣款(日工资*难产产假天数)
		// 基础工资为空或者""的，先置为0
		sql = "update a223 a set a223206=0 where a223206 is null or a223206=''";
		this.activeapi.executeSql(sql);
		// 填充迟到扣款
		// 先将员工日历子集的表中月总工作日项里面为0的设置为null(/0报错，/null不报错)
		sql = "update a240 set a240240=null where a240240='0'";
		this.activeapi.executeSql(sql);
		// 计算日工资
		String jiben = "(select a223206  from a223 b where a.id=b.id and b.a223000='00901')/"
				+ "(select b.a240240 from a240 b where a.id=b.id and b.a240200=a.a810700)";
		sql = "update a810 a set a810213=trunc(0.2*a810704*" + jiben
				+ " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充旷工扣款
		sql = "update a810 a set a810214=trunc(a810706*" + jiben
				+ " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充产假扣款
		sql = "update a810 a set a810219=trunc((select a240237 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben + " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充难产产假扣款
		sql = "update a810 a set a810220=trunc((select a240238 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben + " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充事假扣款
		sql = "update a810 a set a810215=trunc((select a240232 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben + " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充病假扣款
		sql = "update a810 a set a810216=trunc(0.3*(select a240233 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben
				+ "+"
				+ "0.5*(select a240234 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben
				+ "+"
				+ "0.8*(select a240235 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben
				+ "+"
				+ "1.0*(select a240239 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben + " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充产假天数
		sql = "update a810 a set a810709=(select a240237  from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充难产产假天数
		sql = "update a810 a set a810221=(select a240238  from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充事假天数
		sql = "update a810 a set a810707=(select a240232  from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 填充病假天数
		sql = "update a810 a set a810708=(select a240233+a240234+a240235+nvl(a240239,0) from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// 更新当月实际工作日
		sql = "update a810 a set a810701=(select a240240 from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);

		return null;

	}

	/**
	 * 当月的考勤扣款，包括迟到扣款，旷工扣款，事假扣款，病假扣款
	 * 
	 * @param orgId
	 * @param weekDays
	 * @param sql
	 * @param yearMonth
	 * @throws SysException
	 * @throws ParseException
	 */
	public void attDeduction(String orgId, List cummonRestDays, String usersql,
			String yearMonth) throws SysException, ParseException {
		// //---- 生成日历
		updateCalendar(orgId, cummonRestDays, usersql, yearMonth);

		// 首先将各个天数置为0；
		String sql = "update a240 a set a240232=0,a240233=0,a240234=0,a240235=0,a240236=0,a240239=0 where a.a240200='"
				+ yearMonth + "'";
		this.activeapi.executeSql(sql);
		// //----根据日历和事假条和病假条算出事假扣款和病假扣款
		// 算出当月起止时期，然后统计这段时期内出现过的请假条
		String beginDate = yearMonth + "-" + "01";
		String endDate = yearMonth + "-" + DateUtil.getEndDayByMonth(yearMonth);
		List<AttLeaveBO> leaveList = this.attBusiDAO.getAllAttLeaveBO(
				beginDate, endDate);

		for (AttLeaveBO bo : leaveList) {
			// 规定:请假当天，如果在12点之前请，算1天；如果在12点之后请，算半天
			// 请假结束当天，如果在14点之前，算半天；如果在14点之后，算1天。
			// 先算出假条开始时间的小时数 和结束时间的小时数
			String beginDayHh = "";
			String endDayHh = "";
			if (bo.getBeginTime().length() > 14
					&& bo.getEndTime().length() > 14) {
				beginDayHh = bo.getBeginTime().substring(11, 13);
				endDayHh = bo.getEndTime().substring(11, 13);
			} else {
				beginDayHh = "00";
				endDayHh = "23";
			}

			// 统计假条天数;
			beginDate = bo.getBeginTime().substring(0, 10);
			endDate = bo.getEndTime().substring(0, 10);
			List dayList = DateUtil.getAllBetweenDates(beginDate, endDate);
			// ////计算当月事假或病假总天数
			if (bo.getLeaveType().equals("1") || bo.getLeaveType().equals("2")
					|| bo.getLeaveType().equals("5")
					|| bo.getLeaveType().equals("6")) {
				for (int i = 0; i < dayList.size(); i++) {
					if (dayList.size() == 1) {
						// 请假当天，如果12点之前请，下午2点之后来，算一天，其他算半天
						if (Integer.parseInt(beginDayHh) < 12
								&& Integer.parseInt(endDayHh) > 14) {
							// 记请假一天
							sql = "update a240 a set a240236=a240236+1 where a.id='"
									+ bo.getPersonId()
									+ "'  and a.a240200='"
									+ yearMonth + "'";
							this.activeapi.executeSql(sql);
						} else {
							// 记请假半天
							sql = "update a240 a set a240236=a240236+0.5 where a.id='"
									+ bo.getPersonId()
									+ "' and a.a240200='"
									+ yearMonth + "'";
							this.activeapi.executeSql(sql);
						}
					} else {
						// ////请假不是当天结束
						String date = dayList.get(i).toString();
						String ym = date.substring(0, 7);// 获得年月
						String d = date.substring(8);// 获得日子
						if (i == 0) {
							// //如果是请假第一天
							if (ym.equals(yearMonth)) {
								// 对应表中的列名称
								if (Integer.parseInt(beginDayHh) < 12) {
									// 12点前，当天按全天算
									sql = "update a240 a set a240236=a240236+1 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('工作日','公休调休','会议')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								} else {
									// 12点后，当天按半天算
									sql = "update a240 a set a240236=a240236+0.5 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('工作日','公休调休','会议')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								}

							}
						} else if (i == dayList.size() - 1) {
							// //如果是请假结束那天
							if (ym.equals(yearMonth)) {
								// 对应表中的列名称
								if (Integer.parseInt(endDayHh) <= 14) {
									// 14点前，当天按半天算
									sql = "update a240 a set a240236=a240236+0.5 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('工作日','公休调休','会议')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								} else {
									// 14点后，当天按全天算
									sql = "update a240 a set a240236=a240236+1 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('工作日','公休调休','会议')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								}

							}
						} else {
							// 不是请假开始和结束的日子，是工作日就按照1天算
							if (ym.equals(yearMonth)) {
								// 对应表中的列名称
								sql = "update a240 a set a240236=a240236+1 where a.id='"
										+ bo.getPersonId()
										+ "' and a2402"
										+ d
										+ " in('工作日','公休调休','会议')  and a.a240200='"
										+ yearMonth + "'";
								this.activeapi.executeSql(sql);
							}
						}
					}
				}
			}
			if (bo.getLeaveType().equals("5")) {
				// 如果是产假，将临时天数存入产假列，然后将临时天数清零
				sql = "update a240 set a240237=a240236 where a240.id='"
						+ bo.getPersonId() + "'  and a240200='" + yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
				sql = "update a240 set a240236=0 where a240.id='"
						+ bo.getPersonId() + "'  and a240200='" + yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
			}
			if (bo.getLeaveType().equals("6")) {
				// 如果是难产产假，将临时天数存入难产产假列，然后将临时天数清零
				sql = "update a240 set a240238=a240236 where a240.id='"
						+ bo.getPersonId() + "'  and a240200='" + yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
				sql = "update a240 set a240236=0 where a240.id='"
						+ bo.getPersonId() + "'  and a240200='" + yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
			}
			if (bo.getLeaveType().equals("1")) {
				// 如果是事假，将临时天数存入事假列，然后将临时天数清零
				sql = "update a240 set a240232=a240236 where a240.id='"
						+ bo.getPersonId() + "'  and a240200='" + yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
				sql = "update a240 set a240236=0 where a240.id='"
						+ bo.getPersonId() + "'  and a240200='" + yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
			}

			if (bo.getLeaveType().equals("2")) {
				// ////如果是病假，先看下天数是否大于剩余的带薪病假，是就先将带薪病假减去，然后处理剩余的天数，否就直接减去剩余天数
				// 将临时天数字段更新为 它减去剩余带薪病假的值
				sql = "update a240 a set a.a240236=a.a240236-( select b.a236202 from a236 b where a.id=b.id) where a.id='"
						+ bo.getPersonId()
						+ "'  and a.a240200='"
						+ yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
				// 策略:如果现在临时天数 大于等于0 那么，带薪病假清0，然后将将临时天数放到相应的病假天数
				// 否则，将临时天数相反数存入带薪病假
				if (dayList.size() <= 15) {
					// 临时天数大于0 将减去带薪病假的病假天数存入扣除30%工资的列内
					sql = "update a240 a set a.a240233=a.a240236 where a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "'";
					this.activeapi.executeSql(sql);
					// 临时天数大于0 将带薪病假清零
					sql = "update a236 b set b.a236202=0 where exists(select 1 from a240 a where a.id=b.id and a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
					// 临时天数小于0 将带薪病假置位临时天数的相反数
					sql = "update a236 b set b.a236202=0-( select a.a240236 from a240 a where a.id=b.id and a.a240200='"
							+ yearMonth
							+ "') where exists(select 1 from a240 a where a.id=b.id and a.a240236<0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);

				} else if (dayList.size() <= 30) {
					// 将减去带薪病假的病假天数存入扣除50%工资的列内
					// 临时天数大于0
					sql = "update a240 a set a.a240234=a.a240236 where a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "'";
					this.activeapi.executeSql(sql);
					sql = "update a236 b set b.a236202=0 where exists(select 1 from a240 a where a.id=b.id and a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
					// 临时天数小于0 将带薪病假置位临时天数的相反数
					sql = "update a236 b set b.a236202=0-( select a.a240236 from a240 a where a.id=b.id and a.a240200='"
							+ yearMonth
							+ "') where exists(select 1 from a240 a where a.id=b.id and a.a240236<0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
				} else if (dayList.size() <= 60) {
					// 将减去带薪病假的病假天数存入扣除80%工资的列内
					// 临时天数大于0
					sql = "update a240 a set a.a240235=a.a240236 where a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "'";
					this.activeapi.executeSql(sql);
					sql = "update a236 b set b.a236202=0 where exists(select 1 from a240 a where a.id=b.id and a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
					// 临时天数小于0 将带薪病假置位临时天数的相反数
					sql = "update a236 b set b.a236202=0-( select a.a240236 from a240 a where a.id=b.id and a.a240200='"
							+ yearMonth
							+ "') where exists(select 1 from a240 a where a.id=b.id and a.a240236<0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
				} else {
					// 大于60天的病假，停发工资，扣除100%工资
					// 临时天数大于0
					sql = "update a240 a set a.a240239=a.a240236 where a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "'";
					this.activeapi.executeSql(sql);
					sql = "update a236 b set b.a236202=0 where exists(select 1 from a240 a where a.id=b.id and a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
					// 临时天数小于0 将带薪病假置位临时天数的相反数
					sql = "update a236 b set b.a236202=0-( select a.a240236 from a240 a where a.id=b.id and a.a240200='"
							+ yearMonth
							+ "') where exists(select 1 from a240 a where a.id=b.id and a.a240236<0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
				}
				sql = "update a240 set a240236=0 where a240.id='"
						+ bo.getPersonId() + "'  and a240200='" + yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
			}
		}
	}

	/**
	 * 当月的日历 分为 上班0或者空 公休日1 放假2 会议3 公休调休4
	 * 
	 * @param orgId
	 * @param weekDays
	 * @param sql
	 * @param yearMonth
	 * @throws SysException
	 * @throws ParseException
	 */
	public void updateCalendar(String orgId, List cummonRestDays,
			String usersql, String yearMonth) throws SysException,
			ParseException {
		String sql = "";
		// //----先清除本次计算相关记录
		String deleteSql = "delete from a240 a where a240200 ='" + yearMonth
				+ "' and exists(select 1 from (" + usersql
				+ ") b where a.id=b.id) ";
		this.activeapi.executeSql(deleteSql);
		// //----插入数据:人 月份 1--31号
		// 生成临时表
		String selectSql = "select ('"
				+ yearMonth.replace("-", "")
				+ "'||b.id||rownum),b.id,'00901','"
				+ yearMonth
				+ "'"
				+ ",'工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日','工作日'"
				+ " from (" + usersql + ") b";
		// 将数据插入到a240 员工日历子集 先默认所有都是工作日
		String insertSql = "insert into a240(subid,id,a240000,a240200,a240201,a240202,a240203,a240204,a240205,a240206,a240207,a240208,a240209"
				+ ",a240210,a240211,a240212,a240213,a240214,a240215,a240216,a240217,a240218,a240219"
				+ ",a240220,a240221,a240222,a240223,a240224,a240225,a240226,a240227,a240228,a240229,a240230,a240231) "
				+ selectSql;
		this.activeapi.executeSql(insertSql);
		// //----以下处理公休日，节假日，公休调休日，会议
		// 公休日
		for (Object day : cummonRestDays) {
			String date = day.toString();
			String ym = date.substring(0, 7);// 获得年月
			String d = date.substring(8);// 获得日子
			if (ym.equals(yearMonth)) {
				// 对应表中的列名称
				sql = "update a240 set a2402" + d + "='公休日'  where a240200 ='"
						+ yearMonth + "'";
				this.activeapi.executeSql(sql);
			}
		}
		// 节假日 和公休调休日
		List leaveList = this.attfeastDAO.getAllAttFeast(orgId);
		for (int i = 0; i < leaveList.size(); i++) {
			// 所有节假日
			AttFeastBO feast = (AttFeastBO) leaveList.get(i);
			String beginDate = feast.getBeginDate();
			String endDate = feast.getEndDate();
			if (feast.getYearType().equals("-1")) {
				// 开始和结束时间不带带年份的节假日，比如暑假，寒假等每年都放的假日
				// 先将开始结束时间加上年份
				// 获得本年份
				String y = yearMonth.substring(0, 4);
				// 获得下一年份
				String nexty = String.valueOf((Integer.parseInt(y) + 1));
				if (feast.getBeginDate().compareTo(feast.getEndDate()) <= 0) {
					// 非跨年假期
					beginDate = y + "-" + feast.getBeginDate();
					endDate = y + "-" + feast.getEndDate();
				} else {
					// 跨年假期
					beginDate = y + "-" + feast.getBeginDate();
					endDate = nexty + "-" + feast.getEndDate();// 结束时间年份+1
				}
			}
			List leaveDays = DateUtil.getAllBetweenDates(beginDate, endDate);
			String inSql = "";
			if (feast.getPostLeiXing() != null
					&& !"".equals(feast.getPostLeiXing())) {
				// 特定岗位的假日，先构建假期对应岗位的列表
				String[] postList = feast.getPostLeiXing().split(",");

				if (postList.length > 0) {
					for (int j = 0; j < postList.length; j++) {
						if (j == 0) {
							inSql = " in( '" + postList[j] + "'";
						} else {
							inSql += ",'" + postList[j] + "'";
						}
						if (j == postList.length - 1) {
							inSql += ") ";
						}
					}
				}
				// 这里是说如果特定岗位才放假，那么更新要加上这个条件
				inSql = " where exists(select 1 from a001 s where a.id=s.id and s.a001218 "
						+ inSql;
			}

			for (Object day : leaveDays) {
				String date = day.toString();
				String ym = date.substring(0, 7);// 获得年月
				String d = date.substring(8);// 获得日子
				if (ym.equals(yearMonth)) {
					// 对应表中的列名称
					if (inSql.equals("")) {
						sql = "update a240 a set a2402" + d
								+ "='节假日' where a2402" + d
								+ " <>'公休日' and a240200 ='" + yearMonth + "'";
					} else {
						sql = "update a240 a set a2402" + d + "='节假日' " + inSql
								+ ") and a2402" + d + " <>'公休日' and a240200 ='"
								+ yearMonth + "'";
					}
					this.activeapi.executeSql(sql);
				}
			}
			// 公休调休日
			List workDaysList = this.getAttfeastDAO().getAllAttWorkDate(orgId);
			for (Object day : workDaysList) {
				// 如果是本次休假的公休日
				if (((AttWorkDateBO) day).getFeastId().equals(
						feast.getFeastID())) {
					day = ((AttWorkDateBO) day).getWorkDate();
					String date = day.toString();
					String ym = date.substring(0, 7);// 获得年月
					String d = date.substring(8);// 获得日子
					if (ym.equals(yearMonth)) {
						// 对应表中的列名称
						sql = "update a240 a set a2402" + d + "='公休调休' "
								+ inSql + ") and a240200 ='" + yearMonth + "' ";
						this.activeapi.executeSql(sql);
					}
				}

			}

		}

		// 会议
		List<AttClassBO> classList = this.attDurationDAO
				.getAllClassBOByDate(orgId);
		for (AttClassBO bo : classList) {
			if ("1".equals(bo.getFrequencyType())) {
				List dayList = DateUtil.getDayByDayTxt(bo.getFrequencyTxt(),
						"2001-01-01", "2100-01-01");
				for (Object day : dayList) {
					String date = day.toString();
					String ym = date.substring(0, 7);// 获得年月
					String d = date.substring(8);// 获得日子
					if (ym.equals(yearMonth)) {
						// 对应表中的列名称
						// 会议通过关联查询确定人员
						if (bo.getRaleType().equals("0")) {
							// 获得与会人员
							String qry = bo.getRaleQry();
							Hashtable hash = this.queryapi.getQuerySqlHash(
									null, qry);
							String getusersql = (String) hash.get("SQL_FULL");
							sql = "update a240 a set a2402" + d
									+ "='会议' where a.id in (select b.id from ("
									+ getusersql + ") b) and a240200 ='"
									+ yearMonth + "'";
							this.activeapi.executeSql(sql);
						}
						// 会议通过一个一个添加确定人员
						if (bo.getRaleType().equals("1")) {
							sql = "update a240 a set a2402"
									+ d
									+ "='会议' where exists(select 1 from att_class_user b,att_class c "
									+ " where a.id=b.userid and b.classid=c.class_id and b.classid='"
									+ bo.getClassID()
									+ "' and c.rale_type='1') and a240200 ='"
									+ yearMonth + "'";
							this.activeapi.executeSql(sql);
						}
					}
				}
			}
		}
		// 统计当月有几天
		String nday = DateUtil.getEndDayByMonth(yearMonth);
		if (Integer.parseInt(nday) < 31) {
			for (int i = Integer.parseInt(nday) + 1; i < 32; i++) {
				sql = "update a240 set a2402" + i + "='无' where a240200 ='"
						+ yearMonth + "'";
				this.activeapi.executeSql(sql);
			}
		}
		// ////更新本月新入职或者离职的员工
		for (int i = 1; i < Integer.parseInt(nday) + 1; i++) {
			String tempDay = "";
			if (i < 10) {
				tempDay = "0" + i;
			} else {
				tempDay = "" + i;
			}

			// 更新当月入职的数据
			sql = "update a240 a set a2402"
					+ tempDay
					+ "='未入职' where exists(select 1 from a001 b where a.id=b.id "
					+ " and to_date(b.a001044,'yyyy-mm-dd')>to_date('"
					+ yearMonth + "-01" + "','yyyy-mm-dd') "
					+ " and to_date(b.a001044,'yyyy-mm-dd')<=to_date('"
					+ yearMonth + "-" + nday + "','yyyy-mm-dd') "
					+ " and to_date(b.a001044,'yyyy-mm-dd')>to_date('"
					+ yearMonth + "-" + tempDay + "','yyyy-mm-dd') )";
			this.activeapi.executeSql(sql);
			// 更新当月离职的数据
			sql = "update a240 a set a2402"
					+ tempDay
					+ "='离职' where exists(select 1 from a001 b where a.id=b.id "
					+ " and to_date(b.a001246,'yyyy-mm-dd')>=to_date('"
					+ yearMonth + "-01" + "','yyyy-mm-dd') "
					+ " and to_date(b.a001246,'yyyy-mm-dd')<=to_date('"
					+ yearMonth + "-" + nday + "','yyyy-mm-dd') "
					+ " and to_date(b.a001246,'yyyy-mm-dd')<to_date('"
					+ yearMonth + "-" + tempDay + "','yyyy-mm-dd') )";
			this.activeapi.executeSql(sql);

		}
		// //统计当月共有几个工作日
		// 先将本月的总工作日清零
		sql = "update a240 a set a240240=0 where a.a240200='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		for (int i = 1; i < Integer.parseInt(nday) + 1; i++) {
			String tempDay = "";
			if (i < 10) {
				tempDay = "0" + i;
			} else {
				tempDay = "" + i;
			}
			// 统计
			sql = "update a240 a set a240240=a240240+1 where a.a240200='"
					+ yearMonth + "' and " + " a2402" + tempDay
					+ " in('工作日','会议','公休调休') ";
			this.activeapi.executeSql(sql);
		}
	}

	@Override
	public void cleanData1() throws SysException, ParseException {
		// TODO Auto-generated method stub
		String sql = "update a236 a set a236200=0,a236201=0,a236202=5,a236203=3,a236204=3,a236205=98,a236206=15,a236207=3 where exists"
				+ "(select 1 from a001 b where a.id=b.id and b.a001239<>'30531662' )";
		this.activeapi.executeSql(sql);
	}

	@Override
	public void cleanData2() throws SysException, ParseException {
		// TODO Auto-generated method stub
		String sql = "update a236 a set a236200=0,a236201=0,a236202=5,a236203=3,a236204=3,a236205=98,a236206=15,a236207=3 where exists"
				+ "(select 1 from a001 b where a.id=b.id and b.a001239='30531662' )";
		this.activeapi.executeSql(sql);
	}

	@Override
	public void modifyData(String userid) throws SysException, ParseException {
		// TODO Auto-generated method stub
		// 根据员工编号获得员工id
		PersonBO p = SysCacheTool.findPersonByCode(userid);
		String sql = "update a236 set a236200=0,a236201=0,a236202=5,a236203=3,a236204=3,a236205=98,a236206=15,a236207=3 ";
		sql += "where id='" + p.getPersonId() + "'";
		this.activeapi.executeSql(sql);
	}

	// 添加或者修改待办事宜
	// *****************************************有问题
	public void insertTask(Object o, String taskId, String currentUserId)
			throws SysException {
		// 需要插入item_id，operate_id，send_person，send_date，have_process，orguid，content，
		// wf_node_log，processid
		// 主键生成 *** 发送人id 发送日期 是否有流程 "1651" 大致描述 ******* 流程id
		ISysInProcessUCC ucc = (ISysInProcessUCC) SysContext
				.getBean("sys_inprocessUCC");
		SysInProcessBO sb = new SysInProcessBO();
		sb.setSendPerson(currentUserId); // 发送人ID
		sb.setSendDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		sb.setOrguid("1651"); // 业务所属机构
		sb.setHave_process("1");
		// String msg=formateMsg(wt,trans.getToMessage()); // 消息
		sb.setContent("**************");
		sb.setOperateID("0675"); // 要求操作
		sb.setProcessID(""); // 对应流程ID 可以为空
		sb.setNodeLogID(""); // 对应流程LOGID可以为空
		ucc.saveProcessBO(sb);
	}

	/**
	 * /* 生成所有人某段时期内的应出勤天数,实际出勤天数，出勤 一般用于计算年出勤率
	 */
	@Override
	public void getYearAttence(String beginDate, String endDate)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		// 年份按照结束日期的年份来
		String year = endDate.substring(0, 4);
		// 首先删除该年份的所有数据
		String sql = "delete from a241 a where a.a241200='" + year + "'";
		this.activeapi.executeSql(sql);
		// 将其他年份的数据置为非首选(00900)
		sql = "update a241 a set a241000='00900'";
		this.activeapi.executeSql(sql);
		// 插入该年的数据
		sql = "insert into a241 a "
				+ "select id||"
				+ year
				+ ",id,'00901','"
				+ year
				+ "',sum(a810701),sum(a810706)+sum(a810707),'','','','' from a810 where to_date(a810700,'yyyy-MM')>="
				+ "to_date('" + beginDate
				+ "','yyyy-MM') and to_date(a810700,'yyyy-MM')<=to_date('"
				+ endDate + "','yyyy-MM')  group by id ";

		this.activeapi.executeSql(sql);
		// 将应出勤减去旷工和请假的酸楚实际出勤
		sql = "update a241 a set a241202=a241201-a241202 ";
		this.activeapi.executeSql(sql);
		// 将应出勤天数为0的置为null(除以null是合法的，除以0是不合法的)
		sql = "update a241 a set a241201=null where a241201=0";
		this.activeapi.executeSql(sql);
		// 填入出勤率
		sql = "update a241 set a241203=trunc(a241202/a241201,2) where a241200='"
				+ year + "'";
		this.activeapi.executeSql(sql);

		// 填入考勤奖金
		String jiben = "(select a223206  from a223 b where a.id=b.id and b.a223000='00901')";// 基本工资
		sql = "update a241 a set a241204=trunc(a241203*" + jiben
				+ ",2) where a241200='" + year + "'";
		this.activeapi.executeSql(sql);
	}

	@Override
	public void updateResetData(String qryID) throws SysException,
			ParseException {
		// TODO Auto-generated method stub
		Hashtable hash = this.queryapi.getQuerySqlHash(null, qryID);
		List userList = this.jdbcTemplate.queryForList((String) hash
				.get("SQL_FULL"));
		// 更新女员工带薪假
		String sql = "update a236 set a236201=0,a236202=5,a236203=3,a236204=3,a236205=98,a236206=15,a236207=3 ";
		sql += "where exists(select 1 from a001 a where a236.id=a.id and a.a001007='01002') and id in (select id from("
				+ (String) hash.get("SQL_FULL") + ") )";
		this.activeapi.executeSql(sql);
		// 更新男员工带薪假
		sql = "update a236 set a236201=0,a236202=5,a236203=3,a236204=3,a236205=0,a236206=0,a236207=3 ";
		sql += "where exists(select 1 from a001 a where a236.id=a.id and a.a001007='01001') and id in (select id from("
				+ (String) hash.get("SQL_FULL") + ") )";
		this.activeapi.executeSql(sql);

		// getYearAttence("2011-11-20", "2012-06-24");
	}

	// 处理销假
	@Override
	public void updateLeaveBackDate(String id, String date)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		String sql = "update att_leave a set is_back='1',back_date='" + date
				+ "' where a.leave_id='" + id + "'";
		this.activeapi.executeSql(sql);
	}

	// 审核离职提醒
	@Override
	public void updateDimissionDate(String subid, String dimission, String date)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		if (dimission.equals("1")) {
			String sql = "update a810 a set a810217='1',a810218='" + date
					+ "' where a.subid='" + subid + "'";
			this.activeapi.executeSql(sql);
		} else {
			String sql = "update a810 a set a810217='',a810218='" + date
					+ "' where a.subid='" + subid + "'";
			this.activeapi.executeSql(sql);
		}

	}

	// 已批准假条删除的数据回滚
	@Override
	public void rollBackLeave(AttLeaveBO bo) throws SysException,
			ParseException {
		// TODO Auto-generated method stub
		if (bo.getStatus().equals("2")) {
			// 如果是批准的假条，清除累加的请假天数 如果需要，要恢复带薪假的天数
			String type = bo.getLeaveType();
			String sql = "";
			if (type.equals("1")) {
				sql += "update a236 a set a236201=a236201-" + bo.getApplyDays()
						+ " where id='" + bo.getPersonId() + "'";
				this.activeapi.executeSql(sql);
			} else if (type.equals("2")) {

			} else if (type.equals("3")) {
				sql += "update a236 a set a236203=a236203+" + bo.getApplyDays()
						+ " where id='" + bo.getPersonId() + "'";
				this.activeapi.executeSql(sql);
			} else if (type.equals("4")) {
				sql += "update a236 a set a236204=a236204+" + bo.getApplyDays()
						+ " where id='" + bo.getPersonId() + "'";
				this.activeapi.executeSql(sql);
			} else if (type.equals("5")) {
				sql += "update a236 a set a236205=a236205+" + bo.getApplyDays()
						+ " where id='" + bo.getPersonId() + "'";
				this.activeapi.executeSql(sql);
			} else if (type.equals("6")) {
				sql += "update a236 a set a236206=a236206+" + bo.getApplyDays()
						+ " where id='" + bo.getPersonId() + "'";
				this.activeapi.executeSql(sql);
			} else if (type.equals("7")) {
				sql += "update a236 a set a236207=a236207+" + bo.getApplyDays()
						+ " where id='" + bo.getPersonId() + "'";
				this.activeapi.executeSql(sql);
			}
		}
	}

	@Override
	// 存休转为加班费
	public void updateOvertimePay(String id, String hours, String selectMonth)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		// 首先清空带薪假子集的存休
		String sql = "update a236 a set a236200=0 where id='" + id + "'";
		this.activeapi.executeSql(sql);
		// 将加班费表中此人的记录全部置为非当前（00900）
		sql = "update a243 set a243000='00900' where id='" + id + "'";
		this.activeapi.executeSql(sql);

		// 如果有此人该月信息，先删除
		sql = "delete from a243 where id='" + id + "' and a243200='"
				+ selectMonth + "'";
		this.activeapi.executeSql(sql);
		// String jiben = "(select a223206  from a223 b where b.id='"+id+"')";//
		// 基本工资
		// 插入信息
		sql = "insert into a243 select " + id + "||rownum||'" + selectMonth
				+ "'," + id + ",'00901','" + selectMonth + "'," + hours + ","
				+ hours + "*20/8.0 from dual";
		this.activeapi.executeSql(sql);
	}

	@Override
	public List getAndShowAllAttMonthBO(PageVO pageVO, String orgID,
			String nameStr, String personType, String beginYearMonth,
			String endYearMonth, String inself, String operUserID)
			throws SysException {
		// TODO Auto-generated method stub
		return this.attBusiDAO.getAndShowAllAttMonthBO(pageVO, orgID, nameStr,
				personType, beginYearMonth, endYearMonth, inself, operUserID);
	}

	@Override
	public List<AttOvertimeBO> queryOvertimeAuditTask(String userId)
			throws SysException {
		List<AttOvertimeBO> list = new ArrayList<AttOvertimeBO>();
		List taskList = activitiToolService.getTaskAssgineeByPersonId(userId);
		if (taskList != null && taskList.size() > 0) {
			for (int i = 0; i < taskList.size(); i++) {
				Task task = (Task) taskList.get(i);
				AttOvertimeBO bo = this
						.findAttOvertimeBOByProcessInstanceId(task
								.getProcessInstanceId());
				if (bo != null) {
					bo.setTaskId(task.getId());
					list.add(bo);
				}
			}
		}

		if (list != null && list.size() > 0) {
			Collections.sort(list);
			for (int i = 0; i < list.size(); i++) {
				AttOvertimeBO bo = (AttOvertimeBO) list.get(i);
				PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
				bo.setPersonName(p.getName());
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
						p.getDeptId()));
				bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
				bo.setPersonCode(p.getPersonCode());
				list.set(i, bo);
			}
		}
		return list;
	}

	@Override
	public List<AttOutBO> queryOutAuditTask(String userId) throws SysException {
		// TODO Auto-generated method stub
		List<AttOutBO> list = new ArrayList();
		List taskList = activitiToolService.getTaskAssgineeByPersonId(userId);
		if (taskList != null && taskList.size() > 0) {
			for (int i = 0; i < taskList.size(); i++) {
				Task task = (Task) taskList.get(i);
				AttOutBO bo = this.findAttOutBOByProcessInstanceId(task
						.getProcessInstanceId());
				if (bo != null) {
					bo.setTaskId(task.getId());
					list.add(bo);
				}
			}
		}

		if (list != null && list.size() > 0) {
			Collections.sort(list);
			for (int i = 0; i < list.size(); i++) {
				AttOutBO bo = (AttOutBO) list.get(i);
				PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
				bo.setPersonName(p.getName());
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
						p.getDeptId()));
				bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
				bo.setPersonCode(p.getPersonCode());
				list.set(i, bo);
			}
		}
		return list;
	}

	@Override
	public List<AttRestBO> queryRestAuditTask(String userId)
			throws SysException {
		// TODO Auto-generated method stub
		List<AttRestBO> list = new ArrayList();
		List taskList = activitiToolService.getTaskAssgineeByPersonId(userId);
		if (taskList != null && taskList.size() > 0) {
			for (int i = 0; i < taskList.size(); i++) {
				Task task = (Task) taskList.get(i);
				AttRestBO bo = this.findAttRestBOByProcessInstanceId(task
						.getProcessInstanceId());
				if (bo != null) {
					bo.setTaskId(task.getId());
					list.add(bo);
				}
			}
		}

		if (list != null && list.size() > 0) {
			Collections.sort(list);
			for (int i = 0; i < list.size(); i++) {
				AttRestBO bo = (AttRestBO) list.get(i);
				PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
				bo.setPersonName(p.getName());
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
						p.getDeptId()));
				bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
				bo.setPersonCode(p.getPersonCode());
				list.set(i, bo);
			}
		}
		return list;
	}

	@Override
	public List<AttLeaveBO> queryLeaveAuditTask(String userId)
			throws SysException {
		// TODO Auto-generated method stub
		List<AttLeaveBO> leaveList = new ArrayList();
		List list = activitiToolService.getTaskAssgineeByPersonId(userId);
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				Task task = (Task) list.get(i);
				AttLeaveBO leave = this.findAttLeaveBOByProcessInstanceId(task
						.getProcessInstanceId());
				if (leave != null && !leave.getStatus().trim().equals("3")) {
					leave.setTaskId(task.getId());
					leaveList.add(leave);
				}
			}
		}

		if (leaveList != null && leaveList.size() > 0) {
			Collections.sort(leaveList);
			for (int i = 0; i < leaveList.size(); i++) {
				AttLeaveBO bo = (AttLeaveBO) leaveList.get(i);
				PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
				bo.setPersonName(p.getName());
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
						p.getDeptId()));
				bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
				bo.setPersonCode(p.getPersonCode());
				list.set(i, bo);
			}
		}
		return leaveList;
	}

	/**
	 * 计算一段时间内，某个人的实际工作日，用以请假等时间判断
	 * 
	 * @param userId
	 * @param beginTime
	 * @param endTime
	 * @return
	 * @throws SysException
	 */
	@Override
	public double getRealDays(String userId, String beginTime, String endTime)
			throws SysException {
		// 获得请假条的开始和结束时间的小时数
		if (beginTime.compareTo(endTime) >= 0) {
			return 0;
		}
		String beginDayHh = "";
		String endDayHh = "";
		if (beginTime.length() > 14 && endTime.length() > 14) {
			beginDayHh = beginTime.substring(11, 13);
			endDayHh = endTime.substring(11, 13);
		} else {
			beginDayHh = "00";
			endDayHh = "23";
		}
		// 获得请假条包含的所有天数，格式"XXXX-XX-XX"
		String beginDate = beginTime.substring(0, 10);// 开始年月日
		String endDate = endTime.substring(0, 10);// 结束年月日
		List<String> allDays = DateUtil.getAllBetweenDates(beginDate, endDate);
		double totalDays = allDays.size();// 记录下请假的总天数

		// 思路:1获得请假期间所有的公休日数a,
		// 2 获取请假期间所有的假期日子b
		// 3获取请假期间的会议日子c
		// 4获取请假期间的公休调休日d

		List<AttRestOfWeekBO> restOfWeekBOList = this.attrestweekDAO
				.findAll("AttRestOfWeekBO");
		String dayofweek = "";
		if (restOfWeekBOList.size() > 0) {
			AttRestOfWeekBO rwb = (AttRestOfWeekBO) restOfWeekBOList.get(0);
			dayofweek = rwb.getMon() + "," + rwb.getTues() + "," + rwb.getWed()
					+ "," + rwb.getThur() + "," + rwb.getFri() + ","
					+ rwb.getSat() + "," + rwb.getSun();

		}
		List comonRestDays = DateUtil.getAllCommonRestDay(dayofweek, beginDate,
				endDate);

		HashSet<String> daysSet = new HashSet<String>();
		daysSet.addAll(comonRestDays);
		// 获的请假期间的节假日数以及公休调休日数
		List<AttFeastBO> feastList = this.attfeastDAO.getFeastsByUserId(userId);
		// 建立在请假期间的日子的list
		if (feastList != null) {
			for (int i = 0; i < feastList.size(); i++) {
				// 找到能和假条起止日期有重合日期的假期
				if (feastList.get(i).getBeginDate().compareTo(endDate) <= 0
						&& feastList.get(i).getEndDate().compareTo(beginDate) >= 0) {
					String bDate = feastList.get(i).getBeginDate();
					String eDate = feastList.get(i).getEndDate();
					if (bDate.compareTo(beginDate) < 0) {
						// 假期开始时间早于假条开始时间
						bDate = beginDate;
					}
					if (bDate.compareTo(beginDate) < 0) {
						// 假期结束时间晚于假条结束时间
						eDate = endDate;
					}
					List<String> tempDays = DateUtil.getAllBetweenDates(bDate,
							eDate);
					daysSet.addAll(tempDays);
				}
				// 找到这个假期相关的公休调休日，有的话删除这个公休调休日
				List<AttWorkDateBO> attWorkDateList = this.attfeastDAO
						.getAllAttWorkDate(feastList.get(i).getFeastID(),
								"1651");
				if (attWorkDateList != null) {
					for (int j = 0; j < attWorkDateList.size(); j++) {
						daysSet.remove(attWorkDateList.get(j).getWorkDate());
					}
				}
			}
		}
		// 用所有天数扣除公休和节假日的
		allDays.removeAll(daysSet);
		// 分析开头日期的小时和结束日期的小时
		double realday = allDays.size();
		if (allDays.contains(beginDate)) {
			if (beginDayHh.compareTo("12") >= 0) {
				realday -= 0.5;
			}
		}
		if (allDays.contains(endDate)) {
			if (endDayHh.compareTo("12") <= 0) {
				realday -= 0.5;
			}
		}
		return realday;
	}

	/**
	 * 请假流程启动
	 * 
	 * @return
	 */
	@Override
	public String applyLeave(String userId, String leaveId) {
		try {
			String keyId = "";// 流程key
			String postLevel = this.selPersonTool.getPostLevel(userId);// 岗位级别
			if (postLevel != null && !postLevel.equals("")) {
				keyId = AttConstants.getAttFlowKey(postLevel);// 流程KEY
				if (keyId != null && !keyId.equals("")) {

					// 为流程配置参数
					int leaderType = this.selPersonTool.getLeaderType(userId);
					AttLeaveBO bo = this.findAttLeaveBOById(leaveId);
					Map map = new HashMap();
					map.put("proposerId", userId);
					map.put("currPersonId", userId);
					map.put("leaderType", leaderType);
					map.put("leaveDays", bo.getApplyDays());

					// 启动流程
					String instanceId = this.activitiToolService
							.startProcessInstance(keyId, leaveId, map);
					// 设置请假单状态,关联的流程实例ID
					bo.setStatus(AttConstants.STATUS_AUDIT);
					bo.setProcessId(instanceId);
					this.saveAttLeaveBO(bo);
				} else {
					// super.showMessageDetail("您的岗位等级未设置流程！");
				}
			} else {
				// super.showMessageDetail("您没有岗位等级，无法进入请假流程！");
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			// super.showMessageDetail("请假天数必须为>0的数字");
		} catch (Exception e) {
			e.printStackTrace();
			// super.showMessageDetail("操作失败！" + e.getMessage());
		}
		// return "successleave";
		return leaveId;
	}

	/**
	 * 加班流程启动
	 * 
	 * @throws SysException
	 */
	@Override
	public String applyOvertime(String userId, String id) throws SysException {
		String postLevel = this.selPersonTool.getPostLevel(userId);// 岗位级别
		if (postLevel != null && !postLevel.equals("")) {
			String keyId = AttConstants.getAttFlowKey(postLevel);// 流程KEY
			if (keyId != null && !keyId.equals("")) {
				// 为流程配置参数并启动流程
				int leaderType;
				try {
					leaderType = selPersonTool.getLeaderType(userId);
				} catch (SysException e) {
					return e.getMessage();
				}
				AttOvertimeBO bo = (AttOvertimeBO) this.findBOById(
						AttOvertimeBO.class, id);
				Map map = new HashMap();
				map.put("proposerId", userId);
				map.put("currPersonId", userId);
				map.put("leaderType", leaderType);
				map.put("leaveDays", Double.valueOf(bo.getApplyDays()));
				String instanceId = this.activitiToolService
						.startProcessInstance(keyId, id, map);

				// 设置加班申请状态,关联的流程实例ID
				bo.setStatus(AttConstants.STATUS_AUDIT);
				bo.setProcessId(instanceId);
				this.saveOrUpdateBO(bo);
			} else {
				return "您的岗位等级未设置流程";
			}
		} else {
			return "您没有岗位等级，无法进入请假流程";
		}
		return null;
	}

	/**
	 * 调休流程启动
	 * 
	 * @throws SysException
	 */
	@Override
	public String applyRest(String userId, String id) throws SysException {
		String postLevel = this.selPersonTool.getPostLevel(userId);// 岗位级别
		if (postLevel != null && !postLevel.equals("")) {
			String keyId = AttConstants.getAttFlowKey(postLevel);// 流程KEY
			if (keyId != null && !keyId.equals("")) {
				// 为流程配置参数并启动流程
				int leaderType;
				try {
					leaderType = selPersonTool.getLeaderType(userId);
				} catch (SysException e) {
					return e.getMessage();
				}
				AttRestBO bo = (AttRestBO) this.findBOById(AttRestBO.class, id);
				Map map = new HashMap();
				map.put("proposerId", userId);
				map.put("currPersonId", userId);
				map.put("leaderType", leaderType);
				map.put("leaveDays", Double.valueOf(bo.getApplyDays()));
				String instanceId = this.activitiToolService
						.startProcessInstance(keyId, id, map);

				// 设置请假单状态,关联的流程实例ID
				bo.setStatus(AttConstants.STATUS_AUDIT);
				bo.setProcessId(instanceId);
				this.saveOrUpdateBO(bo);
			} else {
				return "您的岗位等级未设置流程";
			}
		} else {
			return "您没有岗位等级，无法进入请假流程";
		}
		return null;
	}

	/**
	 * 公出流程启动
	 * 
	 * @throws SysException
	 */
	@Override
	public String applyOut(String userId, String id) throws SysException {
		String postLevel = this.selPersonTool.getPostLevel(userId);// 岗位级别
		if (postLevel != null && !postLevel.equals("")) {
			String keyId = AttConstants.getAttFlowKey(postLevel);// 流程KEY
			if (keyId != null && !keyId.equals("")) {
				// 为流程配置参数并启动流程
				int leaderType;
				try {
					leaderType = selPersonTool.getLeaderType(userId);
				} catch (SysException e) {
					return e.getMessage();
				}
				AttOutBO bo = (AttOutBO) this.findBOById(AttOutBO.class, id);
				Map map = new HashMap();
				map.put("proposerId", userId);
				map.put("currPersonId", userId);
				map.put("leaderType", leaderType);
				map.put("leaveDays", Double.valueOf(bo.getApplyDays()));
				String instanceId = this.activitiToolService
						.startProcessInstance(keyId, id, map);

				// 设置请假单状态,关联的流程实例ID
				bo.setStatus(AttConstants.STATUS_AUDIT);
				bo.setProcessId(instanceId);
				this.saveOrUpdateBO(bo);
			} else {
				return "您的岗位等级未设置流程";
			}
		} else {
			return "您没有岗位等级，无法进入请假流程";
		}
		return null;
	}

	// 删除请假单
	@Override
	public void deleteLeave(String id) throws SysException {
		try {
			List logList = this.attBusiDAO.getAttLogBOById(id);
			if (logList != null && logList.size() > 0) {
				for (int i = 0; i < logList.size(); i++) {
					AttLogBO log = (AttLogBO) logList.get(i);
					this.attBusiDAO.deleteBo(AttLogBO.class, log.getLogId());
				}
			}
			AttLeaveBO bo = this.findAttLeaveBOById(id);
			if (bo.getProcessId() != null) {
				activitiToolService.deleteProcessInstance(bo.getProcessId());
			}
			if (bo.getStatus().equals("2")) {
				// 如果是批准的假条，清除累加的请假天数 如果需要，要恢复带薪假的天数
				this.rollBackLeave(bo);
			}
			this.attBusiDAO.deleteBo(AttLeaveBO.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 删除公出
	@Override
	public void deleteOut(String id) throws SysException {
		List logList = this.attBusiDAO.getAttLogBOById(id);
		if (logList != null && logList.size() > 0) {
			for (int i = 0; i < logList.size(); i++) {
				AttLogBO log = (AttLogBO) logList.get(i);
				this.attBusiDAO.deleteBo(AttLogBO.class, log.getLogId());
			}
		}
		AttOutBO bo = (AttOutBO) this.attBusiDAO.findBoById(AttOutBO.class, id);
		if (bo.getProcessId() != null) {
			activitiToolService.deleteProcessInstance(bo.getProcessId());
		}
		this.attBusiDAO.deleteBo(AttOutBO.class, id);
	}

	// 删除请假
	@Override
	public void deleteOvertime(String id) throws SysException {
		List logList = this.attBusiDAO.getAttLogBOById(id);
		if (logList != null && logList.size() > 0) {
			for (int i = 0; i < logList.size(); i++) {
				AttLogBO log = (AttLogBO) logList.get(i);
				this.attBusiDAO.deleteBo(AttLogBO.class, log.getLogId());
			}
		}
		AttOvertimeBO bo = (AttOvertimeBO) this.attBusiDAO.findBoById(
				AttOvertimeBO.class, id);
		if (bo.getProcessId() != null) {
			activitiToolService.deleteProcessInstance(bo.getProcessId());
		}
		this.attBusiDAO.deleteBo(AttOvertimeBO.class, id);
	}

	// 删除调休
	@Override
	public void deleteRest(String id) throws SysException {
		List logList = this.attBusiDAO.getAttLogBOById(id);
		if (logList != null && logList.size() > 0) {
			for (int i = 0; i < logList.size(); i++) {
				AttLogBO log = (AttLogBO) logList.get(i);
				this.attBusiDAO.deleteBo(AttLogBO.class, log.getLogId());
			}
		}
		AttRestBO bo = (AttRestBO) this.attBusiDAO.findBoById(AttRestBO.class,
				id);
		if (bo.getProcessId() != null) {
			activitiToolService.deleteProcessInstance(bo.getProcessId());
		}
		this.attBusiDAO.deleteBo(AttRestBO.class, id);
	}

	@Override
	public List getOvertimePayBO(PageVO pageVO, String orgID, String nameStr,
			String personType, String yearMonth) throws SysException {
		// return this.jdbcTemplate.queryForList("select * from a236");
		return this.attBusiDAO.getOvertimePayBO(pageVO, orgID, nameStr,
				personType, yearMonth);
	}

	@Override
	public List getYearBO(PageVO pageVO, String orgID, String nameStr,
			String personType) throws SysException {
		// return this.jdbcTemplate.queryForList("select * from a236");
		return this.attBusiDAO.getYearBO(pageVO, orgID, nameStr, personType);
	}

	@Override
	public void deleteInputLeave(String operItemID) throws SysException {
		AttLeaveBO leave = (AttLeaveBO) this.findBOById(AttLeaveBO.class,
				operItemID);
		this.rollbackLeaveDays(leave.getLeaveType(),
				String.valueOf(leave.getApplyDays()), leave.getPersonId());
		this.deleteBO(AttLeaveBO.class, operItemID);
	}

	@Override
	public void deleteInputOvertime(String operItemID) throws SysException {
		AttOvertimeBO overtime = (AttOvertimeBO) this.findBOById(
				AttOvertimeBO.class, operItemID);
		String days=overtime.getApplyDays();
		//是节假日就加班翻倍。4-7小时按照1天算，8小时以上按照2天
		if(isFeast(overtime.getBeginTime(), overtime.getPersonId())){
			if(Double.parseDouble(days)<1){
				days="1.0";
			}
		}else{
			days="2.0";
		}
		this.rollbackLeaveDays("0", days,
				overtime.getPersonId());
		
		this.deleteBO(AttOvertimeBO.class, operItemID);
	}

	@Override
	public void deleteInputRest(String operItemID) throws SysException {
		AttRestBO rest = (AttRestBO) this.findBOById(AttRestBO.class,
				operItemID);
		this.rollbackLeaveDays("-1", rest.getApplyDays(), rest.getPersonId());
		this.deleteBO(AttRestBO.class, operItemID);
	}

	// 提取出来的考勤统计临时表生成函数
	@Override
	public String updateCalcAttTempData(String orgId, String beginDate,
			String endDate) throws SysException, ParseException {
		// TODO Auto-generated method stub
		// ///////////////////步骤1:构建临时表att_sign_detail,填充人员id，日期，8个时刻，班次类型和班次id,班次打卡类型///////////////////////
		String err = "";
		// 依据orgId获取所有符合条件班次 orgId空为所有（无实际意义）
		List<AttClassBO> classList = this.attDurationDAO
				.getAllClassBOByDate(orgId);
		// dayMap有两层含义,一选择符合本次计算的班次，二显示每个班次需要打卡的日子
		// 内容：key为班次id value为班次需要打卡的日子(是个list)
		Map<String, List> dayMap = new HashMap<String, List>();
		List weekDays = new ArrayList();
		for (AttClassBO bo : classList) {
			List dayList = new ArrayList();
			if ("0".equals(bo.getFrequencyType())
					|| "2".equals(bo.getFrequencyType())) {// 周期班次
				String zhouqiBeginDate = bo.getApplyBeginDate();
				String zhouqiEndDate = bo.getApplyEndDate();
				// 处理跨年周期班次 比如从十月一号到第二年的四月三十号
				if (bo.getApplyBeginDate().compareTo(bo.getApplyEndDate()) > 0) {
					// 如果在头一年的末尾
					String temp = beginDate.substring(5);
					if (bo.getApplyBeginDate().compareTo(temp) <= 0) {
						zhouqiEndDate = "12-31";
					}
					// 如果在第二年的开头
					temp = endDate.substring(5);
					if (bo.getApplyEndDate().compareTo(temp) >= 0) {
						zhouqiBeginDate = "01-01";
					}
				}
				// 以下获得本次计算的天数，规格如下:全勤班次取所有天数(比如后勤冬令时) classtype=2
				// 周期性班次 非全勤型 取当月理论打卡日(比如大校的冬令时考勤 取所有的星期三)
				if ("0".equals(bo.getFrequencyType())) {
					dayList = DateUtil.getDayByWeek(bo.getFrequencyTxt(),
							beginDate, endDate, zhouqiBeginDate, zhouqiEndDate);

				} else if ("2".equals(bo.getFrequencyType())) {
					// 全勤班
					// 排除掉不符合要求的全勤班次
					if (zhouqiBeginDate.compareTo(beginDate.substring(5)) <= 0
							&& zhouqiEndDate.compareTo(endDate.substring(5)) >= 0) {
						dayList = DateUtil.getAllBetweenDates(beginDate,
								endDate);
					}

				}

			} else if ("1".equals(bo.getFrequencyType())) {// 非周期班次
				// 非周期班次，会议型取会议的天数(比如新教师培训) classtype=1
				dayList = DateUtil.getDayByDayTxt(bo.getFrequencyTxt(),
						beginDate, endDate);
			}
			if (dayList.size() > 0) {
				dayMap.put(bo.getClassID(), dayList);
			}
		}
		if (dayMap.size() == 0) {
			return "没有符合条件的班次";
		}
		Map<String, List<AttClassDetailBO>> detailMap = new HashMap<String, List<AttClassDetailBO>>();

		// 先清空记录
		String sql = "delete from att_sign_detail ";
		try {
			this.activeapi.executeSql(sql);
		} catch (SysException e) {
			e.printStackTrace();
		}

		// 设置人员签到关联信息_begin
		for (AttClassBO bo : classList) {
			// userList是本次计算涉及到的人
			List userList = null;
			if (dayMap.containsKey(bo.getClassID())) {
				List dayList = dayMap.get(bo.getClassID());
				if ("0".equals(bo.getRaleType())) {
					String qryID = null;
					if ("-1".equals(bo.getRaleQry()) || bo.getRaleQry() == null) {
						err += bo.getClassName() + "没有关联查询方案,";
						continue;
					} else {
						qryID = bo.getRaleQry();
					}

					Hashtable hash = this.queryapi.getQuerySqlHash(null, qryID);
					userList = this.jdbcTemplate.queryForList((String) hash
							.get("SQL_FULL"));
				} else {
					sql = "select userid ID from att_class_user where classid='"
							+ bo.getClassID() + "'";
					userList = this.jdbcTemplate.queryForList(sql);
				}
				if (userList == null || userList.size() == 0) {
					err += bo.getClassName() + "没有设置人员,";
					continue;
				}
				// 班次详情

				List<AttClassDetailBO> dateilList = this.attDurationDAO
						.getAllAttClassDetailBO1(bo.getClassID());
				// 判断打卡类型,以早上开始打卡时间,早上上班时间和下午开始打卡时间，下午上班时间是否为空为基准 1表示早上打卡
				// 2表示打卡两次下午打卡 3表示全天打卡
				int recordtype = 0;
				String time0 = dateilList.get(0).getItemTime();
				String time1 = dateilList.get(1).getItemTime();
				String time4 = dateilList.get(4).getItemTime();
				String time5 = dateilList.get(5).getItemTime();
				if (time0 != null && !time0.equals("") && time1 != null
						&& !time1.equals("")) {
					recordtype += 1;
				}
				if (time4 != null && !time4.equals("") && time5 != null
						&& !time5.equals("")) {
					recordtype += 2;
				}
				detailMap.put(bo.getClassID(), dateilList);
				// 以下通过select生成临时表需要以下数据:班次人员userList，日期dayList，detailList的8个数据，
				// 班次id，班次类型，班次打卡类型
				// 首先构建人员和日期的临时表a
				// 创建人员表
				String createUserSql = "";
				for (int i = 0; i < userList.size(); i++) {
					Map m = (Map) userList.get(i);
					// 用户id
					String userID = String.valueOf(m.get("ID"));
					if (i == 0) {
						createUserSql = "select '" + userID
								+ "' as userid from dual ";
					} else {
						createUserSql += "union select '" + userID
								+ "' from dual ";
					}

				}
				createUserSql = "(" + createUserSql + ") a";
				// 创建日期表
				String createDaySql = "";
				for (int i = 0; i < dayList.size(); i++) {
					if (i == 0) {
						createDaySql = "select '" + dayList.get(i).toString()
								+ "' as day1 from dual ";
					} else {
						createDaySql += "union select '"
								+ dayList.get(i).toString() + "' from dual ";
					}

				}
				createDaySql = "(" + createDaySql + ") b";
				// 构建临时视图
				// 首先把一个班次的八个时刻组织起来
				String timeSql = " ";
				for (int i = 0; i < dateilList.size(); i++) {
					timeSql += "'" + dateilList.get(i).getItemTime() + "',";
				}
				String createSql = "select (b.day1||a.userid||rownum),a.userid,b.day1,"
						+ timeSql
						+ " '0','0','0','0','0','0','0','0','0','"
						+ bo.getClassID() + "',";
				createSql += "'" + bo.getFrequencyType() + "','" + recordtype
						+ "','0','0','0' from " + createUserSql + ","
						+ createDaySql;
				// 插入临时表
				sql = "insert into att_sign_detail(id,userid,day,time0,time1,time2,time3,time4,time5,time6,time7,normal1,later1,away1,normal2,later2,away2,normal,later,away,classid,classtype,recordtype,ignore,yinggai,shiji) "
						+ createSql;
				this.activeapi.executeSql(sql);

			}
		}
		// /////////////步骤2:比对打卡信息，填充normal1 2等6个字段
		// 统计早上按时打卡的
		sql = "update att_sign_detail s set normal1=normal1+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time0 and a.a808701<=s.time1)";
		this.activeapi.executeSql(sql);
		// 统计下午按时打卡的
		sql = "update att_sign_detail s set normal2=normal2+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time4 and a.a808701<=s.time5)";
		this.activeapi.executeSql(sql);
		// 统计早上迟到的
		sql = "update att_sign_detail s set later1=later1+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time1 and a.a808701<=s.time2)";
		this.activeapi.executeSql(sql);
		// 统计下午迟到的
		sql = "update att_sign_detail s set later2=later2+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time5 and a.a808701<=s.time6)";
		this.activeapi.executeSql(sql);
		// 统计早上旷工半天的
		sql = "update att_sign_detail s set away1=away1+0.5 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time2 and a.a808701<=s.time3)";
		this.activeapi.executeSql(sql);
		// 统计下午旷工半天的
		sql = "update att_sign_detail s set away2=away2+0.5 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time6 and a.a808701<=s.time7)";
		this.activeapi.executeSql(sql);

		// /////////////步骤3:填充normal等三个字段
		// 首先整理统计结果，主要清除重复打卡的记录
		// 打卡打过正常的，迟到和旷工的清除
		// 清除早上的
		sql = "update att_sign_detail s set later1='0',away1='0' where normal1='1'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set away1='0' where later1='1'";
		this.activeapi.executeSql(sql);
		// 清除下午的
		sql = "update att_sign_detail s set later2='0',away2='0' where normal2='1'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set away2='0' where later2='1'";
		this.activeapi.executeSql(sql);
		// ////////////////////填充应该打卡次数和实际打卡次数
		// 应该打卡次数(又叫应该出勤次数)
		sql = "update att_sign_detail s set yinggai='2' where recordtype='3'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set yinggai='1' where recordtype='1' or recordtype='2'";
		this.activeapi.executeSql(sql);
		// 实际打卡次数
		sql = "update att_sign_detail s set shiji=shiji+1 where normal1+later1+away1>0";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set shiji=shiji+1 where normal2+later2+away2>0";
		this.activeapi.executeSql(sql);
		// 处理根本没打卡的情况
		// 处理上午勤，如果没当天记录，记为为旷工一天
		sql = "update att_sign_detail s set away1=away1+1 where normal='0' and later1='0' and away1='0' and (recordtype='1')";
		this.activeapi.executeSql(sql);
		// 处理下午勤，如果没当天记录，记为为旷工一天
		sql = "update att_sign_detail s set away2=away2+1 where normal2='0' and later2='0' and away2='0' and (recordtype='2')";
		this.activeapi.executeSql(sql);
		// 处理全天两次勤
		// 上午无记录，记为旷工半天
		sql = "update att_sign_detail s set away1=away1+0.5 where normal1='0' and later1='0' and away1='0' and recordtype='3'";
		this.activeapi.executeSql(sql);
		// 下午无记录记为旷工半天
		sql = "update att_sign_detail s set away2=away2+0.5 where normal2='0' and later2='0' and away2='0' and recordtype='3'";
		this.activeapi.executeSql(sql);

		// 合并上下午记录,得出打卡记录里面正常,迟到,旷工的次数
		// /-----以下代码处理不同打卡类型的情况
		// 全天勤的合并
		sql = "update att_sign_detail s set normal=normal1+normal2,later=later1+later2,away=away1+away2 where recordtype='3'";
		this.activeapi.executeSql(sql);
		// 早上勤
		sql = "update att_sign_detail s set normal=normal1,later=later1,away=away1 where recordtype='1'";
		this.activeapi.executeSql(sql);
		// 下午勤
		sql = "update att_sign_detail s set normal=normal2,later=later2,away=away2 where recordtype='2'";
		this.activeapi.executeSql(sql);

		// 处理会议和正常勤冲突，去掉正常勤的记录，留下会议勤的记录
		sql = "update att_sign_detail a set a.ignore='1' where exists (select 1 from (select  userid,day "
				+ "from att_sign_detail where classtype='1' ) n  where a.userid = n.userid and a.day = n.day) and (classtype='0' or classtype='2') ";
		this.activeapi.executeSql(sql);
		// 步骤4:处理节假日 请假，公出等信息 修正normal等三个字段
		// /////////////////处理请假，公出，调休
		// 处理请假情况
		sql = "update att_sign_detail s set ignore='1' where exists ( select 1 from att_leave a where s.userid=a.person_id and ";
		sql += " to_date(s.day,'yyyy-mm-dd hh24-mi-ss') >= to_date(a.begin_time,'yyyy-mm-dd hh24-mi-ss') and  to_date(s.day,'yyyy-mm-dd hh24-mi-ss')<= to_date(a.end_time,'yyyy-mm-dd hh24-mi-ss')"
				+ " and a.status='2')";
		this.activeapi.executeSql(sql);
		// 处理公出情况
		sql = "update att_sign_detail s set ignore='1' where exists ( select 1 from att_out a where s.userid=a.person_id and ";
		sql += " to_date(s.day,'yyyy-mm-dd hh24-mi-ss') >= to_date(a.begin_time,'yyyy-mm-dd hh24-mi-ss') and  to_date(s.day,'yyyy-mm-dd hh24-mi-ss')<= to_date(a.end_time,'yyyy-mm-dd hh24-mi-ss')"
				+ " and a.status='2')";
		this.activeapi.executeSql(sql);
		// 处理调休情况
		sql = "update att_sign_detail s set ignore='1' where exists ( select 1 from att_rest a where s.userid=a.person_id and ";
		sql += " to_date(s.day,'yyyy-mm-dd hh24-mi-ss') >= to_date(a.begin_time,'yyyy-mm-dd hh24-mi-ss') and  to_date(s.day,'yyyy-mm-dd hh24-mi-ss')<= to_date(a.end_time,'yyyy-mm-dd hh24-mi-ss')"
				+ " and a.status='2')";
		this.activeapi.executeSql(sql);

		// 步骤五////////考虑公休日 ,节假日(不同人节假日不同)和单位调休日
		// 首先获得时间段内的公休日 先算默认周六周日休息的
		List<AttRestOfWeekBO> restOfWeekBOList = this.attrestweekDAO
				.findAll("AttRestOfWeekBO");
		String dayofweek = "";
		if (restOfWeekBOList.size() > 0) {
			AttRestOfWeekBO rwb = (AttRestOfWeekBO) restOfWeekBOList.get(0);
			if ("1".equals(rwb.getMon())) {
				dayofweek += "1,";
			}
			if ("1".equals(rwb.getTues())) {
				dayofweek += "2,";
			}
			if ("1".equals(rwb.getWed())) {
				dayofweek += "3,";
			}
			if ("1".equals(rwb.getThur())) {
				dayofweek += "4,";
			}
			if ("1".equals(rwb.getFri())) {
				dayofweek += "5,";
			}
			if ("1".equals(rwb.getSat())) {
				dayofweek += "6,";
			}
			if ("1".equals(rwb.getSun())) {
				dayofweek += "7,";
			}
		}
		List days = DateUtil.getAllBetweenDates(beginDate, endDate);
		weekDays = DateUtil.getDayByWeek(dayofweek, beginDate, endDate,
				"01-01", "12-30");
		days.removeAll(weekDays);// 所有天减去工作的周一到周五
		// 构造条件函数
		String inSql = "";
		if (days.size() > 0) {
			for (int i = 0; i < days.size(); i++) {
				if (i == 0) {
					inSql = " in( '" + days.get(i) + "'";
				} else {
					inSql += ",'" + days.get(i) + "'";

				}
				if (i == days.size() - 1) {
					inSql += ") ";
				}
			}
		} else {
			inSql = " in ('') ";
		}

		sql = "update att_sign_detail s set ignore='1' where (classtype='0' or classtype='2') and  day "
				+ inSql;
		this.activeapi.executeSql(sql);
		// //处理节假日
		// 注意 不同岗位人员放假时间不一样
		List leaveList = this.attfeastDAO.getAllAttFeast(orgId);
		// 处理每个放假对象
		for (int i = 0; i < leaveList.size(); i++) {
			AttFeastBO feast = (AttFeastBO) leaveList.get(i);
			if (feast.getPostLeiXing() == null
					|| "".equals(feast.getPostLeiXing())) {
				sql = "update att_sign_detail a set ignore = '1' where exists(select 1 from ATT_FEAST t"
						+ " where (a.day>=t.begindate and a.day<=t.enddate and yeartype='0') "
						+ " or (substr(a.day,6)>=t.begindate and substr(a.day,6)<=t.enddate and yeartype='-1') and (classtype='0' or classtype='2') and t.feast_id='"
						+ feast.getFeastID() + "') ";
				this.activeapi.executeSql(sql);
			} else {
				// 先构建假期对应岗位的列表
				String[] postList = feast.getPostLeiXing().split(",");
				inSql = "";
				if (postList.length > 0) {
					for (int j = 0; j < postList.length; j++) {
						if (j == 0) {
							inSql = " in( '" + postList[j] + "'";
						} else {
							inSql += ",'" + postList[j] + "'";

						}
						if (j == postList.length - 1) {
							inSql += ") ";
						}

					}
				}
				sql = "update att_sign_detail a set ignore = '1' where exists(select 1 from ATT_FEAST t,a001 s "
						+ " where (a.day>=t.begindate and a.day<=t.enddate and yeartype='0') "
						+ " or (substr(a.day,6)>=t.begindate and substr(a.day,6)<=t.enddate and yeartype='-1')"
						+ " and (classtype='0' or classtype='2') and t.feast_id='"
						+ feast.getFeastID()
						+ "' and s.id=a.userid"
						+ " and s.A001218 " + inSql + ")";
				this.activeapi.executeSql(sql);
			}

		}
		this.activeapi.executeSql(sql);
		// //处理公休日调休日
		List workDaysList = this.getAttfeastDAO().getAllAttWorkDate(orgId);
		inSql = "";
		if (workDaysList.size() > 0) {
			for (int j = 0; j < workDaysList.size(); j++) {
				if (j == 0) {
					inSql = " in( '"
							+ ((AttWorkDateBO) workDaysList.get(j))
									.getWorkDate() + "'";
				} else {
					inSql += ",'"
							+ ((AttWorkDateBO) workDaysList.get(j))
									.getWorkDate() + "'";

				}
				if (j == workDaysList.size() - 1) {
					inSql += ") ";
				}

			}
			sql = "update att_sign_detail a set ignore = '0' where a.classtype='1' or a.classtype='2' and a.day "
					+ inSql;
			this.activeapi.executeSql(sql);
		}
		// ///步骤六 根据员工入校时间和离职时间去掉已经离职的人员或者更新本月入职，离职的人员信息
		// 将入校前的信息设为无效
		sql = "update att_sign_detail a set ignore = '1' where exists (select 1 from a001 b where a.userid=b.id "
				+ "and to_date(a.day,'yyyy-mm-dd')<to_date(b.a001044,'yyyy-mm-dd'))";
		this.activeapi.executeSql(sql);
		// 将离职以后的信息设为无效
		sql = "update att_sign_detail a set ignore = '1' where exists (select 1 from a001 b where a.userid=b.id "
				+ "and to_date(a.day,'yyyy-mm-dd')>=to_date(b.a001246,'yyyy-mm-dd'))";
		this.activeapi.executeSql(sql);

		return null;
	}

	@Override
	// 根据考勤临时统计表的数据，编制发给每个人的信息内容
	public void updateAttTempDate(String tempBeginDate, String tempEndDate)
			throws SysException {
		// 先清空提示信息
		String sql = "update att_sign_detail a set a.note=''";
		this.activeapi.executeSql(sql);
		// 先统计每个人每天的信息
		// 先统计全天班的情况(1早上迟到1次 2 下午迟到一次 3早上旷工半天 4下午旷工半天)
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'早上:'||'旷工') where a.away1>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'下午:'||'旷工') where a.away2>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);

		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'早上:'||'迟到') where a.later1>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'下午:'||'迟到') where a.later2>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		// 再统计半天班(迟到 旷工半天/1天)
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||':'||'迟到') where a.later>0 and a.classtype!=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||':'||'旷工'||to_number(a.away)||'天') where a.away>0 and a.classtype!=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		// 统计结果，将结果放入员工考勤临时信息表
		// 首先清空上次统计的数据
		sql = "delete from a244 a";
		this.activeapi.executeSql(sql);
		// 插入新数据
		sql = "insert into a244 select  t.userid||sum(rownum),t.userid,'00901','"
				+ tempBeginDate
				+ "','"
				+ tempEndDate
				+ "',wmsys.wm_concat(t.note) from att_sign_detail t group by t.userid";
		this.activeapi.executeSql(sql);
		// 清空没有迟到和旷工记录的员工
		sql = "delete from a244 a where length(trim(a244202)) is null";
		this.activeapi.executeSql(sql);
	}
    
    @Override
    public List getAttTempDataBO(PageVO pageVO, String orgID, String nameStr,
    		String personType) throws SysException {
    	// return this.jdbcTemplate.queryForList("select * from a236");
    	return this.attBusiDAO.getAttTempDataBO(pageVO, orgID, nameStr, personType);
    }

    @Override
	public void saveClassDetail(List<AttClassDetailBO> list, String[]details) throws SysException {
		Map m = new HashMap();
		for(int i=0;i<details.length;i++){
			String[]d=details[i].split("-");
			m.put(d[0], d[1]);
		}
		for(AttClassDetailBO bo : list){
			if(m.containsKey(bo.getItemID())){
				bo.setItemTime(m.get(bo.getItemID()).toString());
			}else{
				bo.setItemTime(null);
			}
			this.attBusiDAO.saveOrUpdateBo(bo);
		}
	}

	@Override
	public boolean isFeast(String day, String personId) throws SysException {
		// TODO Auto-generated method stub
		return false;
	}
}
