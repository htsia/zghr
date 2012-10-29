<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{personevectionBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{personevectionBB.initEdit2}" />
	<h:panelGrid styleClass="td_title" width="2300" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڳ�����Ϣ�鿴" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<f:verbatim>
			<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
		</f:verbatim>
		<x:dataTable value="#{personevectionBB.persBos3}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="2300">
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:commandButton value="�鿴����" styleClass="button01"
					onclick="showWorkFlowLogByLinkID('#{list.evcctionNO}');"></h:commandButton>
			</h:column>
			<h:column>
				<c:facet name="header">
					<h:outputText value="���" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.personName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.personGroupIDName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.superFlIdName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.evcctionTypeName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.applyDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ʼʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.beginTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.endTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:outputText escape="false" value="#{list.reason}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="Ŀ�ĵ�" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.dest}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��������(�ϼ�)" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.lastDate}" />
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
					<h:outputText value="�����쵼�������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditCausevalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�����쵼������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�����쵼����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�����쵼����˵��" styleClass="td03" />
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
		</x:dataTable>
		<f:verbatim>
			</div>
		</f:verbatim>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
