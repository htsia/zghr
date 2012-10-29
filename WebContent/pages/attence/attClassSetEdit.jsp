<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
	function doAddItem() {
		var classnamevalue = document.all('form1:classnamevalue').value;
		if (classnamevalue == null || classnamevalue == "") {
			alert("�������������ƣ�");
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
			<h:outputText value="���ڹ���-> �������" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="�������"></h:outputText>
			<h:inputText id="classnamevalue" size="27"
				value="#{att_class_set_childBB.attClassBO.className}"></h:inputText>
			<h:outputText value="Ӧ�÷�Χ"></h:outputText>
			<h:selectOneMenu value="#{att_class_set_childBB.atttype}"
				onchange="submit();"
				valueChangeListener="#{att_class_set_childBB.changeStatus}">
				<c:selectItem itemLabel="#{att_class_set_childBB.superName}"
					itemValue="#{att_class_set_childBB.superID}"></c:selectItem>
				<c:selectItem itemLabel="ȫ����" itemValue="-1"></c:selectItem>
			</h:selectOneMenu>
			<h:outputText value="����/����" />
			<h:selectOneRadio value="#{att_class_set_childBB.setStatus}">
				<f:selectItem itemValue="1" itemLabel="����" />
				<f:selectItem itemValue="0" itemLabel="����" />
			</h:selectOneRadio>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" action="#{att_class_set_childBB.save}"
				styleClass="button01" onclick="return doAddItem();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


