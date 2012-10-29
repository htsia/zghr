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
							<h:outputText value="活动名称" />
						</c:facet>
						<h:outputText value="#{list.act_name}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="方式" />
						</c:facet>
						<h:outputText value="#{list.act_method}" />
					</h:column>
					
						
					<h:column>
						<c:facet name="header">
							<h:outputText value="联系人" />
						</c:facet>
						<h:outputText value="#{list.conectionName}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="优先级" />
						</c:facet>
						<h:outputText value="#{list.level}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="状态" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="开始日期" />
						</c:facet>
						<h:outputText value="#{list.begin_date}" />
					</h:column>
					
						<h:column>
						<c:facet name="header">
							<h:outputText value="开始时间" />
						</c:facet>
						<h:outputText value="#{list.begin_time}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="结束日期" />
						</c:facet>
						<h:outputText value="#{list.end_date}" />
					</h:column>
					
				<h:column>
						<c:facet name="header">
							<h:outputText value="结束时间" />
						</c:facet>
						<h:outputText value="#{list.end_time}" />
					</h:column>
					
						
				<h:column>
						<c:facet name="header">
							<h:outputText value="提前提醒" />
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


