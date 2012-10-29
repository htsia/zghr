<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>查看多头发放人员</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>
<body>
<x:saveState value="#{wage_manyHeadPutoutBB}"/>
<h:inputHidden value="#{wage_manyHeadPutoutBB.pageInit}"/>
<h:panelGrid width="98%" align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                cellspacing="0">
    <h:outputText value="   多头发放关系设置"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid columns="1" width="95%" align="center">
    <h:outputText value="发薪单位：#{wage_manyHeadPutoutBB.unitName}"/>
   <%
 //  <h:multlink value="2" paneLable="多头发放关系授权,查看多头发放人员"
           //        paneLink="ManyHeadPersonSetup.jsf,ViewManyHeadPerson.jsf"
             //      align="left" width="50%"/>
                   %>
</h:panelGrid>
<%--<f:verbatim><br></f:verbatim>--%>
<h:form>
<h:panelGrid width="95%" align="center">
    <h:panelGrid align="right" cellpadding="2" cellspacing="0" columns="1">
        <h:commandButton styleClass="button01" value="导出到Excel" action="#{wage_manyHeadPutoutBB.exportInToExcel}"/>
    </h:panelGrid>
    <h:dataTable styleClass="table03" headerClass="td_top"
                 columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 width="100%" align="center"
                 value="#{wage_manyHeadPutoutBB.manyHeadVos}" var="list">
        <h:column>
            <f:facet name="header"><h:outputText value="员工编号"/></f:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="姓名"/></f:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <f:facet name="header"><h:outputText value="授权单位"/></f:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
    </h:dataTable>
</h:panelGrid>
</h:form>
</body>
</html>