<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		var name = document.all('form1:name').value;
		if (name != null && name != "") {
			window.showModalDialog("/attence/personChangeWorkEdit.jsf", "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.6
							+ "px; status:0;resizable:yes");
		} else {
			alert("����Աû�м����κΰ��飬���ܽ��л������");
			return false;
		}
		return true;
	}
	function doEditItem(id) {
		window
				.showModalDialog(
						"/attence/personEvectionMessage.jsf?evcctionNO=" + id,
						"",
						"dialogWidth:550px; dialogHeight:270px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personChangeWorkBB}" />
<h:form id="form1">
	<h:inputHidden value="#{personChangeWorkBB.pageInit}" />
	<h:inputHidden id="name" value="#{personChangeWorkBB.groupName}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="1">

					<h:panelGroup>
						<h:selectBooleanCheckbox value="#{personChangeWorkBB.isExist}"
							onclick="submit();"
							valueChangeListener="#{personChangeWorkBB.changeNowYearValue}" />
						<h:outputText value="��ʾȫ��" />
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��¼��:#{personChangeWorkBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ҳ��:#{personChangeWorkBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ÿҳ��#{personChangeWorkBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="��ǰΪ��#{personChangeWorkBB.mypage.currentPage}ҳ"></h:outputText>

						<h:commandButton value="��ҳ" action="#{personChangeWorkBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{personChangeWorkBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{personChangeWorkBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="βҳ" action="#{personChangeWorkBB.last}"
							styleClass="button01"></h:commandButton>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:commandButton value="��������" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personChangeWorkBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1700">
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="����"
							action="#{personChangeWorkBB.personChangeWorkMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener property="#{personChangeWorkBB.changeID}"
								value="#{list.changeID}" />
						</h:commandButton>
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.changeID}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personChangeWorkBB.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="ԭ���ڰ���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.oldClassName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="�����ڰ���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.newClassName}" />
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
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>

