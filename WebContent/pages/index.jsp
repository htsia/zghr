<%@page import="com.hr319wg.sys.pojo.bo.ParameterBO"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.dao.ParameterDAO"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首页</title>
</head>
<body>
	<%
		ParameterDAO dao = (ParameterDAO) SysContext.getBean("sys_parameterDAO");
	    ParameterBO bo = dao.getParameter("SYS_FIRSTPAGE");
	    if(bo!=null){
			response.sendRedirect(bo.getValue());
	    }else{
			response.sendRedirect("/MainInterface/FirstPage.jsf");	    	
	    }
	%>
</body>
</html>