<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<x:saveState value="#{attcaclruleBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{attcaclruleBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{attcaclruleBB.superID}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���-> ���ÿ��ڼ������" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="Ӧ�÷�Χ"></h:outputText>
			<h:inputText readonly="true" id="classnamevalue" size="27"
				value="#{attcaclruleBB.superName}"></h:inputText>
			<h:outputText value="����ˢ��" />
			<h:selectOneRadio value="#{attcaclruleBB.caclLaterStatuss}">
				<f:selectItem itemValue="0" itemLabel="������" />
				<f:selectItem itemValue="1" itemLabel="����" />
			</h:selectOneRadio>
			<h:outputText value="����ˢ��" />
			<h:selectOneRadio value="#{attcaclruleBB.caclEarlyStatuss}">
				<f:selectItem itemValue="0" itemLabel="������" />
				<f:selectItem itemValue="1" itemLabel="����"/>
			</h:selectOneRadio>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" action="#{attcaclruleBB.save}"
				styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>


