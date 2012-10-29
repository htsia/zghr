<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{cocalAmerceStdSetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{cocalAmerceStdSetBB.initItem}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="���"/>
            <h:inputText id="itemNum" value="#{cocalAmerceStdSetBB.itembo.itemNum}" />
            <h:outputText value="�ȼ�"/>
            <h:selectOneMenu value="#{cocalAmerceStdSetBB.itembo.riskGrade}">
            	<c:selectItem itemLabel="A��" itemValue="A"/>
            	<c:selectItem itemLabel="B��" itemValue="B"/>
            	<c:selectItem itemLabel="C��" itemValue="C"/>
            </h:selectOneMenu>
            <h:outputText value="�۷ֱ�׼"/>
            <h:inputText id="itemScore" value="#{cocalAmerceStdSetBB.itembo.itemScore}" />
            <h:outputText value="����"/>
            <h:inputText id="amerce" value="#{cocalAmerceStdSetBB.itembo.amerce}" />
            <h:outputText value="��Ŀ����"/>
            <h:inputTextarea value="#{cocalAmerceStdSetBB.itembo.itemName}" cols="60" rows="5"></h:inputTextarea>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{cocalAmerceStdSetBB.saveStd}"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
