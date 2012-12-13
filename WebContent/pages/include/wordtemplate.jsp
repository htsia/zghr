<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="taglib.jsp" %>

<html>
<c:view>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=GBK"/>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript" language="javascript" src="/js/check.js"></script>
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