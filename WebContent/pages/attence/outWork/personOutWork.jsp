<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window.showModalDialog("/attence/outWork/personOutWorkMessage.jsf?okID=100",
					"", "dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.7 + "px; status:0;resizable:yes");
			return true;
		}else{
			alert("您还没有加入任何班组。");
			return false;
		}
	}
	function doEditItem(id) {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window.showModalDialog("/attence/outWork/personOutWorkMessage.jsf?outWorkNo="
					+ id, "", "dialogWidth:" + screen.width * 0.6
					+ "px; dialogHeight:" + screen.height * 0.7
					+ "px; status:0;resizable:yes");
			return true;
		}else{
			alert("您还没有加入任何班组。");
			return false;
		}
	}
	function doEditItem1(id, id1, id2) {
		window.showModalDialog("/attence/outWork/personOutWorkMessages.jsf?outWorkNo="
				+ id + "&flag=" + id1 + "&outWorkNoCollectNo=" + id2, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem2(id) {
		window.showModalDialog(
				"/attence/outWork/personOutWorkMessageHistory.jsf?outWorkNo=" + id, "",
				"dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doTimeOff(id) {
		window.showModalDialog(
				"/attence/attTimeOff.jsf?outTimeNo=" + id, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.5 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personoutworkBB}" />
<h:form id="form1">
	<h:inputHidden value="#{personoutworkBB.pageInit}" />
	<h:inputHidden id="desc" value="#{personoutworkBB.groupvalue}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="3">

					<h:panelGroup>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="记录数:#{personoutworkBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{personoutworkBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{personoutworkBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="当前为第#{personoutworkBB.mypage.currentPage}页"></h:outputText>

						<h:commandButton value="首页" action="#{personoutworkBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{personoutworkBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{personoutworkBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{personoutworkBB.last}"
							styleClass="button01"></h:commandButton>
												<h:commandButton value="公出申请" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
												</h:panelGroup>
						<h:outputText value="申请状态："></h:outputText>
			<h:selectOneRadio value="#{personoutworkBB.status1}"
				onclick="submit();" valueChangeListener="#{personoutworkBB.changeStatus1}">
				<f:selectItem itemValue="1" itemLabel="已通过" />
				<f:selectItem itemValue="2" itemLabel="审批过程" />
			</h:selectOneRadio>

				</h:panelGrid> <f:verbatim></td>
			</tr>

</f:verbatim>
<h:panelGroup rendered="#{personoutworkBB.status1=='2'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personoutworkBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="3300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="报批"
						    disabled="#{list.personID!=personoutworkBB.userid}"
							action="#{personoutworkBB.personEvectionMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener property="#{personoutworkBB.outWorkNo}"
								value="#{list.outWorkNo}" />
						</h:commandButton>
						<h:commandButton value="修改" styleClass="button01"
						    disabled="#{list.personID!=personoutworkBB.userid || list.superFlId=='2' || list.superFlId=='3'}"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							onclick="return doEditItem('#{list.outWorkNo}');"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
						    disabled="#{list.personID!=personoutworkBB.userid}"
							action="#{personoutworkBB.delete}" styleClass="button01"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}">
							<x:updateActionListener property="#{personoutworkBB.outWorkNo}"
								value="#{list.outWorkNo}" />
						</h:commandButton>
						<h:commandButton value="撤销申请"
							onclick="return confirm('确定要撤销申请吗?');"
							action="#{personoutworkBB.escdelete}" styleClass="button01"
							rendered="#{list.statusValue=='0' || list.statusValue=='1'}">
							<x:updateActionListener property="#{personoutworkBB.outWorkNo}"
								value="#{list.outWorkNo}" />
						</h:commandButton>
						<h:commandButton value="倒休查看" styleClass="button01" onclick="return doTimeOff('#{list.outWorkNo}');"></h:commandButton>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.outWorkNo}');"
							rendered="#{list.statusValue!='3'}"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="公出人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personGroupIDName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="公出性质" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.superFlIdName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="公出类型" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.outWorkTypeName}" />
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
							<h:outputText value="目的地" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.dest}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="公出天数(合计)" styleClass="td03" />
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
			
			</f:verbatim>
</h:panelGroup>
<f:verbatim>
			
			</f:verbatim>
<h:panelGroup rendered="#{personoutworkBB.status1=='1'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personoutworkBB.persBos}" var="list"
					align="center" id="dateList1" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="续增" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.outWorkNo}','2','#{list.outWorkNoCollectNo}');"></h:commandButton>
						<h:commandButton value="销减" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.outWorkNo}','3','#{list.outWorkNoCollectNo}');"></h:commandButton>
						<h:commandButton value="详细信息" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem2('#{list.outWorkNo}');"></h:commandButton>
						<h:commandButton value="倒休查看" styleClass="button01" onclick="return doTimeOff('#{list.outWorkNo}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="公出人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personGroupIDName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.applyDate}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="公出性质" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.superFlIdName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="公出类型" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.outWorkTypeName}" />
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
				</h:dataTable> <f:verbatim></div>
				</td>
			</tr>
			
			</f:verbatim>
</h:panelGroup>
<f:verbatim>		
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
	setDataTableOver("form1:dateList1");
</script>

