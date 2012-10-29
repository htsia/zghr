<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<x:saveState value="#{actionBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{actionBB.actionDetail}" />
	
	<h:panelGrid columns="1" align="center" width="100%" id="dateList"
		styleClass="table02">
		<h:panelGroup>
			<h:panelGrid columns="4" align="center" width="100%"
				columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">

				<h:outputText value="����� "></h:outputText>
				<h:outputText value="#{actionBB.actionBO.act_name}"></h:outputText>
				<h:outputText value="���ʽ "></h:outputText>
				<h:outputText value="#{actionBB.actionBO.act_method}"></h:outputText>

				<h:outputText value="��  ��  �� "></h:outputText>
				<h:outputText value="#{actionBB.actionBO.create_or}"></h:outputText>
				<h:outputText value="��   �� "></h:outputText>
				<h:outputText value="#{actionBB.actionBO.customerName}"></h:outputText>

				<h:outputText value="״  ̬"></h:outputText>
				<h:outputText value="#{actionBB.actionBO.status}"></h:outputText>
				<h:outputText value="��  ��"></h:outputText>
				<h:outputText value="#{actionBB.actionBO.level}"></h:outputText>

			</h:panelGrid>


			<h:panelGroup>
				<h:panelGrid columns="2" align="center" width="100%" columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">
					<h:outputText value="���ַ "></h:outputText>
					<h:outputText value="#{actionBB.actionBO.act_addr}"></h:outputText>

					<h:outputText value="��ɽ��"></h:outputText>
					<h:outputText value="#{actionBB.actionBO.result}"></h:outputText>
				</h:panelGrid>
			</h:panelGroup>
			
		</h:panelGroup>

		<h:panelGroup>
			<h:panelGrid columns="1" width="100%">
				<h:panelGrid align="left">
					<h:outputText value="�ճ̰���   :"></h:outputText>
				</h:panelGrid>

				<h:panelGrid columns="4" styleClass="td_form01" width="100%"
					columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">
					<h:outputText value="��ʼ����   "></h:outputText>
					<h:outputText value="#{actionBB.actionBO.begin_date}"></h:outputText>


					<h:outputText value="��ʼʱ��   "></h:outputText>
					<h:outputText value="#{actionBB.actionBO.begin_time}"></h:outputText>

					<h:outputText value="��������   "></h:outputText>
					<h:outputText value="#{actionBB.actionBO.end_date}"></h:outputText>

					<h:outputText value="����ʱ��   "></h:outputText>
					<h:outputText value="#{actionBB.actionBO.end_time}"></h:outputText>

				</h:panelGrid>

				<h:panelGrid columnClasses="td_form01,td_middle_left" columns="2" width="100%">
					<h:outputText value="��ǰ����ʱ��   "></h:outputText>
					<h:outputText value="#{actionBB.actionBO.alert_day}"></h:outputText>
				</h:panelGrid>

			</h:panelGrid>
		</h:panelGroup>
	</h:panelGrid>
</h:form>









