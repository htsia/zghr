<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function updateView(vid){
	 window.showModalDialog("/crm/customer/CreateCustomerView.jsf?viewId="+vid, null, "dialogWidth:650px; dialogHeight500px;center:center;resizable:no;status:no;scroll:yes;");
	 return true;
}
</script>

<x:saveState value="#{customerViewBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{customerViewBB.viewMgerInit}"></h:inputHidden>
	<h:panelGrid columns="1" align="center" width="100%">
		<h:panelGrid columns="1" styleClass="td_title" width="100%"
			align="center">
			<h:panelGroup >
				<h:graphicImage value="/images/tips.gif" />
				<h:outputText value="视图管理  - > 客户 "></h:outputText>
			</h:panelGroup>
		</h:panelGrid>

		<x:dataTable value="#{customerViewBB.list}" id="dateList"
			headerClass="td_top" rowIndexVar="index" var="list"
			styleClass="table03" border="1" width="100%" align="center"
			columnClasses=" td_middle_center,td_middle_center ,td_middle_center,td_middle_center">

			<h:column>
				<c:facet name="header">
					<h:outputText value="视图名称" />
				</c:facet>
				<h:outputText value="#{list.viewName}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="数据范围" />
				</c:facet>
				<h:outputText value="#{list.viewType}" />
			</h:column>

			<h:column>
				<c:facet name="header">
					<h:outputText value="视图描述" />
				</c:facet>
				<h:outputText value="#{list.viewDes}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" />
				</f:facet>
				<h:commandButton styleClass="button01" value="修改"
					onclick="return updateView('#{list.viewId}') ;"></h:commandButton> >
						<h:commandButton styleClass="button01"
					onclick="return confirm('确定要删除吗？');"
					action="#{customerViewBB.delCusView}" value="删除">
					<x:updateActionListener value="#{list.viewId}"
						property="#{customerViewBB.cusViewBO.viewId}"></x:updateActionListener>
				</h:commandButton>
			</h:column>
		</x:dataTable>


	</h:panelGrid>

</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>









