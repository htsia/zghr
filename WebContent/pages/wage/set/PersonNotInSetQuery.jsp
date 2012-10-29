<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title>查询未分配账套人员</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>
<body>
<c:view>
<x:saveState value="#{wage_personQueryBB}"/>
<h:inputHidden id="pageInit" value="#{wage_personQueryBB.pageInit}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="1" width="95%"  align="center" >
        <h:outputText value="发薪单位:#{wage_personQueryBB.unitName}"/>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="false"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
    </jsp:include>
</h:form>
</c:view>
</body>
</html>