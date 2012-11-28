<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="taglib.jsp" %>
<html>
<c:view>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8;"/>
    <meta http-equiv="Content-Type" content="text/html;charset=GBK"/>
    <title>
        <%
            response.setHeader("Pragma","No-cache");
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
            response.setContentType("text/html;charset=GBK");
        %>
    </title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript" language="javascript" src="/js/check.js"></script>
</head>
<body BGCOLOR=<%=Constants.BGCOLOR%>>
    <tiles:insert attribute="body" flush="true"/>
    <script language="javascript" src="/pages/common/DatePicker/WdatePicker.js"></script>
</body>
</c:view>
</html>