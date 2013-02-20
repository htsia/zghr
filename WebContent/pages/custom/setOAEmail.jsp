<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){
		var onoff = document.all("form1:onoff").value;
		if(onoff==null || onoff==''){
			alert(onoff);
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{oaemailBB}" />
<h:inputHidden value="#{oaemailBB.pageInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="OA短信设置" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="98%" align="center">
		<f:verbatim><br/><br/></f:verbatim>
		<h:panelGrid columns="2" align="center" width="500" columnClasses="td_form01,td_form02" styleClass="table03">
			<h:outputText value="OA短信发信人"/>
			<h:panelGroup>
				<h:outputText value="用户名:"/>
				<h:inputText id="userID" value="#{oaemailBB.userID}" size="30" styleClass="input"/>
				<f:verbatim><br/></f:verbatim>			
				<h:outputText value="密     码:"/>
				<h:inputSecret id="password" value="#{oaemailBB.password}" size="30" styleClass="input"/>
			</h:panelGroup>
			<h:outputText value="接收用户名:"/>
			<h:inputText id="toOAUserID" value="#{oaemailBB.toOAUserID}" size="30" styleClass="input"/>
			<h:outputText value="是否启用"/>
			<h:selectBooleanCheckbox id="onoff" value="#{oaemailBB.onoff}"/>
		</h:panelGrid>
		<f:verbatim><br/></f:verbatim>
		<h:panelGrid columns="1" align="center">
			<h:commandButton styleClass="button01" value="  保  存  " onclick="return forsave();" action="#{oaemailBB.save}"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>

