<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){
		var money = document.all("form1:money").value;
		money=$.trim(money);
		document.all("form1:money").value=money;
		if(money==null || money.length==0 || isNaN(money)){
			alert("���Ϊ����");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{wage_dataOtherBB}" />
<h:inputHidden value="#{wage_dataOtherBB.editUser}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="�޸Ľ��" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="95%" align="center">
		<h:panelGrid columns="2" align="center" columnClasses="td_form01,td_form02" styleClass="table03">
			<h:outputText value="���"/>
			<h:inputText id="money" value="#{wage_dataOtherBB.userBo.money}" size="30" styleClass="input" onkeypress ="enterKeyDown('form1:save')"/>
			<h:outputText value="��ע"/>
			<h:inputTextarea value="#{wage_dataOtherBB.userBo.remark}" cols="30" rows="5" onkeypress ="enterKeyDown('form1:save')"/>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
			<h:commandButton id="save" styleClass="button01" value="����" onclick="return forsave();" action="#{wage_dataOtherBB.modifyUser}"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>


