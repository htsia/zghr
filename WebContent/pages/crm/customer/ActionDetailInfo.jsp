<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden  value="#{customerBB.actionInit}"/>
<f:verbatim>
<table width="95%"   border="1" align="center" class="table02" >
     <tr>
    <td colspan="4">
    </f:verbatim>
        <x:dataTable value="#{customerBB.activeList}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="�����" />
						</c:facet>
						<h:outputText value="#{list.act_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ʽ" />
						</c:facet>
						<h:outputText value="#{list.act_method}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ϵ��" />
						</c:facet>
						<h:outputText value="#{list.conectionName}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="���ȼ�" />
						</c:facet>
						<h:outputText value="#{list.level}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="״̬" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ʼ����" />
						</c:facet>
						<h:outputText value="#{list.begin_date}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="��ʼʱ��" />
						</c:facet>
						<h:outputText value="#{list.begin_time}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.end_date}" />
					</h:column>
					
				<h:column>
						<c:facet name="header">
							<h:outputText value="����ʱ��" />
						</c:facet>
						<h:outputText value="#{list.end_time}" />
					</h:column>
					
						
				<h:column>
						<c:facet name="header">
							<h:outputText value="��ǰ����" />
						</c:facet>
						<h:outputText value="#{list.alert_day}" />
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


