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
		  		<h:outputText value="记录数:#{coalTaskMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{coalTaskMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{coalTaskMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{coalTaskMgrBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{coalTaskMgrBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{coalTaskMgrBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{coalTaskMgrBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{coalTaskMgrBB.last1}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="选择人员" styleClass="button01" onclick="return fPopUpBackPerTreeDlg('');" action="#{coalTaskMgrBB.selSetPerson}"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{coalTaskMgrBB.personList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle">
				
				<h:column>
					<f:facet name="header">
						<h:outputText value="序号" />
					</f:facet>
                    <h:outputText value="#{index+1}" ></h:outputText>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="姓名" />
					</f:facet>
                    <h:outputText value="#{briefList.personId}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton value="删除" onclick="return confirm('确定要删除吗？');" styleClass="button01" action="#{coalTaskMgrBB.deletePerson}">
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


