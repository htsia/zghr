<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){
		var wage = document.all("form1:wage").value;
		wage=$.trim(wage);
		if(wage.length==0){
			var classNum = document.all("form1:classNum").value;
			classNum=$.trim(classNum);
			if(classNum==null || classNum=='' || isNaN(classNum)){
				alert("����ʱ��ӦΪ����");
				return false;
			}
			document.all("form1:level2").value=document.all("form1:level2").code;
		}else{
			if(wage==null || wage=='' || isNaN(wage)){
				alert("ʵ������ӦΪ����");
				return false;
			}
			document.all("form1:wage").value=wage;
		}
		return true;
	}
</script>
<x:saveState value="#{classWageBB}" />
<h:inputHidden value="#{classWageBB.editInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="����ʱ���޸�" />
			<f:verbatim>
				<span style="color:red;margin-left:30px;">
				</f:verbatim>
				<h:outputText value="#{classWageBB.currUserName}"/>
				<f:verbatim>
				</span>
			</f:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<f:verbatim>
		<div style="color:red;padding:10px 20px;">˵���������дʵ�����ʼ���ʵ�����ʼ���,�����дָ��<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ְ�Ƶȼ����㳬��ʱ����ʱ����ָ����ְ�Ƶȼ�<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�������ձ��˵�ǰְ�Ƶȼ�</div>
	</f:verbatim>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="����ʱ��"/>
			<h:inputText id="classNum" value="#{classWageBB.classWageBO.classNum}" styleClass="input" size="30"/>
			<h:outputText value="ָ��ְ�Ƶȼ�"/>
			<h:panelGroup>
				<h:inputText styleClass="input" id="level2" code="" dict="yes" dict_num="0170" size="30" value="#{classWageBB.classWageBO.level2}"
	                     alt="ְ�Ƶȼ�|0|s|50||"/>
	        	<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:level2')"/>
        	</h:panelGroup>
			<h:outputText value="ʵ������"/>
			<h:inputText styleClass="input" id="wage" size="30" value="#{classWageBB.classWageBO.wage}"/>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return forsave();" action="#{classWageBB.updateUser}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
	
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>