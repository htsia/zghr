<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.portal.hshz.portalClient" %>
<%@ page import="com.hr319wg.portal.hshz.LoginUserInfo" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<head><title><%=Constants.SYSTEM_NAME%></title></head>

</head>
<body>
<%
	String username = request.getParameter("username");
	ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
	String userCount = "select count(*) from sys_user_info where login_name='"+username+"'";
	int count = api.queryForInt(userCount);
	if(count==0){
		response.sendRedirect("/Login.jsf");
	}else{
		session.setAttribute("loginName",username);
		response.sendRedirect("/Logininterface.jsf");
	}
	
%>
</body>
</html>