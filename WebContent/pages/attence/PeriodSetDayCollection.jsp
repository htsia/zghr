<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{periodsetattcaclinfoBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit"
		value="#{periodsetattcaclinfoBB.dayPageInit}" />
	<h:inputHidden id="personList"
		value="#{periodsetattcaclinfoBB.personList}" />
	<f:verbatim>
		<input type="hidden" name="sessionFlag" value="2">
		<table id=t1 height=98% width="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td class="td_page" height=8></f:verbatim> <h:panelGrid width="95%"
					align="center" border="0" columns="1">

					<h:panelGroup>
						<h:outputText value="当前所在机构:" />
						<h:outputText value="【#{periodsetattcaclinfoBB.superName}】"></h:outputText>
						<h:outputText value="姓名或员工编号："></h:outputText>
						<h:inputText id="name" value="#{periodsetattcaclinfoBB.name}"
							size="10" styleClass="input"
							onkeypress="enterKeyDown('form1:queryPerson')" />
						<h:commandButton value="查询" id="queryPerson" styleClass="button01"
							action="#{periodsetattcaclinfoBB.doQuery}" />
						<h:commandButton styleClass="button01" value="取消查看"
							onclick="window.close();" />
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>

				<td class="td_page" height=8></td>
			</tr>

			<tr>
				<td colspan=2><jsp:include
					page="../common/activepage/ActiveList.jsp">
					<jsp:param name="hasOperSign" value="true" />
					<jsp:param name="operSignType" value="checkbox" />
					<jsp:param name="hasEdit" value="true" />
					<jsp:param name="isEditList" value="false" />
					<jsp:param name="isCheckRight" value="true" />
					<jsp:param name="isForward" value="true" />
					<jsp:param name="isRow" value="false" />
					<jsp:param name="isPage" value="true" />
					<jsp:param name="fixcol" value="4" />
				</jsp:include></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<form id="form2"><input type="hidden" name="perids" /></form>
<script type="text/javascript">
	interpret(document.forms(0));
</script>