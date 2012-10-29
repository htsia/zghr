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
                <h:outputText value="ÐÞ¸ÄÃÜÂë"/>
            </h:panelGroup>
        </h:panelGrid>
        <f:verbatim><br></f:verbatim>

        <h:panelGrid columns="2"  width="280" cellpadding="0" border="0" align="center"    styleClass="table03"  columnClasses="td_form01,td_form02">
            <h:outputText value="µÇÂ¼Ãû"/>
            <h:outputText  value="#{user_upPasswordBB.userName}"/>
            <h:outputText value="Ô­ÃÜÂë"/>
            <h:inputSecret value="#{user_upPasswordBB.oldPassword}" alt="Ô­ÃÜÂë|0|s|50" styleClass="input"/>
            <h:outputText value="ÐÂÃÜÂë"/>
            <h:inputSecret value="#{user_upPasswordBB.newPassword}" alt="ÐÂÃÜÂë|0|s|50" styleClass="input"/>
            <h:outputText value="È·ÈÏÃÜÂë"/>
            <h:inputSecret value="#{user_upPasswordBB.confirmPassword}" alt="È·ÈÏÃÜÂë|0|s|50" styleClass="input"/>
        </h:panelGrid>

        <f:verbatim><br></f:verbatim>

        <h:panelGrid columns="1" width="280" cellpadding="0"  align="center" border="0" >
            <h:panelGrid columns="2" align="right">
                <h:commandButton value=" ±£´æ " onclick="return forsubmit(document.forms(0))" action="#{user_upPasswordBB.updatePassword}" styleClass="button01">
                    </h:commandButton>
                <h:commandButton value=" ·µ»Ø " onclick="window.close()" styleClass="button01">
                </h:commandButton>
            </h:panelGrid>
        </h:panelGrid>
</h:form>