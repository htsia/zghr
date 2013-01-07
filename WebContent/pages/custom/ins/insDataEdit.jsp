<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
	function forsave(){
		var wageDate = document.all("form1:wageDate").value;
		if(wageDate==null || wageDate==''){
			alert("请填写适用月份");
			return false;
		}
		return true;
	}

</script>
<x:saveState value="#{ins_dataBB}" />
<h:inputHidden value="#{ins_dataBB.editInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<td height="1" class="td_title"><img src="/images/tips.gif">保险管理 -> 保险缴费计算</td>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="适用月份"/>
			<h:inputText id="wageDate" value="#{ins_dataBB.item.wageDate}" styleClass="input Wdate" readonly="true" onclick="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'form1:wageDate'})"/>
			<h:outputText value="备注"/>
            <h:inputTextarea id="desc" value="#{ins_dataBB.item.remark}" cols="50" rows="3"/>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return forsave();" action="#{ins_dataBB.saveSet}" styleClass="button01"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>