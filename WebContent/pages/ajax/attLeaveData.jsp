<%@page import="com.hr319wg.custom.attence.util.AttConstants"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.hr319wg.xys.workflow.service.SelPersonsToolService"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page
	import="com.hr319wg.custom.attence.service.IAttBusiService"%>
<%
try{
String personId=request.getParameter("personId");
    String userId=personId.split(",")[0];
    IAttBusiService attBusiService = (IAttBusiService) SysContext.getBean("attBusiServiceImpl");
    List leaveDaysList=attBusiService.getDays(userId);//��ȡʣ��Ĵ�н������
    Map undoneDays=attBusiService.getUndoneDays(userId);//��ȡ�������ĸ��������������
    Map leaveDays=(Map)leaveDaysList.get(0);//��ȡʣ��Ĵ�н������
    String result="";
    //�ƶ������ַ����Ĺ���:Ϊһϵ���ַ���������Ϊ
    result+=leaveDays.get("a236202")+",";
    result+=leaveDays.get("a236203")+",";
    result+=leaveDays.get("a236204")+",";
    result+=leaveDays.get("a236205")+",";
    result+=leaveDays.get("a236206")+",";
    result+=leaveDays.get("a236207")+",";
    
    result+=undoneDays.get("a3")+",";
    result+=undoneDays.get("a4")+",";
    result+=undoneDays.get("a5")+",";
    result+=undoneDays.get("a6")+",";
    result+=undoneDays.get("a7")+",";
    out.println(result);   
    
}catch(Exception e){
 		out.print(-1);
 	}
%>