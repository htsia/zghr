<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{networkholidayBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{networkholidayBB.initEdit}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤休假天数查看" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<x:dataTable value="#{networkholidayBB.lists1}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					<h:outputText value="序号" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="休假开始时间" />
				</c:facet>
				<h:outputText value="#{list.holidayBegin}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="休假结束时间" />
				</c:facet>
				<h:outputText value="#{list.holidayEnd}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="休假天数" />
				</c:facet>
				<h:outputText value="#{list.daySpan}" />
			</h:column>
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
