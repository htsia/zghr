<%@ page import="java.util.Vector" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonService"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.NewsParamBO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head>
      <title></title>
      <link href="/css/style.css" rel="stylesheet" type="text/css"/>
      <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
      <script language="javascript">
      function changeTab(pos){
          document.all('expressdiv').style.display="none";
          document.all('weatherdiv').style.display="none";
          document.all('housediv').style.display="none";
          document.all('frienddiv').style.display="none";
          document.all('traindiv').style.display="none";

          if (document.all('express')!=undefined && document.all('express')!=null){
              document.all('express').className = "tab";
          }

          if (document.all('weathertd')!=undefined && document.all('weathertd')!=null){
              document.all('weathertd').className = "tab";
          }
          if (document.all('house')!=undefined && document.all('house')!=null){
              document.all('house').className = "tab";
          }
          if (document.all('friend')!=undefined && document.all('friend')!=null){
              document.all('friend').className = "tab";
          }
          if (document.all('train')!=undefined && document.all('train')!=null){
            document.all('train').className = "tab";
          }

          if (pos==0){
              document.all('weathertd').className = "activeTab";
              document.all('weatherdiv').style.display="block";
          }
          else if (pos==1){
             document.all('house').className = "activeTab";
             document.all('housediv').style.display="block";
          }
          else if (pos==2){
              document.all('friend').className = "activeTab";
              document.all('frienddiv').style.display="block";
          }
          else if (pos==3){
             document.all('train').className = "activeTab";
             document.all('traindiv').style.display="block";
          }
          else if (pos==4){
             document.all('express').className = "activeTab";
             document.all('expressdiv').style.display="block";
          }
      }
      </script>
  </head>
  <body bgcolor="<%=Constants.BGCOLOR%>">
  <table  border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="<%=Constants.BGCOLOR%>">
    <tr>
      <td height="25" colspan="6" align="left"><img src="/images/maininterface/menu/report.gif"  align="absmiddle"> <strong>信息服务</strong></td>
    </tr>
    <tr><td>
      <table  width="96%" border="0" cellspacing="1" cellpadding="0" bgcolor="#CCCCCC">
               <tr >
                   <% if ("1".equals(Constants.SHOW_NEWS_TAB)){%>
                   <td align="center" id="express"  class="tab" ><a onclick="changeTab(4)"><%=Constants.SHOW_NEWS_TITLE%></a></td>
                   <%}%>

                   <% if ("1".equals(Constants.SHOW_WEATHER_TAB)){%>
                   <td align="center" id="weathertd"  class="activeTab" ><a onclick="changeTab(0)">天气</a></td>
                   <%}%>

                   <%
                       if ("1".equals(Constants.SHOW_HOUSE_TAB)){
                   %>
                             <td align="center" id="house"  class=tab><a onclick="changeTab(1)">租房</a></td>
                   <%
                       }
                       if ("1".equals(Constants.SHOW_FRIEND_TAB)){
                   %>
                   <td align="center" id="friend"  class=tab><a onclick="changeTab(2)">交友</a></td>
                   <%
                       }
                       if ("1".equals(Constants.SHOW_TRAIN_TAB)){
                   %>
                   <td align="center" id="train"  class=tab><a onclick="changeTab(3)">培训</a></td>
                   <%
                       }
                   %>
               </tr>
               <tr>
                   <td height="125" colspan="5" bgcolor="<%=Constants.FRAMECOLOR%>">
                       <div id="expressdiv" style="display:none">
                           <table>
                           <%
                               List list = (List) session.getAttribute("EXPRESS");
                               if (list != null && list.size() > 0) {
                                   for(int i=0;i<list.size() && i<4;i++){
                                        NewsParamBO newbo=(NewsParamBO)list.get(i);
                                        out.println("<tr><td><img src='/images/common/hot.gif'><A href=\"javascript:doShowNews('"+newbo.getNewId()+"')\">"+newbo.getNewTopic()+"</A></td></tr>");
                                   }
                               }
                           %>
                           </table>
                       </div>
                       <div id="weatherdiv">
                        <table width="100%">
                       <%
                           String city = "0105110000";
                           Vector v=null;
                           if ("1".equals(Constants.SHOW_WEATHER_TAB)){
                               User user = (User) session.getAttribute(Constants.USER_INFO);
                               OrgBO org = SysCacheTool.findOrgById(user.getOrgId());
                               if (org.getOrgAddress()!=null && !"".equals(org.getOrgAddress())){
                                   city=org.getOrgAddress();
                               }
                               v = com.hr319wg.util.CommonService.getWeather(city);
                               if (v != null && v.size() > 10) {
                                   int lengh = Integer.parseInt((String) v.get(0));
                                   for (int i = 0; i < 1; i++) {
                                       out.println("<tr>");
                                       out.println("<td valign='top' colspan='4' align='left'>"+(String) v.get(i * 11 + 1)+"("+(String) v.get(i * 11 + 2)+")</td>");
                                       out.println("<td valign='top' colspan='2' align='right'><a target='_blank' href='/pages/self/MoreWeather.jsp'>更多</a></td>");
                                       out.println("</tr>");

                                       out.println("<tr>");
                                       out.println("<td>白天</td>");
                                       out.println("<td><img src='/images/weather/" + (String) v.get(i * 11 + 3) + "'></td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 4) + "</td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 5) + "</td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 6) + "</td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 7) + "</td>");
                                       out.println("</tr>");

                                       out.println("<tr>");
                                       out.println("<td>夜晚</td>");
                                       out.println("<td><img src='/images/weather/" + (String) v.get(i * 11 + 8) + "'></td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 9) + "</td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 10) + "</td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 11) + "</td>");
                                       out.println("<td>" + (String) v.get(i * 11 + 12) + "</td>");
                                       out.println("</tr>");

                                   }
                               }
                               String limit = com.hr319wg.util.CommonService.getLimit(city);
                               if (limit!=null && !"".equals(limit)){
                                   out.println("<tr>");
                                   out.println("<td colspan='6'>温馨提示,今日限行尾号："+limit+"</td>");
                                   out.println("</tr>");
                               }
                           }
                       %>
                        </table>
                       </div>
                       <div id="housediv" style="display:none">
                          <table width="100%" valign="top">
                              <%
                                  if ("1".equals(Constants.SHOW_HOUSE_TAB)){
                                      v = com.hr319wg.util.CommonService.getHouseInfo(city);
                                      if (v != null && v.size() >= 3) {
                                          out.println("<tr>");
                                          out.println("<td valign='top' colspan='2' align='right'>信息来源:<a target='_blank' href='"+(String) v.get(1)+"'>"+(String) v.get(0)+"</a></td>");
                                          out.println("</tr>");
                                          out.println("<tr><td colspan='2' height='10'></td</tr>");
                                          int lengh = Integer.parseInt((String) v.get(2));
                                          for (int i = 0; i < 1; i++) {
                                              out.println("<tr>");
                                              out.println("<td><img src='/images/maininterface/hd_main_61.gif'></td>");
                                              out.println("<td><a target='_blank' href='"+(String) v.get(i*2+4)+"'>"+(String) v.get(i*2+3)+"</a></td>");
                                              out.println("</tr>");
                                          }
                                      }
                                  }
                              %>
                          </table>
                       </div>
                       <div id="frienddiv" style="display:none">
                           <table width="100%" valign="top">
                               <%
                                   if ("1".equals(Constants.SHOW_FRIEND_TAB)){
                                       v = com.hr319wg.util.CommonService.getFriendInfo(city);
                                       if (v != null && v.size() >= 3) {
                                           out.println("<tr>");
                                           out.println("<td valign='top' colspan='2' align='right'>信息来源:<a target='_blank' href='"+(String) v.get(1)+"'>"+(String) v.get(0)+"</a></td>");
                                           out.println("</tr>");

                                           out.println("<tr>");
                                           out.println("<td><img height='100' width='80' src='"+(String) v.get(2)+"'></td>");
                                           out.println("<td><a target='_blank' href='"+(String) v.get(4)+"'>"+(String) v.get(3)+"</a></td>");
                                           out.println("</tr>");
                                       }
                                   }
                               %>
                           </table>

                       </div>
                       <div id="traindiv" style="display:none">
                           <table width="100%" valign="top">
                               <%
                                if ("1".equals(Constants.SHOW_TRAIN_TAB)){
                                   v = com.hr319wg.util.CommonService.getTrainInfo(city);
                                   if (v != null && v.size() >= 3) {
                                       out.println("<tr>");
                                       out.println("<td valign='top' colspan='2' align='right'>信息来源:<a target='_blank' href='"+(String) v.get(1)+"'>"+(String) v.get(0)+"</a></td>");
                                       out.println("</tr>");
                                       out.println("<tr><td colspan='2' height='10'></td</tr>");
                                       int lengh = Integer.parseInt((String) v.get(2));
                                       for (int i = 0; i < 1; i++) {
                                           out.println("<tr>");
                                           out.println("<td><img src='/images/maininterface/hd_main_61.gif'></td>");
                                           out.println("<td><a target='_blank' href='"+(String) v.get(i*2+4)+"'>"+(String) v.get(i*2+3)+"</a></td>");
                                           out.println("</tr>");
                                       }
                                   }
                                }
                               %>
                           </table>

                       </div>
                   </td>
               </tr>
            </table>
    </td></tr>
   </table>
  </body>
</html>
<script language="javascript">
    if (document.all('weathertd')==undefined || document.all('weathertd')==null){
        if (document.all('express')!=undefined && document.all('express')!=null){
            document.all('express').className = "activeTab";
            document.all('weatherdiv').style.display="none";
            document.all('expressdiv').style.display="block";
        }
    }
</script>