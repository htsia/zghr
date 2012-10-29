<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function refreshload() {
		document.all('form1:refresh1').click();
	}
</script>
<x:saveState value="#{attimportlogBB}"></x:saveState>
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden value="#{attimportlogBB.pageInit}"></h:inputHidden>
	<h:commandButton id="refresh1" value="ˢ��" style="display:none;"
		action="#{attimportlogBB.doQuery}"></h:commandButton>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">�鿴������־</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="1">
					<h:panelGroup>
						<h:outputText value="��¼��:#{attimportlogBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ҳ��:#{attimportlogBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="ÿҳ��#{attimportlogBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="��ǰΪ��#{attimportlogBB.mypage.currentPage}ҳ"></h:outputText>

						<h:commandButton value="��ҳ" action="#{attimportlogBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{attimportlogBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="��ҳ" action="#{attimportlogBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="βҳ" action="#{attimportlogBB.last}"
							styleClass="button01"></h:commandButton>
					</h:panelGroup>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{attimportlogBB.lists}" var="list" rowIndexVar="index"
					id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%" border="0">

                    <h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{list.logID}" />
					</h:column>

                    <h:column>
						<c:facet name="header">
							<h:outputText value="�����ʾ" />
						</c:facet>
						<h:outputText value="#{list.machineID}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����ʱ��" />
						</c:facet>
						<h:outputText value="#{list.createDate}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��ʼ���" />
						</c:facet>
						<h:outputText value="#{list.minValue}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��ֹ���" />
						</c:facet>
						<h:outputText value="#{list.maxValue}" />
					</h:column>

			        <h:column>
				     <c:facet name="header">
					  <h:outputText value="����" />
				     </c:facet>
					 <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
						action="#{attimportlogBB.delete}" styleClass="button01">
						<x:updateActionListener property="#{attimportlogBB.logID}"
							value="#{list.logID}" />
					 </h:commandButton>
			      </h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
</body>

