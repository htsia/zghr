<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="./include/taglib.jsp" %>
<html>
  <head><title></title></head>
  <body>
  <script type="text/javascript">
       parent.location.href="<%=(String)session.getAttribute("URL")%>";
  </script>
  </body>
</html>