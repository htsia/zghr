<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.attDetailInit}"/>
<h:form id="form1">
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 考勤详情" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="#{attCalcMgrBB.personName }" />
			<h:outputText value="考勤详情如下:" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="cener">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
        <h:outputText value="迟到和旷工:"></h:outputText>
        <h:inputTextarea value="#{attCalcMgrBB.attDetail}" rows="4" cols="40"></h:inputTextarea>
		</h:panelGrid>
	</h:panelGrid>
	<c:verbatim>
	<table>
		   <tr><td>
	</c:verbatim>
    <h:dataTable value="#{attCalcMgrBB.leavesList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center80,td_middle_center80,td_middle_center,td_middle_center80,td_middle_center100,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column >
            <c:facet name="header"><h:outputText value="人员姓名"/></c:facet>
            <h:outputText value="#{list.personName }"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="请假类型"/></c:facet>
            <h:outputText value="#{list.leaveType }"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginTime }"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endTime }"/>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>


