<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<head>
    <title></title>
     <link href="/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%
    String ColName = "";
    if ("TOMCAT".equals(CommonFuns.getAppType())){
        ColName=CommonFuns.getParaFromURL(request.getQueryString(),"ColName");
    }
    else{
        ColName=request.getParameter("ColName");
    }
    String Col = request.getParameter("Col");
%>
<table width="96%" align="center">
   <tr>
     <td>
         <strong>项目属性:</strong><br>
         <iframe height="80" src='/common/activepage/ShowItemProperty.jsf?ColName=<%=ColName%>&Col=<%=Col%>'></iframe>
     </td>
     </tr>

     <tr> 
     <td>
         <strong>统计信息:</strong><br>
         <iframe height="250" src='/common/activepage/ShowStatic.jsf?ColName=<%=ColName%>&Col=<%=Col%>'></iframe>
     </td>
   </tr>
</table>
</body>
</html>