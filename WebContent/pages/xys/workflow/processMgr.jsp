<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="/pages/include/taglib.jsp"%>

<script type="text/javascript">
    
    function addFlow(){
        window.showModalDialog("/xys/workflow/processEdit.jsf", null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function showImg(id){
    	window.showModalDialog("/pages/xys/workflow/showImg.jsp?processDefinitionId="+id, null, "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>
<x:saveState value="#{processMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="pageInit"	value="#{processMgrBB.pageInit}" />
	<c:verbatim>
		<br/>
		<table height="96%" width="99%" align="center">
			<tr>
				<td height=8 align="right"></c:verbatim>
						<h:outputText value="全部流程"></h:outputText>
						<h:selectBooleanCheckbox value="#{processMgrBB.selAll}" onclick="submit();" valueChangeListener="#{processMgrBB.selAllProcess}"></h:selectBooleanCheckbox>
                        <h:commandButton value="部署流程" onclick="return addFlow();" styleClass="button01"></h:commandButton>
                    <c:verbatim>
				</td>
			</tr>
			<tr><td height=8>&nbsp;</td></tr>
			<tr>
				<td valign="top">
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{processMgrBB.flowList}" var="list"
							align="center" id="dateList" rowIndexVar="index"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle"
							styleClass="table03" width="100%">
							<h:column>
								<c:facet name="header">
								   <h:outputText value="序号"/>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column >
								<c:facet name="header" >
								 <h:outputText value="名称"/>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>
							<h:column >
								<c:facet name="header" >
								 <h:outputText value="key"/>
								</c:facet>
								<h:outputText value="#{list.key}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="版本号"/>
								</c:facet>
								<h:outputText value="#{list.version}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								 <h:outputText value="操作"/>
								</c:facet>
								<h:commandButton styleClass="button01" value="查看流程图" type="button" onclick="showImg('#{list.id}');"></h:commandButton>
								<h:commandButton styleClass="button01" value="删除" action="#{processMgrBB.deleteFlow}">
									<x:updateActionListener value="#{list.deploymentId}" property="#{processMgrBB.deploymentId}"></x:updateActionListener>
								</h:commandButton>
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

