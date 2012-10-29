<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<style type="text/css">
.style1 {
	font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border: 2px solid #555555;
}

.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}

.style1 TR {
	FONT-SIZE: 9pt;
	COLOR: #555555;
}

.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
}

.style2 {
	font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
}

.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}

.style1 TR {
	FONT-SIZE: 9pt;
	COLOR: #555555;
}

.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
}

.table_rlbt {
	border: 1px solid #555555;
}

.table_rlbt1 {
	border: 0px;
	height: 0px;
	width:0px;
}
</style>
<c:verbatim>
	<link href="/css/editor.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/js/commonFuns.js"></script>
	<script language="javascript" src="/js/editor.js"></script>
	<script language="javascript" src="/js/editor_toolbar.js"></script>
    
</c:verbatim>
<script type="text/javascript">
function check_test() {
	var networktime = document.all('form1:networktime').value;
	var destination = document.all('form1:destination').value;
	if(networktime != null && networktime != "" && destination != null && destination != ""){
            return true;
	}else{
		alert("拟定休假时间或拟定休假地点是必填项。");
		return false;
	}
}

function test() {
	var timename = document.all('form1:networktime').value;
	//PopUpCalendarDlg_OnlyMonth('form1:timeObjectID');
	//WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM',el:'form1:timeObjectID'});
	if (timename != null && timename != "") {
		document.all('form1:networktime').value = timename + ","
				+ document.all('form1:timeObjectID').value;
	} else {
		document.all('form1:networktime').value = document
				.all('form1:timeObjectID').value;
	}
	return true;
}
function repeart(createdatevalue) {
		document.all('form1:networktime').value = '';
		document.all('form1:destination').value = '';
}
</script>
<x:saveState value="#{mrnetworkholidayBB}" />
<h:form id="form1">
	<h:inputHidden value="#{mrnetworkholidayBB.pageInit1}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="年假拟报单"
			style="font-size:22px;text-align:center;width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<f:verbatim>
		<table align="center" border="0" width="610" id="table1"
			cellspacing="0" cellpadding="0" class="style1">
			<tr>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="姓名" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="6" height="40" align="center"
					width="80" style="border: 1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{mrnetworkholidayBB.personName}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="年度" /> <f:verbatim></td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" style="text-align:left;width:100%"
					value="#{mrnetworkholidayBB.networkyearvalue}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="应享受年休假（天）" /> <f:verbatim></td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" style="text-align:left;width:100%"
					value="#{mrnetworkholidayBB.networkdayvalue}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">拟定休假时间</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> <h:panelGroup>
					<h:inputTextarea styleClass="input" id="networktime" cols="50"
						rows="3" value="#{mrnetworkholidayBB.networktimevalue}"
						readonly="true" />
							<h:inputText id="timeObjectID" styleClass="table_rlbt1" onclick="return test();"
		value="#{mrnetworkholidayBB.timeObject}"></h:inputText>
							<f:verbatim>
					<img onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM',el:'form1:timeObjectID',isShowClear:false})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
				</h:panelGroup> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">拟定休假地点</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> <h:inputText
					id="destination" styleClass="input" style="width:100%"
					value="#{mrnetworkholidayBB.networkdestvalue}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">操作</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> <h:commandButton
					styleClass="button01" value="确认"
					action="#{mrnetworkholidayBB.mrNetWorkHolidayMessage}"
					onclick="return check_test();" disabled="#{mrnetworkholidayBB.isExist2==false}"/> 
								<h:commandButton
				value="重置" onclick="repeart()" styleClass="button01" disabled="#{mrnetworkholidayBB.isExist2==false}"/>
				<h:outputText escape="false" value="年假管理未进行发放或初始化。" rendered="#{mrnetworkholidayBB.isExist2==false}"/>	
					<f:verbatim></td>
			</tr>

		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>


