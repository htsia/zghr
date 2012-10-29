<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	 var timevalue=document.all("form1:timevalue").value;
	    if(timevalue==null||timevalue==""){
	        alert("请输入发放时间。");
	        return false;
	    }
	    return true;
	 }
  </script>
<x:saveState value="#{autoclassmanagerBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{autoclassmanagerBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{autoclassmanagerBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->自动排班计划管理" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="应用范围"></h:outputText>
			<h:outputText value="#{autoclassmanagerBB.superName}"></h:outputText>
			<h:outputText value="发放时间"></h:outputText>
			<h:panelGroup>
				<h:inputText id="timevalue" value="#{autoclassmanagerBB.bo.duraYearMonth}"
					readonly="true">
				</h:inputText>
				<f:verbatim>
					<input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:timevalue')">
				</f:verbatim>
			</h:panelGroup>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return test()"
				action="#{autoclassmanagerBB.save}" styleClass="button01" />
		</h:panelGrid>

	</h:panelGrid>
</h:form>


