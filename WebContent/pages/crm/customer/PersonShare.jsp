<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">

   function selectPerson(cuId){
	   window.showModalDialog("/crm/customer/SelectPersonItem.jsf?cuId="+cuId, null, "dialogWidth:400px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
	   return true;
	   }
  function editShare(shareId ){
	  window.showModalDialog("/crm/customer/ShareEdit.jsf?shareId="+shareId , null, "dialogWidth:300px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
	  return true;
	  }
 </script>
<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{customerBB.shareInit}"></h:inputHidden>
<h:inputHidden value="#{customerBB.cuId}"></h:inputHidden>
<f:verbatim>

  <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="�ͻ�����- > �������� " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>

   <table width="95%" border="0" align="center"  class="table01">
  <tr>
   <td colspan="2">
     </f:verbatim>
            <h:outputLabel style="f141" value="#{customerBB.customerBO.cu_name}��������"></h:outputLabel>
     <f:verbatim> 
     </td>
      <td colspan="2" align="right"> 
        </f:verbatim>  
            <h:commandButton  styleClass="button01"  value="ѡ������Ա"  onclick="return selectPerson('#{customerBB.customerBO.cu_id}') ;" />
            <h:commandButton value="����"  styleClass="button01"  onclick="return window.close();"/>
     <f:verbatim>
      </td>
  </tr>
  <tr>
    <td colspan="4"> 
      </f:verbatim>    
  <x:dataTable value="#{customerBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_left,td_middle_center,td_middle_center,td_middle_center,td_middle_left,
					td_middle_left,td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="������Ա" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="Ȩ��" />
						</c:facet> 
						<h:outputText value="#{list.power =='2'?'��д':'ֻ��'}" />
					</h:column>
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="�������" />
						</f:facet>
						<h:commandButton   styleClass="button01" value="����"  action="#{customerBB.cancleShare}"   >
						   <x:updateActionListener value="#{list.shareId}" property="#{customerBB.shareBO.shareId}"></x:updateActionListener>
						</h:commandButton>
						<h:commandButton   styleClass="button01" value="�༭"   onclick="return editShare('#{list.shareId}');">
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
