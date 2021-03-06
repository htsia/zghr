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
			alert("金额为数字");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{wage_dataOthersBB}" />
<h:inputHidden value="#{wage_dataOthersBB.editUser}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="修改金额" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="95%" align="center">
		<h:panelGrid columns="2" align="center" columnClasses="td_form01,td_form02" styleClass="table03">
			<h:outputText value="金额"/>
			<h:inputText id="money" value="#{wage_dataOthersBB.userBo.money}" size="30" styleClass="input"/>
			<h:outputText value="备注"/>
			<h:inputTextarea value="#{wage_dataOthersBB.userBo.remark}" cols="30" rows="5"/>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
			<h:commandButton styleClass="button01" value="保存" onclick="return forsave();" action="#{wage_dataOthersBB.modifyUser}"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>


