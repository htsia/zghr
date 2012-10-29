<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<c:verbatim>
	<link href="/css/editor.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/js/commonFuns.js"></script>
	<script language="javascript" src="/js/editor.js"></script>
	<script language="javascript" src="/js/editor_toolbar.js"></script>
    
</c:verbatim>
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
<script type="text/javascript">
function check_test() {
	forCheck();
	var desc = document.all('form1:desc').value;
	if(desc != null && desc != ""){
        return true;
	}else{
		alert("请输入请假事由");
		return false;
	}
}

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

function timeCheck1(){
	var beginTime = document.all('form1:beginTime2').value;
	var endTime = document.all('form1:endTime2').value;
	if(beginTime != null && beginTime != ""){
		if(endTime != null && endTime != ""){
			 if(beginTime>endTime){
			        alert("起始日期晚于结束日期");
			        return false;
			 }
			 document.all('form1:refresh1').click();
		}
	}else{
        alert("请设置年假拟扣时间。");
        return false;
	}
	return true;
}

function forCheck() {
    PutTextareaValue(document.all('form1:desc'),fGetContent());
    //if(forsubmit(document.forms(0))){
         return true;
    //}
    //else{
        //return false;
    //}
}
</script>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="刷新" style="display:none;"
		action="#{personleaveBB.makesure}"></h:commandButton>
	<h:commandButton id="refresh1" value="刷新" style="display:none;"
		action="#{personleaveBB.makesure2}"></h:commandButton>
	<h:inputHidden value="#{personleaveBB.pageInit2}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="续/销假单"
			style="font-size:22px;text-align:center;width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<f:verbatim>
		<table align="center" border="0" width="610" id="table1"
			cellspacing="0" cellpadding="0" class="style1">
			<tr>
				<td  height="40" align="center" width="80" style="border:1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="姓名" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="3"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personleaveBB.personName}" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" value="假期类型" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;" colspan="2"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personleaveBB.flleavevalue}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" width="80" class="table_rlbt">
				原始时间</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:outputText value="#{personleaveBB.begindatevalueWdate3}"/>
			</h:panelGroup>
			<h:outputText escape="false" value=" 至  " />
						<h:panelGroup>
				<h:outputText value="#{personleaveBB.enddatevalueWdate3}"/>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" width="80" class="table_rlbt">续/销假<br>
				</f:verbatim>
				<h:outputText value="续增时间" rendered="#{personleaveBB.flag!='3'}"/>
				<h:outputText value="销减时间" rendered="#{personleaveBB.flag=='3'}"/>
				<f:verbatim>
				</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="起始日期|0|d" value="#{personleaveBB.begindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <h:panelGroup rendered="#{personleaveBB.flag=='3'}">
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			        </h:panelGroup>
			</h:panelGroup>
			<h:outputText escape="false" value=" 至  " />
						<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="结束日期|0|d" onclick="timeCheck();"
					size="30" value="#{personleaveBB.enddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">合计(天)</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> <h:inputText
					styleClass="input" style="border:0px;"
					value="#{personleaveBB.kqglLeaverDayValue}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666">
				</f:verbatim> <h:outputText escape="false" value="事由" /> <f:verbatim></td>
				<td class="table_rlbt" align="left" valign="top" colspan="6"
					style="padding-left: 6px;"></f:verbatim> <h:inputTextarea id="desc"
					value="#{personleaveBB.reason}" cols="75" rows="3"
					style="display:none;" /> <f:verbatim>
					<script language="javascript">
                    gFrame = 1;//1-在框架中使用编辑器
                    gContentId = "form1:desc";//要载入内容的content ID
                    OutputEditorLoading();
                </script>
					<iframe id="HtmlEditor" class="editor_frame" frameborder="0"
						marginheight="0" marginwidth="0"
						style="width: 100%; height: 100px; overflow: visible;"></iframe></td>
			</tr>

</f:verbatim>
<h:panelGroup rendered="#{personleaveBB.isExist5}">
<f:verbatim>
			<tr>
				<td align="center" height="40" class="table_rlbt">年假抵扣信息操作</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim> 
			<h:selectOneRadio value="#{personleaveBB.typeStatus}"
				onclick="submit();">
				<f:selectItem itemValue="1" itemLabel="删除" />
				<f:selectItem itemValue="2" itemLabel="修改" />
			</h:selectOneRadio>
					<f:verbatim></td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">年假补扣时间</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime2" size="30"
					alt="起始日期|0|d" value="#{personleaveBB.begindatevalueWdate2}" onclick="timeCheck1();"
				    readonly="true"/>
				    <h:panelGroup rendered="#{personleaveBB.typeStatus=='2'}">
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime2'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			        </h:panelGroup>
			</h:panelGroup>
			<h:outputText escape="false" value=" 至  " />
			<h:panelGroup>
				<h:inputText styleClass="input" id="endTime2" alt="结束日期|0|d" onclick="timeCheck1();"
					size="30" value="#{personleaveBB.enddatevalueWdate2}" readonly="true"/>
					<h:panelGroup rendered="#{personleaveBB.typeStatus=='2'}">
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime2'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
					</h:panelGroup>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">补扣合计(天)</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:inputText id="totaldayvalue2" styleClass="input" style="border:0px;"
				value="#{personleaveBB.daySpan1}" readonly="true"/>
				<f:verbatim>
				</td>
			</tr>
</f:verbatim>
</h:panelGroup>
<f:verbatim>

			<tr>
				<td align="center" height="40" class="table_rlbt">操作</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> 
				<h:commandButton
					styleClass="button01" value="保存"
					action="#{personleaveBB.PersonLeaveMessages}"
					onclick="return check_test();" /> 
				<h:outputText value="  " />
			    <h:outputText value="  " />
			    <h:outputText value="  " />
			    <h:commandButton
					styleClass="button01" value="确认并报批"
					action="#{personleaveBB.PersonLeaveMessagesAndPersonLeaveMessageAudit}"
					onclick="return check_test();" /> 
					<f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666"
					rowspan="3"></f:verbatim> <h:outputText escape="false"
					value="历<br>史<br>记<br>录" />
					 <f:verbatim></td>
				<td class="table_rlbt" colspan="6" valign="top" cellpadding="0">
				</f:verbatim> 
<x:dataTable value="#{personleaveBB.persBos3}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					<h:outputText value="序号" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="类型" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="性质" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.superFlIdName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="处理类别" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flIdProcessName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="是否提交相关证明材料" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flIdStatusName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="申请时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.applyDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="开始时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.beginTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="结束时间" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.endTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="事由" styleClass="td03" />
				</f:facet>
				<h:outputText escape="false" value="#{list.reason}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="天数(合计)" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.lastDate}" />
			</h:column>
						<h:column>
				<f:facet name="header">
					<h:outputText value="操作" styleClass="td03" />
				</f:facet>
				<h:commandButton value="查看流程" styleClass="button01"
					onclick="showWorkFlowLogByLinkID('#{list.furloughNO}');"></h:commandButton>
			</h:column>
				</x:dataTable>
					<f:verbatim></td>
			</tr>

		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>


