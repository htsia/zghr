<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<x:saveState value="#{punch_cardmessageBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{punch_cardmessageBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->打卡" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="打卡人姓名" styleClass="td03" />
			<h:outputText value="#{punch_cardmessageBB.personName}" />
			<h:outputText value="考勤机名称"></h:outputText>
			<h:selectOneMenu value="#{punch_cardmessageBB.machinevalue}"
				valueChangeListener="#{punch_cardmessageBB.changeMachineValue}">
				<c:selectItems value="#{punch_cardmessageBB.machinevaluelist}"></c:selectItems>
			</h:selectOneMenu>
			<h:outputText value="进/出"></h:outputText>
			<h:selectOneMenu value="#{punch_cardmessageBB.flagvalue}"
				valueChangeListener="#{punch_cardmessageBB.changeFlagValue}">
				<c:selectItems value="#{punch_cardmessageBB.flagvaluelist}"></c:selectItems>
			</h:selectOneMenu>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="打卡"
				action="#{punch_cardmessageBB.punchCard}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


