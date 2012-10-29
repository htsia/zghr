package com.hr319wg.custom.util;

import java.util.HashMap;
import java.util.Map;

import com.hr319wg.common.exception.SysException;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

public class ZKEMDetailService extends Thread {
	
	private String IP;
	private Map map=new HashMap();
	
	public Map getMap() {
		return map;
	}

	public void setMap(Map map) {
		this.map = map;
	}

	public String getIP() {
		return IP;
	}

	public void setIP(String iP) {
		IP = iP;
	}

	//初始化参数
	public static String init() throws SysException{
		try {
			ActiveXComponent objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
			objArchSend.getObject();
		} catch (Exception e) {
			return "考勤机驱动注册失败";
		}
		return null;
	}
	
	@Override
	public void run() {
		Variant dwMachineNumber = new Variant(0, true);// 机器号
		Variant dwValue = new Variant(0, true);
		Variant dwStatus = new Variant(0, true);
		
		ActiveXComponent objArchSend = new ActiveXComponent("zkemkeeper.ZKEM.1");
		Dispatch myCon = (Dispatch) objArchSend.getObject();
		// 连接
		Boolean isConnected = Dispatch.call(myCon, "Connect_Net", IP, 4370) .getBoolean();
		// 判断连接结果
		if (isConnected == true) {
			try {
				Dispatch.call(myCon, "EnableDevice", 1, false);// 使机器处于不可用状态
				this.map.put("isCon", true);
				for (int i = 1; i < 7; i++) {
					dwStatus = new Variant(i);
					if (Dispatch.call(myCon, "GetDeviceStatus",dwMachineNumber,dwStatus,dwValue).getBoolean()){
						String value = String.valueOf(dwValue);
						switch (i) {
						case 1:
							this.map.put("manager", value);
							break;
						case 2:
							this.map.put("user", value);
							break;
						case 3:
							this.map.put("finger", value);
							break;
						case 4:
							this.map.put("password", value);
							break;
						case 6:
							this.map.put("log", value);
							break;
						}
					}
				}
			} catch (Exception e) {
				Dispatch.call(myCon, "EnableDevice", 1, true);// 使机器处于可用状态
			}finally{
				Dispatch.call(myCon, "EnableDevice", 1, true);// 使机器处于可用状态				
			}
		}else {
			this.map.put("isCon", false);
			Dispatch.call(myCon, "EnableDevice", 1, true);// 使机器处于可用状态
		}
	}
}
