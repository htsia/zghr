<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head>
      <title></title>
      <link href="/css/style.css" rel="stylesheet" type="text/css"/>
  </head>
  <body>
  <table>
      <%
          List errorDes = (List) session.getAttribute("errorDes");
          for(int i=0;i<errorDes.size();i++){
              out.println("<tr><td>"+(String)errorDes.get(i)+"</td></tr>");
          }
      %>
  </table>
  </body>
</html>