<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.portal.hshz.portalClient" %>
<%@ page import="com.hr319wg.portal.hshz.LoginUserInfo" %>
<%@ page import="com.hr319wg.user.ucc.IUserManageUCC"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>

<%
	String username = request.getParameter("name");
	String password = request.getParameter("password");

ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
String sql = "select count(*) from SYS_PARAMETER t where t.para_key='SYS_PASSWORD' and t.para_value='"+password+"'";
int count1 = api.queryForInt(sql);
if(count1==1){
	String userCount = "select count(*) from sys_user_info where login_name='"+username+"'";
	int count = api.queryForInt(userCount);
	if(count==0){
		out.println("µÇÂ½Ê§°Ü£¬Çë¼ì²éÓÃ»§ÃûºÍÃÜÂë!");
		return;
	}else{
		session.setAttribute("loginName",username);
		IUserManageUCC userucc = (IUserManageUCC) SysContext
				.getBean("user_userManageUccImpl");

		User user = userucc.verifyLogon(username, session, request);

	      session.setAttribute("USER_INFO", user);
		response.sendRedirect("/Logininterface.jsf?approtype="+request.getParameter("approtype"));
	}
}else{
	out.println("µÇÂ½Ê§°Ü£¬Çë¼ì²éÓÃ»§ÃûºÍÃÜÂë!");
}
	
%>
