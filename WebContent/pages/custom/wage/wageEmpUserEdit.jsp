<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
	function forsave(){
		var name =document.all("form1:name").value;
		if(name==null || name==''){
			alert("����д����");
			return false;
		}
		var A001705 =document.all("form1:A001705").value;
		if(A001705==null || A001705==''){
			alert("��ѡ����");
			return false;
		}
		var cardNO =document.all("form1:cardNO").value;
		if(cardNO==null || cardNO==''){
			alert("����д���֤");
			return false;
		}
		var wage = document.all("form1:wage").value;
		wage=$.trim(wage);
		if(wage!='' && wage!=null && isNaN(wage)){
			alert("��������ӦΪ����");
			return false;
		}
		var other = document.all("form1:other").value;
		other=$.trim(other);
		if(other!='' && other!=null && isNaN(other)){
			alert("��������ӦΪ����");
			return false;
		}
		document.all("form1:A001705").value=document.all("form1:A001705").code;
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
			<h:outputText value="��Աά��" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="����"/>
			<h:inputText id="name" value="#{wage_empBB.user.name}" styleClass="input"/>
			<h:outputText value="��Ա���"/>
			<h:selectOneMenu value="#{wage_empBB.user.personType}">
	        	<c:selectItem itemLabel="��Ŀ��" itemValue="0135700572"/>
	        	<c:selectItem itemLabel="��ְ��ʦ" itemValue="0135700574"/>
	        </h:selectOneMenu>
        	<h:outputText value="���֤��"/>
			<h:inputText id="cardNo" value="#{wage_empBB.user.cardNO}" styleClass="input"/>
        	<h:outputText value="���п���"/>
			<h:inputText id="bankNo" value="#{wage_empBB.user.bankNO}" styleClass="input"/>
			<h:outputText value="��������"/>
			<h:panelGroup>
				<h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
	                     readonly="true" value="#{wage_empBB.user.deptId}"
	                     alt="���ڻ���|0|s|50||"/>
	            <f:verbatim>
	        		<input type="button" class="button_org" onclick="PopUpOrgDlgShowGroup('form1:A001705',2)">
	        	</f:verbatim>
        	</h:panelGroup>
        	<h:outputText value="��������"/>
			<h:inputText id="wage" value="#{wage_empBB.wage}" styleClass="input"/>
        	<h:outputText value="��������"/>
			<h:inputText id="other" value="#{wage_empBB.other}" styleClass="input"/>
        	<h:outputText value="�Ƿ��ֽ�"/>
        	<h:selectBooleanCheckbox id="hasCash" value="#{wage_empBB.user.hasCash}"/>
		</h:panelGrid>
		
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return forsave();" action="#{wage_empBB.savePerson}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>