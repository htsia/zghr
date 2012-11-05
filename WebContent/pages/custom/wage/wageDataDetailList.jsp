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
</script>
<x:saveState value="#{wage_dataOtherBB}" />
<h:inputHidden value="#{wage_dataOtherBB.dataInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{wage_dataOtherBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{wage_dataOtherBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid>
			<h:panelGroup>
				<h:commandButton value="全部审阅" onclick="return confirm('确定审阅吗');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataPass}"/>
				<h:commandButton value="全部退回" onclick="return confirm('确定退回吗');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataRollback}"/>
				<h:outputText value=" "/>
				<h:outputText value="姓名或编号"/>
				<h:inputText value="#{wage_dataOtherBB.nameStr}" styleClass="input" size="10"/>
				<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{wage_dataOtherBB.queryDataUser}"/>
				<h:commandButton styleClass="button01" value="查询" action="#{wage_dataOtherBB.queryDataUser}"/>
				<h:outputText value="  "/>
				<h:outputText
					value="记录数:#{wage_dataOtherBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{wage_dataOtherBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{wage_dataOtherBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="当前为第#{wage_dataOtherBB.mypage.currentPage}页"></h:outputText>
	
				<h:commandButton value="首页" action="#{wage_dataOtherBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{wage_dataOtherBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{wage_dataOtherBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{wage_dataOtherBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="1" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<x:dataTable value="#{wage_dataOtherBB.dataList}"
				headerClass="td_top" rowIndexVar="index" var="data" id="dataList"
				styleClass="table03" border="1" width="850"
				columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
				<h:column>
					<f:facet name="header">
						<h:outputText value="序号" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="项目名称" />
					</f:facet>
					<h:outputText value="#{data.setName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="姓名" />
					</f:facet>
					<h:outputText value="#{data.userName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="员工编号" />
					</f:facet>
					<h:outputText value="#{data.userCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="人员类别" />
					</f:facet>
					<h:outputText value="#{data.userType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="所在部门" />
					</f:facet>
					<h:outputText value="#{data.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="金额" />
					</f:facet>
					<h:outputText value="#{data.money}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="状态" />
					</f:facet>
					<h:outputText value="#{data.statusDesc}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="备注" />
					</f:facet>
					<h:outputText value="#{data.remark}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="操作" />
					</f:facet>
					<h:commandButton value="审阅" onclick="return confirm('确定审阅吗');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataPass}"
						rendered="#{data.status=='0'}">
						<x:updateActionListener value="#{data.userID}" property="#{wage_dataOtherBB.operUserID}"/>
						<x:updateActionListener value="#{data.setID}" property="#{wage_dataOtherBB.operSetID}"/>
					</h:commandButton>
					<h:commandButton value="退回" onclick="return confirm('确定退回吗');" styleClass="button01" action="#{wage_dataOtherBB.updateWageDataRollback}"
						rendered="#{data.status=='0'}">
						<x:updateActionListener value="#{data.userID}" property="#{wage_dataOtherBB.operUserID}"/>
						<x:updateActionListener value="#{data.setID}" property="#{wage_dataOtherBB.operSetID}"/>
					</h:commandButton>
				</h:column>
			</x:dataTable>
		</h:panelGrid>

	</h:panelGrid>
</h:form>


