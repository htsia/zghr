<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    String obj1 = CommonFuns.filterNull(request.getParameter("obj1"));
    String obj2 = CommonFuns.filterNull(request.getParameter("obj2"));
    String  partyId =   CommonFuns.filterNull(request.getParameter("superId"));
%>

<html>
<head>
    <base target="_self">
    <title>ѡ����Ա</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forsave(form1) {
            return pageCodeExchange(form1);
        }

        function sel(code, value ,partyId) {
           parent.window.returnValue =code+","+value+","+partyId;
           parent.close();
        }
    </script>
</head>

<body>
<h:form id="form1">
    <h:inputHidden value="#{ccp_PartySelPersonBB.pageInit}"/>
    <h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" styleClass="td_title">
        <h:outputText value="ѡ����Ա"/>
    </h:panelGrid>
    <h:dataTable width="100%" value="#{ccp_PartySelPersonBB.personList}" var="list" border="1" align="center"
                 headerClass="td_top" rowClasses="td_middle" styleClass="table03">
        <h:column>
            <c:verbatim><a style="cursor:hand" 
                    onclick="sel('</c:verbatim><h:outputText value="#{list.personId}"/><c:verbatim>',
                                 '</c:verbatim><h:outputText value="#{list.name}"/>    <c:verbatim>',
                                 ' <%=partyId %>')">ѡ��</a></c:verbatim>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
            <h:outputText value="#{list.sex}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.birth}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������֯"/></c:facet>
            <h:outputText value="#{list.partyId}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.orgId}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.deptId}"/>
        </h:column>
    </h:dataTable>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr></table>
</marquee>
</body>

<script type="text/javascript">
    interpret(form1);
      function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
</script>

</html>