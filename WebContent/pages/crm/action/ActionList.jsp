
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
 function editActiont(act_id){
     window.showModalDialog("/crm/action/EditAction.jsf?actId="+act_id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
     document.all('form1:query').click();
     return false;
 }
 function addAction(){
     window.showModalDialog("/crm/action/EditAction.jsf", null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
     document.all('form1:query').click();
     return false;
 }

 

 function addJoinner(actId){
     window.showModalDialog("/crm/action/addContactToAction.jsf?actId="+actId, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     return false;
 }

 function showActionDetail(act_id){
     window.showModalDialog("/crm/action/ActionDetailMainFrame.jsf?actId="+act_id, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     return false ;
 	 }
</script>



<x:saveState value="#{actionBB}"></x:saveState>
 <h:form id="form1">
  <h:inputHidden value="#{actionBB.pageInit}"></h:inputHidden>
<f:verbatim>
<table width="98%" border="0" align="center">
  <tr>
    <td align="right">
</f:verbatim> 
  <h:panelGroup>
            <h:outputText value="记录数:#{actionBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="页数:#{actionBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="每页有#{actionBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="当前为第#{actionBB.pagevo.currentPage}页"></h:outputText>
            <h:commandButton value="首页" action="#{actionBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{actionBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{actionBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{actionBB.last}" styleClass="button01"></h:commandButton>
            <f:verbatim>&nbsp;</f:verbatim>
            <h:commandButton value="添加活动" onclick="return addAction();" styleClass="button01"></h:commandButton>
            <h:commandButton id="query"  action="#{actionBB.doQuery}"  style="display:none"/>
        </h:panelGroup>
<f:verbatim>  

    </td>
  </tr>
  <tr>
    <td>
 </f:verbatim>    
  <x:dataTable value="#{actionBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="活动名称" />
						</c:facet>
						<h:outputText value="#{list.act_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="活动方式" />
						</c:facet>
						<h:outputText value="#{list.act_method}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="客户" />
						</c:facet>
						<h:outputText value="#{list.customerName}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="联系人" />
						</c:facet>
						<h:outputText value="#{list.conectionName}" />
					</h:column>
					
					
				
					<h:column>
						<c:facet name="header">
							<h:outputText value="优先级" />
						</c:facet>
						<h:outputText value="#{list.level}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="状态" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
				
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>
						<h:commandButton styleClass="button01" value="参与者管理" onclick="return addJoinner('#{list.act_id}');" ></h:commandButton>
						 <f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01" onclick="return showActionDetail('#{list.act_id}') ;" value="查看" ></h:commandButton>
						 <f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01" onclick="return editActiont('#{list.act_id}') ;" value="修改" ></h:commandButton>
					    <f:verbatim>&nbsp;</f:verbatim>
						<h:commandButton styleClass="button01" onclick="return confirm('确定要删除吗？');"  action="#{actionBB.delAction}" value="删除" >
						<x:updateActionListener value="#{list.act_id}" property="#{actionBB.actionBO.act_id}"></x:updateActionListener>
						</h:commandButton>
						
					</h:column>
					
				</x:dataTable>
 
 <f:verbatim>
    </td>
  </tr>
</table>
</f:verbatim>
 </h:form>

<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>









