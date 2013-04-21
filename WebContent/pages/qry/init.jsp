<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="../include/taglib.jsp" %>

<html>
<head><title>
</title></head>

<body>
<%
response.setHeader("Expires","Tues,01 Jan 1980 00:00:00 GMT");
    User u = new User();
    u.setOrgId("10000");
    u.setUserId("10000001");
    session.setAttribute(Constants.USER_INFO, u);
%>
</body>
<center>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=A&unitType=ORG">人员查询(人员)</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=A&unitType=PARTY">人员查询(党员)</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=B&unitType=ORG">机构查询</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=C&unitType=ORG">岗位查询</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=C&unitType=ORG">党组织查询</a>
    <BR><BR><a href="/pages/qry/SysQueryList.jsf">系统默认查询</a>
    <hr>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=S&setType=A&unitType=ORG">人员统计(人员)</a>
</center>
</html>