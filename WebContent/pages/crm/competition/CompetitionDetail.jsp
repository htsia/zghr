<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<x:saveState value="#{competitionBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{competitionBB.editInit}" />
	<h:panelGrid columns="1" align="center" width="100%" id="dateList"
		styleClass="table02">
		<h:panelGroup>
			<h:panelGrid columns="4" align="center" width="100%"
				columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">

				<h:outputText value="公司名称"></h:outputText>
				<h:outputText value="#{competitionBB.competitionBO.compeName}"></h:outputText>
				<h:outputText value="国 籍  "></h:outputText>
				<h:outputText value="#{competitionBB.competitionBO.nation}"></h:outputText>

				<h:outputText value="城市 "></h:outputText>
				<h:outputText value="#{competitionBB.competitionBO.city}"></h:outputText>
				<h:outputText value="邮编 "></h:outputText>
				<h:outputText value="#{competitionBB.competitionBO.zip}"></h:outputText>

				<h:outputText value="#{customerBB.customerBO.cu_type}"></h:outputText>
				<h:outputText value="网站 "></h:outputText>
				<h:outputText value="#{competitionBB.competitionBO.webUrl}"></h:outputText>
			</h:panelGrid>

			<h:panelGroup>
				<h:panelGrid columns="2" align="center" width="100%"
					columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">
					<h:outputText value="客户地址 "></h:outputText>
					<h:outputText value="#{competitionBB.competitionBO.compeAddr}"></h:outputText>

					<h:outputText value="客户描述 "></h:outputText>
					<h:outputText styleClass="f08"
						value="#{competitionBB.competitionBO.description}"></h:outputText>
				</h:panelGrid>
			</h:panelGroup>

		</h:panelGroup>
	</h:panelGrid>
</h:form>

