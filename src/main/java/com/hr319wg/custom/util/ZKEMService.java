package com.hr319wg.custom.util;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.SysContext;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

public class ZKEMService extends Thread {
	
	private String IP;
	private String machineName;
	private String errMsg="";
	private String errUser="";
	private static String operUserID;
	static List<Map<String, Object>> list;

	public static String getOperUserID() {
		return operUserID;
	}
	public static void setOperUserID(String operUserID) {
		ZKEMService.operUserID = operUserID;
	}
	public String getMachineName() {
		return machineName;
	}
	public void setMachineName(String machineName) {
		this.machineName = machineName;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getErrUser() {
		return errUser;
	}
	public void setErrUser(String errUser) {
		this.errUser = errUser;
	}
	public String getIP() {
		return IP;
	}
	public void setIP(String iP) {
		IP = iP;
	}
	public static List<Map<String, Object>> getList() {
		return list;
	}
	public static void setList(List<Map<String, Object>> list) {
		ZKEMService.list = list;
	}
	
	//��ʼ������
	public static String init() throws SysException{
		ActiveXComponent objArchSend = null;
		try {
			objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			objArchSend.getObject();
		} catch (Exception e) {
			return "���ڻ�����ע��ʧ��";
		}
		JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
		String sql = "select a.a001735, a.a001001 ,b.A232210 ,b.A232211 , "
				+ "b.A232200,b.A232201,b.A232202,b.A232203,b.A232204,b.A232205,b.A232206,b.A232207,b.A232208,b.A232209 "
				+ "from a001 a,a232 b where a.ID = b.ID and a.A001054 not in ('013520','013521','013522','013523','013524','013525')";
		if(operUserID!=null){//�����˷ַ�
			sql = "select a.a001735, a.a001001 ,b.A232210 ,b.A232211 , "
					+ "b.A232200,b.A232201,b.A232202,b.A232203,b.A232204,b.A232205,b.A232206,b.A232207,b.A232208,b.A232209 "
					+ "from a001 a,a232 b where a.ID = b.ID and a.ID = '"
					+ operUserID + "'";
		}
		List<Map<String, Object>> list1 = jdbc.queryForList(sql);
		if (list1 == null || list1.size() == 0) {
			return "���Ȳɼ�ָ�ƣ�ϵͳ��û��ָ����Ϣ";
		}else{
			list=list1;
		}
		return null;
	}
	
	@Override
	public void run() {
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
		Boolean isConnected = Dispatch.call(myCon, "Connect_Net", IP, 4370).getBoolean();
		// �ж����ӽ��
		if (isConnected == true) {
			Dispatch.call(myCon, "EnableDevice", 1, false);// ʹ�������ڲ�����״̬
			if (!Dispatch.call(myCon, "BeginBatchUpdate", 1, 1).getBoolean()) {
				this.errMsg= this.machineName+"����ϵͳָ�ƻ���ʧ��";
			}
			for (Map m : list) {
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
				} else {
					errUser += dwEnrollNumber + ",";
				}
			}
			//for-end
			Dispatch.call(myCon, "BatchUpdate", 1);
			Dispatch.call(myCon, "RefreshData", 1);
			Dispatch.call(myCon, "EnableDevice", 1, true);
		}else{
			this.errMsg=this.machineName;
		}
	}
}
