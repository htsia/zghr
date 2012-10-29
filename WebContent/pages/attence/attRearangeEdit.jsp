<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{att_rearrangeBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{att_rearrangeBB.initEdit}" />
	<h:panelGrid align="center" width="90%">
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">


			<h:outputText value="时间序列" />
			<h:inputText value="#{att_rearrangeBB.rearrangeBO.daySeq}"  readonly="true"/>


			<h:outputText value="待选班次"></h:outputText>
			<h:panelGroup>
				<h:inputText id="groupname" readonly="true"
					value="#{att_rearrangeBB.className}" />
				<h:inputHidden id="groupid" value="#{att_rearrangeBB.rearrangeBO.linkClass}" />
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpMoni(document.all('form1:groupid'),document.all('form1:groupname'))" />
			</h:panelGroup>

		</h:panelGrid>

		<h:panelGrid columns="2" align="right" cellspacing="2">
			<h:commandButton styleClass="button01" value="保存" 
				action="#{att_rearrangeBB.save}"
				onclick="if(forsubmit(document.forms(0))){}else{return false;}" />
			<h:commandButton styleClass="button01" value="取消返回"
				onclick="window.close();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
