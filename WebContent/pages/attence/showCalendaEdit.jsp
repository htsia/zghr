<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>

</c:verbatim>
<x:saveState value="#{groupCalendarEditBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{groupCalendarEditBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="时间" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="12"
					alt="时间|0|d" value="#{groupCalendarEditBB.bo1.date}"
					readonly="true" />
			</h:panelGroup>
			<h:outputText value="事宜"></h:outputText>
				<h:inputTextarea id="desc"
					value="#{groupCalendarEditBB.bo1.activity}" cols="35" rows="10"></h:inputTextarea>				
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="提交" action="#{groupCalendarEditBB.add}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


