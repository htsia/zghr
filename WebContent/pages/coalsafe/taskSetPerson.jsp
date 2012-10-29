<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<c:verbatim>
	
</c:verbatim>
<script type="text/javascript">
   
</script>

<x:saveState value="#{coalTaskMgrBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{coalTaskMgrBB.initPersonList}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		<h:outputText value="��¼��:#{coalTaskMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{coalTaskMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{coalTaskMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{coalTaskMgrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{coalTaskMgrBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalTaskMgrBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalTaskMgrBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{coalTaskMgrBB.last1}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="ѡ����Ա" styleClass="button01" onclick="return fPopUpBackPerTreeDlg('');" action="#{coalTaskMgrBB.selSetPerson}"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{coalTaskMgrBB.personList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle">
				
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
                    <h:outputText value="#{index+1}" ></h:outputText>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.personId}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����');" styleClass="button01" action="#{coalTaskMgrBB.deletePerson}">
                          <x:updateActionListener property="#{coalTaskMgrBB.itemId}" value="#{briefList.itemId}"/>
                    </h:commandButton>
                </h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


