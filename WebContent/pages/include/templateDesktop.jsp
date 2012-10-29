<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="taglib.jsp" %>

<html>
<c:view>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=GBK"/>
    <title>
        <%
            response.setHeader("Pragma","No-cache");
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
            response.setContentType("text/html;charset=GBK");
        %>
    </title>
    <link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript" language="javascript" src="/js/check.js"></script>
    <script language="javascript" src="/pages/common/DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        //document.oncontextmenu=function(e){return false;}
    </script>
    
</head>
<body BGCOLOR=<%=Constants.BGCOLOR%>>
    <iframe name="checknewmsg"  src="/pages/system/shortmessage/checknew.jsp" width="0" height="0" ></iframe>
    <tiles:insert attribute="body" flush="true"/>
</body>
</c:view>
</html>