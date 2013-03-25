<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="java.util.Date"%>
<%@ page import="com.hr319wg.common.Constants" %>

<%@ page import="java.rmi.RemoteException" %>
<%@ page import="org.apache.axiom.om.OMAbstractFactory" %>
<%@ page import="org.apache.axiom.om.OMElement" %>
<%@ page import="org.apache.axiom.om.OMFactory" %>
<%@ page import="org.apache.axiom.om.OMNamespace" %>
<%@ page import="org.apache.axis2.AxisFault" %>
<%@ page import="org.apache.axis2.client.ServiceClient" %>
<%@ page import="com.hr319wg.custom.validateLogin.web.HrSSOStub.MySoapHeaderE" %>
<%@ page import="com.hr319wg.custom.validateLogin.web.HrSSOStub.MySoapHeader" %>            
<%@ page import="com.hr319wg.custom.validateLogin.web.HrSSOStub.Validate" %>
<%@ page import="com.hr319wg.custom.validateLogin.web.ValidateLoginEHRBackingBean" %>
<%@ page import="com.hr319wg.custom.validateLogin.web.HrSSOStub" %>
<%@ page import="com.hr319wg.custom.validateLogin.web.HrSSOCallbackHandler" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<head><title><%=Constants.SYSTEM_NAME%></title></head>
<%
	String url = "http://portal.sias.edu.cn:8888/hrsso.asmx";// 提供接口的地址
	String soapaction = "http://tempuri.org/"; // 域名，这是在server定义的
	int AppID = 4;
	String username = request.getParameter("username");
	ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
	String userCount = "select count(*) from sys_user_info where login_name='"+username+"'";
	int count = api.queryForInt(userCount);
	if(count==0){
		response.sendRedirect("/Login.jsf");
	}
	String cre = request.getParameter("cre");
	
	if(null == username){
		username = "";
	}
	if(null == cre){
		cre = "";
	}
	
	HrSSOStub stub;
	ValidateLoginEHRBackingBean backingBean = new ValidateLoginEHRBackingBean();
	try {
		stub = new HrSSOStub();
		ServiceClient client = stub._getServiceClient();
		client.addHeader(backingBean.creatElement());
		stub._setServiceClient(client);
		
		Validate validate = new Validate();
		validate.setAppid(AppID);
		validate.setUsername(username.toString());
		validate.setCredentials(cre);
		validate.setKey("063c3490b076f0ce522f0289833adad4");//key
		
		MySoapHeaderE header = new MySoapHeaderE();
		MySoapHeader mySoapHeader = new MySoapHeader();
		mySoapHeader.setPassWord("siashr@SS0123");
		mySoapHeader.setUserName("siassso");
		header.setMySoapHeader(mySoapHeader);
		try {
			
			boolean result = stub.validate(validate, header).getValidateResult();
			if(result){
				session.setAttribute("loginName",username);
				response.sendRedirect("/Logininterface.jsf");
			}else{
				response.sendRedirect("/Login.jsf");
// 				out.println("<script>alert('验证失败,无法登陆人力资源系统');window.close();</script>");
			}
		} catch (RemoteException e) {
			response.sendRedirect("/Login.jsf");
// 			out.println("<script>alert('验证失败,无法登陆人力资源系统');window.close();</script>");
		}
	} catch (AxisFault e) {
		response.sendRedirect("/Login.jsf");
// 		out.println("<script>alert('验证失败,无法登陆人力资源系统');window.close();</script>");
	}
%>
</head>
<body>
</body>
</html>