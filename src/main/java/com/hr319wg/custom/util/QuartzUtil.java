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
	private static String url = "http://portal.sias.edu.cn:7777/addMailInfo.asmx";// 提供接口的地址
	private static String soapaction = "http://tempuri.org/"; // 域名，这是在server定义的
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
		//计算时间   
		this.jdbcTemplate.execute("BEGIN proc_calc_age(); END;");
		
		//发送邮件
		//岗位变动
		String sql = "select a.a001735 员工编号,a.a001001 姓名,yb.b001005 原部门,xb.b001005 现部门,yc.c001005 原岗位,xc.c001005 现岗位,g.a017015 变动时间 from a017 g,a001 a,b001 yb,b001 xb,c001 yc,c001 xc where g.id=a.id and g.a017705=yb.orguid and g.a017710=xb.orguid and g.a017801=yc.postid and g.a017702=xc.postid and A017200 is null and g.a017000 ='00901'";
		List list = this.jdbcTemplate.queryForList(sql);
		StringBuffer content=new StringBuffer();
		if(list!=null && list.size()>0){
			String[]titles={"员工编号","姓名","原部门","现部门","原岗位","现岗位","变动时间"};
			setEmailContent(titles, list, content ,2);
			sql = "update a017 set A017200='00901'";
			this.jdbcTemplate.execute(sql);
		}
		sql = "select a.a001735 员工编号,a.a001001 姓名,b.b001005 所在部门,c.c001005 岗位,e.changedate 审批时间 from a001 a,b001 b,c001 c,emp_audit_info e where a.a001705=b.orguid and a.A001715 =c.postid and a.id=e.id and e.status is null and changetype=1";
		list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			String[]titles={"员工编号","姓名","所在部门","岗位","审批时间"};
			setEmailContent(titles, list, content, 0);
			sql = "update emp_audit_info set status=1 where changetype=1";
			this.jdbcTemplate.execute(sql);
		}
		sql = "select a.a001735 员工编号,a.a001001 姓名,b.b001005 所在部门,c.c001005 岗位,e.changedate 审批时间 from a001 a,b001 b,c001 c,emp_audit_info e where a.a001705=b.orguid and a.A001715 =c.postid and a.id=e.id and e.status is null and changetype=2";
		list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			String[]titles={"员工编号","姓名","所在部门","岗位","审批时间"};
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
					call.setOperationName(new QName(soapaction,"addPortalMailInfoByUserName")); //设置要调用哪个方法
					
					call.addParameter(new QName(soapaction, "MailTitle"),  org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);// 设置要传递的参数
					call.addParameter(new QName(soapaction, "MailContent"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.addParameter(new QName(soapaction, "MailSender"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.addParameter(new QName(soapaction, "MailAccepter"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.addParameter(new QName(soapaction, "CheckStr"), org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
					call.setReturnType(new QName(soapaction,"addPortalMailInfoByUserName"),Vector.class); //要返回的数据类型（自定义类型）
					call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);//（标准的类型）
					
					call.setUseSOAPAction(true);
					call.setSOAPActionURI(soapaction + "addPortalMailInfoByUserName");
					String result = (String) call.invoke(new Object[]{"人员变动信息",content.toString(),m.get("oa1"),m.get("oa2"),"11204"});//调用方法并传递参数
					System.out.println(result);
				}catch(Exception ex){
					ex.printStackTrace();
				} 
			}
		}
	}
	
	/**
	 * 组装发送内容
	 * @param titles
	 * @param list
	 * @param content
	 * @param changetype 1:新增2：离职3：岗位异动
	 */
	private void setEmailContent(String[]titles, List list, StringBuffer content, int changetype){ 
		String[]changetypes={"人员新增","人员离职","岗位变动"};
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
