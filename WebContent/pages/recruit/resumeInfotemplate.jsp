<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function showdetail(detailId){
        	 window.showModalDialog("/recruit/ResumeImportTemDetail.jsf?templateId="+detailId, null, "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
        	 return true;
         }
         function addTemp(){
        	 window.showModalDialog("/recruit/ResumeTempEdit.jsf", "", "dialogWidth:315px; dialogHeight:200px; status:0;resizable:yes");
             return true;
         }
    </script>

<x:saveState value="#{resumeImportTemBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{resumeImportTemBB.temInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center" >
			<tr>
            <td class="td_title" height="10"><img src="/images/tips.gif"> 招聘管理 -> 简历模版定义
            </td>
            </tr>
            <tr>
            <td height="10" align="right" valign="top">
            	</c:verbatim>
            		<h:commandButton value="增加" onclick="return addTemp()" styleClass="button01"></h:commandButton>
            	<c:verbatim>
            </td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{resumeImportTemBB.temlateList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="序号"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="模版名称"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.templateName}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="是否启用"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.isUse}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="模版定义" styleClass="button01" onclick="showdetail('#{list.templateId}')"></h:commandButton>
            			<h:commandButton value="启用" onclick="return confirm('确定要启用吗?');" action="#{resumeImportTemBB.open}" styleClass="button01" rendered="#{list.isUse=='否'}">
                  	        <x:updateActionListener property="#{resumeImportTemBB.templateId}" value="#{list.templateId}"/>
            			</h:commandButton>
            			<h:commandButton value="禁用" onclick="return confirm('确定要禁用吗?');" action="#{resumeImportTemBB.close}" styleClass="button01" rendered="#{list.isUse=='是'}">
                  	        <x:updateActionListener property="#{resumeImportTemBB.templateId}" value="#{list.templateId}"/>
            			</h:commandButton>
            			<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{resumeImportTemBB.delete}" styleClass="button01">
                  	        <x:updateActionListener property="#{resumeImportTemBB.templateId}" value="#{list.templateId}"/>
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
