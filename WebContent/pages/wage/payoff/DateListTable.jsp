<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript">
    function doDetailPopup(id) {
            var dateId = id;
            popup = window.open("/wage/payoff/WageDetailView.jsf?dateId=" + dateId, "员工工资发放明细", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }
        function doNotePopup(id) {
            var dateId = id;
            popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }

</script>
</head>

<body>
<br><br>
    <h:panelGrid columns="1" align="center" width="90%" >
        <h:panelGrid columns="5" cellspacing="2">
            <h:commandButton value="返回" styleClass="button01"  type="button" onclick="history.go(-1)"/>
        </h:panelGrid>
    </h:panelGrid>
    <h:dataTable value="#{wage_dateBB.dateList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="业务日期"/></c:facet>
            <h:outputText value="#{list.date}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="描述"/></c:facet>
            <h:outputText value="#{list.desc}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.status}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="复核意见"/></c:facet>
            <h:outputText value="#{list.checkContent}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
            <h:outputText value="#{list.approveContent}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="查看明细" styleClass="button01" rendered="#{list.operView}"
                                 type="button" onclick="doDetailPopup('#{list.dateId}')"/>
                <h:commandButton value="查看变动信息" styleClass="button01" rendered="#{list.operView}"
                                 type="button" onclick="doNotePopup('#{list.dateId}')"/>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
</body>
</html>