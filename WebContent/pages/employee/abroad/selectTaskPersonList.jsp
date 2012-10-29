<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function addPerson(){
          var reval = window.showModalDialog("/employee/abroad/taskPersonQuery.jsf?taskId="+document.all("form1:taskId").value+"&orgId="+document.all("form1:orgId").value, null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
			
			if (reval != null && reval!="") {
             	var vars=reval.split("|");
             	document.all("form1:personStr").value = vars[1];
                 return true;
             } else {
                 return false;
             }
         }
         
    </script>

<x:saveState value="#{taskSelPersonBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{taskSelPersonBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="personStr" value="" />
	<h:inputHidden id="taskId" value="#{taskSelPersonBB.taskId}" />
	<h:inputHidden id="orgId" value="#{taskSelPersonBB.orgId}" />
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid align="right" columns="1">
						<h:commandButton value="增加" onclick="return addPerson();"
							action="#{taskSelPersonBB.addPerson}" styleClass="button01"></h:commandButton>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>
			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{taskSelPersonBB.personList}"
							rowIndexVar="index" id="dateList" var="list" align="center"
							headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="100%">
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
				    				 	 <%=LanguageSupport.getResource("YXGL-1035", "序号")%> 
               						 </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>
							<h:column>
								<f:facet name="header">
									 <f:verbatim>
				    				 	 <%=LanguageSupport.getResource("RYGL-2014", "员工编码")%> 
               						 </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.personCode}" />
							</h:column>

							<h:column>
								<f:facet name="header">
									 <f:verbatim>
				    				 	 <%=LanguageSupport.getResource("MSG-0010", "姓名")%>
               						 </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.name}" />
							</h:column>
							<h:column>
								<f:facet name="header">
								 <f:verbatim>
				    				 	 <%=LanguageSupport.getResource("XTGL-1183", "机构")%> 
               					  </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.orgId}" />
							</h:column>
							<h:column>
								<f:facet name="header">
								<f:verbatim>
				    				 	 <%=LanguageSupport.getResource("GWGL-1017", "部门")%> 
               					  </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.deptId}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<f:verbatim>
				    				 	 <%=LanguageSupport.getResource("YXGL-1026", "操作")%> 
               					 </f:verbatim>
								</c:facet>
								<h:commandButton value="删除" styleClass="button01"
									onclick="return confirm('确定要删除吗?');"
									action="#{taskSelPersonBB.deleteSelPerson}">
									<x:updateActionListener property="#{taskSelPersonBB.personId}"
										value="#{list.personId}" />
								</h:commandButton>
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
