package com.hr319wg.custom.mailServices.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.util.CommonFuns;

public class EhrMailServicesBackingBean {
	private String url = "http://portal.sias.edu.cn:7777/addMailInfo.asmx";// �ṩ�ӿڵĵ�ַ
	private String soapaction = "http://tempuri.org/"; // ������������server�����
	private JdbcTemplate jdbcTemplate ;
	
     public JdbcTemplate getJdbcTemplate() {
    	 try {
			jdbcTemplate = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
		} catch (SysException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	/**
	 * ������ְ��ʱ��������ְ��ʦʱ, ����һ���ʼ�
	 * @param arg1 Ա�����
	 * @param arg2 ����
	 * @param arg3 ����ȫƴ
	 * @param arg4 ��λ
	 * @param arg5 ���ڲ���
	 * @param arg6 ʱ��
	 */
	public void  userAddSendMail(String arg1,String arg2,String arg3,String arg4,String arg5 ,String arg6){
    	String MailTitle = "��Ա����ְ��Ϣ";
    	
    	String MailContent = new   String(); 
		MailContent = MailContent+"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
		MailContent = MailContent+"<html xmlns='http://www.w3.org/1999/xhtml'>";
		MailContent = MailContent+"<head><meta http-equiv='MailContent-Type' MailContent='text/html; charset=gb2312' />";
		MailContent = MailContent+"<title>--</title></head>";
		MailContent = MailContent+"<body>";
		MailContent = MailContent+"<table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'>";
		MailContent = MailContent+"<tr>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>Ա�����</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>����</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>����ȫƴ</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>��λ</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>���ڲ���</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>ʱ��</strong></div></td>";
		MailContent = MailContent+"</tr>";
		MailContent = MailContent+"<tr>";
		MailContent = MailContent+"<td><div align='center'>"+arg1+"</div></td>";
		MailContent = MailContent+"<td><div align='center'>"+arg2+"</div></td>";
		MailContent = MailContent+"<td><div align='center'>"+arg3+"</div></td>";
		MailContent = MailContent+"<td><div align='center'>"+arg4+"</div></td>";
		MailContent = MailContent+"<td><div align='center'>"+arg5+"</div></td>";
		MailContent = MailContent+"<td><div align='center'>"+arg6+"</div></td>";
		MailContent = MailContent+"</tr>";
		MailContent = MailContent+"</table>";
		MailContent = MailContent+"</body>";
		MailContent = MailContent+"</html>";
 		String MailSenderID = "1289";
 		String MailAccepterID = "1494";
 		String CheckStr = "11204";
 		publicSendMailMothod(MailTitle, MailContent, MailSenderID, MailAccepterID, CheckStr);       
     }
     
     /**
      * �û� ��λ/ ���ű䶯��Ϣ  �����ʼ�
      * @param arg1 Ա�����
      * @param arg2 ����
      * @param arg3 ����ȫƴ
      * @param arg4 ԭ��λ
      * @param arg5 ԭ����
      * @param arg6 ���벿��
      * @param arg7 �¸�λ
      * @param arg8 ����ʱ��
      */
     public void userModifySendMail(String arg1,String arg2,String arg3,String arg4,String arg5,String arg6,String arg7,String arg8){
    	String MailTitle = "Ա����λ/���ű䶯��Ϣ";
    	String MailContent = new   String(); 
 		MailContent = MailContent+"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
 		MailContent = MailContent+"<html xmlns='http://www.w3.org/1999/xhtml'>";
 		MailContent = MailContent+"<head><meta http-equiv='MailContent-Type' MailContent='text/html; charset=gb2312' />";
 		MailContent = MailContent+"<title>--</title></head>";
 		MailContent = MailContent+"<body>";
 		MailContent = MailContent+"<table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'>";
 		MailContent = MailContent+"<tr>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>Ա�����</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>����</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>����ȫƴ</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>ԭ����</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>ԭ��λ</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>�²���</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>�¸�λ</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>ʱ��</strong></div></td>"; //��š�������ȫƴ��ԭ��λ��ԭ��λ���µ�λ���¸�λ��ʱ��
 		MailContent = MailContent+"</tr>";
 		MailContent = MailContent+"<tr>";
 		MailContent = MailContent+"<td><div align='center'>"+arg1+"</strong></div></td>";
 		MailContent = MailContent+"<td><div align='center'>"+arg2+"</strong></div></td>";
 		MailContent = MailContent+"<td><div align='center'>"+arg3+"</strong></div></td>";
 		MailContent = MailContent+"<td><div align='center'>"+arg4+"</strong></div></td>";
 		MailContent = MailContent+"<td><div align='center'>"+arg5+"</strong></div></td>";
 		MailContent = MailContent+"<td><div align='center'>"+arg6+"</strong></div></td>";
 		MailContent = MailContent+"<td><div align='center'>"+arg7+"</strong></div></td>";
 		MailContent = MailContent+"<td><div align='center'>"+arg8+"</strong></div></td>";
 		MailContent = MailContent+"</tr>";
 		MailContent = MailContent+"</table>";
 		MailContent = MailContent+"</body>";
 		MailContent = MailContent+"</html>";
  		String MailSenderID = "1289";
  		String MailAccepterID = "1494";
  		String CheckStr = "11204";
  		
  		publicSendMailMothod(MailTitle, MailContent, MailSenderID, MailAccepterID, CheckStr);
     }
     
     /**
      * �û���ְʱ,�����ʼ�
      * @param arg1 �û����
      * @param arg2 �û�����
      * @param arg3 �û�����ȫƴ
      * @param arg4 ���ڲ���
      * @param arg5 ��ְ����ʱ��    ϵͳ����ְ��Ա������ְ��ʱ��
      */
     public void userLeaveOfficeSendMail(String arg1,String arg2,String arg3,String arg4,String arg5){
    	String MailTitle = "Ա����ְ��Ϣ";
     	String MailContent = new   String(); 
  		MailContent = MailContent+"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
  		MailContent = MailContent+"<html xmlns='http://www.w3.org/1999/xhtml'>";
  		MailContent = MailContent+"<head><meta http-equiv='MailContent-Type' MailContent='text/html; charset=gb2312' />";
  		MailContent = MailContent+"<title>--</title></head>";
  		MailContent = MailContent+"<body>";
  		MailContent = MailContent+"<table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'>";
  		MailContent = MailContent+"<tr>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>Ա�����</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>����</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>����ȫƴ</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>���ڲ���</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>��ְ����ʱ��</strong></div></td>"; 
  		MailContent = MailContent+"</tr>";
  		MailContent = MailContent+"<tr>";
  		MailContent = MailContent+"<td><div align='center'>"+arg1+"</strong></div></td>";
  		MailContent = MailContent+"<td><div align='center'>"+arg2+"</strong></div></td>";
  		MailContent = MailContent+"<td><div align='center'>"+arg3+"</strong></div></td>";
  		MailContent = MailContent+"<td><div align='center'>"+arg4+"</strong></div></td>";
  		MailContent = MailContent+"<td><div align='center'>"+arg5+"</strong></div></td>";
  		MailContent = MailContent+"</tr>";
  		MailContent = MailContent+"</table>";
  		MailContent = MailContent+"</body>";
  		MailContent = MailContent+"</html>";
   		String MailSenderID = "1289";
   		String MailAccepterID = "1494";
   		String CheckStr = "11204";
   		
   		publicSendMailMothod(MailTitle, MailContent, MailSenderID, MailAccepterID, CheckStr);
     }
     /**
      * ��ִ�з����ʼ��Ĺ���������ȡ����
      * @param MailTitle �ʼ�����
      * @param MailContent �ʼ�����
      * @param MailSenderID �ʼ�������
      * @param MailAccepterID �ʼ�������
      * @param CheckStr �ʼ���֤��
      */
     public void publicSendMailMothod(String MailTitle,String MailContent,String MailSenderID,String MailAccepterID,String CheckStr){
    	 Service service = new Service();
    	 try{
             Call call=(Call)service.createCall();            
             call.setTargetEndpointAddress(url);            
             call.setOperationName(new QName(soapaction,"addPortalMailInfoByUserID")); //����Ҫ�����ĸ�����

             call.addParameter(new QName(soapaction, "MailTitle"),  org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);// ����Ҫ���ݵĲ���
 			 call.addParameter(new QName(soapaction, "MailContent"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
 			 call.addParameter(new QName(soapaction, "MailSenderID"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
 			 call.addParameter(new QName(soapaction, "MailAccepterID"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
 			 call.addParameter(new QName(soapaction, "CheckStr"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
             call.setReturnType(new QName(soapaction,"addPortalMailInfoByUserID"),Vector.class); //Ҫ���ص��������ͣ��Զ������ͣ�
             call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);//����׼�����ͣ�
             
             call.setUseSOAPAction(true);
             call.setSOAPActionURI(soapaction + "addPortalMailInfoByUserID");
                        
             String result = (String) call.invoke(new Object[]{MailTitle,MailContent,MailSenderID,MailAccepterID,CheckStr});//���÷��������ݲ���   
             this.returnResult(result); //10���ͳɹ�
         }catch(Exception ex){
        	 ex.printStackTrace();
         } 
     }
     /**
      * ���ݷ����ʼ�ʱ���ص�ֵ ���жϷ����ʼ���״̬
      * @param result �ʼ�����ֵ
      * @return ����ֵ��Ӧ����ʾ˵��
      */
      public String returnResult(String result){
     	 String resultStr = "";
     	 int resultIndex = Integer.valueOf(result);
     	 switch (resultIndex) {
 			case 0:
 				resultStr = "�û���Ϊ��";
 				break;
 			case 1:
 				resultStr = "�û�������";
 				break;
 			case 3:
 				resultStr = "���ⲻ��Ϊ��";
 				break;
 			case 4:
 				resultStr = "���ݲ���Ϊ��";
 				break;
 			case 5:
 				resultStr = "�����߲���Ϊ��";
 				break;
 			case 6:
 				resultStr = "�����߲���Ϊ��";
 				break;
 			case 7:
 				resultStr = "��֤ʧ��";
 				break;
 			case 8:
 				resultStr = "����ʼ�����ʧ��";
 				break;
 			case 9:
 				resultStr = "����ʧ��";
 				break;
 			case 10:
 				resultStr = "���ͳɹ�";
 				break;
 			case 11:
 				resultStr = "�����������͵���ȷ�ԣ����и��������ϵ����Ա";
 				break;
     	 }
     	 return resultStr;
      }
	
    //����û�  ����֮����ô˷���
	public void userAdd(String arg0){
		String querySql = "select a.a001735, a.a001001,a.a001241,c.C001005 ,b.b001005 ,a.a001044" +
				" from a001 a left join c001 c on c.postid = a.A001715" +
				" left join b001 b on b.orguid = a.A001705  where a.ID = '"+arg0+"'";
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		list = getJdbcTemplate().queryForList(querySql);
		for (int i = 0; i < list.size(); i++) {
			try {
				String c005 = "";
				if ("".equals(list.get(i).get("C001005")) || null == list.get(i).get("C001005")) {
					c005 = "";
				}else {
					c005 = list.get(i).get("C001005").toString();
				}
				userAddSendMail(list.get(i).get("a001735").toString(),list.get(i).get("a001001").toString(),list.get(i).get("a001241").toString(),
						c005,list.get(i).get("b001005").toString(),CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss").toString());
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}
	//Ա������/��λ�޸�  ����֮����ô˷���  ת��
	public void userChangeOrgTitle(String arg0){
		String querySql = "select a.a001735, a.a001001,a.a001241, " +
				"(select b001.b001005 from b001 where b001.orguid = b.a017705) as ydw, " +
				"(select c001.c001005 from c001 where c001.postid = b.a017801) as ygw, " +
				"(select b001.b001005 from b001 where b001.orguid = b.a017710) as xdw, " +
				"(select c001.c001005 from c001 where c001.postid = b.a017702) as xgw, " +
				"b.a017015 " +
				"from a017 b left join  a001 a on a.id = b.id where a.id = '"+arg0+"'";
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		list = getJdbcTemplate().queryForList(querySql);
		for (int i = 0; i < list.size(); i++) {
			try {
				//ԭ��λ
				String a017801 = "";
				if ("".equals(list.get(i).get("ygw")) || null == list.get(i).get("ygw")) {
					a017801 = "";
				}else {
					a017801 = list.get(i).get("ygw").toString();
				}
				//�¸�λ 
				String a017702 = "";
				if ("".equals(list.get(i).get("xgw")) || null == list.get(i).get("xgw")) {
					a017702 = "";
				}else {
					a017702 = list.get(i).get("xgw").toString();
				}
						userModifySendMail(list.get(i).get("a001735").toString(),list.get(i).get("a001001").toString(),list.get(i).get("a001241").toString(),
								list.get(i).get("ydw").toString(),a017801,list.get(i).get("xdw").toString(),
								a017702,CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss").toString());
			} catch (Exception e) {
				// TODO: handle exception��š�������ȫƴ��ԭ��λ��ԭ��λ���µ�λ���¸�λ��ʱ��
				e.printStackTrace();
			}
		}
	}
		
	//Ա�� ��ְ����ͨ��,���ô˷���,�����ʼ�
	public void userLeaveOffice(String arg0){
		String querySql = "select a.a001735, a.a001001,a.a001241," +
				" (select b001.b001005 from b001 where b001.orguid = (select a001.a001705 from a001 where a001.id = '"+arg0+"')) as ybm "+
				" from a016 b left join  a001 a on a.id = b.id where a.id = '"+arg0+"'";
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		list = getJdbcTemplate().queryForList(querySql);
		for (int i = 0; i < list.size(); i++) {
			try {
				userLeaveOfficeSendMail(list.get(i).get("a001735").toString(), list.get(i).get("a001001").toString(), 
						list.get(i).get("a001241").toString(), list.get(i).get("ybm").toString(), CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss").toString());
			} catch (Exception e) {
				// TODO: handle exception Ա����š�������ȫƴ�����ڲ��š�����ʱ��
				e.printStackTrace();
			}
		}
	};
}
