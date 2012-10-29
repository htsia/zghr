<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddItem(){
        var dirId=document.all('form1:dirId').value;
        if (dirId==null || dirId==""){
            alert("请先选择目录！");
            return false;
        }
        window.showModalDialog("/coalsafe/amerceStdEdit.jsf?dirId="+dirId, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyItem(id){
        window.showModalDialog("/coalsafe/amerceStdEdit.jsf?itemId="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    
</script>

<x:saveState value="#{cocalAmerceStdSetBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{cocalAmerceStdSetBB.pageInit}"></h:inputHidden>
      <h:inputHidden id="dirId" value="#{cocalAmerceStdSetBB.dirId}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		<h:outputText value="记录数:#{cocalAmerceStdSetBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{cocalAmerceStdSetBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{cocalAmerceStdSetBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{cocalAmerceStdSetBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{cocalAmerceStdSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{cocalAmerceStdSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{cocalAmerceStdSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{cocalAmerceStdSetBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
                <h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{cocalAmerceStdSetBB.dirItemList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

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
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton value="修改" onclick="doModifyItem('#{briefList.itemId}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="删除" onclick="return confirm('确定要删除吗？');" styleClass="button01" action="#{cocalAmerceStdSetBB.deleteItem}">
                          <x:updateActionListener property="#{cocalAmerceStdSetBB.itemId}" value="#{briefList.itemId}"/>
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


