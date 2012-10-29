<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.recruit.ucc.impl.ResumeTempUcc" %>
<%@ page import="java.io.File" %>
<%@ page import="java.sql.Clob" %>
<%@ page import="com.hr319wg.recruit.pojo.bo.RecuResumeEmailBO" %>
<%
	out.clear();
	String emailId=request.getParameter("recuMailId");
	ResumeTempUcc ucc=(ResumeTempUcc)SysContext.getBean("resume_tempucc");
	String bo=ucc.getMailContentByMailId(emailId);
	if(bo!=null&&!bo.equals("")){
		out.print(bo);
	}
	
%>
