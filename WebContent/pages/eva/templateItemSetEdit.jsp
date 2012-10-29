<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{eva_templateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_templateBB.initItemSet}"/>
    <h:inputHidden id="templateID" value="#{eva_templateBB.templateID}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="�ϼ��ڵ�"></h:outputText>
            <h:panelGroup>
                <h:inputText id="parentname" readonly="true" value="#{eva_templateBB.itemsetbo.parentName}" />
                <h:inputHidden id="parentid" value="#{eva_templateBB.itemsetbo.parentID}" />
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpItemSetTwoControl(document.all('form1:templateID').value,document.all('form1:parentid'),document.all('form1:parentname'))"/>
            </h:panelGroup>

            <h:outputText value="����"/>
            <h:inputText id="name" value="#{eva_templateBB.itemsetbo.setName}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{eva_templateBB.SaveItemSet}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
