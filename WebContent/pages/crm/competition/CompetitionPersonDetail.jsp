<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{compPersonBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden  value="#{compPersonBB.editInit}"/>
	
	<h:panelGrid columns="1" styleClass="td_title" width="100%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="人员管理 - > 查看 "></h:outputText>
		</h:panelGroup>
	</h:panelGrid>
	
	
	<h:panelGrid columns="1" align="center" width="100%" id="dateList"
		styleClass="table02">
		<h:panelGroup>
			<h:panelGrid columns="4" align="center" width="100%"
				columnClasses="td_form01,td_middle_left,td_form01,td_middle_left">

				<h:outputText value="姓名"></h:outputText>
				 <h:outputText value="#{compPersonBB.compPersonBO.personName}"   ></h:outputText>
				<h:outputText value="性别"></h:outputText>
				 <h:outputText   value="#{compPersonBB.compPersonBO.sex}" ></h:outputText>

				<h:outputText value="手机"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.mobile}"></h:outputText>
				<h:outputText value="家庭电话"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.officeTel}"></h:outputText>
 
 				<h:outputText value="QQ"></h:outputText>
				<h:outputText    value="#{compPersonBB.compPersonBO.qq}"></h:outputText>
				<h:outputText value="eMail"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.email}"></h:outputText>
				
				<h:outputText value="MSN"></h:outputText>
				 <h:outputText    value="#{compPersonBB.compPersonBO.msn}"></h:outputText>
				<h:outputText value="传真"></h:outputText>
				<h:outputText    value="#{compPersonBB.compPersonBO.fax}"></h:outputText>
				
				<h:outputText value="职位"></h:outputText>
			    <h:outputText    value="#{compPersonBB.compPersonBO.duty}"></h:outputText>
			</h:panelGrid>

		</h:panelGroup>
	</h:panelGrid>
</h:form>
 

