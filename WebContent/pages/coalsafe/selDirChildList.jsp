<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doSelItem(name,id){
        window.returnValue=name+","+id;
        window.close();
    }
</script>

<x:saveState value="#{selAmerceStdSetBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{selAmerceStdSetBB.pageInit}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		<h:outputText value="记录数:#{selAmerceStdSetBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{selAmerceStdSetBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{selAmerceStdSetBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{selAmerceStdSetBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{selAmerceStdSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{selAmerceStdSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{selAmerceStdSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{selAmerceStdSetBB.last}" styleClass="button01"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{selAmerceStdSetBB.stdList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center" >
				<h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton value="选择" onclick="doSelItem('#{briefList.itemNum}','#{briefList.itemId}');" styleClass="button01"></h:commandButton>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="编号" />
					</f:facet>
                    <h:outputText value="#{briefList.itemNum}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="违法项目" />
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="扣分标准" />
					</f:facet>
                    <h:outputText value="#{briefList.itemScore}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="罚款" />
					</f:facet>
                    <h:outputText value="#{briefList.amerce}" ></h:outputText>
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


