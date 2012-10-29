<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem(id) {
		window.showModalDialog(
				"/attence/personChangeWorkAuditEdit.jsf?evcctionNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.5 + "px; status:0;resizable:yes");
		return true;
	}
	function doAddItem1(id) {
		window.showModalDialog(
				"/attence/personChangeWorkAuditEdit1.jsf?evcctionNO=" + id
						+ "&operID=" + document.all("form1:operID").value, "",
				"dialogWidth:" + screen.width * 0.6 + "px; dialogHeight:"
						+ screen.height * 0.8 + "px; status:0;resizable:yes");
		return true;
	}
</script>
<x:saveState value="#{personChangeWorkBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{personChangeWorkBB.initEdit}" />
	<h:inputHidden id="operID" value="#{personChangeWorkBB.operID}" />
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif"> 换班审批</td>
			</tr>
		</table>
		<table height=98% width=98%>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</f:verbatim> <h:panelGroup>
					<h:selectBooleanCheckbox value="#{personChangeWorkBB.isExist1}"
						onclick="submit();"
						valueChangeListener="#{personChangeWorkBB.changeNowYearValue1}" />
					<h:outputText value="显示全部" />
					<h:outputText value="  "></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="记录数:#{personChangeWorkBB.mypage.totalRecord}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="页数:#{personChangeWorkBB.mypage.totalPage}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="每页有#{personevectionBB.mypage.pageSize}"></h:outputText>
					<h:outputText value="  "></h:outputText>
					<h:outputText value="当前为第#{personevectionBB.mypage.currentPage}页"></h:outputText>

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
				</h:panelGroup> <h:dataTable value="#{personChangeWorkBB.persBos2}" var="list"
					align="center" id="dateList" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="90%">
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
							<h:outputText value="原所在班次" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.oldClassName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="现所在班次" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.newClassName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" styleClass="td03" />
						</f:facet>
						<h:commandButton value="查看流程" styleClass="button01"
							onclick="showWorkFlowLogByLinkID('#{list.changeID}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personChangeWorkBB.operID=='0597' && list.statusValue!='3'}"
							onclick="doAddItem('#{list.changeID}');"></h:commandButton>
						<h:commandButton value="审批" styleClass="button01"
							rendered="#{list.flagvalue=='yes' && personChangeWorkBB.operID=='0540' && list.statusValue!='3'}"
							onclick="doAddItem1('#{list.changeID}');"></h:commandButton>
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





