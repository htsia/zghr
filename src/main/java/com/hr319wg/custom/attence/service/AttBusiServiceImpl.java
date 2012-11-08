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
	 * ���ڻ�����
	 */
	private static int port = 4370;
	private static int iMachineNumber = 1;

	/**
	 * �ӿ��ڻ��а��û�����Ϣ��ȡ����(�����û���ָ����Ϣ)���浽������Դϵͳ��
	 * 
	 * @param myCom
	 * @param ip
	 * @param personCode
	 * @throws SysException
	 */
	@Override
	public String updateAllKQUsersData(Dispatch myCom, String ip)
			throws SysException {
		Variant dwMachineNumber = new Variant(0, true);// ������
		Variant dwEnrollNumber = new Variant("", true);// �û���
		Variant Name = new Variant("", true);// �û�����
		Variant Password = new Variant("", true);// �û�����
		Variant Privilege = new Variant(0, true);// �û�Ȩ�ޣ�3Ϊ����Ա��0Ϊ��ͨ�û�
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// �û����ñ�־��1Ϊ���ã�0Ϊ����
		Variant dwFingerIndex = new Variant(0, true);// ��ָ����
		Variant TmpData = new Variant("", true);// string ָ����Ϣ
		Variant TmpLength = new Variant(0, true);// TmpLength
		String err = "";
		String colectFail = "";
		String noInfo = "";
		List<AttFingerBO> list = new ArrayList<AttFingerBO>();
		// ����
		Boolean isConnected = Dispatch.call(myCom, "Connect_Net", ip, port)
				.getBoolean();
		// �ж����ӽ��
		if (isConnected == true) {
			int idwErrorCode = 0;
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// ʹ�������ڲ�����״̬

			if (!Dispatch.call(myCom, "ReadAllTemplate", dwMachineNumber)
					.getBoolean()) {
				return "���ڻ����ӳɹ�,��ȡָ����Ϣʧ��";
			}

			if (Dispatch.call(myCom, "ReadAllUserID", iMachineNumber)
					.getBoolean()) {// read all the attendance records to the
									// memory
				while (Dispatch.call(myCom, "SSR_GetAllUserInfo",
						dwMachineNumber, dwEnrollNumber, Name, Password,
						Privilege, Enabled).getBoolean()) {
					// ��Ϊ�򿨵���ָ������ʮ����ָ�е�����һ��,����Ҫ���ж� 10 �Ρ�
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
			err += "�����ڻ�����ʧ��";
		}
		if (!"".equals(colectFail)) {
			err += "���±��Ա��" + colectFail + "ָ�Ʋɼ�ʧ�ܡ�";
		}
		if (!"".equals(noInfo)) {
			err += "���±��Ա��" + colectFail + "����ָ����Ϣ��";
		}
		if (list.size() > 0) {
			for (AttFingerBO bo : list) {
				this.attBusiDAO.saveOrUpdateBo(bo);
			}
		}
		return err;
	}

	/**
	 * �ӿ��ڻ��϶�ȡָ���û�����Ϣ ����ָ����Ϣ��������ϢȨ����Ϣ
	 * 
	 * @param myCom
	 * @param ip
	 *            ���ڻ�IP
	 * @param personCode
	 *            Ա�����
	 * @throws SysException
	 */
	@Override
	public String getAndWriteKQUsersDataBypersonCode(Dispatch myCom, String ip,
			String personCode) throws SysException {
		Variant dwMachineNumber = new Variant(0, true);// ������
		Variant dwEnrollNumber = new Variant("", true);// �û���
		Variant Name = new Variant("", true);// �û�����
		Variant Password = new Variant("", true);// �û�����
		Variant Privilege = new Variant(0, true);// �û�Ȩ�ޣ�3Ϊ����Ա��0Ϊ��ͨ�û�
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// �û����ñ�־��1Ϊ���ã�0Ϊ����
		Variant dwFingerIndex = new Variant(0, true);// ��ָ����
		Variant TmpData = new Variant("", true);// string ָ����Ϣ
		Variant TmpLength = new Variant(0, true);// TmpLength
		String err = "";
		// ����
		Boolean isConnected = Dispatch.call(myCom, "Connect_Net", ip, port)
				.getBoolean();
		// �ж����ӽ��
		if (isConnected == true) {
			int idwErrorCode = 0;
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// ʹ�������ڲ�����״̬
			if (Dispatch.call(myCom, "SSR_GetUserInfo", dwMachineNumber,
					personCode, Name, Password, Privilege, Enabled)
					.getBoolean()) {
				// ��Ϊ�򿨵���ָ������ʮ����ָ�е�����һ��,����Ҫ���ж� 10 �Ρ�
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
							err += "��Ա���" + personCode + "ָ����Ϣ����ʧ��";
						}
					}
				}
			} else {
				Dispatch.call(myCom, "GetLastError", idwErrorCode);
				if (idwErrorCode != 0) {
					err += "���ڻ������Ӷ�ȡָ����Ϣʧ��";
				} else {
					err += "���ڻ����޸���Աָ����Ϣ";
				}
			}
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// ʹ�������ڿ���״̬
		} else {
			err += "���ڻ�����ʧ��";
		}
		return err;
	}

	/**
	 * �����ϴ���Ϣ����ָ�Ƶ����ڻ���
	 * 
	 * @param ip
	 *            ���ڻ� IP ��ַ
	 * @param personCode
	 *            Ա�����
	 */
	@Override
	public String uploadInfo(Dispatch myCom, AttMachineBO bo,
			List<Map> infolist) {
		String err="";
		Variant dwMachineNumber = new Variant(0, true);// ������
		Variant dwEnrollNumber = new Variant("", true);// �û���
		Variant Name = new Variant("", true);// �û�����
		Variant Password = new Variant("", true);// �û�����
		Variant Privilege = new Variant(0, true);// �û�Ȩ�ޣ�3Ϊ����Ա��0Ϊ��ͨ�û�
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)),
				true);// �û����ñ�־��1Ϊ���ã�0Ϊ����
		Variant dwFingerIndex = new Variant(0, true);// ��ָ����
		Variant TmpData = new Variant("", true);// string ָ����Ϣ
		Variant TmpLength = new Variant(0, true);// TmpLength
		
		ActiveXComponent objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
		Dispatch myCon = (Dispatch) objArchSend.getObject();
		// ����
		Boolean isConnected = Dispatch.call(myCon, "Connect_Net", bo.getMachineIP(), 4370).getBoolean();
		// �ж����ӽ��
		if (isConnected == true) {
			Dispatch.call(myCon, "EnableDevice", 1, false);// ʹ�������ڲ�����״̬
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
				// �Ȱ��û������ȥ
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
	 * �ӿ��ڻ���������ȡ�û�ָ����Ϣ
	 * 
	 * @param myCom
	 * @param IPStr
	 *            ����һ��IP���ڻ��϶�ȡ�û���Ϣ
	 * @throws Exception
	 */
	@Override
	public List batchDownloadInfoDetailFromZKEM(String ip) throws Exception {
		Variant dwMachineNumber = new Variant(0, true);// ������
		Variant dwEnrollNumber = new Variant("", true);// �û���
		Variant Name = new Variant("", true);// �û�����
		Variant Password = new Variant("", true);// �û�����
		Variant Privilege = new Variant(0, true);// �û�Ȩ�ޣ�3Ϊ����Ա��0Ϊ��ͨ�û�
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// �û����ñ�־��1Ϊ���ã�0Ϊ����
		Variant dwFingerIndex = new Variant(0, true);// ��ָ����
		Variant TmpData = new Variant("", true);// string ָ����Ϣ
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
			throw new Exception("���ڻ�����ע��ʧ��");
		}
		// ����
		Boolean isConnected = Dispatch.call(myCom, "Connect_Net", ip, port)
				.getBoolean();
		// �ж����ӽ��
		if (isConnected == true) {
			int idwErrorCode = 0;
			Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// ʹ�������ڲ�����״̬

			if (!Dispatch.call(myCom, "ReadAllTemplate", dwMachineNumber)
					.getBoolean()) {
				throw new Exception("���ڻ����ӳɹ�,��ȡָ����Ϣʧ��");
			}

			if (Dispatch.call(myCom, "ReadAllUserID", iMachineNumber)
					.getBoolean()) {// read all the attendance records to the
									// memory
				while (Dispatch.call(myCom, "SSR_GetAllUserInfo",
						dwMachineNumber, dwEnrollNumber, Name, Password,
						Privilege, Enabled).getBoolean()) {
					// ��Ϊ�򿨵���ָ������ʮ����ָ�е�����һ��,����Ҫ���ж� 10 �Ρ�
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
			throw new Exception("���ڻ�����ʧ��");
		}
		if (!"".equals(readFail)) {
			err += "���±��Ա��" + readFail + "ָ����Ϣ��ȡʧ�ܡ�";
		}
		if (!"".equals(readFail)) {
			err += "���±��Ա��" + noFinger + "û��ָ����Ϣ��";
		}
		if (!"".equals(err) && err.length() != 0) {
			throw new Exception(err);
		}

		return list;
	}

	/**
	 * �ӿ��ڻ���������ȡ�û���Ϣ������ӵ� a232����
	 * 
	 * @param myCom
	 * @param IPStr
	 *            ����һ��IP���ڻ��϶�ȡ�û���Ϣ
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
			return "���ڻ�����ע��ʧ��";
		}
		try {
			err = updateAllKQUsersData(myCom, ip);
		} catch (SysException e) {
			err = e.getMessage();
		}
		return err;
	}

	/**
	 * �ӿ��ڻ��϶�ȡ�ض��û���Ϣ()������ӵ� a232����
	 * 
	 * @param myCom
	 * @param IPStr
	 *            ����һ��IP���ڻ��϶�ȡ�û���Ϣ
	 * @param personCode
	 *            Ա���û����
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
			return "���ڻ�����ע��ʧ��";
		}
		return getAndWriteKQUsersDataBypersonCode(myCom, IPStr, personCode);
	}

	/**
	 * ��HR���е��û������ϴ��� ��ЩIP���ڻ���
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
			return "���ڻ�����ע��ʧ��";
		}
		String sql = "select a.a001735, a.a001001 ,b.A232210 ,b.A232211 , "
				+ "b.A232200,b.A232201,b.A232202,b.A232203,b.A232204,b.A232205,b.A232206,b.A232207,b.A232208,b.A232209 "
				+ "from a001 a,a232 b where a.ID = b.ID and a.A001054 not in ('013520','013521','013522','013523','013524','013525')";
		if(operUserIDs!=null){//���˷ַ�
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
				err="���¿��ڻ���"+err+"����ʧ��";
			}
		}
		return err;
	}

	/**
	 * ��д���ڻ���¼
	 */
	@Override
	public String downloadLog(String orgID, List<AttMachineBO> mList)
			throws SysException {
		// �������Ӷ���
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "���ڻ�����ע��ʧ��";
		}
		String msg = "";
		String noExsit = "";
		int success = 0;
		for (AttMachineBO bo : mList) {
			Boolean isConnected = Dispatch.call(myCom, "Connect_Net",
					bo.getMachineIP(), port).getBoolean();
			// �ж����ӽ��
			if (isConnected == true) {
				// ��ȡ��¼
				Variant sdwMachineNumber = new Variant("", true);
				Variant sdwEnrollNumber = new Variant("", true); // ����
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

				Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// ʹ�������ڲ�����״̬
				if (Dispatch.call(myCom, "ReadGeneralLogData", iMachineNumber)
						.getBoolean())// read all the attendance records to the
										// memory
				{
					// ѭ����ȡ��¼�����浽���ݿ�
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

						// �Ƿ������ͬ���ڼ�¼
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
										+ "') ";// ʱ��(A808701) ����(A808700)
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
						msg += "���ڻ�" + bo.getMachineName() + "��ȡ���ڼ�¼ʧ��,";
					}
				}
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// ʹ���ڻ�����
			} else {
				msg += "���ڻ�" + bo.getMachineName() + "����ʧ��,";
			}
		}
		if (!"".equals(noExsit)) {
			msg += "���±��Ա��" + noExsit + "�����ڡ�";
		}
		msg = "�������ڼ�¼" + success + "����" + msg;
		return msg;
	}

	/**
	 * ɾ����������
	 * 
	 * @param list
	 * @param operType
	 * @return
	 */
	@Override
	public String clearLog(List<AttMachineBO> list) {
		Variant dwMachineNumber = new Variant(0, true);// ������
		Variant dwEnrollNumber = new Variant("", true);// �û���
		Variant Name = new Variant("", true);// �û�����
		Variant Password = new Variant("", true);// �û�����
		Variant Privilege = new Variant(0, true);// �û�Ȩ�ޣ�3Ϊ����Ա��0Ϊ��ͨ�û�
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// �û����ñ�־��1Ϊ���ã�0Ϊ����
		Variant dwFingerIndex = new Variant(0, true);// ��ָ����
		Variant TmpData = new Variant("", true);// string ָ����Ϣ
		Variant TmpLength = new Variant(0, true);// TmpLength

		String err = "";
		String clearFail = "";
		String connFail = "";
		// �������Ӷ���
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "���ڻ�����ע��ʧ��";
		}
		for (AttMachineBO bo : list) {
			Boolean isConnected = Dispatch.call(myCom, "Connect_Net",
					bo.getMachineIP(), port).getBoolean();
			// �ж����ӽ��
			if (isConnected == true) {
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// ʹ�������ڲ�����״̬
				if (!Dispatch.call(myCom, "ClearGLog", dwMachineNumber)
						.getBoolean()) {
					clearFail += bo.getMachineName() + ",";
				}
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// ʹ���ڻ����ɿ���״̬
			} else {
				connFail += bo.getMachineName() + ",";
			}
		}
		if (!"".equals(clearFail)) {
			err += "���¿��ڻ�" + clearFail + "���ӳɹ�ɾ��ʧ�ܡ�";
		}
		if (!"".equals(connFail)) {
			err += "���¿��ڻ�" + clearFail + "����ʧ�ܡ�";
		}
		return err;
	}

	/**
	 * ɾ�����ڻ����� 1���ڼ�¼ 5��Ա
	 * 
	 * @param list
	 * @param operType
	 * @return
	 */
	@Override
	public String clearData(List<AttMachineBO> list, String operType) {
		Variant dwMachineNumber = new Variant(0, true);// ������
		Variant dwEnrollNumber = new Variant("", true);// �û���
		Variant Name = new Variant("", true);// �û�����
		Variant Password = new Variant("", true);// �û�����
		Variant Privilege = new Variant(0, true);// �û�Ȩ�ޣ�3Ϊ����Ա��0Ϊ��ͨ�û�
		Variant Enabled = new Variant(Boolean.valueOf(String.valueOf(0)), true);// �û����ñ�־��1Ϊ���ã�0Ϊ����
		Variant dwFingerIndex = new Variant(0, true);// ��ָ����
		Variant TmpData = new Variant("", true);// string ָ����Ϣ
		Variant TmpLength = new Variant(0, true);// TmpLength

		String err = "";
		String clearFail = "";
		String connFail = "";
		// �������Ӷ���
		ActiveXComponent objArchSend = null;
		Dispatch myCom = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			myCom = (Dispatch) objArchSend.getObject();
		} catch (Exception e) {
			return "���ڻ�����ע��ʧ��";
		}
		for (AttMachineBO bo : list) {
			Boolean isConnected = Dispatch.call(myCom, "Connect_Net",
					bo.getMachineIP(), port).getBoolean();
			// �ж����ӽ��
			if (isConnected == true) {
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, false);// ʹ�������ڲ�����״̬
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
				Dispatch.call(myCom, "EnableDevice", iMachineNumber, true);// ʹ�������ڿ���״̬
			} else {
				connFail += bo.getMachineName() + ",";
			}
		}
		if (!"".equals(clearFail)) {
			err += "���¿��ڻ�" + clearFail + "���ӳɹ�ɾ��ʧ�ܡ�";
		}
		if (!"".equals(connFail)) {
			err += "���¿��ڻ�" + clearFail + "����ʧ�ܡ�";
		}
		return err;
	}

	// ���´�н�ٴ����Ӽ�������,����������������¼������
	public void updateLeaveDays(String type, String days, String personId) {
		String sql = "update a236 set ";
		// ������ٵ���������
		if (type.equals("1")) {
			// �����¼�
			sql += "a236201=nvl(a236201,0)+" + Double.parseDouble(days);
		} else if (type.equals("2")) {
			/*
			 * // ���� ����Ҫ����5��Ĵ�н���ٺ������� // �㷨:ͳ�Ʋ��٣����ü���������ȥʣ��Ĵ�н���ٵõ�����day
			 * �����ֿ��ܣ�������ڵ���0������С��0 //
			 * �㷨:day���ڵ���0�Ļ���˵�������ٹ�����day����Ҫ��Ǯ��dayС��0�Ļ���˵�������ٹ��� //
			 * ��ʣ��-day�Ĵ�н���� sql += "a236202=" + Double.parseDouble(days) +
			 * "-a236202 where id='" + personId + "'";
			 * this.jdbcTemplate.execute(sql); // ////day���ڵ���0����� // ����ȥ��н���ٵ�
			 * ���������ۼӵ���������� sql =
			 * "update a236 set a236201=a236201+a236202 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); // ����н������0
			 * sql = "update a236 set a236202=0 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); //
			 * ////dayС��0����� sql =
			 * "update a236 set a236202=0-a236202 where id='" + personId +
			 * "' and a236202<0"; this.jdbcTemplate.execute(sql);
			 */
		} else if (type.equals("3")) {
			// ���
			sql += "a236203=nvl(a236203,0)-" + Double.parseDouble(days);
		} else if (type.equals("4")) {
			// ɥ��
			sql += "a236204=nvl(a236204,0)-" + Double.parseDouble(days);
		} else if (type.equals("5")) {
			// ����
			sql += "a236205=nvl(a236205,0)-" + Double.parseDouble(days);
		} else if (type.equals("6")) {
			// �Ѳ�����
			sql += "a236206=nvl(a236206,0)-" + Double.parseDouble(days);
		} else if (type.equals("7")) {
			// ��н�¼�
			sql += "a236207=nvl(a236207,0)-" + Double.parseDouble(days);
		}
		// ����Ӱ�͵���
		else if (type.equals("0")) {
			//����Ӱ�ʱ��
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

	// ���´�н�ٴ����Ӽ�������,����¼�뵥ɾ�������
	public void rollbackLeaveDays(String type, String days, String personId) {
		String sql = "update a236 set ";
		// ������ٵ���������
		if (type.equals("1")) {
			// �����¼�
			sql += "a236201=nvl(a236201,0)+" + Double.parseDouble(days);
		} else if (type.equals("2")) {
			/*
			 * // ���� ����Ҫ����5��Ĵ�н���ٺ������� // �㷨:ͳ�Ʋ��٣����ü���������ȥʣ��Ĵ�н���ٵõ�����day
			 * �����ֿ��ܣ�������ڵ���0������С��0 //
			 * �㷨:day���ڵ���0�Ļ���˵�������ٹ�����day����Ҫ��Ǯ��dayС��0�Ļ���˵�������ٹ��� //
			 * ��ʣ��-day�Ĵ�н���� sql += "a236202=" + Double.parseDouble(days) +
			 * "-a236202 where id='" + personId + "'";
			 * this.jdbcTemplate.execute(sql); // ////day���ڵ���0����� // ����ȥ��н���ٵ�
			 * ���������ۼӵ���������� sql =
			 * "update a236 set a236201=a236201+a236202 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); // ����н������0
			 * sql = "update a236 set a236202=0 where id='" + personId +
			 * "' and a236202>=0"; this.jdbcTemplate.execute(sql); //
			 * ////dayС��0����� sql =
			 * "update a236 set a236202=0-a236202 where id='" + personId +
			 * "' and a236202<0"; this.jdbcTemplate.execute(sql);
			 */
		} else if (type.equals("3")) {
			// ���
			sql += "a236203=nvl(a236203,0)+" + Double.parseDouble(days);
		} else if (type.equals("4")) {
			// ɥ��
			sql += "a236204=nvl(a236204,0)+" + Double.parseDouble(days);
		} else if (type.equals("5")) {
			// ����
			sql += "a236205=nvl(a236205,0)+" + Double.parseDouble(days);
		} else if (type.equals("6")) {
			// �Ѳ�����
			sql += "a236206=nvl(a236206,0)+" + Double.parseDouble(days);
		} else if (type.equals("7")) {
			// ��н�¼�
			sql += "a236207=nvl(a236207,0)+" + Double.parseDouble(days);
		}
		// ����Ӱ�͵���
		else if (type.equals("0")) {
			//����Ӱ�
			//����Ӱ�ʱ��
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
	 * (non-Javadoc) ������ִ�н���ڵ�����
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
	 * ����ĳ����δ��׼�ĸ��ִ�н��
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
		// ��Ӹ��ִ�н������3 4 5 6 7����Ϊ�飬ɥ�����������Ѳ�
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
				// ////���̽���,��ٵ������׼
				// ����ٵ�����Ϣ���µ�--��н�ٴ����Ӽ��ļ�¼
				String days = String.valueOf(leave.getApplyDays());// �������
				String type = leave.getLeaveType();// �������
				String personId = leave.getPersonId();// �����ID
				this.updateLeaveDays(type, days, personId);
				// �������δ��������ӻ��߸��´�������
				// TODO ������
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
				// ////���̽���,��ٵ������׼
				// ��������Ϣ���µ�--��н�ٴ����Ӽ��ļ�¼
				String days = rest.getApplyDays();// �������
				String type = "-1";// �������
				String personId = rest.getPersonId();// �����ID
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
				// ////���̽���,��ٵ������׼
				// ���Ӱ����Ϣ���µ�--��н�ٴ����Ӽ��ļ�¼
				String days = overtime.getApplyDays();// �Ӱ�����
				String type = "0";// �Ӱ���������Ϊ0
				String personId = overtime.getPersonId();// �����ID
				// ����Ӱ�ʱ�䣬4-7Сʱ��Ϊ0.5�� 8-11Сʱ����1�� 12-15Сʱ1.5�� 16-��2�졣
				// �����ڼ��հ���˫��
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
				// ////���̽���,��ٵ������׼
				// ����ٵ�����Ϣ���µ�--��н�ٴ����Ӽ��ļ�¼
				// String days=overtime.getApplyDays();//�������
				// String type=overtime.getType();//�������
				// String personId=overtime.getPersonId();//�����ID
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
	 * �������ݻ���
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
		// ������ʱ����
		updateCalcAttTempData(orgId, beginDate, endDate);

		// ///////////////////////���ٵ��Ϳ����ļ�¼���µ��»��ܱ�///////////////////////////
		// ����������μ����漰������
		// ������β�ѯ�漰��Ա�����:
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
		// ��������¼��Ϊ00900
		sql = "update a810 set a810000='00900'";
		this.activeapi.executeSql(sql);
		// �����»��ܱ�
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
		// //----������Ա����Щ�˿��ڵ�����ȫ������ˣ����߱��ԭ���ڱ���©ͳ���ˣ��������ǽ��»��ܱ�
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
		// �����������������ٵ���ͳ�Ƴ������������
		sql = "update a810 a set a.a810707=(select nvl(sum(to_number(b.apply_days)),0) from att_leave b where a.id=b.person_id and b.leave_type='1' and b.status='2'"
				+ " and to_date(b.begin_time,'yyyy-mm-dd hh24:mi')>=to_date('2012-09-01','yyyy-mm-dd')   and to_date(b.begin_time,'yyyy-mm-dd hh24:mi')<=to_date('2012-09-30','yyyy-mm-dd') )";
		this.activeapi.executeSql(sql);
		// �������ɿ��ڿۿ�� ����orgId���������б���Ա��ȡsql������
		List days = DateUtil.getAllBetweenDates(beginDate, endDate);
		attDeduction(orgId, days, renyuansql, yearMonth);
		// ���ܿ��ڿۿ�(��Ϊ�ٵ��ۿ�(�չ���*0.2*�ٵ�����))
		// �����ۿ�(�չ���*��������)
		// �¼ٿۿ�չ���*�¼�������
		// ���ٿۿ30%�ۿ�+50%�ۿ�+80%�ۿ�+100%�ۿ(�ۿ�Ϊ�������Ͳ�������*�չ���)
		// ���ٿۿ�(�չ���*��������)
		// �Ѳ����ٿۿ�(�չ���*�Ѳ���������)
		// ��������Ϊ�ջ���""�ģ�����Ϊ0
		sql = "update a223 a set a223206=0 where a223206 is null or a223206=''";
		this.activeapi.executeSql(sql);
		// ���ٵ��ۿ�
		// �Ƚ�Ա�������Ӽ��ı������ܹ�����������Ϊ0������Ϊnull(/0����/null������)
		sql = "update a240 set a240240=null where a240240='0'";
		this.activeapi.executeSql(sql);
		// �����չ���
		String jiben = "(select a223206  from a223 b where a.id=b.id and b.a223000='00901')/"
				+ "(select b.a240240 from a240 b where a.id=b.id and b.a240200=a.a810700)";
		sql = "update a810 a set a810213=trunc(0.2*a810704*" + jiben
				+ " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// �������ۿ�
		sql = "update a810 a set a810214=trunc(a810706*" + jiben
				+ " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// �����ٿۿ�
		sql = "update a810 a set a810219=trunc((select a240237 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben + " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// ����Ѳ����ٿۿ�
		sql = "update a810 a set a810220=trunc((select a240238 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben + " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// ����¼ٿۿ�
		sql = "update a810 a set a810215=trunc((select a240232 from a240 c where a.id=c.id and c.a240200=a.a810700)*"
				+ jiben + " ,2) where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// ��䲡�ٿۿ�
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
		// ����������
		sql = "update a810 a set a810709=(select a240237  from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// ����Ѳ���������
		sql = "update a810 a set a810221=(select a240238  from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// ����¼�����
		sql = "update a810 a set a810707=(select a240232  from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// ��䲡������
		sql = "update a810 a set a810708=(select a240233+a240234+a240235+nvl(a240239,0) from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		// ���µ���ʵ�ʹ�����
		sql = "update a810 a set a810701=(select a240240 from a240 b where a.id=b.id and b.a240200='"
				+ yearMonth + "') where a.a810700='" + yearMonth + "'";
		this.activeapi.executeSql(sql);

		return null;

	}

	/**
	 * ���µĿ��ڿۿ�����ٵ��ۿ�����ۿ�¼ٿۿ���ٿۿ�
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
		// //---- ��������
		updateCalendar(orgId, cummonRestDays, usersql, yearMonth);

		// ���Ƚ�����������Ϊ0��
		String sql = "update a240 a set a240232=0,a240233=0,a240234=0,a240235=0,a240236=0,a240239=0 where a.a240200='"
				+ yearMonth + "'";
		this.activeapi.executeSql(sql);
		// //----�����������¼����Ͳ���������¼ٿۿ�Ͳ��ٿۿ�
		// ���������ֹʱ�ڣ�Ȼ��ͳ�����ʱ���ڳ��ֹ��������
		String beginDate = yearMonth + "-" + "01";
		String endDate = yearMonth + "-" + DateUtil.getEndDayByMonth(yearMonth);
		List<AttLeaveBO> leaveList = this.attBusiDAO.getAllAttLeaveBO(
				beginDate, endDate);

		for (AttLeaveBO bo : leaveList) {
			// �涨:��ٵ��죬�����12��֮ǰ�룬��1�죻�����12��֮���룬�����
			// ��ٽ������죬�����14��֮ǰ������죻�����14��֮����1�졣
			// �����������ʼʱ���Сʱ�� �ͽ���ʱ���Сʱ��
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

			// ͳ�Ƽ�������;
			beginDate = bo.getBeginTime().substring(0, 10);
			endDate = bo.getEndTime().substring(0, 10);
			List dayList = DateUtil.getAllBetweenDates(beginDate, endDate);
			// ////���㵱���¼ٻ򲡼�������
			if (bo.getLeaveType().equals("1") || bo.getLeaveType().equals("2")
					|| bo.getLeaveType().equals("5")
					|| bo.getLeaveType().equals("6")) {
				for (int i = 0; i < dayList.size(); i++) {
					if (dayList.size() == 1) {
						// ��ٵ��죬���12��֮ǰ�룬����2��֮��������һ�죬���������
						if (Integer.parseInt(beginDayHh) < 12
								&& Integer.parseInt(endDayHh) > 14) {
							// �����һ��
							sql = "update a240 a set a240236=a240236+1 where a.id='"
									+ bo.getPersonId()
									+ "'  and a.a240200='"
									+ yearMonth + "'";
							this.activeapi.executeSql(sql);
						} else {
							// ����ٰ���
							sql = "update a240 a set a240236=a240236+0.5 where a.id='"
									+ bo.getPersonId()
									+ "' and a.a240200='"
									+ yearMonth + "'";
							this.activeapi.executeSql(sql);
						}
					} else {
						// ////��ٲ��ǵ������
						String date = dayList.get(i).toString();
						String ym = date.substring(0, 7);// �������
						String d = date.substring(8);// �������
						if (i == 0) {
							// //�������ٵ�һ��
							if (ym.equals(yearMonth)) {
								// ��Ӧ���е�������
								if (Integer.parseInt(beginDayHh) < 12) {
									// 12��ǰ�����찴ȫ����
									sql = "update a240 a set a240236=a240236+1 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('������','���ݵ���','����')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								} else {
									// 12��󣬵��찴������
									sql = "update a240 a set a240236=a240236+0.5 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('������','���ݵ���','����')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								}

							}
						} else if (i == dayList.size() - 1) {
							// //�������ٽ�������
							if (ym.equals(yearMonth)) {
								// ��Ӧ���е�������
								if (Integer.parseInt(endDayHh) <= 14) {
									// 14��ǰ�����찴������
									sql = "update a240 a set a240236=a240236+0.5 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('������','���ݵ���','����')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								} else {
									// 14��󣬵��찴ȫ����
									sql = "update a240 a set a240236=a240236+1 where a.id='"
											+ bo.getPersonId()
											+ "' and a2402"
											+ d
											+ " in('������','���ݵ���','����')  and a.a240200='"
											+ yearMonth + "'";
									this.activeapi.executeSql(sql);
								}

							}
						} else {
							// ������ٿ�ʼ�ͽ��������ӣ��ǹ����վͰ���1����
							if (ym.equals(yearMonth)) {
								// ��Ӧ���е�������
								sql = "update a240 a set a240236=a240236+1 where a.id='"
										+ bo.getPersonId()
										+ "' and a2402"
										+ d
										+ " in('������','���ݵ���','����')  and a.a240200='"
										+ yearMonth + "'";
								this.activeapi.executeSql(sql);
							}
						}
					}
				}
			}
			if (bo.getLeaveType().equals("5")) {
				// ����ǲ��٣�����ʱ������������У�Ȼ����ʱ��������
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
				// ������Ѳ����٣�����ʱ���������Ѳ������У�Ȼ����ʱ��������
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
				// ������¼٣�����ʱ���������¼��У�Ȼ����ʱ��������
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
				// ////����ǲ��٣��ȿ��������Ƿ����ʣ��Ĵ�н���٣��Ǿ��Ƚ���н���ټ�ȥ��Ȼ����ʣ������������ֱ�Ӽ�ȥʣ������
				// ����ʱ�����ֶθ���Ϊ ����ȥʣ���н���ٵ�ֵ
				sql = "update a240 a set a.a240236=a.a240236-( select b.a236202 from a236 b where a.id=b.id) where a.id='"
						+ bo.getPersonId()
						+ "'  and a.a240200='"
						+ yearMonth
						+ "'";
				this.activeapi.executeSql(sql);
				// ����:���������ʱ���� ���ڵ���0 ��ô����н������0��Ȼ�󽫽���ʱ�����ŵ���Ӧ�Ĳ�������
				// ���򣬽���ʱ�����෴�������н����
				if (dayList.size() <= 15) {
					// ��ʱ��������0 ����ȥ��н���ٵĲ�����������۳�30%���ʵ�����
					sql = "update a240 a set a.a240233=a.a240236 where a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "'";
					this.activeapi.executeSql(sql);
					// ��ʱ��������0 ����н��������
					sql = "update a236 b set b.a236202=0 where exists(select 1 from a240 a where a.id=b.id and a.a240236>=0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
					// ��ʱ����С��0 ����н������λ��ʱ�������෴��
					sql = "update a236 b set b.a236202=0-( select a.a240236 from a240 a where a.id=b.id and a.a240200='"
							+ yearMonth
							+ "') where exists(select 1 from a240 a where a.id=b.id and a.a240236<0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);

				} else if (dayList.size() <= 30) {
					// ����ȥ��н���ٵĲ�����������۳�50%���ʵ�����
					// ��ʱ��������0
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
					// ��ʱ����С��0 ����н������λ��ʱ�������෴��
					sql = "update a236 b set b.a236202=0-( select a.a240236 from a240 a where a.id=b.id and a.a240200='"
							+ yearMonth
							+ "') where exists(select 1 from a240 a where a.id=b.id and a.a240236<0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
				} else if (dayList.size() <= 60) {
					// ����ȥ��н���ٵĲ�����������۳�80%���ʵ�����
					// ��ʱ��������0
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
					// ��ʱ����С��0 ����н������λ��ʱ�������෴��
					sql = "update a236 b set b.a236202=0-( select a.a240236 from a240 a where a.id=b.id and a.a240200='"
							+ yearMonth
							+ "') where exists(select 1 from a240 a where a.id=b.id and a.a240236<0 and a.id='"
							+ bo.getPersonId()
							+ "'  and a.a240200='"
							+ yearMonth + "')";
					this.activeapi.executeSql(sql);
				} else {
					// ����60��Ĳ��٣�ͣ�����ʣ��۳�100%����
					// ��ʱ��������0
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
					// ��ʱ����С��0 ����н������λ��ʱ�������෴��
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
	 * ���µ����� ��Ϊ �ϰ�0���߿� ������1 �ż�2 ����3 ���ݵ���4
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
		// //----��������μ�����ؼ�¼
		String deleteSql = "delete from a240 a where a240200 ='" + yearMonth
				+ "' and exists(select 1 from (" + usersql
				+ ") b where a.id=b.id) ";
		this.activeapi.executeSql(deleteSql);
		// //----��������:�� �·� 1--31��
		// ������ʱ��
		String selectSql = "select ('"
				+ yearMonth.replace("-", "")
				+ "'||b.id||rownum),b.id,'00901','"
				+ yearMonth
				+ "'"
				+ ",'������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������','������'"
				+ " from (" + usersql + ") b";
		// �����ݲ��뵽a240 Ա�������Ӽ� ��Ĭ�����ж��ǹ�����
		String insertSql = "insert into a240(subid,id,a240000,a240200,a240201,a240202,a240203,a240204,a240205,a240206,a240207,a240208,a240209"
				+ ",a240210,a240211,a240212,a240213,a240214,a240215,a240216,a240217,a240218,a240219"
				+ ",a240220,a240221,a240222,a240223,a240224,a240225,a240226,a240227,a240228,a240229,a240230,a240231) "
				+ selectSql;
		this.activeapi.executeSql(insertSql);
		// //----���´������գ��ڼ��գ����ݵ����գ�����
		// ������
		for (Object day : cummonRestDays) {
			String date = day.toString();
			String ym = date.substring(0, 7);// �������
			String d = date.substring(8);// �������
			if (ym.equals(yearMonth)) {
				// ��Ӧ���е�������
				sql = "update a240 set a2402" + d + "='������'  where a240200 ='"
						+ yearMonth + "'";
				this.activeapi.executeSql(sql);
			}
		}
		// �ڼ��� �͹��ݵ�����
		List leaveList = this.attfeastDAO.getAllAttFeast(orgId);
		for (int i = 0; i < leaveList.size(); i++) {
			// ���нڼ���
			AttFeastBO feast = (AttFeastBO) leaveList.get(i);
			String beginDate = feast.getBeginDate();
			String endDate = feast.getEndDate();
			if (feast.getYearType().equals("-1")) {
				// ��ʼ�ͽ���ʱ�䲻������ݵĽڼ��գ�������٣����ٵ�ÿ�궼�ŵļ���
				// �Ƚ���ʼ����ʱ��������
				// ��ñ����
				String y = yearMonth.substring(0, 4);
				// �����һ���
				String nexty = String.valueOf((Integer.parseInt(y) + 1));
				if (feast.getBeginDate().compareTo(feast.getEndDate()) <= 0) {
					// �ǿ������
					beginDate = y + "-" + feast.getBeginDate();
					endDate = y + "-" + feast.getEndDate();
				} else {
					// �������
					beginDate = y + "-" + feast.getBeginDate();
					endDate = nexty + "-" + feast.getEndDate();// ����ʱ�����+1
				}
			}
			List leaveDays = DateUtil.getAllBetweenDates(beginDate, endDate);
			String inSql = "";
			if (feast.getPostLeiXing() != null
					&& !"".equals(feast.getPostLeiXing())) {
				// �ض���λ�ļ��գ��ȹ������ڶ�Ӧ��λ���б�
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
				// ������˵����ض���λ�ŷż٣���ô����Ҫ�����������
				inSql = " where exists(select 1 from a001 s where a.id=s.id and s.a001218 "
						+ inSql;
			}

			for (Object day : leaveDays) {
				String date = day.toString();
				String ym = date.substring(0, 7);// �������
				String d = date.substring(8);// �������
				if (ym.equals(yearMonth)) {
					// ��Ӧ���е�������
					if (inSql.equals("")) {
						sql = "update a240 a set a2402" + d
								+ "='�ڼ���' where a2402" + d
								+ " <>'������' and a240200 ='" + yearMonth + "'";
					} else {
						sql = "update a240 a set a2402" + d + "='�ڼ���' " + inSql
								+ ") and a2402" + d + " <>'������' and a240200 ='"
								+ yearMonth + "'";
					}
					this.activeapi.executeSql(sql);
				}
			}
			// ���ݵ�����
			List workDaysList = this.getAttfeastDAO().getAllAttWorkDate(orgId);
			for (Object day : workDaysList) {
				// ����Ǳ����ݼٵĹ�����
				if (((AttWorkDateBO) day).getFeastId().equals(
						feast.getFeastID())) {
					day = ((AttWorkDateBO) day).getWorkDate();
					String date = day.toString();
					String ym = date.substring(0, 7);// �������
					String d = date.substring(8);// �������
					if (ym.equals(yearMonth)) {
						// ��Ӧ���е�������
						sql = "update a240 a set a2402" + d + "='���ݵ���' "
								+ inSql + ") and a240200 ='" + yearMonth + "' ";
						this.activeapi.executeSql(sql);
					}
				}

			}

		}

		// ����
		List<AttClassBO> classList = this.attDurationDAO
				.getAllClassBOByDate(orgId);
		for (AttClassBO bo : classList) {
			if ("1".equals(bo.getFrequencyType())) {
				List dayList = DateUtil.getDayByDayTxt(bo.getFrequencyTxt(),
						"2001-01-01", "2100-01-01");
				for (Object day : dayList) {
					String date = day.toString();
					String ym = date.substring(0, 7);// �������
					String d = date.substring(8);// �������
					if (ym.equals(yearMonth)) {
						// ��Ӧ���е�������
						// ����ͨ��������ѯȷ����Ա
						if (bo.getRaleType().equals("0")) {
							// ��������Ա
							String qry = bo.getRaleQry();
							Hashtable hash = this.queryapi.getQuerySqlHash(
									null, qry);
							String getusersql = (String) hash.get("SQL_FULL");
							sql = "update a240 a set a2402" + d
									+ "='����' where a.id in (select b.id from ("
									+ getusersql + ") b) and a240200 ='"
									+ yearMonth + "'";
							this.activeapi.executeSql(sql);
						}
						// ����ͨ��һ��һ�����ȷ����Ա
						if (bo.getRaleType().equals("1")) {
							sql = "update a240 a set a2402"
									+ d
									+ "='����' where exists(select 1 from att_class_user b,att_class c "
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
		// ͳ�Ƶ����м���
		String nday = DateUtil.getEndDayByMonth(yearMonth);
		if (Integer.parseInt(nday) < 31) {
			for (int i = Integer.parseInt(nday) + 1; i < 32; i++) {
				sql = "update a240 set a2402" + i + "='��' where a240200 ='"
						+ yearMonth + "'";
				this.activeapi.executeSql(sql);
			}
		}
		// ////���±�������ְ������ְ��Ա��
		for (int i = 1; i < Integer.parseInt(nday) + 1; i++) {
			String tempDay = "";
			if (i < 10) {
				tempDay = "0" + i;
			} else {
				tempDay = "" + i;
			}

			// ���µ�����ְ������
			sql = "update a240 a set a2402"
					+ tempDay
					+ "='δ��ְ' where exists(select 1 from a001 b where a.id=b.id "
					+ " and to_date(b.a001044,'yyyy-mm-dd')>to_date('"
					+ yearMonth + "-01" + "','yyyy-mm-dd') "
					+ " and to_date(b.a001044,'yyyy-mm-dd')<=to_date('"
					+ yearMonth + "-" + nday + "','yyyy-mm-dd') "
					+ " and to_date(b.a001044,'yyyy-mm-dd')>to_date('"
					+ yearMonth + "-" + tempDay + "','yyyy-mm-dd') )";
			this.activeapi.executeSql(sql);
			// ���µ�����ְ������
			sql = "update a240 a set a2402"
					+ tempDay
					+ "='��ְ' where exists(select 1 from a001 b where a.id=b.id "
					+ " and to_date(b.a001246,'yyyy-mm-dd')>=to_date('"
					+ yearMonth + "-01" + "','yyyy-mm-dd') "
					+ " and to_date(b.a001246,'yyyy-mm-dd')<=to_date('"
					+ yearMonth + "-" + nday + "','yyyy-mm-dd') "
					+ " and to_date(b.a001246,'yyyy-mm-dd')<to_date('"
					+ yearMonth + "-" + tempDay + "','yyyy-mm-dd') )";
			this.activeapi.executeSql(sql);

		}
		// //ͳ�Ƶ��¹��м���������
		// �Ƚ����µ��ܹ���������
		sql = "update a240 a set a240240=0 where a.a240200='" + yearMonth + "'";
		this.activeapi.executeSql(sql);
		for (int i = 1; i < Integer.parseInt(nday) + 1; i++) {
			String tempDay = "";
			if (i < 10) {
				tempDay = "0" + i;
			} else {
				tempDay = "" + i;
			}
			// ͳ��
			sql = "update a240 a set a240240=a240240+1 where a.a240200='"
					+ yearMonth + "' and " + " a2402" + tempDay
					+ " in('������','����','���ݵ���') ";
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
		// ����Ա����Ż��Ա��id
		PersonBO p = SysCacheTool.findPersonByCode(userid);
		String sql = "update a236 set a236200=0,a236201=0,a236202=5,a236203=3,a236204=3,a236205=98,a236206=15,a236207=3 ";
		sql += "where id='" + p.getPersonId() + "'";
		this.activeapi.executeSql(sql);
	}

	// ��ӻ����޸Ĵ�������
	// *****************************************������
	public void insertTask(Object o, String taskId, String currentUserId)
			throws SysException {
		// ��Ҫ����item_id��operate_id��send_person��send_date��have_process��orguid��content��
		// wf_node_log��processid
		// �������� *** ������id �������� �Ƿ������� "1651" �������� ******* ����id
		ISysInProcessUCC ucc = (ISysInProcessUCC) SysContext
				.getBean("sys_inprocessUCC");
		SysInProcessBO sb = new SysInProcessBO();
		sb.setSendPerson(currentUserId); // ������ID
		sb.setSendDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		sb.setOrguid("1651"); // ҵ����������
		sb.setHave_process("1");
		// String msg=formateMsg(wt,trans.getToMessage()); // ��Ϣ
		sb.setContent("**************");
		sb.setOperateID("0675"); // Ҫ�����
		sb.setProcessID(""); // ��Ӧ����ID ����Ϊ��
		sb.setNodeLogID(""); // ��Ӧ����LOGID����Ϊ��
		ucc.saveProcessBO(sb);
	}

	/**
	 * /* ����������ĳ��ʱ���ڵ�Ӧ��������,ʵ�ʳ������������� һ�����ڼ����������
	 */
	@Override
	public void getYearAttence(String beginDate, String endDate)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		// ��ݰ��ս������ڵ������
		String year = endDate.substring(0, 4);
		// ����ɾ������ݵ���������
		String sql = "delete from a241 a where a.a241200='" + year + "'";
		this.activeapi.executeSql(sql);
		// ��������ݵ�������Ϊ����ѡ(00900)
		sql = "update a241 a set a241000='00900'";
		this.activeapi.executeSql(sql);
		// ������������
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
		// ��Ӧ���ڼ�ȥ��������ٵ����ʵ�ʳ���
		sql = "update a241 a set a241202=a241201-a241202 ";
		this.activeapi.executeSql(sql);
		// ��Ӧ��������Ϊ0����Ϊnull(����null�ǺϷ��ģ�����0�ǲ��Ϸ���)
		sql = "update a241 a set a241201=null where a241201=0";
		this.activeapi.executeSql(sql);
		// ���������
		sql = "update a241 set a241203=trunc(a241202/a241201,2) where a241200='"
				+ year + "'";
		this.activeapi.executeSql(sql);

		// ���뿼�ڽ���
		String jiben = "(select a223206  from a223 b where a.id=b.id and b.a223000='00901')";// ��������
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
		// ����ŮԱ����н��
		String sql = "update a236 set a236201=0,a236202=5,a236203=3,a236204=3,a236205=98,a236206=15,a236207=3 ";
		sql += "where exists(select 1 from a001 a where a236.id=a.id and a.a001007='01002') and id in (select id from("
				+ (String) hash.get("SQL_FULL") + ") )";
		this.activeapi.executeSql(sql);
		// ������Ա����н��
		sql = "update a236 set a236201=0,a236202=5,a236203=3,a236204=3,a236205=0,a236206=0,a236207=3 ";
		sql += "where exists(select 1 from a001 a where a236.id=a.id and a.a001007='01001') and id in (select id from("
				+ (String) hash.get("SQL_FULL") + ") )";
		this.activeapi.executeSql(sql);

		// getYearAttence("2011-11-20", "2012-06-24");
	}

	// ��������
	@Override
	public void updateLeaveBackDate(String id, String date)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		String sql = "update att_leave a set is_back='1',back_date='" + date
				+ "' where a.leave_id='" + id + "'";
		this.activeapi.executeSql(sql);
	}

	// �����ְ����
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

	// ����׼����ɾ�������ݻع�
	@Override
	public void rollBackLeave(AttLeaveBO bo) throws SysException,
			ParseException {
		// TODO Auto-generated method stub
		if (bo.getStatus().equals("2")) {
			// �������׼�ļ���������ۼӵ�������� �����Ҫ��Ҫ�ָ���н�ٵ�����
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
	// ����תΪ�Ӱ��
	public void updateOvertimePay(String id, String hours, String selectMonth)
			throws SysException, ParseException {
		// TODO Auto-generated method stub
		// ������մ�н���Ӽ��Ĵ���
		String sql = "update a236 a set a236200=0 where id='" + id + "'";
		this.activeapi.executeSql(sql);
		// ���Ӱ�ѱ��д��˵ļ�¼ȫ����Ϊ�ǵ�ǰ��00900��
		sql = "update a243 set a243000='00900' where id='" + id + "'";
		this.activeapi.executeSql(sql);

		// ����д��˸�����Ϣ����ɾ��
		sql = "delete from a243 where id='" + id + "' and a243200='"
				+ selectMonth + "'";
		this.activeapi.executeSql(sql);
		// String jiben = "(select a223206  from a223 b where b.id='"+id+"')";//
		// ��������
		// ������Ϣ
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
	 * ����һ��ʱ���ڣ�ĳ���˵�ʵ�ʹ����գ�������ٵ�ʱ���ж�
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
		// ���������Ŀ�ʼ�ͽ���ʱ���Сʱ��
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
		// ��������������������������ʽ"XXXX-XX-XX"
		String beginDate = beginTime.substring(0, 10);// ��ʼ������
		String endDate = endTime.substring(0, 10);// ����������
		List<String> allDays = DateUtil.getAllBetweenDates(beginDate, endDate);
		double totalDays = allDays.size();// ��¼����ٵ�������

		// ˼·:1�������ڼ����еĹ�������a,
		// 2 ��ȡ����ڼ����еļ�������b
		// 3��ȡ����ڼ�Ļ�������c
		// 4��ȡ����ڼ�Ĺ��ݵ�����d

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
		// �������ڼ�Ľڼ������Լ����ݵ�������
		List<AttFeastBO> feastList = this.attfeastDAO.getFeastsByUserId(userId);
		// ����������ڼ�����ӵ�list
		if (feastList != null) {
			for (int i = 0; i < feastList.size(); i++) {
				// �ҵ��ܺͼ�����ֹ�������غ����ڵļ���
				if (feastList.get(i).getBeginDate().compareTo(endDate) <= 0
						&& feastList.get(i).getEndDate().compareTo(beginDate) >= 0) {
					String bDate = feastList.get(i).getBeginDate();
					String eDate = feastList.get(i).getEndDate();
					if (bDate.compareTo(beginDate) < 0) {
						// ���ڿ�ʼʱ�����ڼ�����ʼʱ��
						bDate = beginDate;
					}
					if (bDate.compareTo(beginDate) < 0) {
						// ���ڽ���ʱ�����ڼ�������ʱ��
						eDate = endDate;
					}
					List<String> tempDays = DateUtil.getAllBetweenDates(bDate,
							eDate);
					daysSet.addAll(tempDays);
				}
				// �ҵ����������صĹ��ݵ����գ��еĻ�ɾ��������ݵ�����
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
		// �����������۳����ݺͽڼ��յ�
		allDays.removeAll(daysSet);
		// ������ͷ���ڵ�Сʱ�ͽ������ڵ�Сʱ
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
	 * �����������
	 * 
	 * @return
	 */
	@Override
	public String applyLeave(String userId, String leaveId) {
		try {
			String keyId = "";// ����key
			String postLevel = this.selPersonTool.getPostLevel(userId);// ��λ����
			if (postLevel != null && !postLevel.equals("")) {
				keyId = AttConstants.getAttFlowKey(postLevel);// ����KEY
				if (keyId != null && !keyId.equals("")) {

					// Ϊ�������ò���
					int leaderType = this.selPersonTool.getLeaderType(userId);
					AttLeaveBO bo = this.findAttLeaveBOById(leaveId);
					Map map = new HashMap();
					map.put("proposerId", userId);
					map.put("currPersonId", userId);
					map.put("leaderType", leaderType);
					map.put("leaveDays", bo.getApplyDays());

					// ��������
					String instanceId = this.activitiToolService
							.startProcessInstance(keyId, leaveId, map);
					// ������ٵ�״̬,����������ʵ��ID
					bo.setStatus(AttConstants.STATUS_AUDIT);
					bo.setProcessId(instanceId);
					this.saveAttLeaveBO(bo);
				} else {
					// super.showMessageDetail("���ĸ�λ�ȼ�δ�������̣�");
				}
			} else {
				// super.showMessageDetail("��û�и�λ�ȼ����޷�����������̣�");
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			// super.showMessageDetail("�����������Ϊ>0������");
		} catch (Exception e) {
			e.printStackTrace();
			// super.showMessageDetail("����ʧ�ܣ�" + e.getMessage());
		}
		// return "successleave";
		return leaveId;
	}

	/**
	 * �Ӱ���������
	 * 
	 * @throws SysException
	 */
	@Override
	public String applyOvertime(String userId, String id) throws SysException {
		String postLevel = this.selPersonTool.getPostLevel(userId);// ��λ����
		if (postLevel != null && !postLevel.equals("")) {
			String keyId = AttConstants.getAttFlowKey(postLevel);// ����KEY
			if (keyId != null && !keyId.equals("")) {
				// Ϊ�������ò�������������
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

				// ���üӰ�����״̬,����������ʵ��ID
				bo.setStatus(AttConstants.STATUS_AUDIT);
				bo.setProcessId(instanceId);
				this.saveOrUpdateBO(bo);
			} else {
				return "���ĸ�λ�ȼ�δ��������";
			}
		} else {
			return "��û�и�λ�ȼ����޷������������";
		}
		return null;
	}

	/**
	 * ������������
	 * 
	 * @throws SysException
	 */
	@Override
	public String applyRest(String userId, String id) throws SysException {
		String postLevel = this.selPersonTool.getPostLevel(userId);// ��λ����
		if (postLevel != null && !postLevel.equals("")) {
			String keyId = AttConstants.getAttFlowKey(postLevel);// ����KEY
			if (keyId != null && !keyId.equals("")) {
				// Ϊ�������ò�������������
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

				// ������ٵ�״̬,����������ʵ��ID
				bo.setStatus(AttConstants.STATUS_AUDIT);
				bo.setProcessId(instanceId);
				this.saveOrUpdateBO(bo);
			} else {
				return "���ĸ�λ�ȼ�δ��������";
			}
		} else {
			return "��û�и�λ�ȼ����޷������������";
		}
		return null;
	}

	/**
	 * ������������
	 * 
	 * @throws SysException
	 */
	@Override
	public String applyOut(String userId, String id) throws SysException {
		String postLevel = this.selPersonTool.getPostLevel(userId);// ��λ����
		if (postLevel != null && !postLevel.equals("")) {
			String keyId = AttConstants.getAttFlowKey(postLevel);// ����KEY
			if (keyId != null && !keyId.equals("")) {
				// Ϊ�������ò�������������
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

				// ������ٵ�״̬,����������ʵ��ID
				bo.setStatus(AttConstants.STATUS_AUDIT);
				bo.setProcessId(instanceId);
				this.saveOrUpdateBO(bo);
			} else {
				return "���ĸ�λ�ȼ�δ��������";
			}
		} else {
			return "��û�и�λ�ȼ����޷������������";
		}
		return null;
	}

	// ɾ����ٵ�
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
				// �������׼�ļ���������ۼӵ�������� �����Ҫ��Ҫ�ָ���н�ٵ�����
				this.rollBackLeave(bo);
			}
			this.attBusiDAO.deleteBo(AttLeaveBO.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ɾ������
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

	// ɾ�����
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

	// ɾ������
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
		//�ǽڼ��վͼӰ෭����4-7Сʱ����1���㣬8Сʱ���ϰ���2��
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

	// ��ȡ�����Ŀ���ͳ����ʱ�����ɺ���
	@Override
	public String updateCalcAttTempData(String orgId, String beginDate,
			String endDate) throws SysException, ParseException {
		// TODO Auto-generated method stub
		// ///////////////////����1:������ʱ��att_sign_detail,�����Աid�����ڣ�8��ʱ�̣�������ͺͰ��id,��δ�����///////////////////////
		String err = "";
		// ����orgId��ȡ���з���������� orgId��Ϊ���У���ʵ�����壩
		List<AttClassBO> classList = this.attDurationDAO
				.getAllClassBOByDate(orgId);
		// dayMap�����㺬��,һѡ����ϱ��μ���İ�Σ�����ʾÿ�������Ҫ�򿨵�����
		// ���ݣ�keyΪ���id valueΪ�����Ҫ�򿨵�����(�Ǹ�list)
		Map<String, List> dayMap = new HashMap<String, List>();
		List weekDays = new ArrayList();
		for (AttClassBO bo : classList) {
			List dayList = new ArrayList();
			if ("0".equals(bo.getFrequencyType())
					|| "2".equals(bo.getFrequencyType())) {// ���ڰ��
				String zhouqiBeginDate = bo.getApplyBeginDate();
				String zhouqiEndDate = bo.getApplyEndDate();
				// ����������ڰ�� �����ʮ��һ�ŵ��ڶ����������ʮ��
				if (bo.getApplyBeginDate().compareTo(bo.getApplyEndDate()) > 0) {
					// �����ͷһ���ĩβ
					String temp = beginDate.substring(5);
					if (bo.getApplyBeginDate().compareTo(temp) <= 0) {
						zhouqiEndDate = "12-31";
					}
					// ����ڵڶ���Ŀ�ͷ
					temp = endDate.substring(5);
					if (bo.getApplyEndDate().compareTo(temp) >= 0) {
						zhouqiBeginDate = "01-01";
					}
				}
				// ���»�ñ��μ�����������������:ȫ�ڰ��ȡ��������(������ڶ���ʱ) classtype=2
				// �����԰�� ��ȫ���� ȡ�������۴���(�����У�Ķ���ʱ���� ȡ���е�������)
				if ("0".equals(bo.getFrequencyType())) {
					dayList = DateUtil.getDayByWeek(bo.getFrequencyTxt(),
							beginDate, endDate, zhouqiBeginDate, zhouqiEndDate);

				} else if ("2".equals(bo.getFrequencyType())) {
					// ȫ�ڰ�
					// �ų���������Ҫ���ȫ�ڰ��
					if (zhouqiBeginDate.compareTo(beginDate.substring(5)) <= 0
							&& zhouqiEndDate.compareTo(endDate.substring(5)) >= 0) {
						dayList = DateUtil.getAllBetweenDates(beginDate,
								endDate);
					}

				}

			} else if ("1".equals(bo.getFrequencyType())) {// �����ڰ��
				// �����ڰ�Σ�������ȡ���������(�����½�ʦ��ѵ) classtype=1
				dayList = DateUtil.getDayByDayTxt(bo.getFrequencyTxt(),
						beginDate, endDate);
			}
			if (dayList.size() > 0) {
				dayMap.put(bo.getClassID(), dayList);
			}
		}
		if (dayMap.size() == 0) {
			return "û�з��������İ��";
		}
		Map<String, List<AttClassDetailBO>> detailMap = new HashMap<String, List<AttClassDetailBO>>();

		// ����ռ�¼
		String sql = "delete from att_sign_detail ";
		try {
			this.activeapi.executeSql(sql);
		} catch (SysException e) {
			e.printStackTrace();
		}

		// ������Աǩ��������Ϣ_begin
		for (AttClassBO bo : classList) {
			// userList�Ǳ��μ����漰������
			List userList = null;
			if (dayMap.containsKey(bo.getClassID())) {
				List dayList = dayMap.get(bo.getClassID());
				if ("0".equals(bo.getRaleType())) {
					String qryID = null;
					if ("-1".equals(bo.getRaleQry()) || bo.getRaleQry() == null) {
						err += bo.getClassName() + "û�й�����ѯ����,";
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
					err += bo.getClassName() + "û��������Ա,";
					continue;
				}
				// �������

				List<AttClassDetailBO> dateilList = this.attDurationDAO
						.getAllAttClassDetailBO1(bo.getClassID());
				// �жϴ�����,�����Ͽ�ʼ��ʱ��,�����ϰ�ʱ������翪ʼ��ʱ�䣬�����ϰ�ʱ���Ƿ�Ϊ��Ϊ��׼ 1��ʾ���ϴ�
				// 2��ʾ����������� 3��ʾȫ���
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
				// ����ͨ��select������ʱ����Ҫ��������:�����ԱuserList������dayList��detailList��8�����ݣ�
				// ���id��������ͣ���δ�����
				// ���ȹ�����Ա�����ڵ���ʱ��a
				// ������Ա��
				String createUserSql = "";
				for (int i = 0; i < userList.size(); i++) {
					Map m = (Map) userList.get(i);
					// �û�id
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
				// �������ڱ�
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
				// ������ʱ��ͼ
				// ���Ȱ�һ����εİ˸�ʱ����֯����
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
				// ������ʱ��
				sql = "insert into att_sign_detail(id,userid,day,time0,time1,time2,time3,time4,time5,time6,time7,normal1,later1,away1,normal2,later2,away2,normal,later,away,classid,classtype,recordtype,ignore,yinggai,shiji) "
						+ createSql;
				this.activeapi.executeSql(sql);

			}
		}
		// /////////////����2:�ȶԴ���Ϣ�����normal1 2��6���ֶ�
		// ͳ�����ϰ�ʱ�򿨵�
		sql = "update att_sign_detail s set normal1=normal1+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time0 and a.a808701<=s.time1)";
		this.activeapi.executeSql(sql);
		// ͳ�����簴ʱ�򿨵�
		sql = "update att_sign_detail s set normal2=normal2+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time4 and a.a808701<=s.time5)";
		this.activeapi.executeSql(sql);
		// ͳ�����ϳٵ���
		sql = "update att_sign_detail s set later1=later1+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time1 and a.a808701<=s.time2)";
		this.activeapi.executeSql(sql);
		// ͳ������ٵ���
		sql = "update att_sign_detail s set later2=later2+1 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time5 and a.a808701<=s.time6)";
		this.activeapi.executeSql(sql);
		// ͳ�����Ͽ��������
		sql = "update att_sign_detail s set away1=away1+0.5 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time2 and a.a808701<=s.time3)";
		this.activeapi.executeSql(sql);
		// ͳ��������������
		sql = "update att_sign_detail s set away2=away2+0.5 where exists ( select 1 from a808 a where a.id = s.userid and ";
		sql += "to_date(a.a808700,'yyyy-mm-dd') = to_date(s.day,'yyyy-mm-dd') and a.a808701>=s.time6 and a.a808701<=s.time7)";
		this.activeapi.executeSql(sql);

		// /////////////����3:���normal�������ֶ�
		// ��������ͳ�ƽ������Ҫ����ظ��򿨵ļ�¼
		// �򿨴�������ģ��ٵ��Ϳ��������
		// ������ϵ�
		sql = "update att_sign_detail s set later1='0',away1='0' where normal1='1'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set away1='0' where later1='1'";
		this.activeapi.executeSql(sql);
		// ��������
		sql = "update att_sign_detail s set later2='0',away2='0' where normal2='1'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set away2='0' where later2='1'";
		this.activeapi.executeSql(sql);
		// ////////////////////���Ӧ�ô򿨴�����ʵ�ʴ򿨴���
		// Ӧ�ô򿨴���(�ֽ�Ӧ�ó��ڴ���)
		sql = "update att_sign_detail s set yinggai='2' where recordtype='3'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set yinggai='1' where recordtype='1' or recordtype='2'";
		this.activeapi.executeSql(sql);
		// ʵ�ʴ򿨴���
		sql = "update att_sign_detail s set shiji=shiji+1 where normal1+later1+away1>0";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail s set shiji=shiji+1 where normal2+later2+away2>0";
		this.activeapi.executeSql(sql);
		// �������û�򿨵����
		// ���������ڣ����û�����¼����ΪΪ����һ��
		sql = "update att_sign_detail s set away1=away1+1 where normal='0' and later1='0' and away1='0' and (recordtype='1')";
		this.activeapi.executeSql(sql);
		// ���������ڣ����û�����¼����ΪΪ����һ��
		sql = "update att_sign_detail s set away2=away2+1 where normal2='0' and later2='0' and away2='0' and (recordtype='2')";
		this.activeapi.executeSql(sql);
		// ����ȫ��������
		// �����޼�¼����Ϊ��������
		sql = "update att_sign_detail s set away1=away1+0.5 where normal1='0' and later1='0' and away1='0' and recordtype='3'";
		this.activeapi.executeSql(sql);
		// �����޼�¼��Ϊ��������
		sql = "update att_sign_detail s set away2=away2+0.5 where normal2='0' and later2='0' and away2='0' and recordtype='3'";
		this.activeapi.executeSql(sql);

		// �ϲ��������¼,�ó��򿨼�¼��������,�ٵ�,�����Ĵ���
		// /-----���´��봦��ͬ�����͵����
		// ȫ���ڵĺϲ�
		sql = "update att_sign_detail s set normal=normal1+normal2,later=later1+later2,away=away1+away2 where recordtype='3'";
		this.activeapi.executeSql(sql);
		// ������
		sql = "update att_sign_detail s set normal=normal1,later=later1,away=away1 where recordtype='1'";
		this.activeapi.executeSql(sql);
		// ������
		sql = "update att_sign_detail s set normal=normal2,later=later2,away=away2 where recordtype='2'";
		this.activeapi.executeSql(sql);

		// �������������ڳ�ͻ��ȥ�������ڵļ�¼�����»����ڵļ�¼
		sql = "update att_sign_detail a set a.ignore='1' where exists (select 1 from (select  userid,day "
				+ "from att_sign_detail where classtype='1' ) n  where a.userid = n.userid and a.day = n.day) and (classtype='0' or classtype='2') ";
		this.activeapi.executeSql(sql);
		// ����4:����ڼ��� ��٣���������Ϣ ����normal�������ֶ�
		// /////////////////������٣�����������
		// ����������
		sql = "update att_sign_detail s set ignore='1' where exists ( select 1 from att_leave a where s.userid=a.person_id and ";
		sql += " to_date(s.day,'yyyy-mm-dd hh24-mi-ss') >= to_date(a.begin_time,'yyyy-mm-dd hh24-mi-ss') and  to_date(s.day,'yyyy-mm-dd hh24-mi-ss')<= to_date(a.end_time,'yyyy-mm-dd hh24-mi-ss')"
				+ " and a.status='2')";
		this.activeapi.executeSql(sql);
		// ���������
		sql = "update att_sign_detail s set ignore='1' where exists ( select 1 from att_out a where s.userid=a.person_id and ";
		sql += " to_date(s.day,'yyyy-mm-dd hh24-mi-ss') >= to_date(a.begin_time,'yyyy-mm-dd hh24-mi-ss') and  to_date(s.day,'yyyy-mm-dd hh24-mi-ss')<= to_date(a.end_time,'yyyy-mm-dd hh24-mi-ss')"
				+ " and a.status='2')";
		this.activeapi.executeSql(sql);
		// ����������
		sql = "update att_sign_detail s set ignore='1' where exists ( select 1 from att_rest a where s.userid=a.person_id and ";
		sql += " to_date(s.day,'yyyy-mm-dd hh24-mi-ss') >= to_date(a.begin_time,'yyyy-mm-dd hh24-mi-ss') and  to_date(s.day,'yyyy-mm-dd hh24-mi-ss')<= to_date(a.end_time,'yyyy-mm-dd hh24-mi-ss')"
				+ " and a.status='2')";
		this.activeapi.executeSql(sql);

		// ������////////���ǹ����� ,�ڼ���(��ͬ�˽ڼ��ղ�ͬ)�͵�λ������
		// ���Ȼ��ʱ����ڵĹ����� ����Ĭ������������Ϣ��
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
		days.removeAll(weekDays);// �������ȥ��������һ������
		// ������������
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
		// //����ڼ���
		// ע�� ��ͬ��λ��Ա�ż�ʱ�䲻һ��
		List leaveList = this.attfeastDAO.getAllAttFeast(orgId);
		// ����ÿ���żٶ���
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
				// �ȹ������ڶ�Ӧ��λ���б�
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
		// //�������յ�����
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
		// ///������ ����Ա����Уʱ�����ְʱ��ȥ���Ѿ���ְ����Ա���߸��±�����ְ����ְ����Ա��Ϣ
		// ����Уǰ����Ϣ��Ϊ��Ч
		sql = "update att_sign_detail a set ignore = '1' where exists (select 1 from a001 b where a.userid=b.id "
				+ "and to_date(a.day,'yyyy-mm-dd')<to_date(b.a001044,'yyyy-mm-dd'))";
		this.activeapi.executeSql(sql);
		// ����ְ�Ժ����Ϣ��Ϊ��Ч
		sql = "update att_sign_detail a set ignore = '1' where exists (select 1 from a001 b where a.userid=b.id "
				+ "and to_date(a.day,'yyyy-mm-dd')>=to_date(b.a001246,'yyyy-mm-dd'))";
		this.activeapi.executeSql(sql);

		return null;
	}

	@Override
	// ���ݿ�����ʱͳ�Ʊ�����ݣ����Ʒ���ÿ���˵���Ϣ����
	public void updateAttTempDate(String tempBeginDate, String tempEndDate)
			throws SysException {
		// �������ʾ��Ϣ
		String sql = "update att_sign_detail a set a.note=''";
		this.activeapi.executeSql(sql);
		// ��ͳ��ÿ����ÿ�����Ϣ
		// ��ͳ��ȫ�������(1���ϳٵ�1�� 2 ����ٵ�һ�� 3���Ͽ������� 4�����������)
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'����:'||'����') where a.away1>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'����:'||'����') where a.away2>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);

		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'����:'||'�ٵ�') where a.later1>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||'����:'||'�ٵ�') where a.later2>0 and a.classtype=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		// ��ͳ�ư����(�ٵ� ��������/1��)
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||':'||'�ٵ�') where a.later>0 and a.classtype!=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		sql = "update att_sign_detail a set a.note=(nvl(a.note,'')||','||a.day||':'||'����'||to_number(a.away)||'��') where a.away>0 and a.classtype!=2 and ignore='0'";
		this.activeapi.executeSql(sql);
		// ͳ�ƽ�������������Ա��������ʱ��Ϣ��
		// ��������ϴ�ͳ�Ƶ�����
		sql = "delete from a244 a";
		this.activeapi.executeSql(sql);
		// ����������
		sql = "insert into a244 select  t.userid||sum(rownum),t.userid,'00901','"
				+ tempBeginDate
				+ "','"
				+ tempEndDate
				+ "',wmsys.wm_concat(t.note) from att_sign_detail t group by t.userid";
		this.activeapi.executeSql(sql);
		// ���û�гٵ��Ϳ�����¼��Ա��
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
