<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
	
</c:verbatim>
<script type="text/javascript">
   
</script>
<x:saveState value="#{coalTaskMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{coalTaskMgrBB.initEdit}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
        	<h:outputText value="任务内容"/>
        	<h:inputTextarea value="#{coalTaskMgrBB.taskbo.taskContent}" rows="5" cols="60"></h:inputTextarea>
        	<h:outputText value="任务日期"/>
            <h:panelGroup>
            	<h:inputText id="taskTime" value="#{coalTaskMgrBB.taskbo.taskTime}" readonly="true"></h:inputText>
            	<h:commandButton type="button" styleClass="button_select" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',el:'form1:taskTime'})"></h:commandButton>
            </h:panelGroup>
            <h:outputText value="值班负责人"/>
            <h:panelGroup>
            	<h:inputText id="personName" value="#{coalTaskMgrBB.taskbo.personName}" />
            	<h:inputHidden value="#{coalTaskMgrBB.taskbo.taskMaster}"></h:inputHidden>
               <h:commandButton styleClass="button_select" value="" onclick="return fPopUpBackPerTreeDlg('');" action="#{coalTaskMgrBB.selPerson}" />
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{coalTaskMgrBB.saveTask}"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
