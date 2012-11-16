<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
    	var type = document.all("form1:personType").value;
    	if(type==null || type==""){
    		return false;
    	}
    	return true;
    }
	function modify(id) {
        window.showModalDialog("/custom/attence/attCalcResultEdit.jsf?subID="+id, null, "dialogWidth:400px;dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
	function dimission(id) {
        window.showModalDialog("/custom/attence/attCalcDimissionEdit.jsf?subID="+id, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.editInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attCalcMgrBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attCalcMgrBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
			<h:commandButton value="提交" onclick="return confirm('确定提交吗');" styleClass="button01"
					action="#{attCalcMgrBB.submit}"/>
			<h:outputText value="  "/>
			<h:outputText value=" 员工编号或姓名:"/>
			<h:inputText value="#{attCalcMgrBB.nameStr}" styleClass="input" size="20"/>
			<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{attCalcMgrBB.doEditQuery}"/>
			<h:commandButton styleClass="button01" value="查询" action="#{attCalcMgrBB.doEditQuery}"/>
			<h:outputText value="  "/>
			<h:outputText
				value="记录数:#{attCalcMgrBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{attCalcMgrBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{attCalcMgrBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText
				value="当前为第#{attCalcMgrBB.mypage.currentPage}页"></h:outputText>

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
			<x:dataTable value="#{attCalcMgrBB.editList}"
				headerClass="td_top" rowIndexVar="index" var="editList"
				styleClass="table03" border="1" width="98%"
				columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
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
					<h:outputText value="#{editList.personCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="姓名" />
					</f:facet>
					<h:outputText value="#{editList.personName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="人员类别" />
					</f:facet>
					<h:outputText value="#{editList.personType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="二级部门" />
					</f:facet>
					<h:outputText value="#{editList.secDeptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="所在部门" />
					</f:facet>
					<h:outputText value="#{editList.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="迟到" />
					</f:facet>
					<h:outputText value="#{editList.lateTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="旷工" />
					</f:facet>
					<h:outputText value="#{editList.awayTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="事假" />
					</f:facet>
					<h:outputText value="#{editList.leaveReasons}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="病假" />
					</f:facet>
					<h:outputText value="#{editList.leaveSick}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="产假" />
					</f:facet>
					<h:outputText value="#{editList.leaveMaternity}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="难产产假" />
					</f:facet>
					<h:outputText value="#{editList.nanchanjiaLeave}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="迟到扣款" />
					</f:facet>
					<h:outputText value="#{editList.laterDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="旷工扣款" />
					</f:facet>
					<h:outputText value="#{editList.awayDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="事假扣款" />
					</f:facet>
					<h:outputText value="#{editList.normalLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="病假扣款" />
					</f:facet>
					<h:outputText value="#{editList.illLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="产假扣款" />
					</f:facet>
					<h:outputText value="#{editList.chanjiaLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="难产假扣款" />
					</f:facet>
					<h:outputText value="#{editList.nanchanjiaLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="离职时间" />
					</f:facet>
					<h:outputText value="#{editList.dimissionDate}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="操作" />
					</f:facet>
					<h:commandButton value="修改" onclick="modify('#{editList.subID}');" styleClass="button01" />
				</h:column>
				<h:column>
					<h:commandButton value="离职提醒" onclick="dimission('#{editList.subID}');" styleClass="button01" />
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
