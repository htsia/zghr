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
			<h:outputText value="考勤管理->导入项设置 " />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="导入项名称"></h:outputText>
			<h:selectOneMenu value="#{att_importRuleListBB.atttype}"
				valueChangeListener="#{att_importRuleListBB.changeStatus}">
				<c:selectItem itemLabel="员工编号" itemValue="5"></c:selectItem>
				<c:selectItem itemLabel="旧系统员工编号" itemValue="6"></c:selectItem>
				<c:selectItem itemLabel="考勤卡号" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="时间" itemValue="2"></c:selectItem>
				<c:selectItem itemLabel="考勤机号" itemValue="3"></c:selectItem>
				<c:selectItem itemLabel="进出标志" itemValue="4"></c:selectItem>
			</h:selectOneMenu>
			<h:outputText value="字段位置"></h:outputText>
			<h:inputText id="attname1" value="#{att_importRuleListBB.bo.colNum}"></h:inputText>
			<h:outputText value="起始位置"></h:outputText>
			<h:inputText id="attname2"
				value="#{att_importRuleListBB.bo.postStart}"></h:inputText>
			<h:outputText value="结束位置"></h:outputText>
			<h:inputText id="attname3" value="#{att_importRuleListBB.bo.postEnd}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" action="#{att_importRuleListBB.save}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


