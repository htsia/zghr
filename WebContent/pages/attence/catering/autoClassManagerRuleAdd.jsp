<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	var orgIdValue=document.all("form1:orgId").value;
	if(orgIdValue==null || orgIdValue==""){
		alert("��ѡ���������š�");
		return false;
	}
	var restDayValue=document.all("form1:restDay").value;
	if(restDayValue==null || restDayValue==""){
		alert("�����뵱����Ϣ������");
		return false;
	}
	var groupnameValue=document.all("form1:groupname").value;
	if(groupnameValue==null || groupnameValue==""){
		alert("��ѡ���ѡ��Ρ�");
		return false;
	}
	var orgValue=document.all("form1:orgValue").value;
	if(orgValue=='1'){
		var lunchRateValue=document.all("form1:lunchRate").value;
		if(lunchRateValue==null || lunchRateValue==""){
			alert("��������ͱ�����");
			return false;
		}
		var superRateValue=document.all("form1:superRate").value;
		if(superRateValue==null || superRateValue==""){
			alert("��������ͱ�����");
			return false;
		}
		var waiterValue=document.all("form1:waiter").value;
		if(waiterValue==null || waiterValue==""){
			alert("���������Ա��������");
			return false;
		}
	}else if(orgValue=='2'){
		var produceRateValue=document.all("form1:produceRate").value;
		if(produceRateValue==null || produceRateValue==""){
			alert("�������Ʒ�ȡ�");
			return false;
		}
		var produceRoadValue=document.all("form1:produceRoad").value;
		if(produceRoadValue==null || produceRoadValue==""){
			alert("�������˾�ÿ�ͳ�Ʒ����");
			return false;
		}
	}else if(orgValue=='3'){
		var cleanNumberValue=document.all("form1:cleanNumber").value;
		if(cleanNumberValue==null || cleanNumberValue==""){
			alert("�������˾���ϴ����");
			return false;
		}
		var bigTableWareValue=document.all("form1:bigTableWare").value;
		if(bigTableWareValue==null || bigTableWareValue==""){
			alert("�������;������ȡ�");
			return false;
		}
		var smallTableWareValue=document.all("form1:smallTableWare").value;
		if(smallTableWareValue==null || smallTableWareValue==""){
			alert("������С�;������ȡ�");
			return false;
		}
		var bonePlateValue=document.all("form1:bonePlate").value;
		if(bonePlateValue==null || bonePlateValue==""){
			alert("������ǵ������ȡ�");
			return false;
		}
	}
  return true;
}
  </script>
<x:saveState value="#{autoclassmanagerruleBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{autoclassmanagerruleBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->�Զ��Ű�������" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="���ù�ʽ��" />
			<h:panelGroup>
				<h:selectOneMenu id="orgValue" value="#{autoclassmanagerruleBB.nowyearvalue}"
					valueChangeListener="#{autoclassmanagerruleBB.changeNowYearValue}"
					onchange="submit();">
					<c:selectItem itemValue="1" itemLabel="ǰ��" />
					<c:selectItem itemValue="2" itemLabel="����" />
					<c:selectItem itemValue="3" itemLabel="ϴ�빤" />
				</h:selectOneMenu>
			</h:panelGroup>

			<h:outputText value="��������"></h:outputText>
			<h:panelGroup>
               <h:inputHidden id="orgId" value="#{autoclassmanagerruleBB.bo.orgId}"/>
               <h:inputText styleClass="input" id="orgIdName" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{autoclassmanagerruleBB.bo.orgIdName}"
                     alt="���ڲ���|0|s|50||"/>
				<f:verbatim>
                     <input type="button" class="button_select" onclick="fPopUpOrgDlg2('form1:orgId','form1:orgIdName',1,'')">
				</f:verbatim>
			</h:panelGroup>

			<h:outputText value="������Ϣ����"></h:outputText>
			<h:panelGroup>
				<h:inputText id="restDay" value="#{autoclassmanagerruleBB.bo.restDay}">
				</h:inputText>
			</h:panelGroup>
			
			<h:outputText value="��ѡ���"></h:outputText>
			<h:panelGroup>
				<h:inputText id="groupname" readonly="true" size="30"
					value="#{autoclassmanagerruleBB.className}" />
				<h:inputHidden id="groupid" value="#{autoclassmanagerruleBB.bo.linkClass}" />
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpMoni(document.all('form1:groupid'),document.all('form1:groupname'))" />
			</h:panelGroup>
			
			<h:outputText value="��ͱ���:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='1'}"></h:outputText>
			<h:panelGroup rendered="#{autoclassmanagerruleBB.nowyearvalue=='1'}">
			<h:inputText id="lunchRate" value="#{autoclassmanagerruleBB.bo.lunchRate}" size="6"></h:inputText>
			<h:outputText value="%"></h:outputText>
			</h:panelGroup>
			
			<h:outputText value="��ͱ���:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='1'}"></h:outputText>
			<h:panelGroup rendered="#{autoclassmanagerruleBB.nowyearvalue=='1'}">
			<h:inputText id="superRate" value="#{autoclassmanagerruleBB.bo.superRate}" size="6"></h:inputText>
			<h:outputText value="%"></h:outputText>
			</h:panelGroup>
			
			<h:outputText value="����Ա������:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='1'}"></h:outputText>
			<h:inputText id="waiter" value="#{autoclassmanagerruleBB.bo.waiter}" rendered="#{autoclassmanagerruleBB.nowyearvalue=='1'}"></h:inputText>
		
		    <h:outputText value="��Ʒ��:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='2'}"></h:outputText>
			<h:panelGroup rendered="#{autoclassmanagerruleBB.nowyearvalue=='2'}">
			<h:inputText id="produceRate" value="#{autoclassmanagerruleBB.bo.produceRate}" size="6"></h:inputText>
		    <h:outputText value="%"></h:outputText>
			</h:panelGroup>
			
			<h:outputText value="�˾�ÿ�ͳ�Ʒ��:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='2'}"></h:outputText>
			<h:inputText id="produceRoad" value="#{autoclassmanagerruleBB.bo.produceRoad}" rendered="#{autoclassmanagerruleBB.nowyearvalue=='2'}"></h:inputText>
		
			<h:outputText value="�˾���ϴ��:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:outputText>
			<h:inputText id="cleanNumber" value="#{autoclassmanagerruleBB.bo.cleanNumber}" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:inputText>
		
			<h:outputText value="��;�������:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:outputText>
			<h:inputText id="bigTableWare" value="#{autoclassmanagerruleBB.bo.bigTableWare}" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:inputText>
		
			<h:outputText value="С�;�������:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:outputText>
			<h:inputText id="smallTableWare" value="#{autoclassmanagerruleBB.bo.smallTableWare}" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:inputText>
		
			<h:outputText value="�ǵ�������:" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:outputText>
			<h:inputText id="bonePlate" value="#{autoclassmanagerruleBB.bo.bonePlate}" rendered="#{autoclassmanagerruleBB.nowyearvalue=='3'}"></h:inputText>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return test()"
				action="#{autoclassmanagerruleBB.save}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


