<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>

<script type="text/javascript">
	function add() {
		var attname1 = document.all('form1:attname1').value;
		var attname2 = document.all('form1:attname2').value;
		var attname3 = document.all('form1:attname3').value;
		if (attname1 != null  &&   attname1 != "" && attname2 != null  &&   attname2 != "" && attname3 != null  &&   attname3 != "") {
			return true;
		}else{
            alert("��ֵ(��)���ֵ(��)���ݼ���������Ϊ�ա�");
            return false;
		} 
	}
</script>
<x:saveState value="#{annualRuleItemBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{annualRuleItemBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->��ٹ������� " />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="��ֵ(��)"></h:outputText>
			<h:inputText id="attname1" value="#{annualRuleItemBB.bo.lowValue}"></h:inputText>
            <h:outputText value="��ֵ(��)"></h:outputText>
			<h:inputText id="attname2" value="#{annualRuleItemBB.bo.highValue}"></h:inputText>
			<h:outputText value="�ݼ�����"></h:outputText>
			<h:inputText id="attname3" value="#{annualRuleItemBB.bo.annDay}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return add();" action="#{annualRuleItemBB.save}"
				styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


