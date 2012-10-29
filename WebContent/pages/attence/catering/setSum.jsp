<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function refreshload() {
		setTimeout('myrefresh()', 1000);
	}
	function forAddDate() {
		window
				.showModalDialog(
						"/attence/catering/setSumAdd.jsf?ok=10000",
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		document.all('form1:refresh').click();
		return true;
	}
	function forFinanceDate(id, id1) {
		window
				.showModalDialog(
						"/attence/catering/setSumAdd.jsf?subId=" + id
								+ "&orgId=" + id1,
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		document.all('form1:refresh').click();
		return true;
	}
	function doDetailPopup(id,id1) {
		window
				.showModalDialog(
						"/attence/catering/setSumList.jsf?orgId=" + id+"&attenceDate="+id1,
						null,
						"dialogWidth:800px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{setsumBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden id="pageInit" value="#{setsumBB.pageInit}" />
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ���ڹ��� ->�趨��ˮ" />
		</h:panelGroup>
	</h:panelGrid>
		<f:verbatim>
					<table width="98%" align="center">
					<tr>
						<td align="center" width="12%" class=activeTab><a
							href="/attence/catering/setSum.jsf">����ˮ����</a></td>
						<td align="center" width="12%" class=tab><a
							href="/attence/catering/setWeekSum.jsf">����ˮ����</a></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
					</tr>
				</table>	
	</f:verbatim>
	<h:panelGrid columns="2" cellspacing="2" width="89%" align="center">
		<h:panelGroup>
			<h:outputText value="��¼��:#{setsumBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{setsumBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{setsumBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="��ǰΪ��#{setsumBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{setsumBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{setsumBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{setsumBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{setsumBB.last}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="����" styleClass="button01" type="button"
				onclick="return forAddDate();" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="2" align="center" width="90%">
		<h:panelGrid columns="5" cellspacing="2">

		</h:panelGrid>
	</h:panelGrid>

	<h:dataTable value="#{setsumBB.dateList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="Ӧ�÷�Χ" />
			</c:facet>
			<h:outputText value="#{list.orguidName}" />
		</h:column>
		<h:column>
			<c:facet name="header">
				<h:outputText value="ʱ��" />
			</c:facet>
			<h:outputText value="#{list.attenceDate}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="Ԥ����ˮ" />
			</c:facet>
			<h:outputText value="#{list.forecastWater}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="ʵ����ˮ" />
			</c:facet>
			<h:outputText value="#{list.realityWater}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="����" />
			</c:facet>
			<h:commandButton value="����" styleClass="button01" type="button"
				onclick="return forFinanceDate('#{list.subID}','#{list.orguid}');" />
			<h:commandButton value="�鿴��ʷ" styleClass="button01" type="button"
				onclick="return doDetailPopup('#{list.orguid}','#{list.attenceDate}');" />
		</h:column>
	</h:dataTable>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
