<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function refreshload() {
		setTimeout('myrefresh()', 1000);
	}
	function doAddItem() {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window.showModalDialog("/attence/personLeaveMessage.jsf?okID=100", "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.8 + "px; status:0;resizable:yes");
			return true;
		}else{
			alert("����û�м����κΰ��顣");
			return false;
		}
	}
	function doEditItem(id) {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window.showModalDialog("/attence/personLeaveMessage.jsf?furloughNO="
					+ id, "", "dialogWidth:" + screen.width * 0.6
					+ "px; dialogHeight:" + screen.height * 0.8
					+ "px; status:0;resizable:yes");
			return true;
		}else{
			alert("����û�м����κΰ��顣");
			return false;
		}
	}
	function doEditItem1(id, id1, id2) {
		window.showModalDialog("/attence/personLeaveMessages.jsf?furloughNO="
				+ id + "&flag=" + id1 + "&furloughCollectNO=" + id2, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem2(id) {
		window.showModalDialog(
				"/attence/personLeaveMessagesHistory.jsf?furloughNO=" + id, "",
				"dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doTimeOff(id) {
		window.showModalDialog(
				"/attence/personLeaveNetworkholiday.jsf?furloughNO=" + id, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.5 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
	<h:inputHidden value="#{personleaveBB.pageInit}" />
	<h:inputHidden id="desc" value="#{personleaveBB.groupvalue}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="3">

					<h:panelGroup>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��¼��:#{personleaveBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ҳ��:#{personleaveBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ÿҳ��#{personleaveBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��ǰΪ��#{personleaveBB.mypage.currentPage}ҳ"></h:outputText>

						<h:commandButton value="��ҳ" action="#{personleaveBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{personleaveBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{personleaveBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="βҳ" action="#{personleaveBB.last}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��/��������" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
						<h:outputText value="����״̬��"></h:outputText>
						<h:selectOneRadio value="#{personleaveBB.status1}"
				onclick="submit();" valueChangeListener="#{personleaveBB.changeStatus1}">
				<f:selectItem itemValue="1" itemLabel="��ͨ��" />
				<f:selectItem itemValue="2" itemLabel="��������" />
			</h:selectOneRadio>
				</h:panelGrid> <f:verbatim></td>
			</tr>

</f:verbatim>
<h:panelGroup rendered="#{personleaveBB.status1=='2'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personleaveBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="2300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="����"
							action="#{personleaveBB.PersonLeaveMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="�޸�" styleClass="button01" disabled="#{list.superFlId=='2' || list.superFlId=='3'}"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							onclick="return doEditItem('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							action="#{personleaveBB.delete}" styleClass="button01"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','2','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','3','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="��������"
							onclick="return confirm('ȷ��Ҫ����������?');"
							action="#{personleaveBB.escdelete}" styleClass="button01"
							rendered="#{list.statusValue=='0' || list.statusValue=='1'}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="��ϸ��Ϣ" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem2('#{list.furloughNO}');"></h:commandButton>	
						<h:commandButton value="��ٵֿ���Ϣ�鿴" styleClass="button01" onclick="return doTimeOff('#{list.furloughNO}');" rendered="#{list.flID=='01' || list.flID=='02'}"></h:commandButton>
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.furloughNO}');"
							rendered="#{list.statusValue!='3'}"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�����" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personleaveBB.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.superFlIdName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flIdProcessName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�Ƿ��ύ���֤������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flIdStatusName}" />
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
						<h:outputText value="#{list.zjAuditResultvalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ܼ�������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.zjAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ܼ�����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.zjAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ܼ�����˵��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.zjAuditCause}" />
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
						<h:outputText value="#{list.zjlAuditResultvalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ܾ���������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.zjlAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ܾ�������ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.zjlAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ܾ�������˵��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.zjlAuditCause}" />
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
<h:panelGroup rendered="#{personleaveBB.status1=='1'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personleaveBB.persBos}" var="list"
					align="center" id="dateList1" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','2','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','3','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="��ٵֿ���Ϣ�鿴" styleClass="button01" onclick="return doTimeOff('#{list.furloughNO}');" rendered="#{list.flID=='01' || list.flID=='02'}"></h:commandButton>
						<h:commandButton value="��ϸ��Ϣ" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem2('#{list.furloughNO}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�����" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personleaveBB.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="��������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.superFlIdName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flIdProcessName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�Ƿ��ύ���֤������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.flIdStatusName}" />
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
