<%@ page import="com.hr319wg.title.ucc.impl.TitleContentSetUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleScoreTempBO" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleTempDirBO" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleTempItemBO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>

<html>
  <head>
  <title>预览评审内容模板</title>
     <link href="/css/style.css" rel="stylesheet" type="text/css"/>
  </head>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<body>
   <%
   	   //System.out.println(request.getContextPath());
       String templateId = request.getParameter("templateId");
   	   TitleContentSetUCC ucc=null;
   	   EmpTitleScoreTempBO templatebo=null;
       try {
           ucc = (TitleContentSetUCC) SysContext.getBean("titleContentSetUcc");
           templatebo = ucc.findEmpTitleScoreTempBO(templateId);
       }
       catch (Exception e) {

       }
   %>
   <br>
   <table width=98% align="center" >
      <tr><td align="center"><span style="font-size:18px;font-weight:bold;align:center"><%=templatebo.getTemplateName()%>(<%=templatebo.getTotalScore() %>分)</span></td></tr>
       <tr><td height=8>

       </td></tr>

       <tr><td>
           <table class="table02"  align="center" >
               <%
                   List root = ucc.getAllEmpTitleTempDirBO(templateId);
                   for (int i = 0; i < root.size(); i++) {
                	   EmpTitleTempDirBO rootset = (EmpTitleTempDirBO) root.get(i);
                       List items = ucc.getAllEmpTitleTempItemBO(rootset.getDirId());
                       int count = items.size() > 0 ? items.size() : 1;
                       out.println("<tr>");
                       out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(count) + "'>");
                       out.println(rootset.getDirName()+"("+rootset.getTotalScore()+"分)");
                       out.println("</td>");
                       if (items!=null && items.size()>0){
                    	   EmpTitleTempItemBO itembo = (EmpTitleTempItemBO) items.get(0);
                           out.println("<td class='td_middle_left'>");
                           out.println(itembo.getItemName());
                           out.println("</td>");
                           out.println("<td class='td_middle_left'>");
                           if(itembo.getValueType().equals("1")){
	                           String ids[]=itembo.getFields().split(",");
	                           String show="";
	                           for(int j=0;j<ids.length;j++){
	                        	   if(show.equals("")){
	                        		   show+=SysCacheTool.findInfoItem(itembo.getSetId(),ids[j]).getItemName();
	                        	   }else{
	                        		   show+=","+SysCacheTool.findInfoItem(itembo.getSetId(),ids[j]).getItemName();
	                        	   }
	                        	   if((j+1)%5==0){
	                        		   show+="<br>";
	                        	   }
	                           }
	                           out.println(show);
                           }else{
                        	   out.println("<b>主观评断</b>");
                           }
                           out.println("</td>");
                           out.println("</tr>");
                           if(items.size()>1){
	                           for (int j = 1; j < items.size(); j++) {
	                        	   EmpTitleTempItemBO itembo1= (EmpTitleTempItemBO) items.get(j);
	                               out.println("<tr>");
	                               out.println("<td class='td_middle_left'>");
	                               out.println(itembo1.getItemName());
	                               out.println("</td>");
	                               out.println("<td class='td_middle_left'>");
	                               if(itembo1.getValueType().equals("1")){
		                               String ids1[]=itembo1.getFields().split(",");
		                               String show1="";
		                               for(int m=0;m<ids1.length;m++){
		                            	   if(show1.equals("")){
		                            		   show1+=SysCacheTool.findInfoItem(itembo1.getSetId(),ids1[m]).getItemName();
		                            	   }else{
		                            		   show1+=","+SysCacheTool.findInfoItem(itembo1.getSetId(),ids1[m]).getItemName();
		                            	   }
		                            	   if((m+1)%5==0){
		                            		   show1+="<br>";
		                            	   }
		                               }
		                               out.println(show1);
	                               }else{
	                            	   out.println("<b>主观评断</b>");
	                               }
	                               out.println("</td>");
	                               out.println("</tr>");
	                           }
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