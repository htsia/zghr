<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<x:saveState value="#{att_importRuleListBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{att_importRuleListBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->���������� " />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="����������"></h:outputText>
			<h:selectOneMenu value="#{att_importRuleListBB.atttype}"
				valueChangeListener="#{att_importRuleListBB.changeStatus}">
				<c:selectItem itemLabel="Ա�����" itemValue="5"></c:selectItem>
				<c:selectItem itemLabel="��ϵͳԱ�����" itemValue="6"></c:selectItem>
				<c:selectItem itemLabel="���ڿ���" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="ʱ��" itemValue="2"></c:selectItem>
				<c:selectItem itemLabel="���ڻ���" itemValue="3"></c:selectItem>
				<c:selectItem itemLabel="������־" itemValue="4"></c:selectItem>
			</h:selectOneMenu>
			<h:outputText value="�ֶ�λ��"></h:outputText>
			<h:inputText id="attname1" value="#{att_importRuleListBB.bo.colNum}"></h:inputText>
			<h:outputText value="��ʼλ��"></h:outputText>
			<h:inputText id="attname2"
				value="#{att_importRuleListBB.bo.postStart}"></h:inputText>
			<h:outputText value="����λ��"></h:outputText>
			<h:inputText id="attname3" value="#{att_importRuleListBB.bo.postEnd}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" action="#{att_importRuleListBB.save}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


