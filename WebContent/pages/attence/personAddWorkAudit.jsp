<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
		window.showModalDialog(
				"/attence/personAddWorkAuditEdit.jsf?overTimeNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.6 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem1(id) {
		window.showModalDialog(
				"/attence/personAddWorkAuditEdit1.jsf?overTimeNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem2(id) {
		window.showModalDialog(
				"/attence/personAddWorkAuditEdit2.jsf?overTimeNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem3(id) {
		window.showModalDialog(
				"/attence/personAddWorkAuditEdit3.jsf?overTimeNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem4(id) {
		window.showModalDialog(
				"/attence/personAddWorkAuditEdit4.jsf?overTimeNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personaddworkBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{personaddworkBB.initEdit}" />
	<h:inputHidden id="operID" value="#{personaddworkBB.operID}" />
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> �Ӱ�����</td>
			</tr>
		</table>
		<table height=98% width=98%>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:panelGroup>
					<h:selectBooleanCheckbox value="#{personaddworkBB.isExist1}"
						onclick="submit();"
						valueChangeListener="#{personaddworkBB.changeNowYearValue1}" />
					<h:outputText value="��ʾȫ��" />
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="��¼��:#{personaddworkBB.mypage.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="ҳ��:#{personaddworkBB.mypage.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="ÿҳ��#{personaddworkBB.mypage.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="��ǰΪ��#{personaddworkBB.mypage.currentPage}ҳ"></h:outputText>

					<h:commandButton value="��ҳ" action="#{personaddworkBB.first}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="��ҳ" action="#{personaddworkBB.pre}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="��ҳ" action="#{personaddworkBB.next}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="βҳ" action="#{personaddworkBB.last}"
						styleClass="button01"></h:commandButton>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
				</h:panelGroup> <h:dataTable value="#{personaddworkBB.persBos2}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="90%">
					<h:column>
						<f:facet name="header">
							<h:outputText value="�Ӱ�������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
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
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.overTimeNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personaddworkBB.operID=='0555' && list.statusValue!='3'}"
							onclick="doAddItem('#{list.overTimeNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personaddworkBB.operID=='0556' && list.statusValue!='3'}"
							onclick="doAddItem1('#{list.overTimeNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personaddworkBB.operID=='0557' && list.statusValue!='3'}"
							onclick="doAddItem2('#{list.overTimeNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personaddworkBB.operID=='0581' && list.statusValue!='3'}"
							onclick="doAddItem3('#{list.overTimeNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personaddworkBB.operID=='0582' && list.statusValue!='3'}"
							onclick="doAddItem4('#{list.overTimeNO}');"></h:commandButton>
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





