<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		var desc = document.all('form1:desc').value;
		if (desc != null && desc != "") {
			window.showModalDialog(
					"/attence/personEvectionMessage.jsf?okID=100", "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.9
							+ "px; status:0;resizable:yes");
			return true;
		} else {
			alert("����û�м����κΰ��顣");
			return false;
		}
	}
	function doEditItem(id) {
		var desc = document.all('form1:desc').value;
		if (desc != null && desc != "") {
			window.showModalDialog(
					"/attence/personEvectionMessage.jsf?evcctionNO=" + id, "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.9
							+ "px; status:0;resizable:yes");
			return true;
		} else {
			alert("����û�м����κΰ��顣");
			return false;
		}
	}
	function doEditItem1(id, id1, id2) {
		window.showModalDialog(
				"/attence/personEvectionMessages.jsf?evcctionNO=" + id
						+ "&flag=" + id1 + "&evcctionCollectNo=" + id2, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.7 + "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem2(id) {
		window.showModalDialog(
				"/attence/personEvectionMessageHistory.jsf?evcctionNO=" + id,
				"", "dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doTimeOff(id) {
		window.showModalDialog(
				"/attence/attTimeOff.jsf?outTimeNo=" + id, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.5 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personevectionBB}" />
<h:form id="form1">
	<h:inputHidden value="#{personevectionBB.pageInit}" />
	<h:inputHidden id="desc" value="#{personevectionBB.groupvalue}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="3">

					<h:panelGroup>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��¼��:#{personevectionBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ҳ��:#{personevectionBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ÿҳ��#{personevectionBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��ǰΪ��#{personevectionBB.mypage.currentPage}ҳ"></h:outputText>

						<h:commandButton value="��ҳ" action="#{personevectionBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{personevectionBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{personevectionBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="βҳ" action="#{personevectionBB.last}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��������" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
						<h:outputText value="����״̬��"></h:outputText>
									<h:selectOneRadio value="#{personevectionBB.status1}"
				onclick="submit();" valueChangeListener="#{personevectionBB.changeStatus1}">
				<f:selectItem itemValue="1" itemLabel="��ͨ��" />
				<f:selectItem itemValue="2" itemLabel="��������" />
			</h:selectOneRadio>
				</h:panelGrid> <f:verbatim></td>
			</tr>

</f:verbatim>
<h:panelGroup rendered="#{personevectionBB.status1=='2'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personevectionBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="2300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="����"
							disabled="#{list.personID!=personevectionBB.userid}"
							action="#{personevectionBB.personEvectionMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener property="#{personevectionBB.evcctionNO}"
								value="#{list.evcctionNO}" />
						</h:commandButton>
						<h:commandButton value="�޸�" styleClass="button01"
							disabled="#{list.personID!=personevectionBB.userid || list.superFlId=='2' || list.superFlId=='3'}"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							onclick="return doEditItem('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							disabled="#{list.personID!=personevectionBB.userid}"
							action="#{personevectionBB.delete}" styleClass="button01"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}">
							<x:updateActionListener property="#{personevectionBB.evcctionNO}"
								value="#{list.evcctionNO}" />
						</h:commandButton>
						<h:commandButton value="��������"
							disabled="#{list.personID!=personevectionBB.userid}"
							onclick="return confirm('ȷ��Ҫ����������?');"
							action="#{personevectionBB.escdelete}" styleClass="button01"
							rendered="#{list.statusValue=='0' || list.statusValue=='1'}">
							<x:updateActionListener property="#{personevectionBB.evcctionNO}"
								value="#{list.evcctionNO}" />
						</h:commandButton>
                        <h:commandButton value="���ݲ鿴" styleClass="button01" onclick="return doTimeOff('#{list.evcctionNO}');"></h:commandButton>						
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.evcctionNO}');"
							rendered="#{list.statusValue!='3'}"></h:commandButton>
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
							<h:outputText value="����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
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
				</h:dataTable> <f:verbatim></div>
				</td>
			</tr>
			
						</f:verbatim>
</h:panelGroup>
<f:verbatim>
			
			</f:verbatim>
<h:panelGroup rendered="#{personevectionBB.status1=='1'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personevectionBB.persBos}" var="list"
					align="center" id="dateList1" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.evcctionNO}','2','#{list.evcctionCollectNo}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.evcctionNO}','3','#{list.evcctionCollectNo}');"></h:commandButton>
						<h:commandButton value="��ϸ��Ϣ" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem2('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="���ݲ鿴" styleClass="button01" onclick="return doTimeOff('#{list.evcctionNO}');"></h:commandButton>
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
							<h:outputText value="����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
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
				</h:dataTable> <f:verbatim></div>
				</td>
			</tr>

			</f:verbatim>
</h:panelGroup>
<f:verbatim>			
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
	setDataTableOver("form1:dateList1");
</script>

