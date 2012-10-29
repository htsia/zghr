<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" language="javascript">
	function setData() {
		PopUpCalendarDialog('form1:backDate');
	}
</script>
<x:saveState value="#{attLeaveApplyBB}" />
<h:inputHidden id="initEdit" value="#{attLeaveApplyBB.leaveBackInit}" />
<h:form id="form1">
    <h:inputHidden id="leaveBackDate" value="#{attLeaveApplyBB.leaveBackDate}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 考勤管理 ->销假" />
		</h:panelGroup>
	</h:panelGrid>
        <h:panelGrid columns="1" width="100%" align="cener">
		<h:panelGrid columns="3" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
		<h:outputText value="选择日期："></h:outputText>
		<h:inputText id="backDate" value="#{attLeaveApplyBB.leaveBackDate}"
			styleClass="input" size="10" />
		<h:commandButton onclick="return setData();"
			styleClass="button_select" value="" />
		</h:panelGrid>
		</h:panelGrid>		
	
	<h:panelGrid align="right">
		<h:commandButton value="确认" styleClass="button01"
			action="#{attLeaveApplyBB.leaveBack}" />
	</h:panelGrid>

</h:form>
<script type="text/javascript">
	interpret(document.forms(0));
</script>