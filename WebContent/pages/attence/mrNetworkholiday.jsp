<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		window.showModalDialog("/attence/mrNetworkholidayMessage.jsf?okID=100",
				"", "dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem(id) {
		window.showModalDialog(
				"/attence/mrNetworkholidayMessage.jsf?mimicReportNO=" + id, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{mrnetworkholidayBB}" />
<h:form id="form1">
	<h:inputHidden value="#{mrnetworkholidayBB.pageInit}" />
	<h:inputHidden id="desc" value="#{mrnetworkholidayBB.groupvalue}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="1">

					<h:panelGroup>
						<h:selectBooleanCheckbox value="#{mrnetworkholidayBB.isExist}"
							onclick="submit();"
							valueChangeListener="#{mrnetworkholidayBB.changeNowYearValue}" />
						<h:outputText value="��ʾȫ��" />
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��¼��:#{mrnetworkholidayBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ҳ��:#{mrnetworkholidayBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ÿҳ��#{mrnetworkholidayBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="��ǰΪ��#{mrnetworkholidayBB.mypage.currentPage}ҳ"></h:outputText>

						<h:commandButton value="��ҳ" action="#{mrnetworkholidayBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{mrnetworkholidayBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{mrnetworkholidayBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="βҳ" action="#{mrnetworkholidayBB.last}"
							styleClass="button01"></h:commandButton>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:commandButton value="�ⱨ����" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{mrnetworkholidayBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="3600">
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="����"
							action="#{mrnetworkholidayBB.mrNetWorkHolidayMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener
								property="#{mrnetworkholidayBB.mimicReportNO}"
								value="#{list.mimicReportNO}" />
						</h:commandButton>
						<h:commandButton value="�޸�" styleClass="button01"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							onclick="return doEditItem('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							action="#{mrnetworkholidayBB.delete}" styleClass="button01">
							<x:updateActionListener
								property="#{mrnetworkholidayBB.mimicReportNO}"
								value="#{list.mimicReportNO}" />
						</h:commandButton>
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.mimicReportNO}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ⱨ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personaddworkBB.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.mrYear}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ⶨ�ݼٵص�" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.dest}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ⶨ�ݼ�ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.mrMonth}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="Ӧ�������ݼ٣��죩" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.lastDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText escape="false" value="#{list.applyDate}" />
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
							<h:outputText value="������Դ����Ա�������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditResultvalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ����Ա������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ����Ա����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ����Ա����˵��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditCause}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ�����������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditCausevalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ����������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ��������ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ��������˵��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditCause}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ�����쵼�������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditCausevalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ�����쵼������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ�����쵼����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������Դ�����쵼����˵��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditCause}" />
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
				</h:dataTable> <f:verbatim></div>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>



