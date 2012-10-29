<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function checkDate(){
    var endDate = document.all("form1:endTime").value;
    var startDate = document.all("form1:beginTime").value;
    if(startDate==null||startDate==""||endDate==null||endDate==""){
        alert("请输入开始时间和结束时间");
        return false;
    }else if(startDate>endDate){
        alert("开始时间晚于结束时间");
        return false;
    }
    return true;
 }
</script>
<x:saveState value="#{punch_carddaycollectBB}" />
<h:form id="form1">
<h:inputHidden id="pageInit" value="#{punch_carddaycollectBB.pageInit}" />
<h:inputHidden id="personList" value="#{punch_carddaycollectBB.personList}" />
	<f:verbatim>
		<input type="hidden" name="sessionFlag" value="2">
		<table id=t1 height=98% width="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td class="td_page" height=8></f:verbatim> <h:panelGrid width="95%"
					align="center" border="0" columns="1">
					<h:panelGroup>
						<h:outputText value="开始日期" />
						<h:inputText styleClass="input" id="beginTime" size="12"
							alt="开始时间|0|d" value="#{punch_carddaycollectBB.beginTime}"
							readonly="true" />
						<f:verbatim>
						<img onclick="WdatePicker({el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
						</f:verbatim>

						<h:outputText value="结束日期" />
						<h:inputText styleClass="input" id="endTime" alt="结束时间|0|d"
							size="12" value="#{punch_carddaycollectBB.endTime}"
							readonly="true" />
						<f:verbatim>
						<img onclick="WdatePicker({el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
						</f:verbatim>

						<h:commandButton id="set" styleClass="button01" value="查询"
							action="#{punch_carddaycollectBB.checkPersonCardMessage}"
							onclick="return checkDate();" />
					</h:panelGroup>
				</h:panelGrid> <f:verbatim></td>

				<td class="td_page" height=8></td>
			</tr>

			<tr>
				<td colspan=2><jsp:include
					page="../common/activepage/ActiveList.jsp">
					<jsp:param name="hasOperSign" value="true" />
					<jsp:param name="operSignType" value="checkbox" />
					<jsp:param name="hasEdit" value="true" />
					<jsp:param name="isEditList" value="false" />
					<jsp:param name="isCheckRight" value="true" />
					<jsp:param name="isForward" value="true" />
					<jsp:param name="isRow" value="false" />
					<jsp:param name="isPage" value="true" />
					<jsp:param name="fixcol" value="4" />
				</jsp:include></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<form id="form2"><input type="hidden" name="perids" /></form>
<script type="text/javascript">
	interpret(document.forms(0));
</script>