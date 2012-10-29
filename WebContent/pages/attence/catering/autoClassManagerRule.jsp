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
						"/attence/catering/autoClassManagerRuleAdd.jsf?superId="
								+ document.all("form1:superId").value, "",
						"dialogWidth:" + screen.width * 0.3 + "px; dialogHeight:" + screen.height * 0.43 + "px; status:0;resizable:yes");
		document.all('form1:refresh').click();
		return true;
	}
	function forModify(id) {
		window
				.showModalDialog(
						"/attence/catering/autoClassManagerRuleAdd.jsf?amaId="
								+ id,
						null,
						"dialogWidth:" + screen.width * 0.3 + "px; dialogHeight:" + screen.height * 0.43 + "px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
	}
</script>

<x:saveState value="#{autoclassmanagerruleBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		onclick="refreshload()"></h:commandButton>
	<h:inputHidden id="pageInit" value="#{autoclassmanagerruleBB.pageInit}" />
	<h:inputHidden id="superId" value="#{autoclassmanagerruleBB.superId}"></h:inputHidden>
	<h:panelGrid width="98%" align="center" columnClasses="td_title"
		bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ���ڹ��� ->�Զ��Ű�������" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="3" cellspacing="2" width="89%" align="center">
		<h:panelGroup>
			<h:outputText value="��¼��:#{autoclassmanagerruleBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{autoclassmanagerruleBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{autoclassmanagerruleBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="��ǰΪ��#{autoclassmanagerruleBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{autoclassmanagerruleBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{autoclassmanagerruleBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{autoclassmanagerruleBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{autoclassmanagerruleBB.last}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="����" styleClass="button01" type="button"
				onclick="return forAddDate();" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="2" align="center" width="90%">
		<h:panelGrid columns="5" cellspacing="2">

		</h:panelGrid>
	</h:panelGrid>

	<h:dataTable value="#{autoclassmanagerruleBB.dateList}" var="list"
		align="center" id="dateList" headerClass="td_top"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
		styleClass="table03" width="90%">
		<h:column>
			<c:facet name="header">
				<h:outputText value="��������" />
			</c:facet>
			<h:outputText value="#{list.orgIdName}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="���ù�ʽ" />
			</c:facet>
			<h:outputText value="#{list.formula}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="������Ϣ����" />
			</c:facet>
			<h:outputText value="#{list.restDay}" />
		</h:column>

		<h:column>
			<c:facet name="header">
				<h:outputText value="ÿС������" />
			</c:facet>
			<h:outputText value="#{list.squadPerson}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="ÿ��ͱ���(%)" />
			</c:facet>
			<h:outputText value="#{list.lunchRate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="��ͱ���(%)" />
			</c:facet>
			<h:outputText value="#{list.superRate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="����Ա������" />
			</c:facet>
			<h:outputText value="#{list.waiter}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="��Ʒ��(%)" />
			</c:facet>
			<h:outputText value="#{list.produceRate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="�˾�ÿ�ͳ�Ʒ��" />
			</c:facet>
			<h:outputText value="#{list.produceRoad}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="�˾���ϴ��" />
			</c:facet>
			<h:outputText value="#{list.cleanNumber}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="��;�������" />
			</c:facet>
			<h:outputText value="#{list.bigTableWare}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="С�;�������" />
			</c:facet>
			<h:outputText value="#{list.smallTableWare}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
				<h:outputText value="�ǵ�������" />
			</c:facet>
			<h:outputText value="#{list.bonePlate}" />
		</h:column>
		
		<h:column>
			<c:facet name="header">
			    <h:outputText value="����" />
			</c:facet>
			<h:panelGrid columns="5" align="center" cellspacing="2">
			    <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
						action="#{autoclassmanagerruleBB.delete}" styleClass="button01">
						<x:updateActionListener property="#{autoclassmanagerruleBB.amaId}"
							value="#{list.amaId}" />
					</h:commandButton>
					<h:commandButton value="�޸�"
						onclick="return forModify('#{list.amaId}')" styleClass="button01"></h:commandButton>
			</h:panelGrid>
		</h:column>
	</h:dataTable>

</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
