<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forsave(){		
	}
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.masterModifyInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���-> �����޸�" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="cener">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
			<h:outputText value="Ա�����"/>
			<h:outputText value="#{attCalcMgrBB.bo.personCode}"/>
			
			<h:outputText value="����" />
			<h:outputText value="#{attCalcMgrBB.bo.personName}"/>
			
			<h:outputText value="�ٵ�" />
			<h:inputText value="#{attCalcMgrBB.later}"/>

			<h:outputText value="����" />
			<h:inputText value="#{attCalcMgrBB.away}"/>
			
			<h:outputText value="�¼�" />
			<h:inputText value="#{attCalcMgrBB.normalLeave}"/>
			
			<h:outputText value="����" />
			<h:inputText value="#{attCalcMgrBB.illLeave}"/>
			
			<h:outputText value="����" />
			<h:inputText value="#{attCalcMgrBB.chanjiaLeave}"/>
			
			<h:outputText value="�Ѳ�����" />
			<h:inputText value="#{attCalcMgrBB.nanchanjiaLeave}"/>
			
			<h:outputText value="�ٵ��ۿ�" />
			<h:inputText value="#{attCalcMgrBB.laterDeduction}"/>
			
			<h:outputText value="�����ۿ�" />
			<h:inputText value="#{attCalcMgrBB.awayDeduction}"/>
			
			<h:outputText value="�¼ٿۿ�" />
			<h:inputText value="#{attCalcMgrBB.normalLeaveDeduction}"/>
			
			<h:outputText value="���ٿۿ�" />
			<h:inputText value="#{attCalcMgrBB.illLeaveDeduction}"/>
			
			<h:outputText value="���ٿۿ�" />
			<h:inputText value="#{attCalcMgrBB.chanjiaLeaveDeduction}"/>
			
			<h:outputText value="�Ѳ����ٿۿ�" />
			<h:inputText value="#{attCalcMgrBB.nanchanjiaLeaveDeduction}"/>
			
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return forsave();"  action="#{attCalcMgrBB.masterSave}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


