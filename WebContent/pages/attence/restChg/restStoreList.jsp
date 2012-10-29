<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script>
       function queryOutWork() {
            window.showModalDialog("/attence/annualRuleListAdd.jsf?okID=100", null, "dialogWidth:" + screen.width * 0.2 + "px; dialogHeight:" + screen.height * 0.3 + "px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
</script>
<x:saveState value="#{attRestStoreBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{attRestStoreBB.pageInit}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=100% align="center">
       <tr><td height=8 class="td_page">
    </c:verbatim>
	<h:panelGrid width="98%" columns="1" >
		<h:panelGrid columns="1" align="left" >
                        <h:panelGroup>
                            <h:outputText escape="false" value="ʱ�䣺 " />
				<h:inputText styleClass="input" id="beginDate" value="#{attRestStoreBB.beginTime}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:beginDate')"></h:commandButton>
			    <h:outputText escape="false" value=" ��  " />
				<h:inputText styleClass="input" id="endDate" value="#{attRestStoreBB.endTime}"
                             readonly="true" alt="��������|0|d|50||"/>
                 <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:endDate')"></h:commandButton>
                <h:outputText value="  "/>
                <h:outputText value="������Ա�����:"></h:outputText>
                <h:inputText value="#{attRestStoreBB.personValue}" styleClass="input"></h:inputText>
                
                <h:commandButton value="��ѯ" action="#{attRestStoreBB.doQuery}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
        <h:panelGrid columns="1" align="right">
                        <h:panelGroup>
				<h:outputText
					value="��¼��:#{attRestStoreBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ҳ��:#{attRestStoreBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="ÿҳ��#{attRestStoreBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="��ǰΪ��#{attRestStoreBB.mypage.currentPage}ҳ"></h:outputText>

				<h:commandButton value="��ҳ" action="#{attRestStoreBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attRestStoreBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="��ҳ" action="#{attRestStoreBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="βҳ" action="#{attRestStoreBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
     <c:verbatim>
	  </td></tr>

	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<x:dataTable value="#{attRestStoreBB.personList}" id="dateList"
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
				<h:outputText value="����" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.personId}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="��¼����" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.recordTypeDes}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="��������" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.days}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="״̬" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.statusDes}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="��������" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.restTime}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="ʹ������" styleClass="td03" />
			</f:facet>
			<h:outputText escape="false" value="#{list.useDays}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="ʣ������" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.levDays}" />
		</h:column>
        <h:column>
			<f:facet name="header">
				<h:outputText value="����" styleClass="td03" />
			</f:facet>

			<h:commandButton action="#{attRestStoreBB.deleteOutWork}" styleClass="button01" value="��ΪʧЧ">
                <x:updateActionListener property="#{attRestStoreBB.superFurloughNo}" value="#{list.outWorkCollectNo}"/>
			</h:commandButton>
            <h:commandButton value="�鿴����"
						onclick="return forModify('#{list.itemID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="�鿴���"
						onclick="return forModify('#{list.itemID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="�鿴�Ӱ�"
						onclick="return forModify('#{list.itemID}')" styleClass="button01"></h:commandButton>
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






