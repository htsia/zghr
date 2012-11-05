<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){
		var beginDate = document.all("form1:beginDate").value;
		var totalmoney=null;
		
		if($.trim(document.all("form1:name").value).length==0){
			alert("����д��Ŀ����");
			return false;
		}else if(beginDate==null || beginDate==""){
			alert("��ѡ����Ŀ����");
			return false;
		}
		return true;
	}

	function setData1(v){
		if(v==1){
			PopUpCalendar_OnlyMonth('form1:beginDate');
		}else{
			PopUpCalendar_OnlyMonth('form1:endDate');			
		}
		return false;
	}
</script>
<x:saveState value="#{wage_dataOthersBB}" />
<h:inputHidden value="#{wage_dataOthersBB.editInit}" />
<h:form id="form1">
	<h:inputHidden id="datestr" value="" />
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="н�����-> ��������" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">

			<h:outputText value="��Ŀ����"/>
			<h:inputText id="name" value="#{wage_dataOthersBB.item.name}" styleClass="input" size="30"/>

			<h:outputText value="Ŀ���ֶ�"/>
			<h:panelGroup>
				<h:selectOneMenu value="#{wage_dataOthersBB.item.targetData}">
					<c:selectItems value="#{wage_dataOthersBB.itemList}" />
				</h:selectOneMenu>	
			</h:panelGroup>
			<h:outputText value="��Ŀ����" />
			<h:panelGroup>
				<h:outputText value="" />
				<h:inputText id="beginDate"
					value="#{wage_dataOthersBB.item.beginDate}" styleClass="input"
					readonly="true" />
				<h:commandButton onclick="return setData1(1);"
					styleClass="button_select" value="" />
			</h:panelGroup>

			<h:outputText value="��ע" />
			<h:inputTextarea id="desc" value="#{wage_dataOthersBB.item.desc}"
				cols="50" rows="3" />
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return forsave();"
				action="#{wage_dataOthersBB.saveSet}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


