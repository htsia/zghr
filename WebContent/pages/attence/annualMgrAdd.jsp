<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	 var btime=document.all("form1:beginTime").value;
	 var etime=document.all("form1:endTime").value;
	    if(btime==null||btime==""||etime==null||etime==""){
	        alert("�����뿪ʼʱ��ͽ���ʱ��");
	        return false;
	    }else if(btime>etime){
	        alert("��ʼʱ�����ڽ���ʱ��");
	        return false;
	    }
        var groupname=document.all("form1:groupname").value;
	    if(groupname==null || groupname==""){
	        alert("��ѡ��������");
	        return false;
	    }
	    return true;
	 }
  </script>
<x:saveState value="#{annualMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{annualMgrBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{annualMgrBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->�������ڼ����·�" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="�� ��"></h:outputText>
			<h:selectOneMenu value="#{annualMgrBB.nowyearvalue}"
				valueChangeListener="#{annualMgrBB.changeNowYearValue}">
				<c:selectItems value="#{annualMgrBB.nowyearlist}"></c:selectItems>
			</h:selectOneMenu>
			<h:outputText value="��ȿ�ʼʱ��"></h:outputText>
			<h:panelGroup>
				<h:inputText id="beginTime" value="#{annualMgrBB.bo.yearBegin}"
					readonly="true">

				</h:inputText>

				<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCalendarDialog('form1:beginTime');">
				</f:verbatim>
			</h:panelGroup>



			<h:outputText value="��Ƚ���ʱ��"></h:outputText>
			<h:panelGroup>
				<h:inputText id="endTime" value="#{annualMgrBB.bo.yearEnd}"
					readonly="true">

				</h:inputText>

				<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCalendarDialog('form1:endTime');">
				</f:verbatim>
			</h:panelGroup>

			<h:outputText value="�������"></h:outputText>
			<h:panelGroup>
				<h:inputText id="groupname" readonly="true" size="30"
					value="#{annualMgrBB.ruleName}" />
				<h:inputHidden id="groupid" value="#{annualMgrBB.bo.ruleID}" />
				<h:commandButton type="button" styleClass="button_select" onclick="PopUpRule(document.all('form1:groupid'),document.all('form1:groupname'))" />
			</h:panelGroup>

		</h:panelGrid>


		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return test()"
				action="#{annualMgrBB.save}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


