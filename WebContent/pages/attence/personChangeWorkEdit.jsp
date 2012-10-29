<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
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
function addMonth() {
	PopUpCalendarDialog('form1:beginTime');
    if (document.all('form1:beginTime').value!=""){
        document.all('form1:addmonth').click();
    }
}
</script>
<x:saveState value="#{personChangeWorkBB}" />
<h:form id="form1">
<h:inputHidden id="pageInit" value="#{personChangeWorkBB.initset}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="换班申请单"
			style="font-size:22px;text-align:center;width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<f:verbatim>
		<table align="center" border="0" width="610" id="table1"
			cellspacing="0" cellpadding="0" class="style1">
			<tr>
				<td height="40" align="center" width="80" style="border:1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="姓名" /> <f:verbatim></td>
				<td class="table_rlbt" colspan=6 height="40" align="center" width="80" style="border:1px solid #555555;">
								</f:verbatim> 
			<h:outputText escape="false" style="text-align:center;width:100%"
				value="#{personChangeWorkBB.personName}" />
					<f:verbatim>
				</td>
			</tr>


			<tr>
				<td align="center" height="40" class="table_rlbt">换班日期</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="12"
					alt="起始日期|0|d" value="#{personChangeWorkBB.bo.applyDate}"
					readonly="true" />
				<h:commandButton id="addmonth" style="display:none" value="刷新"
					action="#{personChangeWorkBB.getInitset1}" />
				<h:commandButton type="button" styleClass="button_select" onclick="addMonth();"/>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">原班次</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:inputText styleClass="input" style="border:0px;" id="totalday" 
				value="#{personChangeWorkBB.bo.oldClassName}" />
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">新班次</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText id="groupname" readonly="true" size="30"
					value="#{personChangeWorkBB.className}" />
				<h:inputHidden id="groupid"
					value="#{personChangeWorkBB.bo.newClass}" />
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpMoni(document.all('form1:groupid'),document.all('form1:groupname'))" />
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">操作</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:commandButton styleClass="button01" value="确认"
				action="#{personChangeWorkBB.SaveSet}"/>
			<h:commandButton styleClass="button01" value="取消返回"
				onclick="window.close();" />
				<f:verbatim>
				</td>
			</tr>
			
		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>
