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
                <h:outputText value="�޸�����"/>
            </h:panelGroup>
        </h:panelGrid>
        <f:verbatim><br></f:verbatim>

        <h:panelGrid columns="2"  width="280" cellpadding="0" border="0" align="center"    styleClass="table03"  columnClasses="td_form01,td_form02">
            <h:outputText value="��¼��"/>
            <h:outputText  value="#{user_upPasswordBB.userName}"/>
            <h:outputText value="ԭ����"/>
            <h:inputSecret value="#{user_upPasswordBB.oldPassword}" alt="ԭ����|0|s|50" styleClass="input"/>
            <h:outputText value="������"/>
            <h:inputSecret value="#{user_upPasswordBB.newPassword}" alt="������|0|s|50" styleClass="input"/>
            <h:outputText value="ȷ������"/>
            <h:inputSecret value="#{user_upPasswordBB.confirmPassword}" alt="ȷ������|0|s|50" styleClass="input"/>
        </h:panelGrid>

        <f:verbatim><br></f:verbatim>

        <h:panelGrid columns="1" width="280" cellpadding="0"  align="center" border="0" >
            <h:panelGrid columns="2" align="right">
                <h:commandButton value=" ���� " onclick="return forsubmit(document.forms(0))" action="#{user_upPasswordBB.updatePassword}" styleClass="button01">
                    </h:commandButton>
                <h:commandButton value=" ���� " onclick="window.close()" styleClass="button01">
                </h:commandButton>
            </h:panelGrid>
        </h:panelGrid>
</h:form>