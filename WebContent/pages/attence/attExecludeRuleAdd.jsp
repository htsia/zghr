<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function add() {
		var attname = document.all('form1:attname').value;
		if (attname != null  &&   attname != "") {
			return true;
		}else{
            alert("�������Ʋ���Ϊ�ա�");
            return false;
		} 
	}
</script>
<x:saveState value="#{attexecluderuletBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{attexecluderuletBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{attexecluderuletBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->�Ƿ���������ù��� " />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="��������"></h:outputText>
			<h:panelGrid columns="1" width="100%" align="left">
				<h:inputText readonly="true" styleClass="input" size="30"
					value="#{attexecluderuletBB.superName}" />
			</h:panelGrid>
			<h:outputText value="����"></h:outputText>
			<h:inputText id="attname" value="#{attexecluderuletBB.bo.ruleName}"
				size="27"></h:inputText>
			<h:outputText value="Ӧ�÷�Χ"></h:outputText>
			<h:selectOneMenu value="#{attexecluderuletBB.atttype}"
				valueChangeListener="#{annualRuleBB.changeStatus}">
				<c:selectItem itemLabel="#{attexecluderuletBB.superName}"
					itemValue="#{attexecluderuletBB.superId}"></c:selectItem>
				<c:selectItem itemLabel="ȫ������Ч" itemValue="-1"></c:selectItem>
			</h:selectOneMenu>
			<h:outputText value="����ʱ��" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="12"
					alt="����ʱ��|0|d" value="#{attexecluderuletBB.bo.createDate}"
					readonly="true" />
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpCalendarDialog('form1:beginTime');" />
			</h:panelGroup>
			<h:outputText value="����"></h:outputText>
			<h:inputTextarea id="place" value="#{attexecluderuletBB.bo.description}"
				cols="35" rows="5"></h:inputTextarea>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return add();" action="#{attexecluderuletBB.save}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


