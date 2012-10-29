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

<script type="text/javascript">
function timeCheck(){
	//WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'});
	//WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != ""){
		 if(beginTime>endTime){
		        alert("��ʼ�������ڽ�������");
		        return false;
		 }
		 document.all('form1:refresh').click();
	}
	return true;
}

	function add() {
		var attname1 = document.all('form1:attname1').value;
		var attname3 = document.all('form1:attname3').value;
		if (attname3 <= 0) {
			alert("�ݼ�������������㣡");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{networkholidaychildaddBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		action="#{networkholidaychildaddBB.makesure}"></h:commandButton>
	<h:inputHidden id="initEdit"
		value="#{networkholidaychildaddBB.initEdit}"></h:inputHidden>
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="������뵥"
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
					escape="false" value="����" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="6" height="40" align="center"
					width="80" style="border: 1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personoutworkBB.personName}" /> <f:verbatim></td>
			</tr>


			<tr>
				<td align="center" height="40" class="table_rlbt">ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{networkholidaychildaddBB.begindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " />
						<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d" onclick="timeCheck();"
					size="30" value="#{networkholidaychildaddBB.enddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="�ݼ���������ֵ<=" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="6" height="40"
					  style="border: 1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" id="attname1"
					value="#{networkholidaychildaddBB.avaDay}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td height="40" align="center" width="80"
					style="border: 1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="����" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="6" height="40" align="center"
					width="80" style="border: 1px solid #555555;"></f:verbatim> <h:inputText
					id="attname3" styleClass="input" style="width:100%"
					value="#{networkholidaychildaddBB.daySpan}" readonly="true"/> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">����</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim>
				<h:commandButton styleClass="button01" value="����" action="#{networkholidaychildaddBB.save}" onclick="return add();" />
				<h:outputText value="  " />
				<h:outputText value="  " />
				<h:outputText value="  " />
				<h:commandButton styleClass="button01" value="ȷ�ϲ�����" action="#{networkholidaychildaddBB.saveAndAudit}" onclick="return add();" />
				<f:verbatim></td>
			</tr>

		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>


