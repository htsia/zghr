<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title>������Ŀ¼��Ȩ��</title>
</head>

<body>
<x:saveState value="#{ins_inputBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{ins_inputBB.initEdit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="����"/>
            <h:outputText value="#{ins_inputBB.setName}"></h:outputText>

            <h:outputText value="����" />
            <h:outputText id="name" value="#{ins_inputBB.personName}"/>

            <h:outputText value="��Ȩ����Ŀ" />
            <h:selectOneMenu value="#{ins_inputBB.wbo.itemID}">
                <c:selectItems value="#{ins_inputBB.itemList}"></c:selectItems>
            </h:selectOneMenu>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{ins_inputBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

</body>
</html>