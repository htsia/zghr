<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String message = (String) request.getAttribute("message");
%>
<script type="text/javascript">
    var show = "<%=message%>";
    if (show != null && show != "") {
        alert(show);
    }
    window.close();
</script>
