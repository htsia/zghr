<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		var name = document.all('form1:name').value;
		if (name != null && name != "") {
			window.showModalDialog("/attence/personChangeWorkEdit.jsf", "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.6
							+ "px; status:0;resizable:yes");
		} else {
			alert("该人员没有加入任何班组，不能进行换班操作");
			return false;
		}
		return true;
	}
	function doEditItem(id) {
		window
				.showModalDialog(
						"/attence/personEvectionMessage.jsf?evcctionNO=" + id,
						"",
						"dialogWidth:550px; dialogHeight:270px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personChangeWorkBB}" />
<h:form id="form1">
	<h:inputHidden value="#{personChangeWorkBB.pageInit}" />
	<h:inputHidden id="name" value="#{personChangeWorkBB.groupName}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="1">

					<h:panelGroup>
						<h:selectBooleanCheckbox value="#{personChangeWorkBB.isExist}"
							onclick="submit();"
							valueChangeListener="#{personChangeWorkBB.changeNowYearValue}" />
						<h:outputText value="显示全部" />
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="记录数:#{personChangeWorkBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{personChangeWorkBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{personChangeWorkBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="当前为第#{personChangeWorkBB.mypage.currentPage}页"></h:outputText>

						<h:commandButton value="首页" action="#{personChangeWorkBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{personChangeWorkBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{personChangeWorkBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{personChangeWorkBB.last}"
							styleClass="button01"></h:commandButton>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:commandButton value="换班申请" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personChangeWorkBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1700">
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="报批"
							action="#{personChangeWorkBB.personChangeWorkMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener property="#{personChangeWorkBB.changeID}"
								value="#{list.changeID}" />
						</h:commandButton>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.changeID}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personChangeWorkBB.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="原所在班组" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.oldClassName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="现所在班组" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.newClassName}" />
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

