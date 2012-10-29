<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>

<script type="text/javascript">
	function forsave(){
		var userIds = document.all("form1:userIds").value;
		var time = document.all("form1:logDateTime").value;
		if(userIds==null || userIds==""){
			alert("请选择人员");
			return false;
		}else if(time==null || time==""){
			alert("请选择时间");
			return false;
		}
		return true;
	}
	function selperson(){
		var ids = window.showModalDialog(
						"/custom/selPerson.jsf?",
						null,
						"dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
		if(ids!=null && ids.length>0){
			document.all('form1:selectedUserIds').value=ids;
			return true;
		}else{
			return false;
		}
	}
</script>
<x:saveState value="#{att_logMrgBB}" />
<h:inputHidden value="#{att_logMrgBB.checkinInit}"/>
<h:form id="form1">
	<h:inputHidden id="selectedUserIds" value="#{att_logMrgBB.selectedUserIds}"/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%" 
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="签到时间编辑" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left" >
		<h:panelGrid columns="2" align="center" columnClasses="td_form01,td_form02" styleClass="table03">
			<h:outputText value="姓名"/>
             <h:panelGroup>
	             <h:inputTextarea id="userIds" value="#{att_logMrgBB.selectPersonNames}" cols="40" rows="5" readonly="true"/>
             	 <h:commandButton onclick="return selperson();" value="" styleClass="button_select" action="#{att_logMrgBB.selPerson}"/>
             </h:panelGroup>
			<h:outputText value="时间"/>
			<h:panelGroup>
				<h:inputText id="logDateTime" readonly="true" value="#{att_logMrgBB.logDateTime}" styleClass="input" size="25"/>
				<c:verbatim>
                <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:logDateTime'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </c:verbatim>
			</h:panelGroup>
		</h:panelGrid>
		<h:panelGrid columns="1" align="right">
			<h:commandButton styleClass="button01" value="保存" onclick="return forsave();" action="#{att_logMrgBB.checkin}"/>
		</h:panelGrid>
	</h:panelGrid>
</h:form>


