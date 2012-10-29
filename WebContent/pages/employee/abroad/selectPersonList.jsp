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
          var reval = window.showModalDialog("/employee/abroad/personQueryList.jsf?planID="+document.all("form1:planId").value+"&orgId="+document.all("form1:orgId").value, null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
			
			if (reval != null && reval!="") {
             	var vars=reval.split("|");
             	document.all("form1:personStr").value = vars[1];
                 return true;
             } else {
                 return false;
             }
         }
         
    </script>

<x:saveState value="#{deptSelPersonBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{deptSelPersonBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="personStr" value="" />
	<h:inputHidden id="planId" value="#{deptSelPersonBB.planId}" />
	<h:inputHidden id="orgId" value="#{deptSelPersonBB.orgId}" />
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid align="right" columns="1">
						<h:commandButton value="����" onclick="return addPerson();"
							action="#{deptSelPersonBB.addPerson}" styleClass="button01"></h:commandButton>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>
			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{deptSelPersonBB.personList}"
							rowIndexVar="index" id="dateList" var="list" align="center"
							headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="100%">
							<h:column>
								<c:facet name="header">
									<f:verbatim>
				    				 	 <%=LanguageSupport.getResource("YXGL-1035", "���")%> 
               						 </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>
							<h:column>
								<f:facet name="header">
								<f:verbatim>
				    				 	 <%=LanguageSupport.getResource("RYGL-2014", "Ա������")%> 
               			       </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.personCode}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								<f:verbatim>
				    				 	 <%=LanguageSupport.getResource("MSG-0010", "����")%> 
               				     </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.name}" />
							</h:column>
							<h:column>
								<f:facet name="header">
							     <f:verbatim>
				    				 	 <%=LanguageSupport.getResource("XTGL-1183", "����")%> 
               				     </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.orgId}" />
							</h:column>
							<h:column>
								<f:facet name="header">
								 <f:verbatim>
				    				 	 <%=LanguageSupport.getResource("YXGL-1029", "����")%> 
               				     </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.deptId}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				    				 	 <%=LanguageSupport.getResource("YXGL-1026", "����")%> 
               				     </f:verbatim>
								</c:facet>
								<h:commandButton value="ɾ��" styleClass="button01"
									onclick="return confirm('ȷ��Ҫɾ����?');"
									action="#{deptSelPersonBB.deleteSelPerson}">
									<x:updateActionListener property="#{deptSelPersonBB.personId}"
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
