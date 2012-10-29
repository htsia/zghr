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
    <script type="text/javascript">
        function doPopup(personId) {
            if (personId != null && personId != "") {
                var arg = "personId=" + personId;
                arg += "&setId=" + form1.all("form1:setId").value;
                arg += "&dateId=" + form1.all("form1:dateId").value;
                popup = window.open("/wage/payoff/WageDetailView.jsf?" + arg, "", "height=200,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
                popup.focus();
            }
        }
    </script>
</head>

<body>
<x:saveState value="#{wage_flowBB}"/>
<h:inputHidden value="#{wage_flowBB.viewChangeNote}"/>
<h:form id="form1">
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>

    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%">
        <h:panelGrid width="100%" align="center" >
            <h:outputText styleClass="td_title" value="Ա�����ʱ䶯���ܱ�"/>
        </h:panelGrid>
        <h:panelGrid width="100%" align="center" >
            <%--<h:outputLink target="_blank" style="color:blue" value="#{wage_flowBB.downLoadFile}">--%>
                <%--<h:outputText value="����Excel�ļ�"/>--%>
            <%--</h:outputLink>--%>
            <h:commandButton styleClass="button01" value="������Excel" action="#{wage_flowBB.downLoadChangNoteFile}"/>
        </h:panelGrid>
        <h:dataTable value="#{wage_flowBB.list}" var="list" styleClass="table03"
                     headerClass="td_top" columnClasses="td_middle,td_middle,td_middle,td_middle,td_middle,td_middle"
                     width="100%">
            <h:column>
                <c:facet name="header">
                    <h:outputText value="����"/>
                </c:facet>
                <h:outputText value="#{list.personDept}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                    <h:outputText value=" Ա�����"/>
                </c:facet>
                <h:outputText value="#{list.personId}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                    <h:outputText value="����"/>
                </c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                    <h:outputText value="�䶯����"/>
                </c:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                    <h:outputText value="�䶯����"/>
                </c:facet>
                <h:outputText value="#{list.cause}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                    <h:outputText value="�䶯����"/>
                </c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                    <h:outputText value="�鿴����"/>
                </c:facet>
                <h:commandLink value="�鿴" onclick="doPopup('#{list.personId}');return false;"/>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>