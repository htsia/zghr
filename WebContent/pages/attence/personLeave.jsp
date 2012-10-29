<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function refreshload() {
		setTimeout('myrefresh()', 1000);
	}
	function doAddItem() {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window.showModalDialog("/attence/personLeaveMessage.jsf?okID=100", "",
					"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
							+ screen.height * 0.8 + "px; status:0;resizable:yes");
			return true;
		}else{
			alert("您还没有加入任何班组。");
			return false;
		}
	}
	function doEditItem(id) {
		var desc = document.all('form1:desc').value;
		if(desc != null && desc != ""){
			window.showModalDialog("/attence/personLeaveMessage.jsf?furloughNO="
					+ id, "", "dialogWidth:" + screen.width * 0.6
					+ "px; dialogHeight:" + screen.height * 0.8
					+ "px; status:0;resizable:yes");
			return true;
		}else{
			alert("您还没有加入任何班组。");
			return false;
		}
	}
	function doEditItem1(id, id1, id2) {
		window.showModalDialog("/attence/personLeaveMessages.jsf?furloughNO="
				+ id + "&flag=" + id1 + "&furloughCollectNO=" + id2, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
	function doEditItem2(id) {
		window.showModalDialog(
				"/attence/personLeaveMessagesHistory.jsf?furloughNO=" + id, "",
				"dialogWidth:" + screen.width * 0.9 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doTimeOff(id) {
		window.showModalDialog(
				"/attence/personLeaveNetworkholiday.jsf?furloughNO=" + id, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.5 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
	<h:inputHidden value="#{personleaveBB.pageInit}" />
	<h:inputHidden id="desc" value="#{personleaveBB.groupvalue}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8></f:verbatim> <h:panelGrid width="95%" align="center"
					border="0" columns="3">

					<h:panelGroup>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="记录数:#{personleaveBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{personleaveBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{personleaveBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="当前为第#{personleaveBB.mypage.currentPage}页"></h:outputText>

						<h:commandButton value="首页" action="#{personleaveBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{personleaveBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{personleaveBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{personleaveBB.last}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="请/补假申请" styleClass="button01"
							onclick="return doAddItem();"></h:commandButton>
					</h:panelGroup>
						<h:outputText value="申请状态："></h:outputText>
						<h:selectOneRadio value="#{personleaveBB.status1}"
				onclick="submit();" valueChangeListener="#{personleaveBB.changeStatus1}">
				<f:selectItem itemValue="1" itemLabel="已通过" />
				<f:selectItem itemValue="2" itemLabel="审批过程" />
			</h:selectOneRadio>
				</h:panelGrid> <f:verbatim></td>
			</tr>

</f:verbatim>
<h:panelGroup rendered="#{personleaveBB.status1=='2'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personleaveBB.persBos}" var="list"
					align="center" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="2300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="报批"
							action="#{personleaveBB.PersonLeaveMessageAudit}"
							styleClass="button01" rendered="#{list.statusValue=='-1'}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="修改" styleClass="button01" disabled="#{list.superFlId=='2' || list.superFlId=='3'}"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}"
							onclick="return doEditItem('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{personleaveBB.delete}" styleClass="button01"
							rendered="#{list.statusValue=='-1' || list.statusValue=='2'}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="续假" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','2','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="销假" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','3','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="撤销申请"
							onclick="return confirm('确定要撤销申请吗?');"
							action="#{personleaveBB.escdelete}" styleClass="button01"
							rendered="#{list.statusValue=='0' || list.statusValue=='1'}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="详细信息" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem2('#{list.furloughNO}');"></h:commandButton>	
						<h:commandButton value="年假抵扣信息查看" styleClass="button01" onclick="return doTimeOff('#{list.furloughNO}');" rendered="#{list.flID=='01' || list.flID=='02'}"></h:commandButton>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.furloughNO}');"
							rendered="#{list.statusValue!='3'}"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="请假人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personleaveBB.personName}" />
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
				</h:dataTable> <f:verbatim></div>
				</td>
			</tr>
			
			</f:verbatim>
</h:panelGroup>
<f:verbatim>
			
			</f:verbatim>
<h:panelGroup rendered="#{personleaveBB.status1=='1'}">
<f:verbatim>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:dataTable value="#{personleaveBB.persBos}" var="list"
					align="center" id="dateList1" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="1300">
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="续假" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','2','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="销假" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem1('#{list.furloughNO}','3','#{list.furloughCollectNO}');"></h:commandButton>
						<h:commandButton value="年假抵扣信息查看" styleClass="button01" onclick="return doTimeOff('#{list.furloughNO}');" rendered="#{list.flID=='01' || list.flID=='02'}"></h:commandButton>
						<h:commandButton value="详细信息" styleClass="button01"
							rendered="#{list.statusValue=='3' && list.superFlId=='0'}"
							onclick="doEditItem2('#{list.furloughNO}');"></h:commandButton>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="请假人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{personleaveBB.personName}" />
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
