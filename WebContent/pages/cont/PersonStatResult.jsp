<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contSignBB}"/>
<html>
<head>
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript">

</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="应签未签人数统计结果 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
<h:panelGrid  border="0"  align="center" columns="2" width="90%">
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="1" >
         <h:commandButton styleClass="button01" value="返回合同补签" action="#{cont_contSignBB.forwardList}"/>
    </h:panelGrid>
</h:panelGrid>
<center>
<x:dataTable value="#{cont_contSignBB.vos_personStat}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="90%" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
            <%--
            <h:column>
                <c:facet name="header"><h:outputText value="机构id"/></c:facet>
                <h:outputText value="#{list.orgId}"/>
            </h:column>
            --%>
            <h:column>
                <c:facet name="header"><h:outputText value="机构名称"/></c:facet>
                <h:outputText value="#{list.orgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="中长期用工人数"/></c:facet>
                <h:outputText value="#{list.longCount}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="其中：已签人数"/></c:facet>
                <h:outputText value="#{list.longSignCount}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="已签占比"/></c:facet>
                <h:outputText value="#{list.longSignPercent}"/><h:outputText value="%"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="未签人数"/></c:facet>
                <h:outputText value="#{list.longNoSignCount}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="未签占比"/></c:facet>
                <h:outputText value="#{list.longNoSignPercent}"/><h:outputText value="%"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="短期用工人数"/></c:facet>
                <h:outputText value="#{list.shortCount}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="其中：已签人数"/></c:facet>
                <h:outputText value="#{list.shortSignCount}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="已签占比"/></c:facet>
                <h:outputText value="#{list.shortSignPercent}"/><h:outputText value="%"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="未签人数"/></c:facet>
                <h:outputText value="#{list.shortNoSignCount}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="未签占比"/></c:facet>
                <h:outputText value="#{list.shortNoSignPercent}"/><h:outputText value="%"/>
            </h:column>

</x:dataTable>

</center>
<br/>

</h:form>
</body>
</html>