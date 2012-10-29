<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>总量计划调整</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/checkAll.js"></script>
</head>
<x:saveState value="#{wage_grossBB}"/>
<h:inputHidden value="#{wage_grossBB.pageInit}"/>
<%--<h:panelGrid width="98%" align="center" height="30" columnClasses="td_title" bgcolor="#FFFFFF"--%>
                <%--cellpadding="0" cellspacing="0">--%>
    <%--<h:outputText value="   总量维护"/>--%>
<%--</h:panelGrid>--%>
<h:form id="form1">
    <h:panelGrid width="90%" align="center">
        <h:outputText value="发薪单位：#{wage_grossBB.deptName}"/>
        <h:panelGrid columns="4" width="100%" styleClass="table03" align="center"
                        columnClasses="td_form01,td_form02,td_form01,td_form02"
                        >
            <h:outputText value="调整时间 "/>
            <h:panelGroup>
                <h:inputText id="aDate" alt="调整时间|0|d" value="#{wage_grossBB.adjustDate}"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:aDate')"/>
            </h:panelGroup>
            <h:outputText value="调整方式 "/>
            <h:selectOneRadio value="#{wage_grossBB.adjustType}">
                <f:selectItem itemValue="1" itemLabel="增加"/>
                <f:selectItem itemValue="2" itemLabel="减少"/>
                <f:selectItem itemValue="3" itemLabel="实际值"/>
            </h:selectOneRadio>

            <h:outputText value="选择调整指标 "/>
            <h:selectOneMenu value="#{wage_grossBB.adjustItem}">
                <f:selectItem itemValue="1" itemLabel="年初应付工资余额"/>
                <f:selectItem itemValue="2" itemLabel="当年工资计划总量"/>
                <f:selectItem itemValue="3" itemLabel="预留次年发放工资"/>
                <%--<f:selectItem itemValue="4" itemLabel="年度内可用工资总量"/>--%>
                <f:selectItem itemValue="5" itemLabel="已用工资总量"/>
                <%--<f:selectItem itemValue="6" itemLabel="当年可用余额"/>--%>
                <f:selectItem itemValue="7" itemLabel="多头发放调整项"/>
            </h:selectOneMenu>
            <h:outputText value="额度 "/>
            <h:panelGroup>
                <h:inputText alt="额度|0|f" value="#{wage_grossBB.adjustMoney}"/>
                <h:outputText value="(元)"/>
            </h:panelGroup>

            <h:outputText value="说明 "/>
            <h:inputTextarea cols="80" rows="4" value="#{wage_grossBB.adjustDesc}"/>
        </h:panelGrid>
        <h:panelGrid columns="2" align="center" cellpadding="0" cellspacing="2">
            <h:commandButton id="submit" styleClass="button01" value="确定"
                             onclick="if(forsubmit(document.form1))return confirm('确定要调整吗？');else return false;"
                             action="#{wage_grossBB.updateGross}"/>
            <h:commandButton id="cancel" styleClass="button01" value="返回"
                             onclick="location='GrossView.jsf?act=list&unitId=#{wage_grossBB.deptId}';return false;"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
</html>