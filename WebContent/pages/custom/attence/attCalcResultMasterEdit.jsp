<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function check(){
	var v = "";
	var b=true;
	$("input[code='shuzi']").each(function(){
		v = this.value;
		if(isNaN(v)){
			alert("非法字符,应该为数字");
			b=false;
		}
	});	
	return b;
}
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.masterModifyInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 数据修改" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="cener">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
			<h:outputText value="员工编号"/>
			<h:outputText value="#{attCalcMgrBB.bo.personCode}"/>
			
			<h:outputText value="姓名" />
			<h:outputText value="#{attCalcMgrBB.bo.personName}"/>
			
			<h:outputText value="迟到" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.later}"/>

			<h:outputText value="旷工" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.away}"/>
			
			<h:outputText value="事假" />
			<h:inputText code="shuzi"  value="#{attCalcMgrBB.normalLeave}"/>
			
			<h:outputText value="病假" />
			<h:inputText code="shuzi"  value="#{attCalcMgrBB.illLeave}"/>
			
			<h:outputText value="产假" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.chanjiaLeave}"/>
			
			<h:outputText value="难产产假" />
			<h:inputText code="shuzi"  value="#{attCalcMgrBB.nanchanjiaLeave}"/>
			
			<h:outputText value="迟到扣款" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.laterDeduction}"/>
			
			<h:outputText value="旷工扣款" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.awayDeduction}"/>
			
			<h:outputText   value="事假扣款" />
			<h:inputText code="shuzi" value="#{attCalcMgrBB.normalLeaveDeduction}"/>
			
			<h:outputText value="病假扣款" />
			<h:inputText code="shuzi"  value="#{attCalcMgrBB.illLeaveDeduction}"/>
			
			<h:outputText value="产假扣款" />
			<h:inputText code="shuzi"  value="#{attCalcMgrBB.chanjiaLeaveDeduction}"/>
			
			<h:outputText value="难产产假扣款" />
			<h:inputText code="shuzi"  value="#{attCalcMgrBB.nanchanjiaLeaveDeduction}"/>
			
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return check();"  action="#{attCalcMgrBB.masterSave}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


