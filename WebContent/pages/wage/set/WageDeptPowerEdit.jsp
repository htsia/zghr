<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{wage_deptpowerBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_deptpowerBB.pageInit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="帐套"/>
            <h:outputText value="#{wage_deptpowerBB.setName}"></h:outputText>

            <h:outputText value="姓名" />
            <h:outputText id="name" value="#{wage_deptpowerBB.personName}"/>

            <h:outputText value="有权限部门" />
            <h:selectOneMenu value="#{wage_deptpowerBB.wbo.deptID}">
                <c:selectItems value="#{wage_deptpowerBB.deptList}"></c:selectItems>
            </h:selectOneMenu>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_deptpowerBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
