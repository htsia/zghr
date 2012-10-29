<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	
	function checkin(){
		window.showModalDialog(
						"/custom/att/attEleCheckinEdit.jsf?act=init",
						null,
						"dialogWidth:400px; dialogHeight:230px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	function forSel() {
    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
    	var type = document.all("form1:personType").value;
    	if(type==null || type==""){
    		return false;
    	}
    	return true;
    }
</script>
<x:saveState value="#{att_logMrgBB}" />
<h:inputHidden value="#{att_logMrgBB.pageInit}"/>
<h:form id="form1">
	<h:inputHidden id="personType" value="#{att_logMrgBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{att_logMrgBB.personTypeValue}"/>
    
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
			<h:commandButton styleClass="button01" value="签到" onclick="checkin();"/>
			<h:outputText value="  "/>
			<h:outputText value=" 员工编号或姓名:"/>
			<h:inputText value="#{att_logMrgBB.nameStr}" styleClass="input" size="20"/>
			<h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{att_logMrgBB.queryLog}"/>
			<h:commandButton styleClass="button01" value="查询" action="#{att_logMrgBB.queryLog}"/>
			<h:outputText value="  "/>
			<h:outputText
				value="记录数:#{att_logMrgBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{att_logMrgBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{att_logMrgBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText
				value="当前为第#{att_logMrgBB.mypage.currentPage}页"></h:outputText>

			<h:commandButton value="首页" action="#{att_logMrgBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="上页" action="#{att_logMrgBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="下页" action="#{att_logMrgBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="尾页" action="#{att_logMrgBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		<h:panelGrid columns="1" width="100%" align="left">
			<x:dataTable value="#{att_logMrgBB.logList}"
				headerClass="td_top" rowIndexVar="index" var="log"
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
					<h:outputText value="#{log.personSeq}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="姓名" />
					</f:facet>
					<h:outputText value="#{log.name}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="人员类别" />
					</f:facet>
					<h:outputText value="#{log.personType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="二级部门" />
					</f:facet>
					<h:outputText value="#{log.secDeptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="所在部门" />
					</f:facet>
					<h:outputText value="#{log.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="日期" />
					</f:facet>
					<h:outputText value="#{log.date}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="时间" />
					</f:facet>
					<h:outputText value="#{log.time}"></h:outputText>
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
