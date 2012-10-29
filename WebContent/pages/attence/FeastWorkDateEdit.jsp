<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function add() {
		var timename = document.all('form1:A00001').value;
		PopUpCalendarDialog('form1:timeObjectID');
		if (timename != null && timename != "") {
			document.all('form1:A00001').value = timename + ","
					+ document.all('form1:timeObjectID').value;
		} else {
			document.all('form1:A00001').value = document
					.all('form1:timeObjectID').value;
		}
	}
	function repeart() {
		document.all('form1:A00001').value = '';
	}
</script>
<x:saveState value="#{attfeastworkdateBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{attfeastworkdateBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="timeObjectID"
		value="#{attfeastworkdateBB.timeObject}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤调休管理" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="3" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="设置日期"></h:outputText>
			<h:panelGroup>
				<h:inputTextarea id="A00001" readonly="true"
					rendered="#{attfeastworkdateBB.isExist==true}"
					value="#{attfeastworkdateBB.workDatelists}" cols="35" rows="3"></h:inputTextarea>
				<h:commandButton value="" onclick="add();"
					rendered="#{attfeastworkdateBB.isExist==true}"
					styleClass="button_select" />
			</h:panelGroup>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="12"
					rendered="#{attfeastworkdateBB.isExist==false}" alt="起始日期|0|d"
					value="#{attfeastworkdateBB.bo.workDate}" readonly="true" />
				<h:commandButton type="button" styleClass="button_select"
					rendered="#{attfeastworkdateBB.isExist==false}"
					onclick="PopUpCalendarDialog('form1:beginTime');" />
			</h:panelGroup>
			<h:outputText value="说明:"
				rendered="#{attfeastworkdateBB.isExist==true}"></h:outputText>
			<h:panelGroup>
				<h:outputText value="日期格式规定如下："
					rendered="#{attfeastworkdateBB.isExist==true}"></h:outputText>
				<c:verbatim>
					<br>
				</c:verbatim>
				<h:outputText value="1.分割符号必须是-，格式为yyyy-MM-dd，如2010-01-01"
					rendered="#{attfeastworkdateBB.isExist==true}"></h:outputText>
				<c:verbatim>
					<br>
				</c:verbatim>
				<h:outputText
					value="2.包含多个时间时，用逗号分割，如2010-01-01,2010-01-02,2010-01-03"
					rendered="#{attfeastworkdateBB.isExist==true}"></h:outputText>
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="3" align="right">
			<h:commandButton rendered="#{attfeastworkdateBB.isExist==true}"
				value="清空" onclick="repeart()" styleClass="button01" />
			<h:commandButton value="保存" action="#{attfeastworkdateBB.save}"
				rendered="#{attfeastworkdateBB.isExist==true}" styleClass="button01" />
			<h:commandButton value="保存" action="#{attfeastworkdateBB.update}"
				rendered="#{attfeastworkdateBB.isExist==false}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


