<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<x:saveState value="#{att_class_detailBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{att_class_detailBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->时间设置" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="时间:"/>
			<h:panelGroup>
				<h:selectOneMenu value="#{att_class_detailBB.newDetailValue}"
					valueChangeListener="#{att_class_detailBB.changeDetailValue}">
					<c:selectItems value="#{att_class_detailBB.detailList}"></c:selectItems>
				</h:selectOneMenu>
				<h:outputText value=" : "/>
				<h:selectOneMenu value="#{att_class_detailBB.newDetailValue1}"
					valueChangeListener="#{att_class_detailBB.changeDetailValue1}">
					<c:selectItems value="#{att_class_detailBB.detailList1}"></c:selectItems>
				</h:selectOneMenu>
				<h:outputText value=" (时:分)"/>
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:panelGroup>
				<h:commandButton value="保存" action="#{att_class_detailBB.add}"
					styleClass="button01" />
				<h:outputText value="  "/>
				<h:commandButton value="取消" action="#{att_class_detailBB.del}"
					styleClass="button01" />
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
</h:form>


