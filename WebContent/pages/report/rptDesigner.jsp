<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/pages/cache/";
    %>

</head>
<body>
    <OBJECT id="openReport" style="Z-INDEX: 101; LEFT: 88px; POSITION: absolute; TOP: 32px"      codeBase="rptprint.cab"
        classid="clsid:CE222640-651C-462E-A863-634B986270F3" VIEWASTEXT>
    </OBJECT>
    <script language="javascript">
         openReport.OpenReport("","");
         window.close();
    </script>

</body>
</html>