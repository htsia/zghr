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
	font-family: "����";
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
	font-family: "����";
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
	font-family: "����";
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
	font-family: "����";
}

.table_rlbt {
	border: 1px solid #555555;
}
</style>
<x:saveState value="#{personaddworkBB}" />
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{personaddworkBB.initEdit1}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="�Ӱ�������"
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
					escape="false" value="�Ӱ���" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="3"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.personName}" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" value="�Ӱ�����" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;" colspan="2"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.typeStatusName}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" width="80" class="table_rlbt">
				ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
				 <h:panelGroup>
<h:outputText escape="false" value="#{personaddworkBB.bo1.beginTime}" />
				<h:outputText  escape="false" value=" ��  " />
<h:outputText escape="false" value="#{personaddworkBB.bo1.endTime}" />
</h:panelGroup>			
                <f:verbatim></td>
			</tr>

			<tr>
				<td  height="40" align="center" width="80" style="border:1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="����ʱ��" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="3"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.applyDate}" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" value="����" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;" colspan="2"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.lastDate}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="����" /> <f:verbatim></td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
				<h:outputText escape="false" style="text-align:center;width:100%" value="#{personaddworkBB.bo1.reason}" />	
              <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666"
					rowspan="3"></f:verbatim> <h:outputText escape="false"
					value="��<br>��<br>��<br>��<br>��<br>��" /> <f:verbatim></td>
									<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="����" /> <f:verbatim></td>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;"></f:verbatim>
<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.deptAuditOper}" />
 <f:verbatim></td>
 				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="���" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="3"
					style="border: 1px solid #555555;"></f:verbatim>
<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.deptAuditCausevalue}" />
 <f:verbatim></td>
			</tr>

						<tr>
				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="˵��" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="6"
					style="border: 1px solid #555555;"></f:verbatim>
				<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.deptAuditCause}" />
 <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">����ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
<h:outputText
					escape="false"
					value="#{personaddworkBB.bo1.deptAuditDate}" />
					 <f:verbatim></td>
			</tr>
			
						<tr>
				<td align="center" height="100" style="border: 1px solid #666666"
					rowspan="3"></f:verbatim> <h:outputText escape="false"
					value="��<br>��<br>��<br>��" /> <f:verbatim></td>
									<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="����" /> <f:verbatim></td>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;"></f:verbatim>
<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.hileaderAuditOper}" />
 <f:verbatim></td>
 				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="���" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="3"
					style="border: 1px solid #555555;"></f:verbatim>
<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.hileaderAuditResultvalue}" />
 <f:verbatim></td>
			</tr>
			
						<tr>
				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="˵��" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="6"
					style="border: 1px solid #555555;"></f:verbatim>
				<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.bo1.hileaderAuditCause}" />
 <f:verbatim></td>
			</tr>
			
						<tr>
				<td align="center" height="40" class="table_rlbt">����ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
<h:outputText
					escape="false"
					value="#{personaddworkBB.bo1.hileaderAuditDate}" />
					 <f:verbatim></td>
			</tr>
			
			<tr>
				<td align="center" height="100" style="border: 1px solid #666666"
					rowspan="3"></f:verbatim> <h:outputText escape="false"
					value="��<br>��<br>��<br>��<br>��<br>��" /> <f:verbatim></td>
									<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="����" /> <f:verbatim></td>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;"></f:verbatim>
<h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personaddworkBB.personName}" />
 <f:verbatim></td>
 				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="���" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="3"
					style="border: 1px solid #555555;"></f:verbatim>
			<h:selectOneMenu value="#{personaddworkBB.status}" onchange="submit();"
				valueChangeListener="#{personaddworkBB.changeStatus}">
				<c:selectItem itemLabel="ͬ��" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="��ͬ��" itemValue="2"></c:selectItem>
			</h:selectOneMenu>
 <f:verbatim></td>
			</tr>
			
						<tr>
				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="˵��" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="6"
					style="border: 1px solid #555555;"></f:verbatim>
			<h:inputTextarea value="#{personaddworkBB.bo1.leaderAuditCause}" rows="3"
				cols="80" />
 <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">����</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
			<h:commandButton styleClass="button01" value="ȷ��"
				action="#{personaddworkBB.personAddWorkAudit2}" />
					 <f:verbatim></td>
			</tr>

		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>



