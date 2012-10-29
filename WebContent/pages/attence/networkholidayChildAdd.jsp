<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function doAddItem() {
		var desc = document.all('form1:desc').value;
		var itemId = document.all('form1:itemId').value;
		if(desc != null && desc != ""){
			window
			.showModalDialog(
					"/attence/networkholidayChildAddEdit.jsf?itemId="
							+ itemId,
					null,
					"dialogWidth:"
							+ screen.width
							* 0.6
							+ "px; dialogHeight:"
							+ screen.height
							* 0.6
							+ "px;center:center;resizable:yes;status:no;scroll:yes;");
	        return true;
		}else{
			alert("您还没有加入任何班组。");
			return false;
		}
	}
	function doEditItem(id) {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window
			.showModalDialog(
					"/attence/networkholidayChildAddEdit.jsf?detailId="
							+ id,
					null,
					"dialogWidth:"
							+ screen.width
							* 0.6
							+ "px; dialogHeight:"
							+ screen.height
							* 0.6
							+ "px;center:center;resizable:yes;status:no;scroll:yes;");
	        return true;
		}else{
			alert("您还没有加入任何班组。");
			return false;
		}
	}
</script>
<x:saveState value="#{networkholidaychildaddBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit"
		value="#{networkholidaychildaddBB.pageInit}" />
	<h:inputHidden id="itemId" value="#{networkholidaychildaddBB.itemID}" />
	<h:inputHidden id="desc" value="#{networkholidaychildaddBB.groupvalue}" />
	<h:panelGrid styleClass="td_title" width="2300" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤休假网上申请" />
		</h:panelGroup>
	</h:panelGrid>

	<h:commandButton value="休假申请" styleClass="button01"
		onclick="return doAddItem();"></h:commandButton>
	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<h:dataTable value="#{networkholidaychildaddBB.lists}" var="list"
			align="center" id="dateList" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="2300">
			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" styleClass="td03" />
				</f:facet>
				<h:commandButton value="报批"
					action="#{networkholidaychildaddBB.saveoraudit}"
					styleClass="button01" rendered="#{list.statusValue=='-1'}">
					<x:updateActionListener
						property="#{networkholidaychildaddBB.detailId}"
						value="#{list.detailId}" />
				</h:commandButton>
				<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
					rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
					action="#{networkholidaychildaddBB.delete}" styleClass="button01">
					<x:updateActionListener
						property="#{networkholidaychildaddBB.detailId}"
						value="#{list.detailId}" />
				</h:commandButton>
				<h:commandButton value="查看流程" styleClass="button01"
					onclick="showWorkFlowLogByLinkID('#{list.detailId}');"></h:commandButton>
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="申请人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{networkholidaychildaddBB.personName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="开始时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.holidayBegin}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="结束时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.holidayEnd}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="休假天数" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.daySpan}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="部门审批意见" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditCausevalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="部门审批人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="部门审批时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="部门审批说明" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.deptAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总监审批意见" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总监审批人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总监审批时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总监审批说明" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hileaderAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="领导审批意见" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditCausevalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="领导审批人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="领导审批时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="领导审批说明" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.leaderAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总经理审批意见" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总经理审批人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总经理审批时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总经理审批说明" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.manAuditCause}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人力资源审批意见" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人力资源审批人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人力资源审批时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="人力资源审批说明" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.hrAuditCause}" />
			</h:column>
		</h:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
