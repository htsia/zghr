<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script>

    function addMore(){
        window.showModalDialog("/attence/mrNetworkholidayEdit.jsf?operType=add","","dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }
    function editMore(mimicReportNO){
        window.showModalDialog("/attence/mrNetworkholidayEdit.jsf?operType=edit&mimicReportNO="+mimicReportNO,"","dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }
     function exportExcel(){
        window.open("/pages/attence/mrNetWorkHodidayExcel.jsp?superId="+document.all("form1:superId").value+
                "&personValue="+document.all("form1:personValue").value+
                "&timeValue="+document.all("form1:timeValue").value+
                "&statusValue="+document.all("form1:statusValue").value,"","dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }
</script>
<x:saveState value="#{attMImicReportRecQryBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{attMImicReportRecQryBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{attMImicReportRecQryBB.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       <tr><td height=8 class="td_page">
    </c:verbatim>
	<h:panelGrid width="98%" columns="1">
		<h:panelGrid columns="1" align="left" >
                        <h:panelGroup>
                 <h:outputText escape="false" value="�ⶨ�ݼ�ʱ�䣺 " />
                <h:inputText id="timeValue" value="#{attMImicReportRecQryBB.timeValue}" styleClass="input"></h:inputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="������Ա����ţ�"></h:outputText>
                <h:inputText id="personValue" value="#{attMImicReportRecQryBB.personValue}" styleClass="input"></h:inputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="״̬��"></h:outputText>
                <h:selectOneMenu id="statusValue" value="#{attMImicReportRecQryBB.statusValue}">
                      <c:selectItem itemLabel="ȫ��" itemValue=""></c:selectItem>
                      <c:selectItem itemLabel="�ⶨ" itemValue="-1"></c:selectItem>
                      <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
                      <c:selectItem itemLabel="��׼" itemValue="1"></c:selectItem>
                      <c:selectItem itemLabel="�˻�" itemValue="2"></c:selectItem>
                </h:selectOneMenu>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="��ѯ" action="#{attMImicReportRecQryBB.doQuery}"
					styleClass="button01"></h:commandButton>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="����Excel" styleClass="button01" style="button" onclick="exportExcel();"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
        <h:panelGrid columns="1" align="right">
                        <h:panelGroup>
				<h:outputText
					value="��¼��:#{attMImicReportRecQryBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{attMImicReportRecQryBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{attMImicReportRecQryBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{attMImicReportRecQryBB.mypage.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{attMImicReportRecQryBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attMImicReportRecQryBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attMImicReportRecQryBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{attMImicReportRecQryBB.last}"
					styleClass="button01"></h:commandButton>
                <h:outputText value=" "></h:outputText>
                <h:commandButton  styleClass="button01" value="����" onclick="addMore()"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
     <c:verbatim>
	  </td></tr>

	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<x:dataTable value="#{attMImicReportRecQryBB.personList}" id="dateList"
		headerClass="td_top tr_fixrow" rowIndexVar="index" var="list"
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
				<h:outputText value="����" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.personID}" />
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
				<h:outputText value="����ʱ��" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.applyDate}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="Ӧ�������(��)" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.lastDate}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="����״̬" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.statusDes}" />
		</h:column>
        <h:column>
			<f:facet name="header">
				<h:outputText value="����" styleClass="td03" />
			</f:facet>
			<h:commandButton styleClass="button01" value="�༭" onclick="editMore('#{list.mimicReportNO}')"></h:commandButton>
            <h:commandButton styleClass="button01" value="ɾ��" action="#{attMImicReportRecQryBB.delete}">
                <x:updateActionListener property="#{attMImicReportRecQryBB.mimicReportNO}" value="#{list.mimicReportNO}"></x:updateActionListener>
            </h:commandButton>
            <h:commandButton styleClass="button01" value="����" action="#{attMImicReportRecQryBB.apprive}" rendered="#{list.statusValue=='-1'||list.statusValue=='2'}">
                <x:updateActionListener property="#{attMImicReportRecQryBB.mimicReportNO}" value="#{list.mimicReportNO}"></x:updateActionListener>
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






