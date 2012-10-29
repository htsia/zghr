<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
function add() {
	var feastId = document.all('form1:feastId').value;
	var orgId = document.all('form1:orgId').value;
	window
	.showModalDialog(
			"/attence/FeastWorkDateEdit.jsf?feastID="+feastId+"&oid="+orgId+"&okId="+100,
			null,
			"dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.3+"px;center:center;resizable:yes;status:no;scroll:yes;");
	return true;
}
function modify(id,id1,id2) {
	window
	.showModalDialog(
			"/attence/FeastWorkDateEdit.jsf?attworkdateId="+id+"&feastID="+id1+"&oid="+id2,
			null,
			"dialogWidth:"+screen.width*0.26+"px; dialogHeight:"+screen.height*0.23+"px;center:center;resizable:yes;status:no;scroll:yes;");
	return true;
}
</script>
<x:saveState value="#{attfeastworkdateBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{attfeastworkdateBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="feastId" value="#{attfeastworkdateBB.feastID}"></h:inputHidden>
	<h:inputHidden id="orgId" value="#{attfeastworkdateBB.orgId}"></h:inputHidden>
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤调休管理" />
		</h:panelGroup>
	</h:panelGrid>
	<br>
	<h:panelGrid width="98%" columns="1" align="center">
		<h:panelGrid columns="4" align="left">
			<h:commandButton styleClass="button01" value="新建"
				onclick="return add();" />
		</h:panelGrid>

		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<x:dataTable value="#{attfeastworkdateBB.lists}" id="dateList"
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
				<h:outputText value="日期" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.workDate}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="状态" styleClass="td03" />
			</f:facet>
			<h:outputText value="工作日" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="操作" styleClass="td03" />
			</f:facet>
			<h:commandButton value="编辑"
				onclick="return modify('#{list.id}','#{list.feastId}','#{list.orgId}')"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
				action="#{attfeastworkdateBB.delete}" styleClass="button01">
				<x:updateActionListener
					property="#{attfeastworkdateBB.attworkdateId}" value="#{list.id}" />
			</h:commandButton>
		</h:column>
	</x:dataTable>

</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>






