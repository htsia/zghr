
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.vo.AttFileVO" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<html>
<head>
    <title>员工风采附件</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<table width="95%" align="center">
    <tr><td  align="right">
        <input type="button" value="关闭" class="button01" onclick="window.close()"/>
    </td></tr>
</table>
<table width="95%" align="center" class="table03">
    <%
        String name=(String)session.getAttribute("Name");
        if (name!=null){
           out.println("<tr>");
           out.println("<td class='td_form01' width='30%'>姓名</td>");
           out.println("<td class='td_form02' width='70%'>"+name+"</td>");
           out.println("</tr>");
        }
        List attList = (List) session.getAttribute("attList");
        if (attList != null) {
            for (int i = 0; i < attList.size(); i++) {
                AttFileVO vo=(AttFileVO)attList.get(i);
                out.println("<tr>");
                out.println("<td width='30%' class='td_form01'>附件"+(i+1)+"</td>");
                out.println("<td class='td_form02' width='70%'><a href='"+vo.getAttFile()+"'>"+vo.getAttTitle()+"</a></td>");
                out.println("</tr>");
            }
        }
    %>
</table>
</body>
</html>


