<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{eLearn_questionLibBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eLearn_questionLibBB.initset}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="上级节点"></h:outputText>
            <h:panelGroup>
                <h:inputText id="parentname" readonly="true" value="#{eLearn_questionLibBB.setbo.parentName}" />
                <h:inputHidden id="parentid" value="#{eLearn_questionLibBB.setbo.parentID}" />
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpQuestionLibTwoControl(document.all('form1:parentid'),document.all('form1:parentname'))"/>
            </h:panelGroup>

            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{eLearn_questionLibBB.setbo.libName}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eLearn_questionLibBB.SaveLib}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
