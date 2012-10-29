<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function showdetail(detailId){
        	 window.open('/pages/recruit/personResume.jsp?recuMailId='+detailId, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
         }
         function importTemp(recuMailId){
        	 window.showModalDialog("/recruit/ResumeImport.jsf?recuMailId="+recuMailId, "", "dialogWidth:350px; dialogHeight:250px; status:0;resizable:yes");
             return true;  
         }
         function showEmailBoxList(){
        	 window.showModalDialog("/recruit/showEmailBoxList.jsf", "", "dialogWidth:"+0.5*screen.width+"px; dialogHeight:300px; status:0;resizable:yes");
             return true;  
         }
    </script>

<x:saveState value="#{resumeemaillistBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{resumeemaillistBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			             	<h:commandButton value="���ý�������" styleClass="button01" onclick="showEmailBoxList()"></h:commandButton>
			             	<h:outputText value="  "></h:outputText>
			                <h:outputText value="��¼��:#{resumeemaillistBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ҳ��:#{resumeemaillistBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="ÿҳ��#{resumeemaillistBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="��ǰΪ��#{resumeemaillistBB.mypage.currentPage}ҳ"></h:outputText>
			           		<h:commandButton value="��ҳ" action="#{resumeemaillistBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{resumeemaillistBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="��ҳ" action="#{resumeemaillistBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="βҳ" action="#{resumeemaillistBB.last}" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{resumeemaillistBB.mailList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ʼ�����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.sender}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="����ʱ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.sendDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�Ƿ��Ѷ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.isRead}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="��������"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.orgId}"/>
                    </h:column>
                    
                    <h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�鿴��ϸ" styleClass="button01" onclick="showdetail('#{list.recuMailId}')"></h:commandButton>
						<h:commandButton value="����" styleClass="button01" onclick="importTemp('#{list.recuMailId}')"></h:commandButton>
                        <h:commandButton value="ɾ��" styleClass="button01" action="#{resumeemaillistBB.deleteMail}" onclick="return confirm('ȷ��ɾ�����ʼ���');">
                            <x:updateActionListener property="#{resumeemaillistBB.recuMailId}" value="#{list.recuMailId}"/>
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
