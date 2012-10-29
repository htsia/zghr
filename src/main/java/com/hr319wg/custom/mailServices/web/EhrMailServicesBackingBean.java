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
	private String url = "http://portal.sias.edu.cn:7777/addMailInfo.asmx";// 提供接口的地址
	private String soapaction = "http://tempuri.org/"; // 域名，这是在server定义的
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
	 * 新增教职工时、新增兼职教师时, 发送一个邮件
	 * @param arg1 员工编号
	 * @param arg2 姓名
	 * @param arg3 姓名全拼
	 * @param arg4 岗位
	 * @param arg5 所在部门
	 * @param arg6 时间
	 */
	public void  userAddSendMail(String arg1,String arg2,String arg3,String arg4,String arg5 ,String arg6){
    	String MailTitle = "新员工入职信息";
    	
    	String MailContent = new   String(); 
		MailContent = MailContent+"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
		MailContent = MailContent+"<html xmlns='http://www.w3.org/1999/xhtml'>";
		MailContent = MailContent+"<head><meta http-equiv='MailContent-Type' MailContent='text/html; charset=gb2312' />";
		MailContent = MailContent+"<title>--</title></head>";
		MailContent = MailContent+"<body>";
		MailContent = MailContent+"<table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'>";
		MailContent = MailContent+"<tr>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>员工编号</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>姓名</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>姓名全拼</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>岗位</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>所在部门</strong></div></td>";
		MailContent = MailContent+"<td width='150'><div align='center'><strong>时间</strong></div></td>";
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
      * 用户 岗位/ 部门变动信息  发送邮件
      * @param arg1 员工编号
      * @param arg2 姓名
      * @param arg3 姓名全拼
      * @param arg4 原岗位
      * @param arg5 原部门
      * @param arg6 调入部门
      * @param arg7 新岗位
      * @param arg8 调入时间
      */
     public void userModifySendMail(String arg1,String arg2,String arg3,String arg4,String arg5,String arg6,String arg7,String arg8){
    	String MailTitle = "员工岗位/部门变动信息";
    	String MailContent = new   String(); 
 		MailContent = MailContent+"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
 		MailContent = MailContent+"<html xmlns='http://www.w3.org/1999/xhtml'>";
 		MailContent = MailContent+"<head><meta http-equiv='MailContent-Type' MailContent='text/html; charset=gb2312' />";
 		MailContent = MailContent+"<title>--</title></head>";
 		MailContent = MailContent+"<body>";
 		MailContent = MailContent+"<table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'>";
 		MailContent = MailContent+"<tr>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>员工编号</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>姓名</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>姓名全拼</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>原部门</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>原岗位</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>新部门</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>新岗位</strong></div></td>";
 		MailContent = MailContent+"<td width='100'><div align='center'><strong>时间</strong></div></td>"; //编号、姓名、全拼、原单位、原岗位、新单位、新岗位、时间
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
      * 用户离职时,发送邮件
      * @param arg1 用户编号
      * @param arg2 用户姓名
      * @param arg3 用户姓名全拼
      * @param arg4 所在部门
      * @param arg5 离职处理时间    系统对离职人员处理离职的时间
      */
     public void userLeaveOfficeSendMail(String arg1,String arg2,String arg3,String arg4,String arg5){
    	String MailTitle = "员工离职信息";
     	String MailContent = new   String(); 
  		MailContent = MailContent+"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
  		MailContent = MailContent+"<html xmlns='http://www.w3.org/1999/xhtml'>";
  		MailContent = MailContent+"<head><meta http-equiv='MailContent-Type' MailContent='text/html; charset=gb2312' />";
  		MailContent = MailContent+"<title>--</title></head>";
  		MailContent = MailContent+"<body>";
  		MailContent = MailContent+"<table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'>";
  		MailContent = MailContent+"<tr>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>员工编号</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>姓名</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>姓名全拼</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>所在部门</strong></div></td>";
  		MailContent = MailContent+"<td width='160'><div align='center'><strong>离职处理时间</strong></div></td>"; 
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
      * 把执行发送邮件的公共方法提取出来
      * @param MailTitle 邮件标题
      * @param MailContent 邮件内容
      * @param MailSenderID 邮件发送人
      * @param MailAccepterID 邮件接收人
      * @param CheckStr 邮件验证码
      */
     public void publicSendMailMothod(String MailTitle,String MailContent,String MailSenderID,String MailAccepterID,String CheckStr){
    	 Service service = new Service();
    	 try{
             Call call=(Call)service.createCall();            
             call.setTargetEndpointAddress(url);            
             call.setOperationName(new QName(soapaction,"addPortalMailInfoByUserID")); //设置要调用哪个方法

             call.addParameter(new QName(soapaction, "MailTitle"),  org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);// 设置要传递的参数
 			 call.addParameter(new QName(soapaction, "MailContent"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
 			 call.addParameter(new QName(soapaction, "MailSenderID"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
 			 call.addParameter(new QName(soapaction, "MailAccepterID"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
 			 call.addParameter(new QName(soapaction, "CheckStr"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
             call.setReturnType(new QName(soapaction,"addPortalMailInfoByUserID"),Vector.class); //要返回的数据类型（自定义类型）
             call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);//（标准的类型）
             
             call.setUseSOAPAction(true);
             call.setSOAPActionURI(soapaction + "addPortalMailInfoByUserID");
                        
             String result = (String) call.invoke(new Object[]{MailTitle,MailContent,MailSenderID,MailAccepterID,CheckStr});//调用方法并传递参数   
             this.returnResult(result); //10发送成功
         }catch(Exception ex){
        	 ex.printStackTrace();
         } 
     }
     /**
      * 根据发送邮件时返回的值 ，判断发送邮件的状态
      * @param result 邮件返回值
      * @return 返回值对应的提示说明
      */
      public String returnResult(String result){
     	 String resultStr = "";
     	 int resultIndex = Integer.valueOf(result);
     	 switch (resultIndex) {
 			case 0:
 				resultStr = "用户名为空";
 				break;
 			case 1:
 				resultStr = "用户不存在";
 				break;
 			case 3:
 				resultStr = "标题不能为空";
 				break;
 			case 4:
 				resultStr = "内容不能为空";
 				break;
 			case 5:
 				resultStr = "发送者不能为空";
 				break;
 			case 6:
 				resultStr = "接收者不能为空";
 				break;
 			case 7:
 				resultStr = "验证失败";
 				break;
 			case 8:
 				resultStr = "添加邮件内容失败";
 				break;
 			case 9:
 				resultStr = "发送失败";
 				break;
 			case 10:
 				resultStr = "发送成功";
 				break;
 			case 11:
 				resultStr = "请检查数据类型的正确性，如有该问题可联系管理员";
 				break;
     	 }
     	 return resultStr;
      }
	
    //添加用户  审批之后调用此方法
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
	//员工部门/岗位修改  审批之后调用此方法  转岗
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
				//原岗位
				String a017801 = "";
				if ("".equals(list.get(i).get("ygw")) || null == list.get(i).get("ygw")) {
					a017801 = "";
				}else {
					a017801 = list.get(i).get("ygw").toString();
				}
				//新岗位 
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
				// TODO: handle exception编号、姓名、全拼、原单位、原岗位、新单位、新岗位、时间
				e.printStackTrace();
			}
		}
	}
		
	//员工 离职处理通过,掉用此方法,发送邮件
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
				// TODO: handle exception 员工编号、姓名、全拼、所在部门、处理时间
				e.printStackTrace();
			}
		}
	};
}
