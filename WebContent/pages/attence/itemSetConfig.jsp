<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
function add() {
	window
	.showModalDialog(
			"/attence/itemSetConfigAdd.jsf",
			null,
			"dialogWidth:"+screen.width*0.26+"px; dialogHeight:"+screen.height*0.36+"px;center:center;resizable:yes;status:no;scroll:yes;");
	return true;
}
function modify(id) {
	window
	.showModalDialog(
			"/attence/itemSetConfigAdd.jsf?itemID="+id,
			null,
			"dialogWidth:"+screen.width*0.26+"px; dialogHeight:"+screen.height*0.36+"px;center:center;resizable:yes;status:no;scroll:yes;");
	return true;
}
</script>
<x:saveState value="#{itemsetconfigBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{itemsetconfigBB.pageInit}"></h:inputHidden>
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤项目规则" />
		</h:panelGroup>
	</h:panelGrid>
	<br>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="4" align="left">
			<h:commandButton styleClass="button01" value="新建规则"
				onclick="return add();" />
		</h:panelGrid>

		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<x:dataTable value="#{itemsetconfigBB.itemList}" id="dateList"
		headerClass="td_top" rowIndexVar="index" var="list"
		styleClass="table03" border="1" width="98%"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center">
		<h:column>
			<c:facet name="header">
				<h:outputText value="序号" />
			</c:facet>
			<h:outputText value="#{index+1}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="规则名称" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.itemCodeName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="代表字符" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.flagChar}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="计量单位" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.unitName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="日汇总字段" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.dayFieldName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="月汇总字段" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.monthFieldName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="年汇总字段" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.yearFieldName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="操作" styleClass="td03" />
			</f:facet>
			<h:commandButton value="编辑" onclick="return modify('#{list.itemID}')"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
				action="#{itemsetconfigBB.delete}" styleClass="button01">
				<x:updateActionListener property="#{itemsetconfigBB.itemID}"
					value="#{list.itemID}" />
			</h:commandButton>
		</h:column>
	</x:dataTable>

</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>






