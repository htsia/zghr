<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<%
	String setID=request.getParameter("setID");
	User user=(User)session.getAttribute(Constants.USER_INFO);
	String base="/employee/info/PersonSubSetQueryList.jsf?flag=2&type=0&setId="+setID+"&fk="+user.getUserId();
%>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	window.location="<%=base%>";
</script>

