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
						"/attence/catering/autoClassManagerAdd.jsf?superId="
								+ document.all("form1:superId").value, "",
						"dialogWidth:" + screen.width * 0.3 + "px; dialogHeight:" + screen.height * 0.3 + "px; status:0;resizable:yes");
		document.all('form1:refresh').click();
		return true;
	}
	function doDetailPopup(id) {
		window
				.showModalDialog(
						"/attence/catering/autoClassManagerList.jsf?amaId="
								+ id,
						null,
						"dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:" + screen.height * 1.0 + "px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
	function doDetailPopupDate(id) {
		window
				.showModalDialog(
						"/attence/catering/autoClassManagerWater.jsf?duraYearMonth="
								+ id,
						null,
						"dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:" + screen.height * 1.0 + "px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{autoclassmanagerBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden id="pageInit" value="#{autoclassmanagerBB.pageInit}" />
	<h:inputHidden id="superId" value="#{autoclassmanagerBB.superId}"></h:inputHidden>
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ���ڹ��� ->�Զ��Ű�ƻ�����" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="3" cellspacing="2" width="89%" align="center">
		<h:panelGroup>
			<h:outputText value="��¼��:#{autoclassmanagerBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{autoclassmanagerBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{autoclassmanagerBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="��ǰΪ��#{autoclassmanagerBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{autoclassmanagerBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{autoclassmanagerBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{autoclassmanagerBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{autoclassmanagerBB.last}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="����" styleClass="button01" type="button"
				onclick="return forAddDate();" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="2" align="center" width="90%">
		<h:panelGrid columns="5" cellspacing="2">

		</h:panelGrid>
	</h:panelGrid>

	<h:dataTable value="#{autoclassmanagerBB.dateList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="����" />
			</c:facet>
			<h:outputText value="#{list.duraYearMonth}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="������" />
			</c:facet>
			<h:outputText value="#{list.createOper}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="����ʱ��" />
			</c:facet>
			<h:outputText value="#{list.createDate}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="����" />
			</c:facet>
			<h:commandButton value="��" styleClass="button01" type="button" onclick="return doDetailPopup('#{list.amaId}')" rendered="#{list.status!='9'}" />
			<h:commandButton value="¼�����" styleClass="button01" type="button" onclick="return doDetailPopupDate('#{list.duraYearMonth}')" rendered="#{list.status!='9'}" />
			<h:commandButton value="�鿴" styleClass="button01" type="button" onclick="return doDetailPopup('#{list.amaId}')" rendered="#{list.status!='-1' && list.status!='0'}" />
			<h:commandButton value="����" onclick="return confirm('ȷ��Ҫ������?');" rendered="#{list.status!='9'}"
				action="#{autoclassmanagerBB.finish}" styleClass="button01">
				<x:updateActionListener property="#{autoclassmanagerBB.amaId}"
					value="#{list.amaId}" />
			</h:commandButton>
		</h:column>
	</h:dataTable>

</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
