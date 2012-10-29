<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <base target="_self">
    <title>选择人员</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forsave(form1) {
//            document.getElementById("form1:flag").value = "2";
            return pageCodeExchange(form1);
        }

        function sel(code, value) {
            window.returnValue = code + "," + value;
            window.close();
        }
    </script>
</head>

<body>
<h:form id="form1">
    <%--<h:inputHidden id="flag" value="#{ccp_PartySelPersonBB.flag}"/>--%>
    <h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" styleClass="td_title">
        <h:outputText value="选择人员"/>
    </h:panelGrid>
    <h:panelGrid width="100%" columns="1" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
        <h:panelGroup>
            <h:outputText value="姓名："/>
            <h:inputText id="name" value="#{ccp_PartySelPersonBB.name}" size="20"/>
            <h:outputText value=" "/>
            <h:outputText value="所属党组织："/>
            <h:inputText id="party" value="#{ccp_PartySelPersonBB.party}" size="20" code="" dict="yes" dict_num="PA"/>
            <h:commandButton type="button" styleClass="button_select" value=".."
                             onclick="fPopUpPartyDlg('form1:party',1)"/>
            <h:outputText value=" "/>
            <h:commandButton value="查询" onclick="javascript:return forsave(form1)" styleClass="button01"
                             action="#{ccp_PartySelPersonBB.queryPerson}"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:dataTable width="100%" value="#{ccp_PartySelPersonBB.personList}" var="list" border="1" align="center"
                 headerClass="td_top" rowClasses="td_middle" styleClass="table03">
        <h:column>
            <c:verbatim><a class="cursor:hand" onclick="sel('</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim>','</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim>')">选择</a></c:verbatim>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="性别"/></c:facet>
            <h:outputText value="#{list.sex}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="出生日期"/></c:facet>
            <h:outputText value="#{list.birth}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属党组织"/></c:facet>
            <h:outputText value="#{list.partyId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属机构"/></c:facet>
            <h:outputText value="#{list.orgId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
            <h:outputText value="#{list.deptId}"/>
        </h:column>
    </h:dataTable>
</h:form>
</body>
<script type="text/javascript">
    interpret(form1);
</script>
</html>