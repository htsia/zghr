<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<c:verbatim>
	<script type="text/javascript">
	function add() {
		var timename = document.all('form1:A00001').value;
		PopUpCalendarDialog('form1:timeObjectID');
		if (timename != null && timename != "") {
			document.all('form1:A00001').value = timename + ","
					+ document.all('form1:timeObjectID').value;
		} else {
			document.all('form1:A00001').value = document
					.all('form1:timeObjectID').value;
		}
	}
</script>
</c:verbatim>
<x:saveState value="#{att_importRuleBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{att_importRuleBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{att_importRuleBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->���������ļ����չ��� " />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="��������"></h:outputText>
			<h:panelGrid columns="1" width="100%" align="left">
				<h:inputText readonly="true" styleClass="input" size="30"
					value="#{att_importRuleBB.superName}" />
			</h:panelGrid>
			<h:outputText value="����"></h:outputText>
			<h:inputText id="attname" value="#{att_importRuleBB.bo.importName}"
				size="27"></h:inputText>
			<h:outputText value="Ӧ�÷�Χ"></h:outputText>
			<h:selectOneMenu value="#{att_importRuleBB.atttype}"
				valueChangeListener="#{att_importRuleBB.changeStatus}">
				<c:selectItem itemLabel="#{att_importRuleBB.superName}"
					itemValue="#{att_importRuleBB.superId}"></c:selectItem>
				<c:selectItem itemLabel="ȫ������Ч" itemValue="-1"></c:selectItem>
			</h:selectOneMenu>

			<h:outputText value="�ļ���ʽ"></h:outputText>
			<h:selectOneMenu value="#{att_importRuleBB.atttype1}"
				valueChangeListener="#{att_importRuleBB.changeStatus1}">
				<c:selectItem itemLabel="�ı��ļ�(*.TXT)" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="EXCEL(*.CSV)" itemValue="2"></c:selectItem>
				<c:selectItem itemLabel="EXCEL(*.XLS)" itemValue="3"></c:selectItem>
			</h:selectOneMenu>

			<h:outputText value="�ı��ļ���ʽ"></h:outputText>
			<h:selectOneMenu value="#{att_importRuleBB.atttype2}"
				valueChangeListener="#{att_importRuleBB.changeStatus2}">
				<c:selectItem itemLabel="���ŷָ�" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="�涨λ��" itemValue="2"></c:selectItem>
			</h:selectOneMenu>

			<h:outputText value="�ָ����"></h:outputText>
			<h:selectOneMenu value="#{att_importRuleBB.atttype3}"
				valueChangeListener="#{att_importRuleBB.changeStatus3}">
				<c:selectItem itemLabel="�Ʊ��" itemValue="TAB"></c:selectItem>
				<c:selectItem itemLabel="����" itemValue=","></c:selectItem>
			</h:selectOneMenu>

			<h:outputText value="ʱ�䴦�����"></h:outputText>
			<h:selectOneMenu value="#{att_importRuleBB.atttype4}"
				valueChangeListener="#{att_importRuleBB.changeStatus4}">
				<c:selectItem itemLabel="Ĭ��(yyyy-MM-dd hh:mm:ss)" itemValue="0"></c:selectItem>
				<c:selectItem itemLabel="12Сʱ��(yyyy-MM-dd AM/PM hh:mm:ss)" itemValue="1"></c:selectItem>
			</h:selectOneMenu>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" action="#{att_importRuleBB.save}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


