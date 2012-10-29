<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addElement(){
        window.showModalDialog("/attence/personAddWorkAdd.jsf","","dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }
</script>

<x:saveState value="#{seepersonaddworkListBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{seepersonaddworkListBB.pageInit}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=100% align="center">
       <tr><td height=8 class="td_page">
    </c:verbatim>
	<h:panelGrid width="98%" columns="1">
		<h:panelGrid columns="1" align="left">
            <h:panelGroup>
            <h:outputText escape="false" value="ʱ�䣺 " />
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{seepersonaddworkListBB.beginTime}"
				    readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})"/>

			<h:outputText escape="false" value=" ��  " />
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d"
					size="30" value="#{seepersonaddworkListBB.endTime}" readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})"/>
			<h:outputText value="  "></h:outputText>
                <h:outputText value="������Ա�����:"></h:outputText>
                <h:inputText value="#{seepersonaddworkListBB.personValue}" styleClass="input"></h:inputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��λ���ƣ�"></h:outputText>
                <h:inputText value="#{seepersonaddworkListBB.postName}" styleClass="input"></h:inputText>
            <h:commandButton value="��ѯ" id="queryPerson" styleClass="button01"
				action="#{seepersonaddworkListBB.queryPerson}" />
            </h:panelGroup>
		</h:panelGrid>
        <h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:outputText
					value="��¼��:#{seepersonaddworkListBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{seepersonaddworkListBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{seepersonaddworkListBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{seepersonaddworkListBB.mypage.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{seepersonaddworkListBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{seepersonaddworkListBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{seepersonaddworkListBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{seepersonaddworkListBB.last}"
					styleClass="button01"></h:commandButton>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="����" style="button"
					styleClass="button01" onclick="addElement()"></h:commandButton>
			</h:panelGroup>

		</h:panelGrid>

	</h:panelGrid>
    <c:verbatim>
	  </td></tr>

	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<x:dataTable value="#{seepersonaddworkListBB.lists1}" id="dateList"
		headerClass="td_top" rowIndexVar="index" var="list"
		styleClass="table03" border="1" width="100%"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center">
		<h:column>
			<c:facet name="header">
				<h:outputText value="��Ա���" />
			</c:facet>
			<h:outputText value="#{list.seqName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="�Ӱ���" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.personName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="�Ӱ�����" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.typeStatusName}" />
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
				<h:outputText value="�༭" styleClass="td03" />
			</f:facet>

			<h:commandButton action="#{seepersonaddworkListBB.deleteOverTimeLog}" styleClass="button01" value="ɾ��">
                <x:updateActionListener property="#{seepersonaddworkListBB.superFurloughNo}" value="#{list.overTimeLogNO}"/>
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






