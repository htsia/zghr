<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function forSel() {
		PopUpMutilCodeDlgNoLayerForSubmit('form1:personType',
				'form1:personTypeValue', "0135", '');
		var type = document.all("form1:personType").value;
		if (type == null || type == "") {
			return false;
		}
		return true;
	}
	function process() {
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
	}

	</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.pageInit1}" />
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attCalcMgrBB.personType}" />
	<h:inputHidden id="personTypeValue"
		value="#{attCalcMgrBB.personTypeValue}" />		

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
		<h:outputText value="开始月份:" />
			<h:inputText value="#{attCalcMgrBB.beginYearMonth}" styleClass="input"
				size="20" onclick="WdatePicker({dateFmt:'yyyy-MM'})" />
		    <h:outputText value="结束月份:" />
			<h:inputText value="#{attCalcMgrBB.endYearMonth}" styleClass="input"
				size="20" onclick="WdatePicker({dateFmt:'yyyy-MM'})" />
			<h:outputText value=" 员工编号或姓名:" />
			<h:inputText value="#{attCalcMgrBB.nameStr}" styleClass="input"
				size="20" />           
			<h:commandButton styleClass="button01" value="人员类别"
				onclick="return forSel();" action="#{attCalcMgrBB.doQuery1}" />
			<h:commandButton styleClass="button01" value="查询"
				action="#{attCalcMgrBB.doQuery1}" />
			<h:outputText value="  " />
			<c:verbatim>
			<br/>
			</c:verbatim>
			<h:outputText value="记录数:#{attCalcMgrBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{attCalcMgrBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{attCalcMgrBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="当前为第#{attCalcMgrBB.mypage.currentPage}页"></h:outputText>

			<h:commandButton value="首页" action="#{attCalcMgrBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="上页" action="#{attCalcMgrBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="下页" action="#{attCalcMgrBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="尾页" action="#{attCalcMgrBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		<h:panelGrid columns="1" width="100%" align="left">
			<x:dataTable value="#{attCalcMgrBB.list}" headerClass="td_top"
				rowIndexVar="index" var="list" styleClass="table03" border="1"
				width="98%"
				columnClasses="td_middle_center,td_middle_center,td_middle_center60,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center60">
				<h:column>
					<f:facet name="header">
						<h:outputText value="序号" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="员工编号" />
					</f:facet>
					<h:outputText value="#{list.personCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="姓名" />
					</f:facet>
					<h:outputText value="#{list.personName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="人员类别" />
					</f:facet>
					<h:outputText value="#{list.personType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="所在部门" />
					</f:facet>
					<h:outputText value="#{list.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="事假扣款" />
					</f:facet>
					<h:outputText value="#{list.nomalLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="病假扣款" />
					</f:facet>
					<h:outputText value="#{list.illLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="产假扣款" />
					</f:facet>
					<h:outputText value="#{list.chanjiaLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="难产产假扣款" />
					</f:facet>
					<h:outputText value="#{list.nanchanjiaLeaveDeduction}"></h:outputText>
				</h:column>				
				<h:column>
					<f:facet name="header">
						<h:outputText value="旷工扣款" />
					</f:facet>
					<h:outputText value="#{list.awayDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="实到次数" />
					</f:facet>
					<h:outputText value="#{list.realityTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="迟到" />
					</f:facet>
					<h:outputText value="#{list.lateTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="旷工" />
					</f:facet>
					<h:outputText value="#{list.awayTime}" rendered="#{list.awayTime!='.5' }"></h:outputText>
					<h:outputText value="0.5" rendered="#{list.awayTime=='.5' }"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="事假" />
					</f:facet>
					<h:outputText value="#{list.leaveReasons}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="病假" />
					</f:facet>
					<h:outputText value="#{list.leaveSick}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="产假" />
					</f:facet>
					<h:outputText value="#{list.leaveMaternity}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="难产产假" />
					</f:facet>
					<h:outputText value="#{list.leaveNanchanjia}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="婚假" />
					</f:facet>
					<h:outputText value="#{list.leaveWedding}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="丧假" />
					</f:facet>
					<h:outputText value="#{list.leaveArrangingFuneral}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="公出" />
					</f:facet>
					<h:outputText value="#{list.outWorkValue}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="加班" />
					</f:facet>
					<h:outputText value="#{list.workAddValue}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="月份" />
					</f:facet>
					<h:outputText value="#{list.attenceDate}"></h:outputText>
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<marquee id="processbar"
	style="position: absolute; display: none; border: 1px solid #000000"
	direction="right" width="300" scrollamount="5" scrolldelay="10"
	bgcolor="#ECF2FF">
	<table cellspacing="1" cellpadding="0">
		<tr height=8>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
		</tr>
	</table>
</marquee>
