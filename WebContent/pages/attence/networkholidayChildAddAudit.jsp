<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
		window.showModalDialog(
				"/attence/networkholidayChildAddAuditEdit.jsf?detailId=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.6 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem1(id) {
		window.showModalDialog(
				"/attence/networkholidayChildAddAuditEdit1.jsf?detailId=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem2(id) {
		window.showModalDialog(
				"/attence/networkholidayChildAddAuditEdit2.jsf?detailId=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem3(id) {
		window.showModalDialog(
				"/attence/networkholidayChildAddAuditEdit3.jsf?detailId=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem4(id) {
		window.showModalDialog(
				"/attence/networkholidayChildAddAuditEdit4.jsf?detailId=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{networkholidaychildaddBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit"
		value="#{networkholidaychildaddBB.initEdit1}" />
	<h:inputHidden id="operID" value="#{networkholidaychildaddBB.operID}" />
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> �������</td>
			</tr>
		</table>
		<table height=98% width=98%>
			<tr>
                <td height="8" align="center">
                   </f:verbatim>
                        <h:outputText value="������Ա�����:"/>
                        <h:inputText value="#{networkholidaychildaddBB.personValue}" styleClass="input"/>
                        <h:commandButton value="��ѯ" styleClass="button01" action="#{networkholidaychildaddBB.doQueryAudit}"/>
                    <f:verbatim>
                </td>
                <td align="right" height="8">
                  </f:verbatim>
                         <h:panelGroup>
					<h:selectBooleanCheckbox
						value="#{networkholidaychildaddBB.isExist}" onclick="submit();"
						valueChangeListener="#{networkholidaychildaddBB.changeNowYearValue}" />
					<h:outputText value="��ʾȫ��" />
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText
						value="��¼��:#{networkholidaychildaddBB.mypage.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText
						value="ҳ��:#{networkholidaychildaddBB.mypage.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText
						value="ÿҳ��#{networkholidaychildaddBB.mypage.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText
						value="��ǰΪ��#{networkholidaychildaddBB.mypage.currentPage}ҳ"></h:outputText>

					<h:commandButton value="��ҳ"
						action="#{networkholidaychildaddBB.first}" styleClass="button01"></h:commandButton>
					<h:commandButton value="��ҳ"
						action="#{networkholidaychildaddBB.pre}" styleClass="button01"></h:commandButton>
					<h:commandButton value="��ҳ"
						action="#{networkholidaychildaddBB.next}" styleClass="button01"></h:commandButton>
					<h:commandButton value="βҳ"
						action="#{networkholidaychildaddBB.last}" styleClass="button01"></h:commandButton>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
				</h:panelGroup>
                  <f:verbatim>
                </td>
                 </tr>
                 <tr>
				<td colspan="2">
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim><h:dataTable value="#{networkholidaychildaddBB.persBos2}"
					var="list" align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
						<f:facet name="header">
							<h:outputText value="������" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
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
							<h:outputText value="�������" styleClass="td03" />
						</f:facet>
						<h:outputText escape="false" value="#{list.daySpan}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" styleClass="td03" />
						</f:facet>
						<h:commandButton value="�鿴����" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.detailId}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && networkholidaychildaddBB.operID=='0562' && list.statusValue!='3'}"
							onclick="doAddItem('#{list.detailId}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && networkholidaychildaddBB.operID=='0563' && list.statusValue!='3'}"
							onclick="doAddItem1('#{list.detailId}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && networkholidaychildaddBB.operID=='0564' && list.statusValue!='3'}"
							onclick="doAddItem2('#{list.detailId}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && networkholidaychildaddBB.operID=='0585' && list.statusValue!='3'}"
							onclick="doAddItem3('#{list.detailId}');"></h:commandButton>
						<h:commandButton value="����" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && networkholidaychildaddBB.operID=='0584' && list.statusValue!='3'}"
							onclick="doAddItem4('#{list.detailId}');"></h:commandButton>
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





