<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">

 function addCustomer(){
     window.showModalDialog("/crm/customer/CustomerEdit.jsf?init=true", null, "dialogWidth:700px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:yes;");
     document.all('form1:query').click();
     return false;
 }

 function goTo(url){
	 window.open (url,'newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
     return false;
 }

 function competitionPerson(cuidd){
     window.showModalDialog("/crm/customer/CompetitionPersonMger.jsf?cuidd="+cuidd, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     return false;
 }
 function contactManager(cuidd){
     window.showModalDialog("/crm/customer/ContactManager.jsf?cuidd="+cuidd, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     document.all('form1:query').click();
     return false;
 }
 
 function updateCustomer(crmID){
	 window.showModalDialog("/crm/customer/CustomerEdit.jsf?crmID="+crmID, null, "dialogWidth:700px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
	 document.all('form1:query').click();
	 return false;
 }

 function showDetailInfo(identity){
	 window.showModalDialog("/crm/customer/CustomerDetailMainFrame.jsf?cuId="+identity, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
	     return false;
	 }
 function shareSet(cusId){
		 window.showModalDialog("/crm/customer/PersonShare.jsf?cuId="+cusId, null, "dialogWidth:400px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
	    return false;
		 }

 function addAction(cuId){
		 window.showModalDialog("/crm/customer/AddAction.jsf?cuId="+cuId, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
		  return false;
		 }
 </script>

 <x:saveState value="#{customerBB}"></x:saveState>
 
 <h:form id="form1">
  <h:inputHidden value="#{customerBB.pageInit}"></h:inputHidden>
   <h:inputHidden value="#{customerBB.cuType}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" align="center">
  <tr>
    <td align="right">
</f:verbatim> 
  <h:panelGroup >
            <h:commandButton value="增加客户"   onclick="return addCustomer();" styleClass="button01"></h:commandButton>
             <h:commandButton id="query" style="display:none"  value="查询" action="#{customerBB.doQuery}" />
        </h:panelGroup>
<f:verbatim>  

    </td>
  </tr>
  <tr>
    <td>
 </f:verbatim>    
  <x:dataTable value="#{customerBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_left,td_middle_left,td_middle_left,td_middle_left,td_middle_left,
					td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="客户名称" />
						</c:facet>
						<h:outputText value="#{list.cu_name}" />
					</h:column>
					
				 
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="主联系人" />
						</c:facet>
						<h:outputText value="#{list.priName}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="城市" />
						</c:facet>
						<h:outputText value="#{list.cu_city}" />
					</h:column>
					 

					
					<h:column>
						<c:facet name="header">
							<h:outputText value="客户网站" />
						</c:facet>
						<f:verbatim>
						 <a  target="blank"   href="</f:verbatim>
						   	<h:outputText value="//#{list.web_url}"/> 
						 <f:verbatim>">
						 </f:verbatim>
						 	<h:outputText value="#{list.web_url}"/> 
						 <f:verbatim>
						 </a>
						</f:verbatim>
					</h:column>
					
										
					<h:column>
						<c:facet name="header">
							<h:outputText value="客户级别" />
						</c:facet>
						<h:outputText value="#{list.customerLevel}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="客户类型" />
						</c:facet>
						<h:outputText value="#{list.cu_type}" />
					</h:column>
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>
						<h:commandButton rendered ="#{list.power == '2'}" styleClass="button01" value="联系人" onclick="return contactManager('#{list.cu_id}');"  ></h:commandButton>
						<h:commandButton  styleClass="button01" value="查看" onclick="return showDetailInfo('#{list.cu_id}') ;"></h:commandButton> >
						<h:commandButton rendered ="#{list.power == '2'}" styleClass="button01" value="修改" onclick="return updateCustomer('#{list.cu_id}') ;"></h:commandButton> >
						<h:commandButton rendered ="#{list.power == '2'}" styleClass="button01" onclick="return confirm('确定要删除吗？');" action="#{customerBB.delCustomer}" value="删除" >
							<x:updateActionListener value="#{list.cu_id}" property="#{customerBB.customerBO.cu_id}"></x:updateActionListener>
						</h:commandButton> 
						 <h:commandButton rendered ="#{list.share == '2'}"  styleClass="button01" value="共享设置"   onclick="return shareSet('#{list.cu_id}');"  ></h:commandButton>
						 <h:commandButton rendered ="#{list.power == '2'}" styleClass="button01" value="添加活动" onclick="return addAction('#{list.cu_id}') ;"></h:commandButton> >
						 <h:commandButton rendered ="#{list.power == '2'}" styleClass="button01" value="竞争对手" onclick="return competitionPerson('#{list.cu_id}');"  ></h:commandButton>
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









