<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden  value="#{customerBB.contactInit}"/>
<f:verbatim>
<table width="95%"   border="1" align="center" class="table02" >
    <tr>
    <td colspan="4">
    </f:verbatim>
        <x:dataTable value="#{customerBB.conactList}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_left,td_middle_center,td_middle_center,td_middle_center,td_middle_left,
					td_middle_left,td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.person_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="性别" />
						</c:facet>
						<h:outputText value="#{list.sex}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="手机" />
						</c:facet>
						<h:outputText value="#{list.mobile}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="办公电话" />
						</c:facet>
						<h:outputText value="#{list.office_tel}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="Email" />
						</c:facet>
						<h:outputText value="#{list.email}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="MSN" />
						</c:facet>
						<h:outputText value="#{list.msn}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="传真" />
						</c:facet>
						<h:outputText value="#{list.fax}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="QQ" />
						</c:facet>
						<h:outputText value="#{list.qq}" />
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


