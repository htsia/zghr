<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function setData() {
	PopUpCalendarDialog('form1:dimissionDate');
}
function forsave() {
	
}
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.dimissionInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->离职说明" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="cener">
		<h:panelGrid columns="3" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
			<h:outputText value="是否离职"/>
			<c:verbatim>
			<input name="fretype" checked="checked" value="1" type="radio"/>是
				<input name="fretype" value="0" type="radio"/>否				
			</c:verbatim>
			<h:outputText></h:outputText>
			<h:outputText value="离职日期："></h:outputText>
		<h:inputText id="dimissionDate" readonly="true" value="#{attCalcMgrBB.dimissionDate}"
			styleClass="input" size="10" />
		<h:commandButton onclick="return setData();"
			styleClass="button_select" value="" />		
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();"  action="#{attCalcMgrBB.updateDimissionDate}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


