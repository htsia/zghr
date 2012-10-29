<%@ page import="com.hr319wg.client.portalClient" %>
<%@ page import="com.hr319wg.client.LoginInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head><title></title></head>
  <body>
      <%
          portalClient pc = new portalClient();
          pc.setServer("http://127.0.0.1:7001");
          LoginInfo li = pc.enterApplication("123");
          if (li.getResult()==1){ // ³É¹¦
              String userID=li.getUserID();
          }
          else{
              String des=li.getErrDes();
          }
      %>
  </body>
</html>