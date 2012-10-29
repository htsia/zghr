<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{autorearrangelistBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{autorearrangelistBB.initEdit}" />
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" 考勤管理 ->人员存休信息列表" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="2" cellspacing="2" width="89%" align="center">
		<h:panelGroup>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="2" align="center" width="90%">
		<h:panelGrid columns="5" cellspacing="2">

		</h:panelGrid>
	</h:panelGrid>

	<h:dataTable value="#{autorearrangelistBB.dateList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="姓名" />
			</c:facet>
			<h:outputText value="#{list.personName}" />
		</h:column>
		<h:column>
			<c:facet name="header">
				<h:outputText value="年月" />
			</c:facet>
			<h:outputText value="#{list.attenceDay}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="月初值" />
			</c:facet>
			<h:outputText value="#{list.beginMonthValue}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="增加" />
			</c:facet>
			<h:outputText value="#{list.monthAdd}" />
		</h:column>
		
				<h:column>
			<c:facet name="header">
				<h:outputText value="减少" />
			</c:facet>
			<h:outputText value="#{list.monthRemove}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="月末值" />
			</c:facet>
			<h:outputText value="#{list.endMonthValue}" />
		</h:column>
	</h:dataTable>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
