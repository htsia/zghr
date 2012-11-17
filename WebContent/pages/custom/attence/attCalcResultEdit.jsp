<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){		
	}
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.modifyInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 数据修改" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="cener">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
			<h:outputText value="员工编号"/>
			<h:outputText value="#{attCalcMgrBB.bo.personCode}"/>
			
			<h:outputText value="姓名" />
			<h:outputText value="#{attCalcMgrBB.bo.personName}"/>
			
			<h:outputText value="迟到" />
			<h:inputText value="#{attCalcMgrBB.lateModify}"/>

			<h:outputText value="旷工" />
			<h:inputText value="#{attCalcMgrBB.awayModify}"/>
			
			<h:outputText value="事假" />
			<h:inputText value="#{attCalcMgrBB.leaveReasonsModify}"/>
			
			<h:outputText value="病假" />
			<h:inputText value="#{attCalcMgrBB.sickModify}"/>
			
			<h:outputText value="产假" />
			<h:inputText value="#{attCalcMgrBB.maternityModify}"/>
			
			<h:outputText value="婚假" />
			<h:inputText value="#{attCalcMgrBB.weddingModify}"/>
			
			<h:outputText value="探亲假" />
			<h:inputText value="#{attCalcMgrBB.homeModify}"/>
			
			<h:outputText value="工伤假" />
			<h:inputText value="#{attCalcMgrBB.industrialInjuryModify}"/>
			
			<h:outputText value="丧假" />
			<h:inputText value="#{attCalcMgrBB.arrangingFuneralModify}"/>
			
			<h:outputText value="公出" />
			<h:inputText value="#{attCalcMgrBB.outModify}"/>
			
			<h:outputText value="加班" />
			<h:inputText value="#{attCalcMgrBB.overtimeModify}"/>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();"  action="#{attCalcMgrBB.save}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


