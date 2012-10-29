<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	function forsave(){
		var type = document.all("form1:koushuiType").value;
		if(type==1){
			var xs = document.all("form1:koushui").value;
			if(xs ==null || xs =='' || isNaN(xs)){
				alert("固定税额应填写数字");
				return false;
			}
		}
		return true;
	}
</script>
<x:saveState value="#{evaWageBB}" />
<h:inputHidden value="#{evaWageBB.koushuiInit}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="koushuiType" value="#{evaWageBB.koushuiType}"/>
	<c:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	        <tr>
	            <td height=20 class="td_title"><img src="/images/tips.gif">扣税办法</td>
	        </tr>
	    </table>
	</c:verbatim>
	<h:panelGrid columns="1" width="100%" align="left">
		 <h:panelGrid columns="1" align="left">
			<h:panelGroup>
				<h:commandButton styleClass="button01" value="保存" onclick="return forsave();" action="#{evaWageBB.saveKoushui}"/>
			</h:panelGroup>
		 </h:panelGrid>
		 <h:panelGrid columns="2" width="98%" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
		 	<h:outputText value="扣税方法"/>
		 	<h:panelGroup>
		 		<h:selectOneRadio value="#{evaWageBB.koushuiType}" onclick="submit();" valueChangeListener="#{evaWageBB.changeType}">
					<c:selectItem itemValue="0" itemLabel="关联税率表"/>
			        <c:selectItem itemValue="1" itemLabel="固定数额"/>
				</h:selectOneRadio>
				<h:outputText value="固定数额:"/>
				<h:inputText id="koushui" value="#{evaWageBB.koushui}" styleClass="input" size="5"/>
		 	</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
</h:form>


