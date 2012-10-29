<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{law_editbb}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{law_editbb.pageInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="�ϼ��ڵ�"></h:outputText>
            <h:panelGroup>
                <h:inputText id="parentname" readonly="true" value="#{law_editbb.lawtype.parentTypeName}" />
                <h:inputHidden id="parentid" value="#{law_editbb.lawtype.parentTypeid}" />
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpLawTypeTwoControl(document.all('form1:parentid'),document.all('form1:parentname'))"/>
            </h:panelGroup>

            <h:outputText value="����"/>
            <h:inputText id="name" value="#{law_editbb.lawtype.typeName}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{law_editbb.SaveType}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
