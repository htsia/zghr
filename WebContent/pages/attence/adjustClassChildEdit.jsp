<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function addMonth() {
	PopUpCalendarDialog('form1:beginTime');
    if (document.all('form1:beginTime').value!=""){
        document.all('form1:addmonth').click();
    }
}
</script>
<x:saveState value="#{adjustClassChildBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{adjustClassChildBB.initset}" />
	<h:panelGrid align="center" width="90%">
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			<h:outputText value="换班日期" />
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="12"
					alt="起始日期|0|d" value="#{adjustClassChildBB.applydatevalues}"
					readonly="true" />
				<h:commandButton id="addmonth" style="display:none" value="刷新"
					action="#{adjustClassChildBB.getInitset1}" />
				<h:commandButton type="button" styleClass="button_select" onclick="addMonth();"/>
			</h:panelGroup>
			<h:outputText value="原所在班次" />
			<h:inputTextarea id="place"
				value="#{adjustClassChildBB.oldvalues}" cols="35" rows="5" readonly="true"></h:inputTextarea>
			<h:outputText value="现所在班次"></h:outputText>
			<h:panelGroup>
				<h:inputText id="groupname" readonly="true" size="30"
					value="#{adjustClassChildBB.className}" />
				<h:inputHidden id="groupid"
					value="#{adjustClassChildBB.newvalues}" />
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpMoni(document.all('form1:groupid'),document.all('form1:groupname'))" />
			</h:panelGroup>
		</h:panelGrid>

		<h:panelGrid columns="2" align="right" cellspacing="2">
			<h:commandButton styleClass="button01" value="保存"
				action="#{adjustClassChildBB.SaveSet}"/>
			<h:commandButton styleClass="button01" value="取消返回"
				onclick="window.close();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
