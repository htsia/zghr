<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head><title></title></head>

<body>
<c:view>
    <h:form id="form1">

        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="true"/>
            <jsp:param name="editName" value="Î¬»¤"/>
            <jsp:param name="editFuncName" value="forView"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="true"/>
        </jsp:include>
    </h:form>
</c:view>
</body>
</html>