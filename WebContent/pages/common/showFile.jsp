<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head>
      <title></title>
      <link href="/css/style.css" rel="stylesheet" type="text/css"/>
  </head>
  <%
      String url=CommonFuns.filterNull((String)session.getAttribute("SHOWFILE_URL"));
      String title=CommonFuns.filterNull((String)session.getAttribute("SHOWFILE_TITLE"));
  %>
  <body>
      <br><br>
      <table width="98%" align="center">
            <tr><td align="left"><strong>╣Ц╩ВобйЖа╢╫с:</strong></td></tr>
            <tr><td align="right">
                <a href='<%=url%>'><%=title%></a>
            </td></tr>
      </table>
  </body>
</html>