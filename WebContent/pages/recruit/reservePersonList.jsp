<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<x:saveState value="#{interviewPersonaduitBB}" />
<h:form>
	<h:inputHidden value="#{interviewPersonaduitBB.initPage}"></h:inputHidden>
	<h:panelGrid align="center" width="98%" columns="1">
		 <h:panelGrid columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
		<h:outputText value="审批意见"/>
            <h:selectOneMenu id="status" value="#{interviewPersonaduitBB.odbo.finalResult}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>
        <h:outputText value="原因"/>
            <h:inputTextarea value="#{interviewPersonaduitBB.odbo.finalResultExplain}" rows="3" cols="80"/>
        <h:outputText value="审批"/>
        <h:commandButton value="审批" styleClass="button01" action="#{interviewPersonaduitBB.audit}"/>
        </h:panelGrid>
	</h:panelGrid>
</h:form>