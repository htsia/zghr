<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	 var text5=document.all("form1:text5").value;
	 var btime=document.all("form1:beginTime").value;
	 var etime=document.all("form1:endTime").value;
	    if(text5==null||text5==""){
	        alert("��ѡ��Ӧ�÷�Χ");
	        return false;
	    }
	    if(btime==null||btime==""){
	        alert("�������׼��Ч");
	        return false;
	    }
	    if(etime==null||etime==""){
	        alert("�����붨������");
	        return false;
	    }
		if (btime <= 0) {
			alert("��׼��Ч��������㡣");
			return false;
		}
		if (etime <= 0) {
			alert("����������������㡣");
			return false;
		}
	    return true;
	 }
  </script>
<x:saveState value="#{setstandardBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{setstandardBB.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���->������׼" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="Ӧ�÷�Χ" rendered="#{setstandardBB.isExist==false}"></h:outputText>
             <h:inputText  styleClass="input"  value="#{setstandardBB.bo.orguidName}" readonly="true" rendered="#{setstandardBB.isExist==false}"/>
			<h:outputText value="Ӧ�÷�Χ" rendered="#{setstandardBB.isExist==true}"></h:outputText>
			<h:panelGroup>
                    <h:inputText id="text5" styleClass="input"  value="#{setstandardBB.bo.orguidName}" size="30" readonly="true" rendered="#{setstandardBB.isExist==true}"/>
                    <h:inputHidden id="text5code" value="#{setstandardBB.orgId}" />
                    <h:commandButton type="button" styleClass="button_select" onclick="PopUpMutilOnlyOrgTwoControl('form1:text5code','form1:text5','1','')" rendered="#{setstandardBB.isExist==true}"/>
</h:panelGroup>
<h:outputText value="" rendered="#{setstandardBB.isExist==false}"></h:outputText>
			<h:outputText value="��׼��Ч"></h:outputText>
			<h:panelGroup>
				<h:inputText id="beginTime" value="#{setstandardBB.bo.standWork}">
				</h:inputText>
			</h:panelGroup>
			
			<h:outputText value="��������"></h:outputText>
			<h:panelGroup>
				<h:inputText id="endTime" value="#{setstandardBB.bo.personNumber}">
				</h:inputText>
			</h:panelGroup>
			
		</h:panelGrid>


		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return test()"
				action="#{setstandardBB.save}" styleClass="button01" rendered="#{setstandardBB.isExist==true}"/>
		<h:commandButton value="����"   rendered="#{setstandardBB.isExist==false}"
				action="#{setstandardBB.save1}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


