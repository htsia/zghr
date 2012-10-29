<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{setweeksumBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{setweeksumBB.initEdit1}" />
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ���ڹ��� ->�趨��ˮ��ʷ�б�" />
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

	<h:dataTable value="#{setweeksumBB.dateList1}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="Ӧ�÷�Χ" />
			</c:facet>
			<h:outputText value="#{list.orguidName}" />
		</h:column>
		<h:column>
			<c:facet name="header">
				<h:outputText value="ʱ��" />
			</c:facet>
			<h:outputText value="#{list.attenceDate}" />
		</h:column>
		<h:column>
			<c:facet name="header">
				<h:outputText value="�ڼ���" />
			</c:facet>
			<h:outputText value="#{list.attenceWeekDate}" />
		</h:column>
		<h:column>
			<c:facet name="header">
				<h:outputText value="Ԥ����ˮ" />
			</c:facet>
			<h:outputText value="#{list.forecastWater}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="ʵ����ˮ" />
			</c:facet>
			<h:outputText value="#{list.realityWater}" />
		</h:column>
	</h:dataTable>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
