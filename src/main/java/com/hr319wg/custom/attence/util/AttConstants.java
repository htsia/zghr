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
	
	//0����1����2��׼3�˻�
	public static final String STATUS_APPLY="0";
	public static final String STATUS_AUDIT="1";
	public static final String STATUS_AUDIT_SUCCES="2";
	public static final String STATUS_AUDIT_LOSE="3";
	
	
	public static String getAttFlowKey(String code){
		if(code.equals("3018700422")//����
				||code.equals("3018700425")
				||code.equals("3018700418")
				){
			//У��key
			return "XiaoJiLeave";
		}else if(code.equals("3018700415") 
				|| code.equals("3018700416") 
				|| code.equals("3018700568") 
				|| code.equals("3018700567") 
				){
			//����key
			return "ChuJiLeave";			
		}else {
			//һ��Ա��key
			return "YiBanYuanGongLeave";
		}
	}
	
	
	//�������м���
	public static List getLeaveType(){
		List list=new ArrayList();
		SelectItem si1=new SelectItem();
		si1.setLabel("�������");
		si1.setValue("1");
		SelectItem si2=new SelectItem();
		si2.setLabel("����");
		si2.setValue("2");
		SelectItem si3=new SelectItem();
		si3.setLabel("���");
		si3.setValue("3");
		SelectItem si4=new SelectItem();
		si4.setLabel("ɥ��");
		si4.setValue("4");
		SelectItem si5=new SelectItem();
		si5.setLabel("����");
		si5.setValue("5");
		SelectItem si6=new SelectItem();
		si6.setLabel("�Ѳ�����");
		si6.setValue("6");
		SelectItem si7=new SelectItem();
		si7.setLabel("��н�¼�");
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
