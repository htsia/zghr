<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>�����ƻ�����</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/checkAll.js"></script>
</head>
<x:saveState value="#{wage_grossBB}"/>
<h:inputHidden value="#{wage_grossBB.pageInit}"/>
<%--<h:panelGrid width="98%" align="center" height="30" columnClasses="td_title" bgcolor="#FFFFFF"--%>
                <%--cellpadding="0" cellspacing="0">--%>
    <%--<h:outputText value="   ����ά��"/>--%>
<%--</h:panelGrid>--%>
<h:form id="form1">
    <h:panelGrid width="90%" align="center">
        <h:outputText value="��н��λ��#{wage_grossBB.deptName}"/>
        <h:panelGrid columns="4" width="100%" styleClass="table03" align="center"
                        columnClasses="td_form01,td_form02,td_form01,td_form02"
                        >
            <h:outputText value="����ʱ�� "/>
            <h:panelGroup>
                <h:inputText id="aDate" alt="����ʱ��|0|d" value="#{wage_grossBB.adjustDate}"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:aDate')"/>
            </h:panelGroup>
            <h:outputText value="������ʽ "/>
            <h:selectOneRadio value="#{wage_grossBB.adjustType}">
                <f:selectItem itemValue="1" itemLabel="����"/>
                <f:selectItem itemValue="2" itemLabel="����"/>
                <f:selectItem itemValue="3" itemLabel="ʵ��ֵ"/>
            </h:selectOneRadio>

            <h:outputText value="ѡ�����ָ�� "/>
            <h:selectOneMenu value="#{wage_grossBB.adjustItem}">
                <f:selectItem itemValue="1" itemLabel="���Ӧ���������"/>
                <f:selectItem itemValue="2" itemLabel="���깤�ʼƻ�����"/>
                <f:selectItem itemValue="3" itemLabel="Ԥ�����귢�Ź���"/>
                <%--<f:selectItem itemValue="4" itemLabel="����ڿ��ù�������"/>--%>
                <f:selectItem itemValue="5" itemLabel="���ù�������"/>
                <%--<f:selectItem itemValue="6" itemLabel="����������"/>--%>
                <f:selectItem itemValue="7" itemLabel="��ͷ���ŵ�����"/>
            </h:selectOneMenu>
            <h:outputText value="��� "/>
            <h:panelGroup>
                <h:inputText alt="���|0|f" value="#{wage_grossBB.adjustMoney}"/>
                <h:outputText value="(Ԫ)"/>
            </h:panelGroup>

            <h:outputText value="˵�� "/>
            <h:inputTextarea cols="80" rows="4" value="#{wage_grossBB.adjustDesc}"/>
        </h:panelGrid>
        <h:panelGrid columns="2" align="center" cellpadding="0" cellspacing="2">
            <h:commandButton id="submit" styleClass="button01" value="ȷ��"
                             onclick="if(forsubmit(document.form1))return confirm('ȷ��Ҫ������');else return false;"
                             action="#{wage_grossBB.updateGross}"/>
            <h:commandButton id="cancel" styleClass="button01" value="����"
                             onclick="location='GrossView.jsf?act=list&unitId=#{wage_grossBB.deptId}';return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
</html>