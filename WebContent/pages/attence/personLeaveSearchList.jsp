<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script>

    function addMore(){
        window.showModalDialog("/attence/personLeaveAdd.jsf","","dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }

</script>
<x:saveState value="#{attFurloughRecMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{attFurloughRecMgrBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       <tr><td height=8 class="td_page">
    </c:verbatim>
	<h:panelGrid width="98%" columns="1">
		<h:panelGrid columns="1" align="left" >
                        <h:panelGroup>
                            <h:outputText escape="false" value="ʱ�䣺 " />
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{attFurloughRecMgrBB.beginTime}"
				    readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})"/>

			<h:outputText escape="false" value=" ��  " />
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d"
					size="30" value="#{attFurloughRecMgrBB.endTime}" readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})"/>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="������Ա����ţ�"></h:outputText>
                <h:inputText value="#{attFurloughRecMgrBB.personValue}" styleClass="input"></h:inputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="������ͣ�"></h:outputText>
                <h:selectOneMenu value="#{attFurloughRecMgrBB.flID}" style="width:90px;" onchange="submit();">
				        <c:selectItems value="#{attFurloughRecMgrBB.flIDList}"></c:selectItems>
			    </h:selectOneMenu>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��λ���ƣ�"></h:outputText>
                <h:inputText value="#{attFurloughRecMgrBB.postName}" styleClass="input"></h:inputText>
                <h:commandButton value="��ѯ" action="#{attFurloughRecMgrBB.doQuery}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
        <h:panelGrid columns="1" align="right">
                        <h:panelGroup>
				<h:outputText
					value="��¼��:#{attFurloughRecMgrBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{attFurloughRecMgrBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{attFurloughRecMgrBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{attFurloughRecMgrBB.mypage.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{attFurloughRecMgrBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attFurloughRecMgrBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attFurloughRecMgrBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{attFurloughRecMgrBB.last}"
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
	<x:dataTable value="#{attFurloughRecMgrBB.personList}" id="dateList"
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
				<h:outputText value="�����Ա" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.personID}" />
		</h:column>
        <h:column>
			<f:facet name="header">
				<h:outputText value="��������" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.flID}" />
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
				<h:outputText value="����" styleClass="td03" />
			</f:facet>

			<h:commandButton action="#{attFurloughRecMgrBB.deleteFurloughRec}" styleClass="button01" value="ɾ��">
                <x:updateActionListener property="#{attFurloughRecMgrBB.superFurloughNo}" value="#{list.furloughCollectNO}"/>
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






