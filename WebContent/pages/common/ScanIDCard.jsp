<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String url = request.getRequestURL().toString();
    String server = CommonFuns.extractServer(url,"pages/common/ScanIDCard.jsp");
%>
<html>
<head><link href="/css/style.css" rel="stylesheet" type="text/css"/></head>
<body>
<form action="">
    <OBJECT id="idscan" style="Z-INDEX: 101; LEFT: -100px; POSITION: absolute; TOP: -100px"  width="10" height="10"
        classid="clsid:4823365D-73A2-4F78-B80A-D07C5C05253B">
    </OBJECT>
    <table height="98%" width="98%">
        <tr><td align="center" valign="middle">
             ีýิฺษจร่...
        </td></tr>
    </table>
</form>
</body>
<script type="text/javascript">
     document.all("idscan").SetServer('<%=server%>');
     window.returnValue=document.all("idscan").doScan();
     //window.returnValue=document.all("idscan").AboutBox();
     window.close();
</script>
</html>
