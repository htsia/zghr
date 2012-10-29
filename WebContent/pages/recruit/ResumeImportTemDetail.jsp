<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
        
         function add(){
        	 window.showModalDialog("/recruit/ResumeTempItemEdit.jsf?templateId="+document.all("form1:templateId").value, "", "dialogWidth:315px; dialogHeight:200px; status:0;resizable:yes");
             return true;
         }
         function modify(id){
        	 window.showModalDialog("/recruit/ResumeTempItemEdit.jsf?itemId="+id, "", "dialogWidth:315px; dialogHeight:200px; status:0;resizable:yes");
             return true;
         }
    </script>

<x:saveState value="#{resumeImportTemBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{resumeImportTemBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="templateId" value="#{resumeImportTemBB.templateId}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
			
            <tr>
            <td height="10" align="right" valign="top">
            	</c:verbatim>
            		<h:commandButton value="����" onclick="return add()" styleClass="button01"></h:commandButton>
            	<c:verbatim>
            </td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{resumeImportTemBB.itemList}" rowIndexVar="index"
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
                            <h:outputText value="��Ӧ����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.setId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="��Ӧ�ֶ�"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.fieldId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="������ʼ"/>
                        </f:facet>
                        <h:inputText value="#{list.tagBegin}" readonly="true"></h:inputText>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="��������"/>
                        </f:facet>
                        <h:inputText value="#{list.tagEnd}" readonly="true"></h:inputText>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�༭" styleClass="button01" onclick="modify('#{list.itemId}')"></h:commandButton>
            			<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{resumeImportTemBB.deleteItem}" styleClass="button01">
                  	        <x:updateActionListener property="#{resumeImportTemBB.itemId}" value="#{list.itemId}"/>
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
