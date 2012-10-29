<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@page import="java.io.InputStream"%>
<%@page import="com.hr319wg.common.web.SysContext" %>
<%@page import="com.hr319wg.xys.workflow.service.ActivitiToolsService" %>
<%
    ActivitiToolsService tools=(ActivitiToolsService)SysContext.getBean("activitiToolService");
    String processDefinitionId=request.getParameter("processDefinitionId");
	InputStream is =tools.getProcessImg(processDefinitionId) ;
	
	byte[] b = new byte[1024];
	int len = -1;
	while((len = is.read(b, 0, 1024)) != -1) {
		response.getOutputStream().write(b, 0, len);
		// ·ÀÖ¹Òì³££ºgetOutputStream() has already been called for this response
		out.clear();
		out = pageContext.pushBody();
	}	

%>


