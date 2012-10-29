<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head><title></title>
    <script type="text/javascript">
    </script>
</head>

<body>
    <h:form id="form1">
        <h:inputHidden value="#{ins_ChangeQueryBB.personCountDetail}"/>
        <table id=t1 width="100%" height="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="right" height=30 valign="middle">
                    <h:commandButton value="¹Ø±Õ" onclick="window.close()" styleClass="button01" type="button"></h:commandButton>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    <jsp:include page="../common/activepage/ActiveList.jsp">
                        <jsp:param name="hasOperSign" value="true"/>
                        <jsp:param name="operSignType" value="checkbox"/>
                        <jsp:param name="hasEdit" value="true"/>
                        <jsp:param name="isEditList" value="false"/>
                        <jsp:param name="isCheckRight" value="false"/>
                        <jsp:param name="isForward" value="true"/>
                        <jsp:param name="isRow" value="false"/>
                        <jsp:param name="isPage" value="true"/>
                    </jsp:include>
                </td>
            </tr>
        </table>
    </h:form>
</body>
</html>