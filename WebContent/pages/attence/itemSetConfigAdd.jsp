<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
function add() {
	var timevalue=window
	.showModalDialog(
			"/pages/attence/itemSetConfigAddFlagChar.jsp",
			null,
			"dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
    if(timevalue!=null && timevalue!=""){
    	document.all('form1:endtimevalue').value=timevalue; 
    }else{
    	document.all('form1:endtimevalue').value="";
    }
	return true;
}
function check() {
	var timevalue=document.all('form1:endtimevalue').value;
    if(timevalue!=null && timevalue!=""){
    	return true;
    }else{
        alert("代表字符为空。");
    	return false;
    }
}
</script>
<x:saveState value="#{itemsetconfigBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{itemsetconfigBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->考勤项目规则" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="规则名称"></h:outputText>
			<h:selectOneMenu value="#{itemsetconfigBB.atttype}"
				valueChangeListener="#{itemsetconfigBB.changeStatus}">
				<c:selectItems value="#{itemsetconfigBB.nowyearlist}"></c:selectItems>
			</h:selectOneMenu>
			<h:outputText value="代表字符" />
			<h:panelGroup>
				<h:inputText id="endtimevalue"
					value="#{itemsetconfigBB.flagcharname}" size="12"></h:inputText>
				<h:commandButton onclick="selectItemFlag(document.all('form1:endtimevalue'))" type="button"
					styleClass="button_select"></h:commandButton>
			</h:panelGroup>
			<h:outputText value="计量单位"></h:outputText>
			<h:selectOneMenu value="#{itemsetconfigBB.unitvalue}"
				valueChangeListener="#{itemsetconfigBB.changeStatus1}">
				<c:selectItem itemLabel="-" itemValue="-1"></c:selectItem>
				<c:selectItem itemLabel="次" itemValue="0"></c:selectItem>
				<c:selectItem itemLabel="天" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="小时" itemValue="2"></c:selectItem>
				<c:selectItem itemLabel="分钟" itemValue="3"></c:selectItem>
			</h:selectOneMenu>

		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" action="#{itemsetconfigBB.save}"
				onclick="return check();" styleClass="button01"
				rendered="#{itemsetconfigBB.isExist==true}" />
			<h:commandButton value="保存" action="#{itemsetconfigBB.update}"
				onclick="return check();" styleClass="button01"
				rendered="#{itemsetconfigBB.isExist==false}" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


