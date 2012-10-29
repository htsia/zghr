<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.sendRedirect(request.getAttribute("downurl").toString());
%>