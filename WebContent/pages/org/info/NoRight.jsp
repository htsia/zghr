<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <f:verbatim>
        <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    </f:verbatim>
</head>

<body>
<h:form id="form1">
    <h:panelGrid width="100%" align="center" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" styleClass="td_title">
       <%=LanguageSupport.getResource("JGGL-1102","ÎÞÈ¨ÏÞ")%> 
    </h:panelGrid>
</h:form>
</body>
</html>