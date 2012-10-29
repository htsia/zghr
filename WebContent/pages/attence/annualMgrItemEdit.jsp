<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<x:saveState value="#{annualMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{annualMgrBB.annItemEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{annualMgrBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->修改年假信息" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">


			<h:outputText value="人员姓名"></h:outputText>
			<h:panelGroup>
				<h:inputText 
					value="#{annualMgrBB.attannualitembo.personName}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="工作时间"></h:outputText>
			<h:panelGroup>
				<h:inputText 
					value="#{annualMgrBB.attannualitembo.workDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="进入本单位时间"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.enterDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="工龄"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.lengthService}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="假期天数" styleClass="f07"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.annDay}" readonly="false" id="annDay">
				</h:inputText>
			</h:panelGroup>


			<h:outputText value="已休天数"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.useDay}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="可用天数"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.avaDay}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="计算日期"></h:outputText>
			<h:panelGroup>
				<h:inputText 
					value="#{annualMgrBB.attannualitembo.calcDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="当前计算可休天数"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.calcAnnDay}" readonly="true">
				</h:inputText>
			</h:panelGroup>


			<h:outputText value="临界日期"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.criticalDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="临界日期后可休"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.criticalAnnDay}"  >
				</h:inputText>
			</h:panelGroup>


		</h:panelGrid>


		<h:panelGrid align="right">
			<h:commandButton value="保存"  
				action="#{annualMgrBB.saveOrUpdateAnnItemBO}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


