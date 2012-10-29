<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
  <head><title></title></head>
  <body>
  <%
       String path=request.getParameter("url");
       if (path==null){
           path="/file/chart/none.jpg";
       }
       out.println("<img src='"+path+"'>");
  %>
  </body>
</html>