<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
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
</style>
<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
    
</c:verbatim>
<script type="text/javascript">
function timeCheck(){
	//WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'});
	//WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != ""){
		 if(beginTime>endTime){
		        alert("起始日期晚于结束日期");
		        return false;
		 }
		 document.all('form1:refresh').click();
	}
	return true;
}
</script>
<x:saveState value="#{personevectionBB}" />
<h:form id="form1">
    <h:commandButton id="refresh" value="刷新" style="display:none;" action="#{personevectionBB.makesures}"></h:commandButton>
    <h:inputHidden value="#{personevectionBB.pageInit3}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="倒休设置"
			style="font-size:22px;text-align:center;width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<f:verbatim>
		<table align="center" border="0" width="610" id="table1"
			cellspacing="0" cellpadding="0" class="style1">
			<tr>
				<td align="center" height="40" class="table_rlbt">所选人员列表</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:outputText styleClass="input" style="border:0px;"
				value="#{personevectionBB.personIdTimeOff}"/>
				<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">本次出差最大倒休天数</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:outputText styleClass="input" style="border:0px;" id="totalday1" 
				value="#{personevectionBB.personIdTimeOffDay}"/>
				<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">倒休时间</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="起始日期|0|d" value="#{personevectionBB.timeoffbegindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			</h:panelGroup>
			<h:outputText escape="false" value=" 至  " />
						<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="结束日期|0|d" onclick="timeCheck();"
					size="30" value="#{personevectionBB.timeoffenddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">合计(天)</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:inputText styleClass="input" style="border:0px;" id="totalday2" 
				value="#{personevectionBB.timeoffkqglLeaverDayValue}" readonly="true"/>
				<f:verbatim>
				</td>
			</tr>



			<tr>
				<td align="center" height="40" class="table_rlbt">操作</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
            <h:commandButton styleClass="button01" value="确认" action="#{personevectionBB.personEvectionMessageTimeOff}" disabled="#{personevectionBB.isExist3==false}"/>
				<f:verbatim>
				</td>
			</tr>
			
		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>


