<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%  
    response.setContentType("application/vnd.ms-excel;charset=GBK");
    response.setHeader("Content-Disposition", "filename=" + new String(com.hr319wg.util.CommonFuns.filterNull("导出.xls").getBytes("GBK"),"ISO8859_1"));
    String content = CommonFuns.filterNull(request.getParameter("content"));
    content=CommonFuns.ISO2GBK(content);
%>
<html>
  <head>
      <title></title>
      <meta http-equiv="Content-Type" content="text/html;charset=GBK"/>
  </head>
  <body>
      <center>
          <%=content%>
      </center>
  </body>
</html>