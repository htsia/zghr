<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forSave(){
            return forsubmit(document.forms(0));
        }
    </script>

<x:saveState value="#{cont_codeinfoBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{cont_codeinfoBB.pageInit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="��������"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="orguid" code="" dict="yes" dict_num="OU"
                             readonly="true" value="#{cont_codeinfoBB.contCodeInfo.orguid}"
                             alt="����|0|s|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgOnlyDlg('form1:orguid',2)"/>
            </h:panelGroup>


            <h:outputText value="����һ����"/>
            <h:inputText value="#{cont_codeinfoBB.contCodeInfo.low1}" />
            <h:outputText value="����һ����"/>
            <h:inputText value="#{cont_codeinfoBB.contCodeInfo.high1}" />

            <h:outputText value="���������"/>
            <h:inputText value="#{cont_codeinfoBB.contCodeInfo.low2}" />
            <h:outputText value="���������"/>
            <h:inputText value="#{cont_codeinfoBB.contCodeInfo.high2}" />

            <h:outputText value="����������"/>
            <h:inputText value="#{cont_codeinfoBB.contCodeInfo.low3}" />
            <h:outputText value="����������"/>
            <h:inputText value="#{cont_codeinfoBB.contCodeInfo.high3}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{cont_codeinfoBB.save}" onclick="forSave();" />
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>

