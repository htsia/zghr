<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{eva_templateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_templateBB.initItemEdit}"/>
    <h:inputHidden id="templateID" value="#{eva_templateBB.templateID}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="选择指标"></h:outputText>
            <h:panelGroup>
                <h:inputHidden id="linkID" value="#{eva_templateBB.tempitembo.linkID}"></h:inputHidden>
                <h:inputText readonly="true" id="itemName" value="#{eva_templateBB.tempitembo.itemName}"></h:inputText>
                <h:commandButton type="button" onclick="PopUpItemKeyTwoControl(document.all('form1:linkID'),document.all('form1:itemName'))" styleClass="button_select"></h:commandButton>
            </h:panelGroup>

            <h:outputText value="权重%"/>
            <h:inputText id="name" value="#{eva_templateBB.tempitembo.score}" />
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eva_templateBB.SaveItem}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
