<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<script type="text/javascript">
 function selectPersonItem(actId){
     window.showModalDialog("/crm/action/actionFrame.jsf?actId="+actId, null, "dialogWidth:400px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:yes;");
     return true;
 }
</script>

<x:saveState value="#{actionBB}"></x:saveState>
  <h:form id="form1">
   <h:inputHidden  value="#{actionBB.insertContactInit}"/>
   <h:inputHidden  value="#{actionBB.actId}"/>
  <f:verbatim>
   <table width="102%">
		    <tr>
		      <td class="td_title" width="102%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  rendered="#{compPersonBB.flag == 1}"/>
			   <h:outputText value="活动管理 - > 参与者管理 " rendered="#{compPersonBB.flag == 1}"></h:outputText></td>
		      <f:verbatim>
		      </tr>
	    </table>
  
  
  
    <table width="95%"  align="center"  >
  <tr>
     <td>
      </f:verbatim>
     <h:outputLabel value="当前活动  :  #{actionBB.actionBO.act_name}" styleClass="f04" ></h:outputLabel>
    <f:verbatim>
     </td>
    <td><div align="right">
    </f:verbatim>
    <h:commandButton value="选择人员"   onclick="return selectPersonItem('#{actionBB.actId}');"  styleClass="button01" />
    <f:verbatim>&nbsp;</f:verbatim>
    <h:commandButton value="返回"  onclick="window.close();"  styleClass="button01" />
    <f:verbatim>
    </div></td>
  </tr>
  </table>
   <table width="95%" border="1" align="center"  class="table02">
  <tr>
    <td colspan="2">
     </f:verbatim>
        <x:dataTable value="#{actionBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses=" td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="手机" />
						</c:facet>
						<h:outputText value="#{list.perMobile}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="Email" />
						</c:facet>
						<h:outputText value="#{list.perEmail}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="QQ" />
						</c:facet>
						<h:outputText value="#{list.QQ}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="人员类型" />
						</c:facet>
						<h:outputText value="#{list.personType}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
					    <h:commandButton styleClass="button01" onclick="return confirm('确定要删除吗？');"  action="#{actionBB.deleteActionPerson}" value="删除" >
						<x:updateActionListener value="#{list.item_id}" property="#{actionBB.actionPersonBO.item_id}"></x:updateActionListener>
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
 