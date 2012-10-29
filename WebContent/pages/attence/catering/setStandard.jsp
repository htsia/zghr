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
						"/attence/catering/setStandardAdd.jsf?ok=10000",
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		document.all('form1:refresh').click();
		return true;
	}
	function forFinanceDate(id, id1) {
		window
				.showModalDialog(
						"/attence/catering/setStandardAdd.jsf?subId=" + id
								+ "&orgId=" + id1,
						null,
						"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
		document.all('form1:refresh').click();
		return true;
	}
	function doDetailPopup(id) {
		window
				.showModalDialog(
						"/attence/catering/setStandardList.jsf?orgId=" + id,
						null,
						"dialogWidth:800px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{setstandardBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden id="pageInit" value="#{setstandardBB.pageInit}" />
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ���ڹ��� ->�趨��׼" />
		</h:panelGroup>
	</h:panelGrid>
    <h:panelGrid columns="1" width="100%">
    <h:panelGrid  cellspacing="2" width="89%" align="right">
          <h:panelGroup>
			<h:outputText value="��¼��:#{setstandardBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{setstandardBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{setstandardBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="��ǰΪ��#{setstandardBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{setstandardBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{setstandardBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{setstandardBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{setstandardBB.last}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="����" styleClass="button01" type="button"
				onclick="return forAddDate();" />
		</h:panelGroup>
    </h:panelGrid>

	<h:dataTable value="#{setstandardBB.dateList}" var="list"
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
				<h:outputText value="��׼��Ч" />
			</c:facet>
			<h:outputText value="#{list.standWork}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="��������" />
			</c:facet>
			<h:outputText value="#{list.personNumber}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="��׼ȷ��ʱ��" />
			</c:facet>
			<h:outputText value="#{list.attenceDate}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="����" />
			</c:facet>
			<h:commandButton value="����" styleClass="button01" type="button"
				onclick="return forFinanceDate('#{list.subID}','#{list.orguid}');" />
			<h:commandButton value="�鿴��ʷ" styleClass="button01" type="button"
				onclick="return doDetailPopup('#{list.orguid}');" />
		</h:column>
	</h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
