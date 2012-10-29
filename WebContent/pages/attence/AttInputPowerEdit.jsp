<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{att_inputBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{att_inputBB.initEdit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="帐套"/>
            <h:outputText value="#{att_inputBB.setName}"></h:outputText>

            <h:outputText value="姓名" />
            <h:outputText id="name" value="#{att_inputBB.personName}"/>

            <h:outputText value="有权限项目" />
            <h:selectOneMenu value="#{att_inputBB.wbo.itemID}">
                <c:selectItems value="#{att_inputBB.itemList}"></c:selectItems>
            </h:selectOneMenu>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{att_inputBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

