<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<html>
  <head>
  <title> <%=Constants.SYSTEM_NAME%>
  </title>
      <script type="text/javascript">
          with (window) onload = onresize = function(){
              var mainHeight = document.body.offsetHeight - 50;
              document.getElementById("main").style.height = "" + mainHeight + "px";
          }
      </script>

  </head>
  <body>
  <%
     String pid=request.getParameter("PersonID");
  %>
  <iframe name="main" height="100%"  width="98%" frameborder="0" src="<%=Constants.LEAD_SHOW_PERSONURL%>?flag=2&fk=<%=pid%>&typeId=2001010000,2001010100&setId=A001&ShowReport=false">
  </iframe>
  </body>
</html>