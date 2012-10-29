<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>

<body>
<x:saveState value="#{wage_fbstandardBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="unitId" value="#{wage_fbstandardBB.standard.unitId}"/>
    <h:inputHidden id="stdId" value="#{wage_fbstandardBB.standard.stdId}"/>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid align="right" columns="3" cellspacing="2">
            <h:commandButton styleClass="button01" value="上一步" action="#{wage_fbstandardBB.step3_setValue}"/>
            <h:commandButton styleClass="button01" value="保存" action="#{wage_fbstandardBB.save}"
                             onclick="return forsubmit(document.forms(0))"/>
            <h:commandButton styleClass="button01" value="取消返回" action="#{wage_fbstandardBB.list}"/>
        </h:panelGrid>
        <h:panelGrid width="100%" align="center" styleClass="table03" columns="2" columnClasses="td_form01,td_form02">
            <h:outputText value="标准表名称"/>
            <h:inputText id="name" value="#{wage_fbstandardBB.standard.name}" alt="标准表名称|0" size="40" maxlength="50"/>
            <h:outputText value="标准表编号"/>
            <h:inputText id="no" value="#{wage_fbstandardBB.standard.number}" alt="标准表编号|0" size="40" maxlength="4"/>
            <h:outputText value="执行时间"/>
            <h:panelGroup>
                <h:inputText id="rDate" value="#{wage_fbstandardBB.standard.runDate}" alt="执行时间|0|d" size="14" />
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:rDate')"/>
            </h:panelGroup>
            <h:outputText value="标准表描述"/>
            <h:inputTextarea id="desc" value="#{wage_fbstandardBB.standard.desc}" cols="80" rows="6"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
</body>
</html>