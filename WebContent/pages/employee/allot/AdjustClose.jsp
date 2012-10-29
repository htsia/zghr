<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String message = (String) request.getAttribute("message");
%>
<script type="text/javascript">
    var show = "<%=message%>";
    var flag = "<%=(String) request.getAttribute("flag")%>";
    if (show != null && show != "") {
        alert(show);
    }
    if(flag != "1"){
        opener.document.all("form1:queryPerson").click();
     }
    window.close();
</script>
