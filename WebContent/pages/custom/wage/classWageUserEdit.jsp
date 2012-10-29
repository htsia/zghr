<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	function forsave(){
		var classNum = document.all("form1:classNum").value;
		classNum=$.trim(classNum);
		if(classNum==null || classNum=='' || isNaN(classNum)){
			alert("超课时数应为数字");
			return false;
		}
		document.all("form1:level2").value=document.all("form1:level2").code;
		return true;
	}
</script>
<x:saveState value="#{classWageBB}" />
<h:inputHidden value="#{classWageBB.editInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="超课时数修改" />
		</h:panelGroup>
	</h:panelGrid>
	<f:verbatim>
		<div style="color:red;padding:10px 20px;">说明：填写指定职称等级核算超课时工资时依照指定的<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;职称等级否则依照本人当前职称等级</div>
	</f:verbatim>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="超课时数"/>
			<h:inputText id="classNum" value="#{classWageBB.classWageBO.classNum}" styleClass="input" size="30"/>
			<h:outputText value="指定职称等级"/>
			<h:panelGroup>
				<h:inputText styleClass="input" id="level2" code="" dict="yes" dict_num="0170" size="30" value="#{classWageBB.classWageBO.level2}"
	                     alt="职称等级|0|s|50||"/>
	        	<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:level2')"/>
        	</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();" action="#{classWageBB.updateUser}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
	
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>