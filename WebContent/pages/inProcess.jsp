<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="./include/taglib.jsp" %>
<html>
  <head><title></title></head>
  <body>
      <%
         String url=(String)session.getAttribute("URL");
         response.sendRedirect(url);
      %>
  </body>
</html>