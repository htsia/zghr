<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<x:saveState value="#{actionBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden  value="#{actionBB.joinerInit}"/>
<h:inputHidden  value="#{actionBB.actId}"/>
<h:panelGrid columns="1" width="100%" align="center" styleClass="table02">
<x:dataTable value="#{actionBB.list}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses=" td_middle_left,td_middle_left,td_middle_left,td_middle_left,td_middle_center">

					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="手机" />
						</c:facet>
						<h:outputText value="#{list.perMobile}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="Email" />
						</c:facet>
						<h:outputText value="#{list.perEmail}" />
					</h:column>
					
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="QQ" />
						</c:facet>
						<h:outputText value="#{list.QQ}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="人员类型" />
						</c:facet>
						<h:outputText value="#{list.personType}" />
					</h:column>
			
				</x:dataTable>	

</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>












