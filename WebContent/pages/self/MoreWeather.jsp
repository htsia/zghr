<%@ page import="java.util.Vector" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head>
      <title></title>
      <link href="/css/style.css" rel="stylesheet" type="text/css"/>
  </head>
  <body>
  <br/>
  <table class='table02' width="400">
  <%
      String city = "0105110000";
      User user = (User) session.getAttribute(Constants.USER_INFO);
      OrgBO org = SysCacheTool.findOrgById(user.getOrgId());
      if (org.getOrgAddress() != null && !"".equals(org.getOrgAddress())) {
          city = org.getOrgAddress();
      }

      Vector v = com.hr319wg.util.CommonService.getWeather(city);
      if (v != null && v.size() > 10) {
          int lengh = Integer.parseInt((String) v.get(0));
          out.println("<tr><td align='left' colspan='6'><strong>所在城市:" + (String) v.get(1) + "</strong></td></tr>");
          for (int i = 0; i < lengh; i++) {
              out.println("<tr>");
              out.println("<td rowspan='2' class='td10'>" + (String) v.get(i * 11 + 2) + "</td>");
              out.println("<td>白天</td>");
              out.println("<td><img src='/images/weather/" + (String) v.get(i * 11 + 3) + "'></td>");
              out.println("<td>" + (String) v.get(i * 11 + 4) + "</td>");
              out.println("<td>" + (String) v.get(i * 11 + 5) + "</td>");
              out.println("<td>" + (String) v.get(i * 11 + 6) + "</td>");
              out.println("<td>" + (String) v.get(i * 11 + 7) + "</td>");
              out.println("</tr>");

              out.println("<tr>");
              out.println("<td class='td10'>夜晚</td>");
              out.println("<td class='td10'><img src='/images/weather/" + (String) v.get(i * 11 + 8) + "'></td>");
              out.println("<td class='td10'>" + (String) v.get(i * 11 + 9) + "</td>");
              out.println("<td class='td10'>" + (String) v.get(i * 11 + 10) + "</td>");
              out.println("<td class='td10'>" + (String) v.get(i * 11 + 11) + "</td>");
              out.println("<td class='td10'>" + (String) v.get(i * 11 + 12) + "</td>");
              out.println("</tr>");
          }
      }
  %>
  </table>
  </body>
</html>