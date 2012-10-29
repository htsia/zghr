<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){
		var chuqinlv = document.all("form1:chuqinlv").value;
		if(chuqinlv!='' && isNaN(chuqinlv)){
			alert("出勤率应为数字");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{evaWageBB}" />
<h:inputHidden value="#{evaWageBB.editWageInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="绩效基础信息修改" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="考核结果等级"/>
			<h:inputText id="level" value="#{evaWageBB.evaWage.resultLevel}" styleClass="input" size="30"/>
			<h:outputText value="出勤率"/>
			<h:inputText id="chuqinlv" value="#{evaWageBB.evaWage.chuqinlv}" styleClass="input" size="30"/>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();" action="#{evaWageBB.saveEvaWage}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>