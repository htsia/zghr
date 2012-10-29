<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	 var place=document.all("form1:place").value;
	    if(place==null || place==""){
	        alert("排除原因为空");
	        return false;
	    }
	    return true;
	 }
  </script>
<x:saveState value="#{annualMgrListBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{annualMgrListBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->不允许休年假" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="人员" />
			<h:inputTextarea value="#{annualMgrListBB.personNames}"
				cols="35" rows="5" readonly="true"></h:inputTextarea>
			<h:outputText value="排除原因" />
			<h:inputTextarea id="place" value="#{annualMgrListBB.causeValues}"
				cols="35" rows="5"></h:inputTextarea>
		</h:panelGrid>

		<h:panelGrid columns="2" align="right">
			<h:commandButton value="保存" onclick="return test()"
				action="#{annualMgrListBB.confirmMethod}" styleClass="button01" />
			<h:commandButton styleClass="button01" value="取消返回"
				onclick="window.close();" />
		</h:panelGrid>

	</h:panelGrid>
</h:form>
