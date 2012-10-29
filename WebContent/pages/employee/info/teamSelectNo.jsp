<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{teamMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{teamMgrBB.initSelectNo}"/>
    <h:inputHidden id="pageInit" value="#{teamMgrBB.itemID}"/>
    <h:panelGrid align="center" width="90%">

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="选择任职文号"></h:outputText>
            <h:selectOneMenu id="teamStep" value="#{teamMgrBB.subID}">
               <c:selectItems value="#{teamMgrBB.noList}"></c:selectItems>
            </h:selectOneMenu>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{teamMgrBB.SaveNo}" />
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
