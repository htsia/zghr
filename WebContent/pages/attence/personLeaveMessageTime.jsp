<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function al() {
		var classnamevalue = document.all('form1:classnamevalue').value;
		var classnamevalue1 = document.all('form1:classnamevalue1').value;
        var ymd=classnamevalue.trim()+":"+classnamevalue1.trim();
	        window.returnValue=ymd;
	        window.close();
	}
</script>
<x:saveState value="#{att_class_detailBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{att_class_detailBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="时间:"></h:outputText>
			<h:panelGroup>
			<h:selectOneMenu  id="classnamevalue" value="#{att_class_detailBB.newDetailValue}"
				valueChangeListener="#{att_class_detailBB.changeDetailValue}">
				<c:selectItems value="#{att_class_detailBB.detailList}"></c:selectItems>
			</h:selectOneMenu>
			<h:outputText value=" : "></h:outputText>
			<h:selectOneMenu id="classnamevalue1" value="#{att_class_detailBB.newDetailValue1}"
				valueChangeListener="#{att_class_detailBB.changeDetailValue1}">
				<c:selectItems value="#{att_class_detailBB.detailList1}"></c:selectItems>
			</h:selectOneMenu>
			<h:outputText value=" (时:分)"></h:outputText>
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="提交" onclick="al();"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>