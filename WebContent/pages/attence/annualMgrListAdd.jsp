<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
function test1() {
	PopUpCalendarDialog('form1:beginTime');
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	var begintimevalue = document.all('form1:begintimevalue').value;
	var endtimevalue = document.all('form1:endtimevalue').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != "" && begintimevalue != null && begintimevalue != "" && endtimevalue != null && endtimevalue != ""){
		 if(beginTime>endTime){
		        alert("起始日期晚于结束日期");
		        return false;
		 }
		document.all('form1:refresh').click();
	}
	return true;
}

function test2() {
	PopUpCalendarDialog('form1:endTime');
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	var begintimevalue = document.all('form1:begintimevalue').value;
	var endtimevalue = document.all('form1:endtimevalue').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != "" && begintimevalue != null && begintimevalue != "" && endtimevalue != null && endtimevalue != ""){
		 if(beginTime>endTime){
		        alert("起始日期晚于结束日期");
		        return false;
		 }
		document.all('form1:refresh').click();
	}
	return true;
}

function test3() {
	doAddItem();
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	var begintimevalue = document.all('form1:begintimevalue').value;
	var endtimevalue = document.all('form1:endtimevalue').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != "" && begintimevalue != null && begintimevalue != "" && endtimevalue != null && endtimevalue != ""){
		 if(beginTime>endTime){
		        alert("起始日期晚于结束日期");
		        return false;
		 }
		document.all('form1:refresh').click();
	}
	return true;
}

function test4() {
	doAddItem1();
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	var begintimevalue = document.all('form1:begintimevalue').value;
	var endtimevalue = document.all('form1:endtimevalue').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != "" && begintimevalue != null && begintimevalue != "" && endtimevalue != null && endtimevalue != ""){
		 if(beginTime>endTime){
		        alert("起始日期晚于结束日期");
		        return false;
		 }
		document.all('form1:refresh').click();
	}
	return true;
}


function doAddItem() {
	var timevalue=window
			.showModalDialog(
					"/attence/personLeaveMessageTime.jsf",
					null,
					"dialogWidth:300px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
    if(timevalue!=null && timevalue!=""){
    	document.all('form1:begintimevalue').value=timevalue; 
    }else{
    	document.all('form1:begintimevalue').value="";
    }
	return true;
}





function doAddItem1() {
	var timevalue=window
			.showModalDialog(
					"/attence/personLeaveMessageTime.jsf",
					null,
					"dialogWidth:300px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
    if(timevalue!=null && timevalue!=""){
    	document.all('form1:endtimevalue').value=timevalue; 
    }else{
    	document.all('form1:endtimevalue').value="";
    }
	return true;
}

	function add() {
		var attname3 = document.all('form1:attname3').value;
		if (attname3 <= 0) {
			alert("休假结束日期要在开始日期之后。");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{annualMgrListChildBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{annualMgrListChildBB.initEdit}"></h:inputHidden>
	<h:commandButton id="refresh" value="刷新" style="display:none;"
		action="#{annualMgrListChildBB.makesure}"></h:commandButton>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->休假天数设置 " />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02"
			align="left" styleClass="table03">
			<h:outputText value="起始日期" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="12"
					alt="起始日期|0|d" value="#{annualMgrListChildBB.begindatevalue}"
					readonly="true" />
				<h:commandButton type="button" styleClass="button_select"
						onclick="return test1();"  />
			</h:panelGroup>
			<h:outputText value="起始时间" />
			<h:panelGroup>
				<h:inputText id="begintimevalue"
					value="#{annualMgrListChildBB.begintimevalue}" size="12"></h:inputText>
				<h:commandButton    onclick="return test3();"  type="button"
					styleClass="button_select"></h:commandButton>
			</h:panelGroup>

			<h:outputText value="结束日期" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="结束日期|0|d"
					size="12" value="#{annualMgrListChildBB.enddatevalue}" readonly="true" />
				<h:commandButton type="button" styleClass="button_select"
					onclick="return test2();" />
			</h:panelGroup>

			<h:outputText value="结束时间" />
			<h:panelGroup>
				<h:inputText id="endtimevalue"
					value="#{annualMgrListChildBB.endtimevalue}" size="12"></h:inputText>
				<h:commandButton onclick="return test4();"  type="button"
					styleClass="button_select"></h:commandButton>
			</h:panelGroup>

		
		</h:panelGrid>
		<h:panelGrid columns="2"  columnClasses="td_form01 "
			align="left"   >
		<h:outputText value="可用天数   "></h:outputText>
			<h:outputLabel id="attname1"   styleClass="f06"
				value="#{annualMgrListChildBB.avaDay}"></h:outputLabel>
				
				
			<h:outputText value="实际天数  "></h:outputText>
			<h:inputText id="attname3" value="#{annualMgrListChildBB.bo.daySpan}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return add();"
				rendered="#{annualMgrListChildBB.isExist==true}"
				action="#{annualMgrListChildBB.save}" styleClass="button01" />
			<h:commandButton value="保存" onclick="return add();"
				rendered="#{annualMgrListChildBB.isExist==false}"
				action="#{annualMgrListChildBB.saves}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


