<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{emp_blacksheetBB}"></x:saveState>
<h:form id="form1">
    <h:panelGrid columns="2" width="95%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
        <h:outputText value="名称"/>
        <h:panelGroup>
            <h:inputText id="name" readonly="true" value="#{emp_blacksheetBB.personNames}"/>
            <h:inputHidden value="#{emp_blacksheetBB.personIds}"></h:inputHidden>
            <h:commandButton value="" styleClass="button_person" onclick="return fPopUpBackPerTreeDlg();" action="#{emp_blacksheetBB.selPerson}"></h:commandButton>
        </h:panelGroup>

        <h:outputText value="原因"></h:outputText>
        <h:inputTextarea value="#{emp_blacksheetBB.addReson}" rows="4" cols="40"></h:inputTextarea>

        <h:outputText value="操作"></h:outputText>
        <h:panelGroup>
            <h:commandButton value="保存" styleClass="button01" action="#{emp_blacksheetBB.save}"></h:commandButton>
            <h:commandButton value="退出" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
        </h:panelGroup>

    </h:panelGrid>
</h:form>