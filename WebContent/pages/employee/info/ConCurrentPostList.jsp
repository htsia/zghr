<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function addConPost(){
         window.showModalDialog("/employee/info/ConCurrentPersonAdd.jsf", "", "dialogWidth:365px; dialogHeight:270px; status:0;resizable:yes");
         return true;
     }
    function CancelConPost(id){
        window.showModalDialog("/employee/info/ConCurrentPersonCancel.jsf?ID="+id, "", "dialogWidth:500px; dialogHeight:230px; status:0;resizable:yes");
        return true;
    }
</script>


<x:saveState value="#{emp_ConPostListBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emp_ConPostListBB.pageInit}"></h:inputHidden>
	<h:inputHidden value="#{emp_ConPostListBB.superId}"></h:inputHidden>
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8px align="right">
    </f:verbatim>
                   <h:commandButton value="增加"	styleClass="button01" onclick="return addConPost();"></h:commandButton>
					<f:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{emp_ConPostListBB.personList}" var="list"
							align="center" id="dateList" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="90%">
							<h:column>
								<c:facet name="header">
									 <f:verbatim>
						                   <%=LanguageSupport.getResource("XTGL-1042","员工编号")%>
						              </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personCode}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2136","员工姓名")%>
               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									  <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2284","主单位")%>
               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.mainOrgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									 <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2288","兼职单位")%>1
               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.conOrguid1Name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2285","兼职部门")%>1
               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.conDeptid1Name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								  <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2288","兼职单位")%>2
               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.conOrguid2Name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2285","兼职部门")%>2
               </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.conDeptid2Name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									 <f:verbatim>
                   <%=LanguageSupport.getResource("YXGL-1026","操作")%>
               </f:verbatim>
								</c:facet>
								<h:commandButton value="取消兼职" styleClass="button01"
									onclick="return CancelConPost('#{list.personID}')"></h:commandButton>
							</h:column>
						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
