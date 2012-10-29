<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
    
</c:verbatim>
<script type="text/javascript">
function test(){
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != ""){
		 if(beginTime>endTime){
		        alert("起始日期晚于结束日期");
		        return false;
		 }
	}
	    return true;
}
function timeCheck(){
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != ""){
		 if(beginTime>endTime){
		        alert("起始日期晚于结束日期");
		        return false;
		 }
		 document.all('form1:refresh').click();
	}
	return true;
}
</script>
<x:saveState value="#{amtolBB}" />
<h:form id="form1">
    <h:commandButton id="refresh" value="刷新" style="display:none;" action="#{amtolBB.makesure}"></h:commandButton>
	<h:inputHidden id="attname" value="#{amtolBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->倒休调整" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="姓名"></h:outputText>
			<h:outputText value="#{amtolBB.bo.personName}"></h:outputText>
			<h:outputText value="倒休时间"></h:outputText>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="起始日期|0|d" value="#{amtolBB.begindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			        <h:outputText escape="false" value=" 至  " />
			        <h:inputText styleClass="input" id="endTime" alt="结束日期|0|d" onclick="timeCheck();"
					size="30" value="#{amtolBB.enddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
			<h:outputText value="倒休天数"></h:outputText>
			<h:panelGroup>
				<h:inputText value="#{amtolBB.kqglLeaverDayValue}" readonly="true"></h:inputText>
				<h:outputText value="="></h:outputText>
				<h:outputText value="#{amtolBB.bo.lastDate}"></h:outputText>
			</h:panelGroup>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return test()"
				action="#{amtolBB.save}" styleClass="button01" />
		</h:panelGrid>

	</h:panelGrid>
</h:form>


