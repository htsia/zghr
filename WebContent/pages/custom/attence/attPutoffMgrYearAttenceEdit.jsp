<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function setapplytime(applyobj) {

		var time = document.all('form1:' + applyobj).value;

		PopUpCalendarDialog('form1:applytime');
		var ymd = document.all('form1:applytime').value;
		if (ymd == null) {
			document.all('form1:' + applyobj).value = "";
		} else {
			document.all('form1:' + applyobj).value = ymd;
		}
	}
</script>
<x:saveState value="#{attPutoffMgrBB}" />
<h:inputHidden value="#{attPutoffMgrBB.pageInit}" />
<h:form id="form1">
<h:inputHidden id="applytime"></h:inputHidden>
<h:panelGrid columns="3" align="center">
	
	<h:outputText value=" 起始日期:" />
	<h:inputText id="begintime" readonly="true"
		value="#{attPutoffMgrBB.beginDate}" styleClass="input" size="20" />
	<f:verbatim>
		<input type="button" class="button_select"
			onclick="setapplytime('begintime');">
	</f:verbatim>
	<h:outputText value=" 结束日期:" />
	<h:inputText id="endtime" readonly="true"
		value="#{attPutoffMgrBB.endDate}" styleClass="input" size="20" />
	<f:verbatim>
		<input type="button" class="button_select"
			onclick="setapplytime('endtime');">
	</f:verbatim>
	</h:panelGrid>
	<h:panelGrid align="right">
	<h:commandButton value="确定" action="#{attPutoffMgrBB.yearAttence}"
		styleClass="button01" />
    </h:panelGrid>
</h:form>