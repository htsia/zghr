<%@page import="org.codehaus.groovy.ast.stmt.TryCatchStatement"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.user.ucc.IUserManageUCC"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.user.web.LoginBackingBean"%>
<%@ page import="com.hr319wg.common.exception.SysException;"%>
<%
	//String loginName = request.getParameter("loginName");
	//String password = request.getParameter("password");
	//��½�ɹ��Ļ���user��ɹ������������׳��쳣
		String loginName = request.getParameter("name");
		String password = request.getParameter("password");
		if(password==null||"".equals(password)){
			out.println("��½ʧ�ܣ������û���������!");
			return;
		}else{
		try {
			IUserManageUCC userucc = (IUserManageUCC) SysContext
					.getBean("user_userManageUccImpl");
			User user = userucc.verifyLogon(loginName, null, password, session,
					request);
			session.setAttribute("loginName",loginName);
			session.setAttribute("USER_INFO",user);
		} catch (SysException e) {
			out.println("��½ʧ�ܣ������û���������!");
			return;
		}
			
		}
		response.sendRedirect("/Logininterface.jsf");
%>

