<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function showdetail(detailId){
        	 window.showModalDialog("/employee/title/auditGroupPersonList.jsf?groupId="+detailId, "", "dialogWidth:650px; dialogHeight:400px; status:0;resizable:yes");
             return true;  
         }
         function add(){
        	 window.showModalDialog("/employee/title/groupEdit.jsf?applyId="+document.all("form1:applyid").value, "", "dialogWidth:300px; dialogHeight:100px; status:0;resizable:yes");
             return true;  
         }
         function modify(id){
        	 window.showModalDialog("/employee/title/groupEdit.jsf?groupId="+id, "", "dialogWidth:300px; dialogHeight:100px; status:0;resizable:yes");
             return true;  
         }
</script>

<x:saveState value="#{emptitleauditgroupmgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitleauditgroupmgrBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="applyid" value="#{emptitleauditgroupmgrBB.applyId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <h:outputText value="��¼��:#{emptitleauditgroupmgrBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ҳ��:#{emptitleauditgroupmgrBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ÿҳ��#{emptitleauditgroupmgrBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="��ǰΪ��#{emptitleauditgroupmgrBB.mypage.currentPage}ҳ"></h:outputText>
			           		<h:commandButton value="��ҳ" action="#{emptitleauditgroupmgrBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleauditgroupmgrBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{emptitleauditgroupmgrBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="βҳ" action="#{emptitleauditgroupmgrBB.last}" styleClass="button01"></h:commandButton>
				            <h:outputText value="  "></h:outputText>
				            <h:commandButton value="����" styleClass="button01" onclick="add()"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitleauditgroupmgrBB.groupList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.groupName}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�鿴��Ա" styleClass="button01" onclick="showdetail('#{list.groupId}')"></h:commandButton>
						<h:commandButton value="�༭" styleClass="button01" onclick="modify('#{list.groupId}')"></h:commandButton>
						<h:commandButton value="ɾ��" action="#{emptitleauditgroupmgrBB.deleteGroup}" styleClass="button01">
							<x:updateActionListener property="#{emptitleauditgroupmgrBB.groupId}" value="#{list.groupId}"/>
						</h:commandButton>
					</h:column>
				</x:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
