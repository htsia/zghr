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
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=A&unitType=ORG">��Ա��ѯ(��Ա)</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=A&unitType=PARTY">��Ա��ѯ(��Ա)</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=B&unitType=ORG">������ѯ</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=C&unitType=ORG">��λ��ѯ</a>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=Q&setType=C&unitType=ORG">����֯��ѯ</a>
    <BR><BR><a href="/pages/qry/SysQueryList.jsf">ϵͳĬ�ϲ�ѯ</a>
    <hr>
    <BR><BR><a href="/qry/QueryIndex.jsf?qsType=S&setType=A&unitType=ORG">��Աͳ��(��Ա)</a>
</center>
</html>