<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
function doEditItem(id) {
		window.showModalDialog("/attence/modifyTimeOfEdit.jsf?timeOffRecNO="
				+ id, "", "dialogWidth:" + screen.width * 0.6
				+ "px; dialogHeight:" + screen.height * 0.6
				+ "px; status:0;resizable:yes");
		return true;
}
</script>
<x:saveState value="#{amtolBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{amtolBB.pageInit}"></h:inputHidden>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="7" align="left">
			<h:panelGroup>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��¼��:#{amtolBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{amtolBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{amtolBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{amtolBB.mypage.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{amtolBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{amtolBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{amtolBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{amtolBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
			<h:outputText value="������Ա����ţ�"></h:outputText>
			<h:inputText id="name" value="#{amtolBB.name}"
				size="10" styleClass="input" />
			<h:outputText value="��������" />
			<h:inputText styleClass="input" id="beginTime" size="12"
				alt="��������|0|d" value="#{amtolBB.beginTime}"
				readonly="true" />
			<f:verbatim>
				<input type="button" class="button_select"
					onclick=PopUpCalendarDialog('form1:beginTime');;
>
			</f:verbatim>
			<h:commandButton value="��ѯ" id="queryPerson" styleClass="button01"
				action="#{amtolBB.queryPerson}" />
		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<x:dataTable value="#{amtolBB.lists1}" id="dateList"
		headerClass="td_top" rowIndexVar="index" var="list"
		styleClass="table03" border="1" width="98%"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center">
		<h:column>
			<c:facet name="header">
				<h:outputText value="��Ա���" />
			</c:facet>
			<h:outputText value="#{list.seqName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="������" styleClass="td03" />
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
			<h:outputText value="#{list.lastDate}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="����" styleClass="td03" />
			</f:facet>
			<h:commandButton value="�޸�" styleClass="button01" onclick="return doEditItem('#{list.timeOffRecNO}');"></h:commandButton>
	    </h:column>			
	</x:dataTable>

</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>






