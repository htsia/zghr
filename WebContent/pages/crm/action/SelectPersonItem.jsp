<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
  
 </script>
<x:saveState value="#{actionBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{actionBB.selectPersonInit}"></h:inputHidden>
<h:inputHidden value="#{actionBB.actId}"></h:inputHidden>
<f:verbatim>
<br><br>
	<table width="95%" border="0" align="center" class="table02">
		<tr>
			<td align="center"   class="td_form01">
			 </f:verbatim>
			    <x:dataTable value="#{actionBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">
					<h:column>
						<c:facet name="header">
							<h:outputText value="选择" />
						</c:facet>
						<h:commandLink action="#{actionBB.saveActionPerson}">
						  <h:outputText value="选择"></h:outputText>
						  <x:updateActionListener value="#{list.personId}" property="#{actionBB.actionPersonBO.person_id}"></x:updateActionListener>
						</h:commandLink>
					</h:column>
					 <h:column>
						<c:facet name="header">
							<h:outputText value="人员姓名" />
						</c:facet>
						<h:outputText value="#{list.name }" />
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
