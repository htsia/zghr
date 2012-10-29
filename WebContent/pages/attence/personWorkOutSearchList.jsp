<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script>

    function addMore(){
        window.showModalDialog("/attence/personWorkOutAdd.jsf","","dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }

</script>
<x:saveState value="#{attOutWorkMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{attOutWorkMgrBB.pageInit}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=100% align="center">
       <tr><td height=8 class="td_page">
    </c:verbatim>
	<h:panelGrid width="98%" columns="1" >
		<h:panelGrid columns="1" align="left" >
                        <h:panelGroup>
                            <h:outputText escape="false" value="ʱ�䣺 " />
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{attOutWorkMgrBB.beginTime}"
				    readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})"/>

			<h:outputText escape="false" value=" ��  " />
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d"
					size="30" value="#{attOutWorkMgrBB.endTime}" readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})"/>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="������Ա�����:"></h:outputText>
                <h:inputText value="#{attOutWorkMgrBB.personValue}" styleClass="input"></h:inputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��λ����:"></h:outputText>
                <h:inputText value="#{attOutWorkMgrBB.postName}" styleClass="input"></h:inputText>
                <h:commandButton value="��ѯ" action="#{attOutWorkMgrBB.doQuery}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
        <h:panelGrid columns="1" align="right">
                        <h:panelGroup>
				<h:outputText
					value="��¼��:#{attOutWorkMgrBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{attOutWorkMgrBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{attOutWorkMgrBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{attOutWorkMgrBB.mypage.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{attOutWorkMgrBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attOutWorkMgrBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attOutWorkMgrBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{attOutWorkMgrBB.last}"
					styleClass="button01"></h:commandButton>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="����" styleClass="button01" style="button" onclick="addMore();"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
     <c:verbatim>
	  </td></tr>

	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<x:dataTable value="#{attOutWorkMgrBB.personList}" id="dateList"
		headerClass="td_fixtop" rowIndexVar="index" var="list"
		styleClass="table03" border="1" width="100%"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center">
		<h:column>
			<c:facet name="header">
				<h:outputText value="���" />
			</c:facet>
			<h:outputText value="#{index+1}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="������Ա" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.personID}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="����ʱ��" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.caclDate}" />
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
			<h:outputText escape="false" value="#{list.reason}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="Ŀ�ĵ�" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.dest}" />
		</h:column>
        <h:column>
			<f:facet name="header">
				<h:outputText value="����" styleClass="td03" />
			</f:facet>

			<h:commandButton action="#{attOutWorkMgrBB.deleteOutWork}" styleClass="button01" value="ɾ��">
                <x:updateActionListener property="#{attOutWorkMgrBB.superFurloughNo}" value="#{list.outWorkCollectNo}"/>
			</h:commandButton>
		</h:column>
	</x:dataTable>
       <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>






