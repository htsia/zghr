<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">

 function contactDetailInfo(conID){
     window.showModalDialog("/crm/customer/ShowContactDetailInfo.jsf?conID="+conID, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
      return false;
 }

 function updateContact(modID){
	 window.showModalDialog("/crm/customer/ContaInfoEdit.jsf?modID="+modID, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
	 document.all('form1:query').click();
		 return false;
	 }
 
 function addContact( ){
	 window.showModalDialog("/crm/customer/ContaInfoEdit.jsf?cuId="+document.all("form1:cuid").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
	 document.all('form1:query').click();
     return false;
	 }
 
 </script>


<f:verbatim>
   
    <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="客户管理- > 联系人管理 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>
	   


  <table width="95%" align="center">
    <tr>
       <td align="right">
          </f:verbatim>
              <h:commandButton value="添加"  styleClass="button01" onclick="return addContact(); "/>
              <f:verbatim>&nbsp;</f:verbatim>
              <h:commandButton value="返回"  styleClass="button01" onclick="window.close();"/>
           <f:verbatim>
       </td>
    </tr>
     <tr>
       <td>
       </f:verbatim>
<x:saveState value="#{customerBB}"></x:saveState>
       <h:form id="form1">
	   <h:inputHidden value="#{customerBB.contacManagerInit}"></h:inputHidden>
	    <h:inputHidden id="cuid" value="#{customerBB.cuId}"></h:inputHidden>
	 <h:commandButton id="query" style="display:none"   action="#{customerBB.getContacManagerInit}" />
	<x:dataTable value="#{customerBB.conactList}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="姓 名" />
						</c:facet>
						<h:outputText value="#{list.person_name}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="主联系人" />
						</c:facet>
						<h:outputText value="#{list.primaryPerson}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="性别" />
						</c:facet>
						<h:outputText value="#{list.sex}" />
					</h:column>
						<h:column>
						<c:facet name="header">
							<h:outputText value="职务" />
						</c:facet>
						<h:outputText value="#{list.duty}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="手机" />
						</c:facet>
						<h:outputText value="#{list.mobile}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="QQ" />
						</c:facet>
						<h:outputText value="#{list.qq}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="Email" />
						</c:facet>
						<h:outputText value="#{list.email}" />
					</h:column>

					
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>
						<h:commandButton styleClass="button01" value="查看" onclick="return contactDetailInfo('#{list.person_id}') ;"></h:commandButton>
						<f:verbatim>&nbsp;</f:verbatim> 
						<h:commandButton styleClass="button01" value="修改" onclick="return updateContact('#{list.person_id}') ;">
						<x:updateActionListener value="#{list.cu_id}" property="#{customerBB.contactBO.cu_id}"></x:updateActionListener>
						</h:commandButton> 
						<f:verbatim>&nbsp;</f:verbatim> 
						<h:commandButton styleClass="button01" onclick="return confirm('确定要删除吗？');"  action="#{customerBB.delConact}" value="删除" >
							<x:updateActionListener value="#{list.person_id}" property="#{customerBB.contactBO.person_id}"></x:updateActionListener>
						</h:commandButton> >
						
					</h:column>
				</x:dataTable>
</h:form>
       <f:verbatim>
       </td>
    </tr>
  </table>
</f:verbatim>

<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>

