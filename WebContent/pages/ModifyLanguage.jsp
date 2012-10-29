<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="./include/taglib.jsp" %>
    <%
        response.setHeader("progma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    %>

<x:saveState value="#{user_upPasswordBB}"/>
<h:form id="formModifyPassword">
        <h:inputHidden id="pageInit" value="#{user_upPasswordBB.pageInit}"/>
        <h:panelGrid columns="1" width="280" cellpadding="0"
                        align="center" border="0" columnClasses="td_title">
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="#{user_upPasswordBB.modiLangTitle}"/>
            </h:panelGroup>
        </h:panelGrid>
        <f:verbatim><br></f:verbatim>

        <h:panelGrid columns="2"  width="280" cellpadding="0" border="0" align="center"    styleClass="table03"  columnClasses="td_form01,td_form02">
            <h:outputText value="#{user_upPasswordBB.loginTitle}"/>
            <h:outputText  value="#{user_upPasswordBB.userName}"/>
            <h:outputText value="#{user_upPasswordBB.languageTitle}"/>
            <h:selectOneMenu value="#{user_upPasswordBB.language}">
                <c:selectItem itemValue="zh_cn" itemLabel="简体中文"></c:selectItem>
                <c:selectItem itemValue="zh_tw" itemLabel="繁體中文"></c:selectItem>
                <c:selectItem itemValue="en_us" itemLabel="English"></c:selectItem>
            </h:selectOneMenu>
        </h:panelGrid>

        <f:verbatim><br></f:verbatim>

        <h:panelGrid columns="1" width="280" cellpadding="0"  align="center" border="0" >
            <h:panelGrid columns="2" align="right">
                <h:commandButton value="#{sys_buttonBB.btnSave}" onclick="return forsubmit(document.forms(0))" action="#{user_upPasswordBB.updateLang}" styleClass="button01">
                 </h:commandButton>
                <h:commandButton value="#{sys_buttonBB.btnReturn}" onclick="window.close()" styleClass="button01">
                </h:commandButton>
            </h:panelGrid>
        </h:panelGrid>
</h:form>