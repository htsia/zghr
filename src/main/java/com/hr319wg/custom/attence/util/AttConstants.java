package com.hr319wg.custom.attence.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.faces.model.SelectItem;

import com.hr319wg.util.CommonFuns;

public class AttConstants {
	
	//0申请1报批2批准3退回
	public static final String STATUS_APPLY="0";
	public static final String STATUS_AUDIT="1";
	public static final String STATUS_AUDIT_SUCCES="2";
	public static final String STATUS_AUDIT_LOSE="3";
	
	
	public static String getAttFlowKey(String code){
		if(code.equals("3018700422")//理事
				||code.equals("3018700425")
				||code.equals("3018700418")
				){
			//校级key
			return "XiaoJiLeave";
		}else if(code.equals("3018700415") 
				|| code.equals("3018700416") 
				|| code.equals("3018700568") 
				|| code.equals("3018700567") 
				){
			//处级key
			return "ChuJiLeave";			
		}else {
			//一般员工key
			return "YiBanYuanGongLeave";
		}
	}
	
	
	//返回所有假期
	public static List getLeaveType(){
		List list=new ArrayList();
		SelectItem si1=new SelectItem();
		si1.setLabel("正常请假");
		si1.setValue("1");
		SelectItem si2=new SelectItem();
		si2.setLabel("病假");
		si2.setValue("2");
		SelectItem si3=new SelectItem();
		si3.setLabel("婚假");
		si3.setValue("3");
		SelectItem si4=new SelectItem();
		si4.setLabel("丧假");
		si4.setValue("4");
		SelectItem si5=new SelectItem();
		si5.setLabel("产假");
		si5.setValue("5");
		SelectItem si6=new SelectItem();
		si6.setLabel("难产产假");
		si6.setValue("6");
		SelectItem si7=new SelectItem();
		si7.setLabel("带薪事假");
		si7.setValue("7");
		list.add(si1);
		list.add(si2);
		list.add(si3);
		list.add(si4);
		list.add(si5);
		list.add(si6);
		list.add(si7);
		return list;
	}
	
	public static String getPostIdBySecDeptCode(String secDeptCode) throws Exception{
		String base = AttConstants.class.getResource("/").toString().replaceAll("file:/", "");
		Properties p = new Properties();
		base+="flowDeptId.properties";
		InputStream in = new FileInputStream(base);
		p.load(in);
		Object[]keys= p.keySet().toArray();
		if(keys!=null && keys.length>0){
			for(int i=0;i<keys.length;i++){
				String[]deptIds=p.get(keys[i]).toString().split(",");
				for(int j =0;j<deptIds.length;j++){
					if(secDeptCode.equals(deptIds[j])){
						return keys[i].toString();
					}					
				}
			}
		}
		return null;
	}

}
