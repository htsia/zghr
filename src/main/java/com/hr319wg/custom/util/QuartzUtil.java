package com.hr319wg.custom.util;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class QuartzUtil extends QuartzJobBean{
	private static String url = "http://portal.sias.edu.cn:7777/addMailInfo.asmx";// �ṩ�ӿڵĵ�ַ
	private static String soapaction = "http://tempuri.org/"; // ������������server�����
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}


	/* (non-Javadoc)
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		//����ʱ��   
		this.jdbcTemplate.execute("BEGIN proc_calc_age(); END;");
		
		//�����ʼ�
		//��λ�䶯
		String sql = "select a.a001735 Ա�����,a.a001001 ����,yb.b001005 ԭ����,xb.b001005 �ֲ���,yc.c001005 ԭ��λ,xc.c001005 �ָ�λ,g.a017015 �䶯ʱ�� from a017 g,a001 a,b001 yb,b001 xb,c001 yc,c001 xc where g.id=a.id and g.a017705=yb.orguid and g.a017710=xb.orguid and g.a017801=yc.postid and g.a017702=xc.postid and A017200 is null and g.a017000 ='00901'";
		List list = this.jdbcTemplate.queryForList(sql);
		StringBuffer content=new StringBuffer();
		if(list!=null && list.size()>0){
			String[]titles={"Ա�����","����","ԭ����","�ֲ���","ԭ��λ","�ָ�λ","�䶯ʱ��"};
			setEmailContent(titles, list, content ,2);
			sql = "update a017 set A017200='00901'";
			this.jdbcTemplate.execute(sql);
		}
		sql = "select a.a001735 Ա�����,a.a001001 ����,b.b001005 ���ڲ���,c.c001005 ��λ,e.changedate ����ʱ�� from a001 a,b001 b,c001 c,emp_audit_info e where a.a001705=b.orguid and a.A001715 =c.postid and a.id=e.id and e.status is null and changetype=1";
		list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			String[]titles={"Ա�����","����","���ڲ���","��λ","����ʱ��"};
			setEmailContent(titles, list, content, 0);
			sql = "update emp_audit_info set status=1 where changetype=1";
			this.jdbcTemplate.execute(sql);
		}
		sql = "select a.a001735 Ա�����,a.a001001 ����,b.b001005 ���ڲ���,c.c001005 ��λ,e.changedate ����ʱ�� from a001 a,b001 b,c001 c,emp_audit_info e where a.a001705=b.orguid and a.A001715 =c.postid and a.id=e.id and e.status is null and changetype=2";
		list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			String[]titles={"Ա�����","����","���ڲ���","��λ","����ʱ��"};
			setEmailContent(titles, list, content, 1);
			sql = "update emp_audit_info set status=1 where changetype=2";
			this.jdbcTemplate.execute(sql);
		}
		if(content.toString()!=null && !"".equals(content.toString())){
			sql = "select a2.a001230 oa1,a3.a001230 oa2 from sys_oa_email m left join a001 a2 on m.userid2=a2.id left join a001 a3 on m.userid3=a3.id";
			List userids1=this.jdbcTemplate.queryForList(sql);
			if(userids1!=null){
				Map m = (Map)userids1.get(0);
				Service service = new Service();
				try{
					Call call=(Call)service.createCall();            
					call.setTargetEndpointAddress(url);
					call.setOperationName(new QName(soapaction,"addPortalMailInfoByUserName")); //����Ҫ�����ĸ�����
					
					call.addParameter(new QName(soapaction, "MailTitle"),  org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);// ����Ҫ���ݵĲ���
					call.addParameter(new QName(soapaction, "MailContent"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.addParameter(new QName(soapaction, "MailSender"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.addParameter(new QName(soapaction, "MailAccepter"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.addParameter(new QName(soapaction, "CheckStr"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.setReturnType(new QName(soapaction,"addPortalMailInfoByUserName"),Vector.class); //Ҫ���ص��������ͣ��Զ������ͣ�
					call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);//����׼�����ͣ�
					
					call.setUseSOAPAction(true);
					call.setSOAPActionURI(soapaction + "addPortalMailInfoByUserName");
					String result = (String) call.invoke(new Object[]{"��Ա�䶯��Ϣ",content.toString(),m.get("oa1"),m.get("oa2"),"11204"});//���÷��������ݲ���
					System.out.println(result);
				}catch(Exception ex){
					ex.printStackTrace();
				} 
			}
		}
	}
	
	/**
	 * ��װ��������
	 * @param titles
	 * @param list
	 * @param content
	 * @param changetype 1:����2����ְ3����λ�춯
	 */
	private void setEmailContent(String[]titles, List list, StringBuffer content, int changetype){ 
		String[]changetypes={"��Ա����","��Ա��ְ","��λ�䶯"};
		content.append("<div style='font-size:14px;font-weight:bold;margin:20px 0 5px 0;'>"+changetypes[changetype]+"</div><table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'><tr>");
		for(int i=0;i<titles.length;i++){
			content.append("<td align='center' width='100'>"+titles[i]+"</td>");			
		}
 		content.append("</tr>");
 		for(int i=0;i<list.size();i++){
 			content.append("<tr>");
 			Map m = (Map)list.get(i);
 			for(int j=0;j<titles.length;j++){
 				content.append("<td align='center'>"+((m.get(titles[j])==null || "null".equals(m.get(titles[j])))?"":m.get(titles[j]))+"</td>"); 				
 			}
 			content.append("</tr>");
 		}
 		content.append("</table>");
	}
}
