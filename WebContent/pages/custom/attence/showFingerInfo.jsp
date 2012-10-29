<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{attMachineMgrBB}"/>
<h:inputHidden value="#{attMachineMgrBB.fingerInfoInit}"/>
<h:form id="form1">
	<f:verbatim>
		<table width=100% align="center">
		     <tr>
		         <td height="1" class="td_title"><img src="/images/tips.gif">考勤机信息</td>
		     </tr>
		</table>
	</f:verbatim>
	<h:panelGrid columns="2" width="90%" columnClasses="td_form01_center,td_middle" align="center" styleClass="table03">
		<h:outputText value="考勤记录总数" />
		<h:outputText value="#{attMachineMgrBB.countInfoMap.log}" />
		<h:outputText value="管理员总数" />
		<h:outputText value="#{attMachineMgrBB.countInfoMap.manager}" />
		<h:outputText value="考勤机人员总数" />
		<h:outputText value="#{attMachineMgrBB.countInfoMap.user}" />
		<h:outputText value="指纹总数" />
		<h:outputText value="#{attMachineMgrBB.countInfoMap.finger}" />
		<h:outputText value="密码总数" />
		<h:outputText value="#{attMachineMgrBB.countInfoMap.password}" />
	</h:panelGrid>
</h:form>
