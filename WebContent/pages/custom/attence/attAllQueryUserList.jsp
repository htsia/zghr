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
		<h:outputText value="��ʼ�·�:" />
			<h:inputText value="#{attCalcMgrBB.beginYearMonth}" styleClass="input"
				size="20" onclick="WdatePicker({dateFmt:'yyyy-MM'})" />
		    <h:outputText value="�����·�:" />
			<h:inputText value="#{attCalcMgrBB.endYearMonth}" styleClass="input"
				size="20" onclick="WdatePicker({dateFmt:'yyyy-MM'})" />
			<h:outputText value=" Ա����Ż�����:" />
			<h:inputText value="#{attCalcMgrBB.nameStr}" styleClass="input"
				size="20" />           
			<h:commandButton styleClass="button01" value="��Ա���"
				onclick="return forSel();" action="#{attCalcMgrBB.doQuery1}" />
			<h:commandButton styleClass="button01" value="��ѯ"
				action="#{attCalcMgrBB.doQuery1}" />
			<h:outputText value="  " />
			<c:verbatim>
			<br/>
			</c:verbatim>
			<h:outputText value="��¼��:#{attCalcMgrBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ҳ��:#{attCalcMgrBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="ÿҳ��#{attCalcMgrBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="��ǰΪ��#{attCalcMgrBB.mypage.currentPage}ҳ"></h:outputText>

			<h:commandButton value="��ҳ" action="#{attCalcMgrBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{attCalcMgrBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="��ҳ" action="#{attCalcMgrBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="βҳ" action="#{attCalcMgrBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		<h:panelGrid columns="1" width="100%" align="left">
			<x:dataTable value="#{attCalcMgrBB.list}" headerClass="td_top"
				rowIndexVar="index" var="list" styleClass="table03" border="1"
				width="98%"
				columnClasses="td_middle_center,td_middle_center,td_middle_center60,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center60">
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="Ա�����" />
					</f:facet>
					<h:outputText value="#{list.personCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{list.personName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="��Ա���" />
					</f:facet>
					<h:outputText value="#{list.personType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���ڲ���" />
					</f:facet>
					<h:outputText value="#{list.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�¼ٿۿ�" />
					</f:facet>
					<h:outputText value="#{list.nomalLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���ٿۿ�" />
					</f:facet>
					<h:outputText value="#{list.illLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���ٿۿ�" />
					</f:facet>
					<h:outputText value="#{list.chanjiaLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�Ѳ����ٿۿ�" />
					</f:facet>
					<h:outputText value="#{list.nanchanjiaLeaveDeduction}"></h:outputText>
				</h:column>				
				<h:column>
					<f:facet name="header">
						<h:outputText value="�����ۿ�" />
					</f:facet>
					<h:outputText value="#{list.awayDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="ʵ������" />
					</f:facet>
					<h:outputText value="#{list.realityTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�ٵ�" />
					</f:facet>
					<h:outputText value="#{list.lateTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{list.awayTime}" rendered="#{list.awayTime!='.5' }"></h:outputText>
					<h:outputText value="0.5" rendered="#{list.awayTime=='.5' }"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�¼�" />
					</f:facet>
					<h:outputText value="#{list.leaveReasons}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{list.leaveSick}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{list.leaveMaternity}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�Ѳ�����" />
					</f:facet>
					<h:outputText value="#{list.leaveNanchanjia}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
					<h:outputText value="#{list.leaveWedding}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="ɥ��" />
					</f:facet>
					<h:outputText value="#{list.leaveArrangingFuneral}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
					<h:outputText value="#{list.outWorkValue}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�Ӱ�" />
					</f:facet>
					<h:outputText value="#{list.workAddValue}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="�·�" />
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
