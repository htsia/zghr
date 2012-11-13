<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.portal.hshz.portalClient" %>
<%@ page import="com.hr319wg.portal.hshz.LoginUserInfo" %>


<%
	String username = request.getParameter("name");
	String password = request.getParameter("password");

ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
String sql = "select count(*) from SYS_PARAMETER t where t.para_key='SYS_PASSWORD' and t.para_value='"+password+"'";
int count1 = api.queryForInt(sql);
if(count1==1){
	System.out.println(username);
	String userCount = "select count(*) from sys_user_info where login_name='"+username+"'";
	int count = api.queryForInt(userCount);
	if(count==0){
		out.println("µÇÂ½Ê§°Ü£¬Çë¼ì²éÓÃ»§ÃûºÍÃÜÂë!");
		return;
	}else{
		session.setAttribute("loginName",username);
		response.sendRedirect("/Logininterface.jsf");
	}
}else{
	out.println("µÇÂ½Ê§°Ü£¬Çë¼ì²éÓÃ»§ÃûºÍÃÜÂë!");
}
	
%>
