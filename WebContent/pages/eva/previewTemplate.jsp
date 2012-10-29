<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaTemplateBO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.eva.pojo.bo.TemplateItemSetBO" %>
<%@ page import="com.hr319wg.eva.pojo.bo.TemplateItemBO" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaKeyItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
 <%
       String templateID = request.getParameter("templateID");
       EvaKeyItemUCC ucc=null;
       EvaTemplateBO templatebo=null;
       try {
           ucc = (EvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
           templatebo = ucc.findTemplateBO(templateID);
       }
       catch (Exception e) {

       }
   %>
<html>
  <head>
  <title>Ô¤ÀÀ´ò·ÖÄ£°å</title>
     <link href="/css/style.css" rel="stylesheet" type="text/css"/>
  </head>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<body>

   <br>
   <table width=98% align="center" >
      <tr><td align="right"></td></tr>
      <tr><td align="center"><span style="font-size:18px;font-weight:bold;align:center"><%=templatebo.getTemplateName()%></span></td></tr>
       <tr><td height=8>

       </td></tr>

       <tr><td>
           <table class="table02"  align="center" >
               <%
                   List root = ucc.getAllChildItemSet(templateID);
                   for (int i = 0; i < root.size(); i++) {
                       TemplateItemSetBO rootset = (TemplateItemSetBO) root.get(i);
                       List items = ucc.getAllChildItem(rootset.getSetID());
                       int count = items.size() > 0 ? items.size() : 1;
                       out.println("<tr>");
                       out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(count) + "'>");
                       out.println(rootset.getSetName());
                       out.println("</td>");
                       if (items!=null && items.size()>0){
                           TemplateItemBO itembo = (TemplateItemBO) items.get(0);
                           EvaKeyItemBO keybo = ucc.getEvaKeyItemBO(itembo.getLinkID());
                           String title="";
                           if(Constants.EVA_SHOW_POWER_PERCENT.equals("1")){
                           		title = keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + "%)";
                           }else{
                        	    title = keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + ")";
                           }
                           out.println("<td class='td_middle_left'>");
                           out.println(title);
                           out.println("</td>");

                           out.println("<td class='td_middle_left'>");
                           out.println("<input type='text'>");
                           out.println("</td>");
                           out.println("</tr>");
                           for (int j = 1; j < items.size(); j++) {
                               itembo = (TemplateItemBO) items.get(j);
                               keybo = ucc.getEvaKeyItemBO(itembo.getLinkID());
                               if(Constants.EVA_SHOW_POWER_PERCENT.equals("1")){
                               		title = keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + "%)";
                               }else{
                            	    title = keybo.getItemName() + "(" + CommonFuns.filterNull(itembo.getScore()) + ")";
                               }
                               out.println("<tr>");
                               out.println("<td class='td_middle_left'>");
                               out.println(title);
                               out.println("</td>");
                               out.println("<td class='td_middle_left'>");
                               out.println("<input type='text'>");
                               out.println("</td>");
                               out.println("</tr>");
                           }
                       }
                       else{
                         out.println("</tr>");
                       }
                   }
               %>
           </table>
       </td></tr>
   </table>
</body>
</html>