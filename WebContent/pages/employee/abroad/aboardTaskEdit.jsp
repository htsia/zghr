<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>
<x:saveState value="#{aboradtaskMannageBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{aboradtaskMannageBB.initEdit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" �������� -> ��������༭"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
        	<h:outputText value="����Ŀ��"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="aim" code="" dict="yes" dict_num="0385"
                             readonly="true" value="#{aboradtaskMannageBB.aboradTaskbo.aim}"
                             alt="��������|0|s|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:aim')">
                </c:verbatim>
             </h:panelGroup>
            <h:outputText value="��������"/>
            <h:inputTextarea id="task" value="#{aboradtaskMannageBB.aboradTaskbo.task}" cols="75" rows="3" />
        </h:panelGrid>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{aboradtaskMannageBB.saveTask}"
                             onclick="return forCheck();"/>
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>