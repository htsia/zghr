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
	    //��½�ɹ��Ļ���user��ɹ������������׳��쳣
		//String loginName = request.getParameter("name");
		//String password = request.getParameter("password"); 
		//��ȡ��Ҫ����ļӰ��������
		IAttBusiService attBusiService = (IAttBusiService) SysContext
				.getBean("attBusiServiceImpl");
		User user = (User)session.getAttribute("USER_INFO");
		//��üӰ����뵥��Ŀ
		int overtimeNumber = attBusiService.queryOvertimeAuditTask(user.getUserId()).size();
		out.println(overtimeNumber+",");

		//��ȡ��Ҫ����Ĺ����������
		int outNumber = attBusiService.queryOutAuditTask(user.getUserId()).size();
		out.println(outNumber+",");

		//��ȡ��Ҫ����ĵ����������
		int restNumber = attBusiService.queryRestAuditTask(user.getUserId()).size();
		out.println(restNumber+",");
		
		//��ȡ��Ҫ���������������
		int leaveNumber = attBusiService.queryLeaveAuditTask(user.getUserId()).size();
		out.println(leaveNumber+",");
		out.println(user.getName());
%>

