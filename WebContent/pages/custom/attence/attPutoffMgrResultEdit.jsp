<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
	<script src="<%=request.getContextPath()%>/js/jquery.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function modify(){
		document.all("form1:days").value=document.all("form1:hours").value;
	}
	function check(){
		var v = "";
		var b=true;
		$("input[code='shuzi']").each(function(){
			v = this.value;
			if(v == ""){
				alert("数字不能为空");
				b=false;
			}
			if(isNaN(v)){
				alert("非法字符,应该为数字");
				b=false;
			}
		});	
		return b;
	}
</script>
<x:saveState value="#{attPutoffMgrBB}" />
<h:inputHidden value="#{attPutoffMgrBB.modifyInit}" />
<h:form id="form1">
<h:inputHidden  id="days" value="#{attPutoffMgrBB.putoffDays}" />
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 数据修改" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="cener">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			styleClass="table03" align="center">
			<h:outputText value="姓名" />
			<h:outputText value="#{attPutoffMgrBB.bo.name}" />

			<h:outputText value="总存休时间/时" />			
			<h:inputText code="shuzi" id="hours" value="" onchange="modify()" />

			<h:outputText value="请假天数" />
			<h:inputText code="shuzi" value="#{attPutoffMgrBB.leaveDays}" />

			<h:outputText value="病假" />
			<h:inputText code="shuzi" value="#{attPutoffMgrBB.bingjia}" />

			<h:outputText value="婚假" />
			<h:inputText code="shuzi" value="#{attPutoffMgrBB.hunjia}" />

			<h:outputText value="丧假" />
			<h:inputText code="shuzi" value="#{attPutoffMgrBB.sangjia}" />

			<h:outputText value="产假" />
			<h:inputText code="shuzi" value="#{attPutoffMgrBB.chanjia}" />


			<h:outputText value="难产产假" />
			<h:inputText code="shuzi" value="#{attPutoffMgrBB.nanchanjia}" />

			<h:outputText value="带薪事假" />
			<h:inputText code="shuzi" value="#{attPutoffMgrBB.daixinjia}" />
			<h:outputText value="应出勤天数" />
			<h:inputText value="#{attPutoffMgrBB.yinggai}" />
			<h:outputText value="实际出勤天数" />
			<h:inputText value="#{attPutoffMgrBB.shiji}" />
			<h:outputText value="出勤率" />
			<h:inputText value="#{attPutoffMgrBB.rate}" />

		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return check()" action="#{attPutoffMgrBB.save}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
	document.all("form1:hours").value=document.all("form1:days").value;
</script>