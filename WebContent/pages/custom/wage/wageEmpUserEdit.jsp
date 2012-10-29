<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery.js" type="text/javascript"></script>

<script type="text/javascript">
	function forsave(){
		var name =document.all("form1:name").value;
		if(name==null || name==''){
			alert("请填写姓名");
			return false;
		}
		var A001705 =document.all("form1:A001705").value;
		if(A001705==null || A001705==''){
			alert("请选择部门");
			return false;
		}
		document.all("form1:A001705").value=document.all("form1:A001705").code;
		document.all("form1:xueli").value=document.all("form1:xueli").code;
		document.all("form1:xuewei").value=document.all("form1:xuewei").code;
		document.all("form1:zhicheng").value=document.all("form1:zhicheng").code;
		document.all("form1:zhichengLevel").value=document.all("form1:zhichengLevel").code;
		document.all("form1:zhichengXulie").value=document.all("form1:zhichengXulie").code;
		return true;
	}
</script>
<x:saveState value="#{wage_empBB}" />
<h:inputHidden value="#{wage_empBB.editInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="人员维护" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="姓名"/>
			<h:inputText id="name" value="#{wage_empBB.user.name}" styleClass="input"/>
			<h:outputText value="人员类别"/>
			<h:selectOneMenu value="#{wage_empBB.user.personType}">
	        	<c:selectItem itemLabel="项目工" itemValue="0135700572"/>
	        	<c:selectItem itemLabel="学生工" itemValue="0135700573"/>
	        	<c:selectItem itemLabel="兼职教师" itemValue="0135700574"/>
	        </h:selectOneMenu>
        	<h:outputText value="身份证号"/>
			<h:inputText id="cardNo" value="#{wage_empBB.user.cardNO}" styleClass="input"/>
        	<h:outputText value="银行卡号"/>
			<h:inputText id="bankNo" value="#{wage_empBB.user.bankNO}" styleClass="input"/>
			<h:outputText value="所属部门"/>
			<h:panelGroup>
				<h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
	                     readonly="true" value="#{wage_empBB.user.deptId}"
	                     alt="所在机构|0|s|50||"/>
	            <f:verbatim>
	        		<input type="button" class="button_org" onclick="PopUpOrgDlgShowGroup('form1:A001705',2)">
	        	</f:verbatim>
        	</h:panelGroup>
        	<h:outputText value="学历"/>
        	<h:panelGroup>
				<h:inputText styleClass="input" id="xueli" code="" dict="yes" dict_num="0365" value="#{wage_empBB.user.xueli}"
	                     alt="学历|0|s|50||"/>
	        	<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:xueli')"/>
        	</h:panelGroup>
        	<h:outputText value="学位"/>
        	<h:panelGroup>
				<h:inputText styleClass="input" id="xuewei" code="" dict="yes" dict_num="0380" value="#{wage_empBB.user.xuewei}"
	                     alt="学位|0|s|50||"/>
	        	<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:xuewei')"/>
        	</h:panelGroup>
        	<h:outputText value="职称"/>
        	<h:panelGroup>
				<h:inputText styleClass="input" id="zhicheng" code="" dict="yes" dict_num="0355" value="#{wage_empBB.user.zhicheng}"
	                     alt="职称|0|s|50||"/>
	        	<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:zhicheng')"/>
        	</h:panelGroup>
        	<h:outputText value="职称等级"/>
        	<h:panelGroup>
				<h:inputText styleClass="input" id="zhichengLevel" code="" dict="yes" dict_num="0170" value="#{wage_empBB.user.zhichengLevel}"
	                     alt="职称等级|0|s|50||"/>
	        	<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:zhichengLevel')"/>
        	</h:panelGroup>
        	<h:outputText value="职称序列"/>
        	<h:panelGroup>
				<h:inputText styleClass="input" id="zhichengXulie" code="" dict="yes" dict_num="3029" value="#{wage_empBB.user.zhichengXulie}"
	                     alt="职称序列|0|s|50||"/>
	        	<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:zhichengXulie')"/>
        	</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();" action="#{wage_empBB.savePerson}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>