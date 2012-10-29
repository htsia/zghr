 <%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaTemplateBO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.eva.pojo.bo.TemplateItemSetBO" %>
<%@ page import="com.hr319wg.eva.pojo.bo.TemplateItemBO" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaKeyItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <%
    out.clearBuffer();
    response.setHeader("Content-Type","application/vnd.ms-excel;charset=GBK");
  	response.setHeader("Content-Disposition","attachment;filename=result.xls");
%>
     <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
  </head>

<body>
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
   <br>
   <table width=98% align="center" border="1">
      <tr><td align="right"><input type="button" class="button01" value="导出Excel" onclick="exportCvs()"></td></tr>
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
                       out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(count) + "' width='30%'>");
                       out.println(rootset.getSetName());
                       out.println("</td>");
                       if (items!=null && items.size()>0){
                           TemplateItemBO itembo = (TemplateItemBO) items.get(0);
                           EvaKeyItemBO keybo = ucc.getEvaKeyItemBO(itembo.getLinkID());
                           String title="";
                           out.println("<td class='td_middle_left'width='50%'>");
                           out.println(keybo.getItemName());
                           out.println("</td>");

                           out.println("<td class='td_middle_left'>");
                           if(Constants.EVA_SHOW_POWER_PERCENT.equals("1")){
                           		title =  CommonFuns.filterNull(itembo.getScore()) + "%";
                           }else{
                        	    title = CommonFuns.filterNull(itembo.getScore());
                           }
                           out.println(title);
                           out.println("</td>");
                           out.println("</tr>");
                           for (int j = 1; j < items.size(); j++) {
                               itembo = (TemplateItemBO) items.get(j);
                               keybo = ucc.getEvaKeyItemBO(itembo.getLinkID());
                               if(Constants.EVA_SHOW_POWER_PERCENT.equals("1")){
                               		title =  CommonFuns.filterNull(itembo.getScore()) + "%";
                               }else{
                            	    title =  CommonFuns.filterNull(itembo.getScore());
                               }
                               out.println("<tr>");
                               out.println("<td class='td_middle_left'>");
                               out.println(keybo.getItemName());
                               out.println("</td>");
                               out.println("<td class='td_middle_left'>");
                               out.println(title);
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