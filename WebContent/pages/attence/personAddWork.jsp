<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		var desc = document.all('form1:desc').value;
		if (desc != null && desc != "") {
			window.showModalDialog(
					"/attence/personAddWorkMessage.jsf?okID=100", "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.8
							+ "px; status:0;resizable:yes");
			return true;
		} else {
			alert("您还没有加入任何班组。");
			return false;
		}
	}
	function doEditItem(id) {
		var desc = document.all('form1:desc').value;
		if (desc != null && desc != "") {
			window.showModalDialog(
					"/attence/personAddWorkMessage.jsf?overTimeNO=" + id, "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.8
							+ "px; status:0;resizable:yes");
			return true;
		} else {
			alert("您还没有加入任何班组。");
			return false;
		}
	}
	function dotimeoffItem(id) {
		window.showModalDialog("/attence/timeoffrec.jsf?overTimeNO=" + id, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.3 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personaddworkBB}" />
<h:form id="form1">
	<h:inputHidden value="#{personaddworkBB.pageInit}" />
	<h:inputHidden id="desc" value="#{personaddworkBB.groupvalue}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="1">

					<h:panelGroup>
						<h:selectBooleanCheckbox value="#{personaddworkBB.isExist}"
							onclick="submit();"
							valueChangeListener="#{personaddworkBB.changeNowYearValue}" />
						<h:outputText value="显示全部" />
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="记录数:#{personaddworkBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{personaddworkBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{personaddworkBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="当前为第#{personaddworkBB.mypage.currentPage}页"></h:outputText>

						<h:commandButton value="首页" action="#{personaddworkBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{personaddworkBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{personaddworkBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{personaddworkBB.last}"
							styleClass="button01"></h:commandButton>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:commandButton value="加班申请" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personaddworkBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="2300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="报批"
							action="#{personaddworkBB.personAddWorkMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener property="#{personaddworkBB.overTimeNO}"
								value="#{list.overTimeNO}" />
						</h:commandButton>
						<h:commandButton value="修改" styleClass="button01"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							onclick="return doEditItem('#{list.overTimeNO}');"></h:commandButton>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.overTimeNO}');"></h:commandButton>
						<h:commandButton value="倒休列表" styleClass="button01"
							rendered="#{list.typeStatus=='2'}"
							onclick="dotimeoffItem('#{list.overTimeNO}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personaddworkBB.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="类型" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.typeStatusName}" />
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
							<h:outputText value="加班天数(合计)" styleClass="td03" />
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
				</h:dataTable> <f:verbatim></div>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>



