<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{compPersonBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden  value="#{compPersonBB.editInit}"/>
	
	<h:panelGrid columns="1" styleClass="td_title" width="100%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="��Ա���� - > �鿴 "></h:outputText>
		</h:panelGroup>
	</h:panelGrid>
	
	
	<h:panelGrid columns="1" align="center" width="100%" id="dateList"
		styleClass="table02">
		<h:panelGroup>
			<h:panelGrid columns="4" align="center" width="100%"
				columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">

				<h:outputText value="����"></h:outputText>
				 <h:outputText value="#{compPersonBB.compPersonBO.personName}"   ></h:outputText>
				<h:outputText value="�Ա�"></h:outputText>
				 <h:outputText   value="#{compPersonBB.compPersonBO.sex}" ></h:outputText>

				<h:outputText value="�ֻ�"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.mobile}"></h:outputText>
				<h:outputText value="��ͥ�绰"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.officeTel}"></h:outputText>
 
 				<h:outputText value="QQ"></h:outputText>
				<h:outputText    value="#{compPersonBB.compPersonBO.qq}"></h:outputText>
				<h:outputText value="eMail"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.email}"></h:outputText>
				
				<h:outputText value="MSN"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.msn}"></h:outputText>
				<h:outputText value="����"></h:outputText>
				<h:outputText    value="#{compPersonBB.compPersonBO.fax}"></h:outputText>
				
				<h:outputText value="ְλ"></h:outputText>
			    <h:outputText    value="#{compPersonBB.compPersonBO.duty}"></h:outputText>
			</h:panelGrid>

		</h:panelGroup>
	</h:panelGrid>
</h:form>
 

