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
</style>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
<h:inputHidden id="pageInit" value="#{personleaveBB.initEdit1}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="审批假单"
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
					escape="false" value="#{personleaveBB.bo1.superFlIdName}人" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="3"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personleaveBB.bo1.personName}" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" value="假期类型" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;" colspan="2"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personleaveBB.bo1.flName}" /> <f:verbatim></td>
			</tr>


			<tr>
				<td align="center" height="40" width="80" class="table_rlbt">
				时间</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
				 <h:panelGroup>
<h:outputText escape="false" value="#{personleaveBB.bo1.beginTime}" />
				<h:outputText  escape="false" value=" 至  " />
<h:outputText escape="false" value="#{personleaveBB.bo1.endTime}" />
</h:panelGroup>			
                <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="#{personleaveBB.bo1.superFlIdName}天数" /> <f:verbatim></td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
				<h:outputText escape="false" value="#{personleaveBB.bo1.lastDate}" />	
              <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="#{personleaveBB.bo1.superFlIdName}事由" /> <f:verbatim></td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
				<h:outputText escape="false" value="#{personleaveBB.bo1.reason}" />	
              <f:verbatim></td>
			</tr>
			
</f:verbatim>
<h:panelGroup rendered="#{personleaveBB.isExist6==true}">
<f:verbatim>
			<tr>
				<td align="center" height="100" style="border: 1px solid #666666"
					rowspan="2"></f:verbatim> <h:outputText escape="false"
					value="年<br>假<br>抵<br>扣<br>信<br>息" /> <f:verbatim></td>
 				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="时间" /> <f:verbatim></td>
				<td height="40" align="left" colspan="5"
					style="border: 1px solid #555555;"></f:verbatim>
<h:outputText escape="false" value="#{personleaveBB.holidayBegin}" />
				<h:outputText  escape="false" value=" 至  " />
<h:outputText escape="false" value="#{personleaveBB.holidayEnd}" />
 <f:verbatim></td>
			</tr>

						<tr>
				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="天数" /> <f:verbatim></td>
				<td height="40" align="left" colspan="6"
					style="border: 1px solid #555555;"></f:verbatim>
				<h:outputText
					escape="false"
					value="#{personleaveBB.holidayDaySpan}" />
 <f:verbatim></td>
			</tr>
			
</f:verbatim>
</h:panelGroup>
<f:verbatim>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666"
					rowspan="3"></f:verbatim> <h:outputText escape="false"
					value="部<br>门<br>经<br>理<br>审<br>批" /> <f:verbatim></td>
									<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="姓名" /> <f:verbatim></td>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;"></f:verbatim>
<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personleaveBB.personName}" />
 <f:verbatim></td>
 				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="意见" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="3"
					style="border: 1px solid #555555;"></f:verbatim>
			<h:selectOneMenu value="#{personleaveBB.status}" onchange="submit();"
				valueChangeListener="#{personleaveBB.changeStatus}">
				<c:selectItem itemLabel="同意" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="不同意" itemValue="2"></c:selectItem>
			</h:selectOneMenu>
 <f:verbatim></td>
			</tr>
			
						<tr>
				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="说明" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="6"
					style="border: 1px solid #555555;"></f:verbatim>
			<h:inputTextarea value="#{personleaveBB.bo1.deptAuditCause}" rows="3"
				cols="80" />
 <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">操作</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
			<h:commandButton styleClass="button01" value="确认"
				action="#{personleaveBB.PersonLeaveAudit1}" />
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

