<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.api.ActivePageAPI"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String password = request.getParameter("para");
	ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
	String sql = "select count(*) from SYS_PARAMETER t where t.para_key='SYS_PASSWORD' and t.para_value='"+password+"'";
	int count = api.queryForInt(sql);
	out.print(count);
%>