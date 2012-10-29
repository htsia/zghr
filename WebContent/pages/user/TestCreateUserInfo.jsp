<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<html>
<head>
    <title>�û�������</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" language="JavaScript1.2"
            src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/check.js"></script>
    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>
</head>


<c:view>
   <x:saveState value="#{user_testCreateUserInfoBB}"></x:saveState>
    <h:inputHidden value="user_testCreateUserInfoBB.pageInit"></h:inputHidden>
    <h:form id="form1">
        <h:outputText value="---------------------------�û����������ɹ������----------------------"></h:outputText> <br/>

        <h:outputText value="����"></h:outputText>
        <h:inputText styleClass="input"
                     value="#{user_testCreateUserInfoBB.personName}"/><br/>
        <h:outputText value="���֤��"></h:outputText>
        <h:inputText styleClass="input"
                     value="#{user_testCreateUserInfoBB.inNum}"/><br/>
        <h:outputText value="ID"></h:outputText>
        <h:inputText styleClass="input"
                     value="#{user_testCreateUserInfoBB.personId}"/><br/>
        <h:outputText value="OrgId"></h:outputText>
        <h:inputText styleClass="input"
                     value="#{user_testCreateUserInfoBB.orgId}"/><br/>
        <h:commandButton value="����" action="#{user_testCreateUserInfoBB.createuser}"></h:commandButton><br/>
        <h:outputText value="---------------------------���������û�������----------------------"></h:outputText> <br/>

        <h:commandButton value="���������û���" action="#{user_testCreateUserInfoBB.batchBuildUserInfo}"></h:commandButton>
    </h:form>
</c:view>
</html>
