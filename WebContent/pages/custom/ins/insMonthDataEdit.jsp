<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
	function forsave(){
		var pass=true;
		var obj = document.getElementById("form1").elements;
		for(var i=0;i<obj.length;i++){
			var dict=obj[i].dict;
			if(dict!=null && dict!=''){
				if(obj[i].value.trim().length==0 || isNaN(obj[i].value)){
					alert(dict+"ӦΪ����");
					pass=false;
					break;
				}
			}
		}
		return pass;
	}

</script>
<x:saveState value="#{ins_dataBB}" />
<h:inputHidden value="#{ins_dataBB.editMonthInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>���չ��� -> ���սɷ�ά��</f:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="��������"/>
			<h:inputText id="personYlao" dict="��������" value="#{ins_dataBB.monthPay.personYlao}" styleClass="input"/>
			<h:outputText value="����ʧҵ"/>
			<h:inputText id="personShiye" dict="����ʧҵ" value="#{ins_dataBB.monthPay.personShiye}" styleClass="input"/>
			<h:outputText value="����ҽ��"/>
			<h:inputText id="personYliao" dict="����ҽ��" value="#{ins_dataBB.monthPay.personYliao}" styleClass="input"/>
			<h:outputText value="����ҽ����ҵ"/>
			<h:inputText id="personDaejin" dict="����ҽ����ҵ" value="#{ins_dataBB.monthPay.personDaejin}" styleClass="input"/>
			<h:outputText value="���˹�����"/>
			<h:inputText id="personGongjijin" value="#{ins_dataBB.monthPay.personGongjijin}" styleClass="input"/>
			<h:outputText value="��λ����"/>
			<h:inputText id="companyYlao" dict="���˹�����" value="#{ins_dataBB.monthPay.companyYlao}" styleClass="input"/>
			<h:outputText value="��λʧҵ"/>
			<h:inputText id="companyShiye" dict="��λʧҵ" value="#{ins_dataBB.monthPay.companyShiye}" styleClass="input"/>
			<h:outputText value="��λ����"/>
			<h:inputText id="companyGongshang" dict="��λ����" value="#{ins_dataBB.monthPay.companyGongshang}" styleClass="input"/>
			<h:outputText value="��λҽ��"/>
			<h:inputText id="companyYliao" dict="��λҽ��" value="#{ins_dataBB.monthPay.companyYliao}" styleClass="input"/>
			<h:outputText value="��λ����"/>
			<h:inputText id="companyShengyu" dict="��λ����" value="#{ins_dataBB.monthPay.companyShengyu}" styleClass="input"/>
			<h:outputText value="��λҽ����ҵ"/>
			<h:inputText id="companyDaejin" dict="��λ����ҽ����ҵ" value="#{ins_dataBB.monthPay.companyDaejin}" styleClass="input"/>
			<h:outputText value="��λ������"/>
			<h:inputText id="companyGongjijin" dict="��λ������" value="#{ins_dataBB.monthPay.companyGongjijin}" styleClass="input"/>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return forsave();" action="#{ins_dataBB.saveMonthPay}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>