<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function check() {
	var v = "";
	var b = true;
	$("input[code='shuzi']").each(function() {
		v = this.value;
		if (isNaN(v)) {
			alert("�Ƿ��ַ�,Ӧ��Ϊ����");
			b = false;
		}
	});
	return b;
}
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.modifyInit}"/>
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
			<h:inputText code="shuzi" value="#{attCalcMgrBB.lateModify}" />

			<h:outputText value="����" />
			<h:inputText code="shuzi" value="#{attCalcMgrBB.awayModify}" />

			<h:outputText value="�¼�" />
			<h:inputText code="shuzi" value="#{attCalcMgrBB.leaveReasonsModify}" />

			<h:outputText value="����" />
			<h:inputText code="shuzi" value="#{attCalcMgrBB.sickModify}" />

			<h:outputText value="����" />
			<h:inputText code="shuzi" value="#{attCalcMgrBB.maternityModify}" />
			
			<h:outputText value="�Ѳ�����" />
			<h:inputText code="shuzi" value="#{attCalcMgrBB.nanchanjiaLeaveModify}" />
				
			<h:outputText value="�ٵ��ۿ�" />
			<h:inputText code="shuzi"  value="#{attCalcMgrBB.laterDeductionModify}"/>
			
			<h:outputText value="�����ۿ�" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.awayDeductionModify}"/>
			
			<h:outputText value="�¼ٿۿ�" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.normalLeaveDeductionModify}"/>
			
			<h:outputText value="���ٿۿ�" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.illLeaveDeductionModify}"/>
			
			<h:outputText value="���ٿۿ�" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.chanjiaLeaveDeductionModify}"/>
			
			<h:outputText value="�Ѳ��ٿۿ�" />
			<h:inputText  code="shuzi" value="#{attCalcMgrBB.nanchanjiaLeaveDeductionModify}"/>
			
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return check();"  action="#{attCalcMgrBB.verifySave}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


