<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function doAddItem() {
		var desc = document.all('form1:desc').value;
		var itemId = document.all('form1:itemId').value;
		if(desc != null && desc != ""){
			window
			.showModalDialog(
					"/attence/networkholidayChildAddEdit.jsf?itemId="
							+ itemId,
					null,
					"dialogWidth:"
							+ screen.width
							* 0.6
							+ "px; dialogHeight:"
							+ screen.height
							* 0.6
							+ "px;center:center;resizable:yes;status:no;scroll:yes;");
	        return true;
		}else{
			alert("����û�м����κΰ��顣");
			return false;
		}
	}
	function doEditItem(id) {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window
			.showModalDialog(
					"/attence/networkholidayChildAddEdit.jsf?detailId="
							+ id,
					null,
					"dialogWidth:"
							+ screen.width
							* 0.6
							+ "px; dialogHeight:"
							+ screen.height
							* 0.6
							+ "px;center:center;resizable:yes;status:no;scroll:yes;");
	        return true;
		}else{
			alert("����û�м����κΰ��顣");
			return false;
		}
	}
</script>
<x:saveState value="#{networkholidaychildaddBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit"
		value="#{networkholidaychildaddBB.pageInit}" />
	<h:inputHidden id="itemId" value="#{networkholidaychildaddBB.itemID}" />
	<h:inputHidden id="desc" value="#{networkholidaychildaddBB.groupvalue}" />
	<h:panelGrid styleClass="td_title" width="2300" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="�����ݼ���������" />
		</h:panelGroup>
	</h:panelGrid>

	<h:commandButton value="�ݼ�����" styleClass="button01"
		onclick="return doAddItem();"></h:commandButton>
	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<h:dataTable value="#{networkholidaychildaddBB.lists}" var="list"
			align="center" id="dateList" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="2300">
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:commandButton value="����"
					action="#{networkholidaychildaddBB.saveoraudit}"
					styleClass="button01" rendered="#{list.statusValue=='-1'}">
					<x:updateActionListener
						property="#{networkholidaychildaddBB.detailId}"
						value="#{list.detailId}" />
				</h:commandButton>
				<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
					rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
					action="#{networkholidaychildaddBB.delete}" styleClass="button01">
					<x:updateActionListener
						property="#{networkholidaychildaddBB.detailId}"
						value="#{list.detailId}" />
				</h:commandButton>
				<h:commandButton value="�鿴����" styleClass="button01"
					onclick="showWorkFlowLogByLinkID('#{list.detailId}');"></h:commandButton>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{networkholidaychildaddBB.personName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ʼʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.holidayBegin}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.holidayEnd}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ݼ�����" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.daySpan}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�����������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditCausevalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������˵��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܼ��������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܼ�������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܼ�����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܼ�����˵��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�쵼�������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditCausevalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�쵼������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�쵼����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�쵼����˵��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܾ����������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܾ���������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܾ�������ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�ܾ�������˵��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������Դ�������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������Դ������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������Դ����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������Դ����˵��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditCause}" />
			</h:column>
		</h:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
