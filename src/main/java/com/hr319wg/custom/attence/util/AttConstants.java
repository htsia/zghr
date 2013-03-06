package com.hr319wg.custom.attence.util;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

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
		SelectItem si8=new SelectItem();
		si8.setLabel("��������");
		si8.setValue("8");
		SelectItem si9=new SelectItem();
		si9.setLabel("˫��̥����");
		si9.setValue("9");
		list.add(si1);
		list.add(si2);
		list.add(si3);
		list.add(si4);
		list.add(si5);
		list.add(si6);
		list.add(si7);
//		list.add(si8);
//		list.add(si9);
		
		return list;
	}
}
