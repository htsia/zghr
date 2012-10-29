<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
		window.showModalDialog("/attence/personLeaveAuditEdit.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.7 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem1(id) {
		window.showModalDialog("/attence/personLeaveAuditEdit1.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem2(id) {
		window.showModalDialog("/attence/personLeaveAuditEdit2.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
   //总监审批
	function doAddItem3(id) { 
		window.showModalDialog("/attence/personLeaveAuditEdit3.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	   //总经理审批
	function doAddItem4(id) { 
		window.showModalDialog("/attence/personLeaveAuditEdit4.jsf?furloughNO="
				+ id + "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{personleaveBB.initEdit}" />
	<h:inputHidden id="operID" value="#{personleaveBB.operID}" />
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">
				请假审批</td>
			</tr>
		</table>
		<table height=98% width=98%>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:panelGroup>
					<h:selectBooleanCheckbox value="#{personleaveBB.isExist1}"
						onclick="submit();"
						valueChangeListener="#{personleaveBB.changeNowYearValue1}" />
					<h:outputText value="显示全部" />
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
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
				</h:panelGroup> <h:dataTable value="#{personleaveBB.persBos2}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
						<f:facet name="header">
							<h:outputText value="请假人" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="申请状态" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.statusValueName}" />
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
							<h:outputText value="假开始时间" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.beginTime}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="假结束时间" styleClass="td03" />
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
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="确认证明"
							onclick="return confirm('确定要提交证明吗?');"
							action="#{personleaveBB.makeDemonstrate}" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0532' && list.flIdStatus=='0' && (list.flID=='02' || list.flID=='04')}">
							<x:updateActionListener property="#{personleaveBB.furloughNO}"
								value="#{list.furloughNO}" />
						</h:commandButton>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0530' && list.statusValue!='3'}"
							onclick="doAddItem('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0531' && list.statusValue!='3'}"
							onclick="doAddItem1('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0532' && list.statusValue!='3'}"
							onclick="doAddItem2('#{list.furloughNO}');"></h:commandButton>
					    <h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0538' && list.statusValue!='3'}"
							onclick="doAddItem3('#{list.furloughNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personleaveBB.operID=='0539' && list.statusValue!='3'}"
							onclick="doAddItem4('#{list.furloughNO}');"></h:commandButton>
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





