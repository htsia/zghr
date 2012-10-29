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
			<h:outputText value="���ڹ���->�޸������Ϣ" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">


			<h:outputText value="��Ա����"></h:outputText>
			<h:panelGroup>
				<h:inputText 
					value="#{annualMgrBB.attannualitembo.personName}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="����ʱ��"></h:outputText>
			<h:panelGroup>
				<h:inputText 
					value="#{annualMgrBB.attannualitembo.workDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="���뱾��λʱ��"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.enterDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="����"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.lengthService}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="��������" styleClass="f07"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.annDay}" readonly="false" id="annDay">
				</h:inputText>
			</h:panelGroup>


			<h:outputText value="��������"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.useDay}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="��������"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.avaDay}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="��������"></h:outputText>
			<h:panelGroup>
				<h:inputText 
					value="#{annualMgrBB.attannualitembo.calcDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="��ǰ�����������"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.calcAnnDay}" readonly="true">
				</h:inputText>
			</h:panelGroup>


			<h:outputText value="�ٽ�����"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.criticalDate}" readonly="true">
				</h:inputText>
			</h:panelGroup>

			<h:outputText value="�ٽ����ں����"></h:outputText>
			<h:panelGroup>
				<h:inputText  
					value="#{annualMgrBB.attannualitembo.criticalAnnDay}"  >
				</h:inputText>
			</h:panelGroup>


		</h:panelGrid>


		<h:panelGrid align="right">
			<h:commandButton value="����"  
				action="#{annualMgrBB.saveOrUpdateAnnItemBO}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


