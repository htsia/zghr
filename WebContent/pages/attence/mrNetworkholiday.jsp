<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		window.showModalDialog("/attence/mrNetworkholidayMessage.jsf?okID=100",
				"", "dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem(id) {
		window.showModalDialog(
				"/attence/mrNetworkholidayMessage.jsf?mimicReportNO=" + id, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{mrnetworkholidayBB}" />
<h:form id="form1">
	<h:inputHidden value="#{mrnetworkholidayBB.pageInit}" />
	<h:inputHidden id="desc" value="#{mrnetworkholidayBB.groupvalue}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="1">

					<h:panelGroup>
						<h:selectBooleanCheckbox value="#{mrnetworkholidayBB.isExist}"
							onclick="submit();"
							valueChangeListener="#{mrnetworkholidayBB.changeNowYearValue}" />
						<h:outputText value="显示全部" />
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="记录数:#{mrnetworkholidayBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{mrnetworkholidayBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{mrnetworkholidayBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="当前为第#{mrnetworkholidayBB.mypage.currentPage}页"></h:outputText>

						<h:commandButton value="首页" action="#{mrnetworkholidayBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{mrnetworkholidayBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{mrnetworkholidayBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{mrnetworkholidayBB.last}"
							styleClass="button01"></h:commandButton>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:commandButton value="拟报申请" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{mrnetworkholidayBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="3600">
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="报批"
							action="#{mrnetworkholidayBB.mrNetWorkHolidayMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener
								property="#{mrnetworkholidayBB.mimicReportNO}"
								value="#{list.mimicReportNO}" />
						</h:commandButton>
						<h:commandButton value="修改" styleClass="button01"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							onclick="return doEditItem('#{list.mimicReportNO}');"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							action="#{mrnetworkholidayBB.delete}" styleClass="button01">
							<x:updateActionListener
								property="#{mrnetworkholidayBB.mimicReportNO}"
								value="#{list.mimicReportNO}" />
						</h:commandButton>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.mimicReportNO}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="拟报人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personaddworkBB.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="年度" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.mrYear}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="拟定休假地点" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.dest}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="拟定休假时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.mrMonth}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="应享受年休假（天）" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.lastDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请时间" styleClass="td03" />
						</f:facet>
						<h:outputText escape="false" value="#{list.applyDate}" />
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
							<h:outputText value="主管领导审批意见" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.leaderAuditCausevalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="主管领导审批人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.leaderAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="主管领导审批时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.leaderAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="主管领导审批说明" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.leaderAuditCause}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源考勤员审批意见" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditResultvalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源考勤员审批人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源考勤员审批时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源考勤员审批说明" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrAuditCause}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源部门审批意见" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditCausevalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源部门审批人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源部门审批时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源部门审批说明" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrDeptAuditCause}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源主管领导审批意见" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditCausevalue}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源主管领导审批人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditOper}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源主管领导审批时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="人力资源主管领导审批说明" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.hrLeaderAuditCause}" />
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



