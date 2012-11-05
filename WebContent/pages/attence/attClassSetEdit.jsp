<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		var classnamevalue = document.all('form1:classnamevalue').value;
		if (classnamevalue == null || classnamevalue == "") {
			alert("请先填入班次名称！");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{att_class_set_childBB}" />
<h:inputHidden id="initEdit" value="#{att_class_set_childBB.initEdit}"/>
<h:form id="form1">
	<h:inputHidden id="superId" value="#{att_class_set_childBB.superID}"/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 班次设置" />
		</h:panelGroup>
	</h:panelGrid>
	<f:verbatim><br/><br/></f:verbatim>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="班次名称"></h:outputText>
			<h:inputText id="classnamevalue" size="30"
				value="#{att_class_set_childBB.attClassBO.className}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" action="#{att_class_set_childBB.save}"
				styleClass="button01" onclick="return doAddItem();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


