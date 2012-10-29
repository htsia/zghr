
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
 function groupEdit(gpId){
     window.showModalDialog("/crm/system/EditGroup.jsf?gpId="+gpId, null, "dialogWidth:600px; dialogHeight:350px;center:center;resizable:no;status:no;scroll:yes;");
     document.all('form1:query').click();
     return false;
 }

 function memberManager(gpId){
     window.showModalDialog("/crm/system/MemberManager.jsf?gpId="+gpId, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     return false;
 }

 function showActionDetail(act_id){
     window.showModalDialog("/crm/action/ActionDetailInfo.jsf?act_id="+act_id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
     return false ;
 	 }
</script>

<x:saveState value="#{groupBB}"></x:saveState>
 <h:form id="form1">
  <h:inputHidden value="#{groupBB.pageInit}"></h:inputHidden>
<f:verbatim>
<table width="98%" border="0" align="center">
  <tr>
    <td align="right">
</f:verbatim> 
  <h:panelGroup>
            <h:outputText value="��¼��:#{groupBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ҳ��:#{groupBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{groupBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{groupBB.pagevo.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{groupBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{groupBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{groupBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{groupBB.last}" styleClass="button01"></h:commandButton>
            <f:verbatim>&nbsp;</f:verbatim>
            <h:commandButton value="����Ŷ�" onclick="return groupEdit('');" styleClass="button01"></h:commandButton>
            <h:commandButton id="query"  action="#{groupBB.doQuery}"  style="display:none"/>
        </h:panelGroup>
<f:verbatim>  

    </td>
  </tr>
  <tr>
    <td>
 </f:verbatim>    
  <x:dataTable value="#{groupBB.groupList}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ŷӱ��" />
						</c:facet>
						<h:outputText value="#{list.groupId}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ŷ�����" />
						</c:facet>
						<h:outputText value="#{list.groupName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" />
						</f:facet>
						 <h:commandButton styleClass="button01" value="��Ա����" onclick="return memberManager('#{list.groupId}');"  ></h:commandButton>
						<h:commandButton styleClass="button01" value="�޸�" onclick="return groupEdit('#{list.groupId}') ;"></h:commandButton> >
						<h:commandButton styleClass="button01" onclick="return confirm('ȷ��Ҫɾ����');" action="#{groupBB.delGroup}" value="ɾ��" >
							<x:updateActionListener value="#{list.groupId}" property="#{groupBB.group.groupId}"></x:updateActionListener>
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









