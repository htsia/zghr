<%@ page import="com.hr319wg.util.FileUtil" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head><title></title></head>
  <body>
  <%
      FileUtil.Html2Pdf("E:\\program\\newHR\\source\\HRD_App\\WebContent\\pages\\common\\hello.html","E:\\program\\newHR\\source\\HRD_App\\WebContent\\pages\\common\\xhtml2fo.xsl");
  %>
  </body>
</html>