<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
		window.showModalDialog(
				"/attence/evection/personEvcctionAuditEdit.jsf?evcctionNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.7 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem1(id) {
		window.showModalDialog(
				"/attence/evection/personEvcctionAuditEdit1.jsf?evcctionNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem2(id) {
		window.showModalDialog(
				"/attence/evection/personEvcctionAuditEdit2.jsf?evcctionNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem3(id) {
		window.showModalDialog(
				"/attence/evection/personEvcctionAuditEdit3.jsf?evcctionNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.9 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem4(id) {
		window.showModalDialog(
				"/attence/evection/personEvcctionAuditEdit4.jsf?evcctionNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 1.0 + "px; status:0;resizable:yes");
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
<x:saveState value="#{personevectionBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{personevectionBB.initEdit}" />
	<h:inputHidden id="operID" value="#{personevectionBB.operID}" />
	<f:verbatim>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">
				出差审批</td>
			</tr>
		</table>
		<table height=98% width=98%>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:panelGroup>
					<h:selectBooleanCheckbox value="#{personevectionBB.isExist1}"
						onclick="submit();"
						valueChangeListener="#{personleaveBB.changeNowYearValue1}" />
					<h:outputText value="显示全部" />
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="记录数:#{personevectionBB.mypage.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="页数:#{personevectionBB.mypage.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="每页有#{personevectionBB.mypage.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="当前为第#{personevectionBB.mypage.currentPage}页"></h:outputText>

					<h:commandButton value="首页" action="#{personevectionBB.first}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="上页" action="#{personevectionBB.pre}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="下页" action="#{personevectionBB.next}"
						styleClass="button01"></h:commandButton>
					<h:commandButton value="尾页" action="#{personevectionBB.last}"
						styleClass="button01"></h:commandButton>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
				</h:panelGroup> <h:dataTable value="#{personevectionBB.persBos2}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%">
					<h:column>
						<f:facet name="header">
							<h:outputText value="出差人" styleClass="td03" />
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
							<h:outputText value="目的地" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.dest}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="倒休查看" styleClass="button01" onclick="return doTimeOff('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personevectionBB.operID=='0533' && list.statusValue!='3'}"
							onclick="doAddItem('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personevectionBB.operID=='0534' && list.statusValue!='3'}"
							onclick="doAddItem1('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personevectionBB.operID=='0535' && list.statusValue!='3'}"
							onclick="doAddItem2('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personevectionBB.operID=='0536' && list.statusValue!='3'}"
							onclick="doAddItem3('#{list.evcctionNO}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personevectionBB.operID=='0537' && list.statusValue!='3'}"
							onclick="doAddItem4('#{list.evcctionNO}');"></h:commandButton>
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





