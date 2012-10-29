<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">

 function showDetailInfo(identity){
	 window.showModalDialog("/crm/customer/DetailMainFrame.jsf?cuId="+identity, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
	     return false;
	 }
 </script>

 <x:saveState value="#{customerViewBB}"></x:saveState>
 <h:form id="form1">
<f:verbatim>
<table width="100%" border="0" align="center">
  <tr>
     <td align="right">
     </f:verbatim>
       <h:commandButton  styleClass="button01" value="返回" action= "#{customerViewBB.goBack}"></h:commandButton>
     <f:verbatim>
     </td>
  </tr>
  <tr>
    <td>
 </f:verbatim>    
  <x:dataTable value="#{customerViewBB.list}" id="dateList"
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
						<h:commandButton  styleClass="button01" value="查看" onclick="return showDetailInfo('#{list.cu_id}') ;"></h:commandButton> >
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









