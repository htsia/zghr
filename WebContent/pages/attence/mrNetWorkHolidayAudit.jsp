<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
		window.showModalDialog(
				"/attence/mrNetWorkHolidayAuditEdit.jsf?mimicReportNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.6 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem1(id) {
		window.showModalDialog(
				"/attence/mrNetWorkHolidayAuditEdit1.jsf?mimicReportNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem2(id) {
		window.showModalDialog(
				"/attence/mrNetWorkHolidayAuditEdit2.jsf?mimicReportNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem3(id) {
		window.showModalDialog(
				"/attence/mrNetWorkHolidayAuditEdit3.jsf?mimicReportNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem4(id) {
		window.showModalDialog(
				"/attence/mrNetWorkHolidayAuditEdit4.jsf?mimicReportNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem5(id) {
		window.showModalDialog(
				"/attence/mrNetWorkHolidayAuditEdit5.jsf?mimicReportNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{mrnetworkholidayBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{mrnetworkholidayBB.initEdit}" />
	<h:inputHidden id="operID" value="#{mrnetworkholidayBB.operID}" />
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> ����ⱨ����</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
            <tr>
                <td align="right" height="10">
                  </f:verbatim>
                         <h:panelGroup>
					<h:selectBooleanCheckbox value="#{mrnetworkholidayBB.isExist1}"
						onclick="submit();"
						valueChangeListener="#{mrnetworkholidayBB.changeNowYearValue1}" />
					<h:outputText value="��ʾȫ��" />
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="��¼��:#{mrnetworkholidayBB.mypage.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="ҳ��:#{mrnetworkholidayBB.mypage.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="ÿҳ��#{mrnetworkholidayBB.mypage.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="��ǰΪ��#{mrnetworkholidayBB.mypage.currentPage}ҳ"></h:outputText>

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
				</h:panelGroup>
                   <f:verbatim>
                </td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim>
           <h:dataTable value="#{mrnetworkholidayBB.persBos2}" var="list"
					align="center" id="dateList" headerClass="locked_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="98%">
					<h:column>
						<f:facet name="header">
							<h:outputText value="�ⱨ������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
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
							<h:outputText value="Ӧ�������ݼ�(��)" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.lastDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����ʱ��" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && mrnetworkholidayBB.operID=='0542' && list.statusValue!='3'}"
							onclick="doAddItem('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && mrnetworkholidayBB.operID=='0543' && list.statusValue!='3'}"
							onclick="doAddItem1('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && mrnetworkholidayBB.operID=='0544' && list.statusValue!='3'}"
							onclick="doAddItem2('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && mrnetworkholidayBB.operID=='0545' && list.statusValue!='3'}"
							onclick="doAddItem3('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && mrnetworkholidayBB.operID=='0546' && list.statusValue!='3'}"
							onclick="doAddItem4('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && mrnetworkholidayBB.operID=='0547' && list.statusValue!='3'}"
							onclick="doAddItem5('#{list.mimicReportNO}');"></h:commandButton>
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





