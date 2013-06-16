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
					alert(dict+"应为数字");
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
			<f:verbatim>保险管理 -> 保险缴费维护</f:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="个人养老"/>
			<h:inputText id="personYlao" dict="个人养老" value="#{ins_dataBB.monthPay.personYlao}" styleClass="input"/>
			<h:outputText value="个人失业"/>
			<h:inputText id="personShiye" dict="个人失业" value="#{ins_dataBB.monthPay.personShiye}" styleClass="input"/>
			<h:outputText value="个人医疗"/>
			<h:inputText id="personYliao" dict="个人医疗" value="#{ins_dataBB.monthPay.personYliao}" styleClass="input"/>
			<h:outputText value="个人医疗商业"/>
			<h:inputText id="personDaejin" dict="个人医疗商业" value="#{ins_dataBB.monthPay.personDaejin}" styleClass="input"/>
			<h:outputText value="个人公积金"/>
			<h:inputText id="personGongjijin" value="#{ins_dataBB.monthPay.personGongjijin}" styleClass="input"/>
			<h:outputText value="单位养老"/>
			<h:inputText id="companyYlao" dict="个人公积金" value="#{ins_dataBB.monthPay.companyYlao}" styleClass="input"/>
			<h:outputText value="单位失业"/>
			<h:inputText id="companyShiye" dict="单位失业" value="#{ins_dataBB.monthPay.companyShiye}" styleClass="input"/>
			<h:outputText value="单位工伤"/>
			<h:inputText id="companyGongshang" dict="单位工伤" value="#{ins_dataBB.monthPay.companyGongshang}" styleClass="input"/>
			<h:outputText value="单位医疗"/>
			<h:inputText id="companyYliao" dict="单位医疗" value="#{ins_dataBB.monthPay.companyYliao}" styleClass="input"/>
			<h:outputText value="单位生育"/>
			<h:inputText id="companyShengyu" dict="单位生育" value="#{ins_dataBB.monthPay.companyShengyu}" styleClass="input"/>
			<h:outputText value="单位医疗商业"/>
			<h:inputText id="companyDaejin" dict="单位个人医疗商业" value="#{ins_dataBB.monthPay.companyDaejin}" styleClass="input"/>
			<h:outputText value="单位公积金"/>
			<h:inputText id="companyGongjijin" dict="单位公积金" value="#{ins_dataBB.monthPay.companyGongjijin}" styleClass="input"/>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();" action="#{ins_dataBB.saveMonthPay}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>