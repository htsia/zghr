<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function modify(id){
        	 window.showModalDialog("/employee/title/applyContentEdit.jsf?templateId="+id, "", "dialogWidth:350px; dialogHeight:250px; status:0;resizable:yes");
             return true;  
         }
         function add(){
        	 window.showModalDialog("/employee/title/applyContentEdit.jsf?applyId="+document.all('form1:applyId').value, "", "dialogWidth:350px; dialogHeight:250px; status:0;resizable:yes");
             return true;  
         }
         function doSetContent(id){
        	 window.showModalDialog("/employee/title/applyContentSetIndex.jsf?templateId="+id, "", "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:yes");
             return true;  
         }
         function showSetContent(id){
        	 window.showModalDialog("/pages/employee/title/applyContentShow.jsp?templateId="+id, "", "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:yes");
             return true;  
         }
    </script>

<x:saveState value="#{titleContentSetBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{titleContentSetBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="applyId" value="#{titleContentSetBB.applyId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
	            			<h:commandButton value="����" onclick="return add();" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{titleContentSetBB.tempList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="ģ������"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.templateName}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="����ʱ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.createTime}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="������"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.createPid}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ȼ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.levelId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ܷ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.totalScore}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="״̬"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:panelGrid columns="5">
						<h:commandButton value="�༭" styleClass="button01" onclick="modify('#{list.templateId}')" rendered="#{list.status=='0'}"></h:commandButton>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{titleContentSetBB.deleteTemp}" styleClass="button01" rendered="#{list.status=='0'}">
                  	        <x:updateActionListener property="#{titleContentSetBB.templateId}" value="#{list.templateId}"/>
            			</h:commandButton>
            			<h:commandButton value="����" styleClass="button01" onclick="doSetContent('#{list.templateId}')" ></h:commandButton>
            			<h:commandButton value="����" onclick="return confirm('�������ܱ༭��ɾ��,ȷ��������?');" action="#{titleContentSetBB.clockTemp}" styleClass="button01" rendered="#{list.status=='0'}">
                  	        <x:updateActionListener property="#{titleContentSetBB.templateId}" value="#{list.templateId}"/>
            			</h:commandButton>
            			<h:commandButton value="Ԥ��" styleClass="button01" onclick="showSetContent('#{list.templateId}')" ></h:commandButton>
            			</h:panelGrid>
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
