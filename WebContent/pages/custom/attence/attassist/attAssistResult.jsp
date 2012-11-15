<%@page import="com.hr319wg.sys.cache.SysCache"%>
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
<%@ page
	import="com.hr319wg.custom.attence.web.AttLeaveAuditBackingBean"%>
<%@ page
	import="com.hr319wg.custom.attence.service.IAttBusiService"%>
<%@ page
	import="com.hr319wg.custom.attence.web.AttOvertimeAuditBackingBean"%>
<%@ page import="com.hr319wg.custom.attence.web.AttOutAuditBackingBean"%>
<%@ page import="com.hr319wg.custom.attence.web.AttRestAuditBackingBean"%>
<%@ page import="com.hr319wg.common.exception.SysException"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%
	    //登陆成功的话，user会成功创建，否则，抛出异常
		//String loginName = request.getParameter("name");
		//String password = request.getParameter("password"); 
		//获取需要处理的加班申请个数
		IAttBusiService attBusiService = (IAttBusiService) SysContext
				.getBean("attBusiServiceImpl");
		User user = (User)session.getAttribute("USER_INFO");
		//获得加班申请单数目
		int overtimeNumber = attBusiService.queryOvertimeAuditTask(user.getUserId()).size();
		out.println(overtimeNumber+",");

		//获取需要处理的公出申请个数
		int outNumber = attBusiService.queryOutAuditTask(user.getUserId()).size();
		out.println(outNumber+",");

		//获取需要处理的调休申请个数
		int restNumber = attBusiService.queryRestAuditTask(user.getUserId()).size();
		out.println(restNumber+",");
		
		//获取需要处理的请假申请个数
		int leaveNumber = attBusiService.queryLeaveAuditTask(user.getUserId()).size();
		out.println(leaveNumber+",");
		out.println(user.getName());
%>

