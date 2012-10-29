<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{personleaveBB.initEdit2}" />
	<h:panelGrid styleClass="td_title" width="2300" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤请假假信息查看" />
		</h:panelGroup>
	</h:panelGrid>


	<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="6">
		<x:dataTable value="#{personleaveBB.persBos3}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="2300">
			<h:column>
				<f:facet name="header">
					<h:outputText value="操作" styleClass="td03" />
				</f:facet>
				<h:commandButton value="查看流程" styleClass="button01"
					onclick="showWorkFlowLogByLinkID('#{list.furloughNO}');"></h:commandButton>
			</h:column>
			<h:column>
				<c:facet name="header">
					<h:outputText value="序号" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="假期类型" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="假期性质" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.superFlIdName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="处理类别" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flIdProcessName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="是否提交相关证明材料" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flIdStatusName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="申请时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.applyDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="开始时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.beginTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="结束时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.endTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="事由" styleClass="td03" />
				</f:facet>
				<h:outputText escape="false" value="#{list.reason}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="假期天数(合计)" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.lastDate}" />
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
				<h:outputText value="#{list.zjAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总监审批人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.zjAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总监审批时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.zjAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总监审批说明" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.zjAuditCause}" />
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
				<h:outputText value="#{list.zjlAuditResultvalue}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总经理审批人" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.zjlAuditOper}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总经理审批时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.zjlAuditDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="总经理审批说明" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.zjlAuditCause}" />
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
		</x:dataTable>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
