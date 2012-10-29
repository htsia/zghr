<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="taglib.jsp" %>

<html>
<c:view>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=GBK"/>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript" language="javascript" src="/js/check.js"></script>
    <script language="javascript" src="/pages/common/DatePicker/WdatePicker.js"></script>
    <%
        response.setContentType("application/msword;charset=GBK");
        session.setAttribute("inWord","true");
    %>
</head>
<body>
    <tiles:insert attribute="body" flush="true"/>
</body>
</c:view>
</html>