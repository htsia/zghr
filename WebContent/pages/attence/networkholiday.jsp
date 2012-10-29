<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
			window.showModalDialog("/attence/networkholidayChild.jsf?itemID="+id, "",
					"dialogWidth:" + screen.width * 0.4 + "px; dialogHeight:"+ screen.height * 0.3+ "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem(id) {
		window.showModalDialog(
						"/attence/networkholidayChildAdd.jsf?itemID="+id,
						"",
						"dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:"+ screen.height * 0.9+ "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{networkholidayBB}" />
<h:form id="form1">
	<h:inputHidden value="#{networkholidayBB.pageInit}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="1">

					<h:panelGroup>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��¼��:#{networkholidayBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ҳ��:#{networkholidayBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ÿҳ��#{networkholidayBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��ǰΪ��#{networkholidayBB.mypage.currentPage}ҳ"></h:outputText>

						<h:commandButton value="��ҳ" action="#{networkholidayBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{networkholidayBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{networkholidayBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="βҳ" action="#{networkholidayBB.last}"
							styleClass="button01"></h:commandButton>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <x:dataTable value="#{networkholidayBB.lists}" var="list"
					rowIndexVar="index" align="center" id="dateList"
					headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1300">
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="��ʾ"
							onclick="return doAddItem('#{list.itemID}');"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="�ݼ�"
							onclick="return doEditItem('#{list.itemID}');"
							styleClass="button01"></h:commandButton>
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="�ݼ����" />
						</c:facet>
						<h:outputText value="#{list.yearValues}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>

			        <h:column>
						<c:facet name="header">
							<h:outputText value="���뱾��λʱ��" />
						</c:facet>
						<h:outputText value="#{list.enterDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="�μӹ���ʱ��" />
						</c:facet>
						<h:outputText value="#{list.workDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.calcDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.annDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.useDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="ʣ������" />
						</c:facet>
						<h:outputText value="#{list.avaDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="�ٽ�����" />
						</c:facet>
						<h:outputText value="#{list.criticalDate}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="�ٽ���������" />
						</c:facet>
						<h:outputText value="#{list.criticalAnnDay}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="�ٽ����������" />
						</c:facet>
						<h:outputText value="#{list.calcAnnDay}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="�ٽ��ʣ������" />
						</c:facet>
						<h:outputText value="#{list.criticalAvaDay}" />
					</h:column>
				</x:dataTable> <f:verbatim></div>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>

