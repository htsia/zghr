<%@ page import="com.hr319wg.title.ucc.impl.TitleContentSetUCC" %>
<%@ page import="com.hr319wg.title.ucc.impl.EmpTitleApplyUcc" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleScoreTempBO" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleTempDirBO" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleTempItemBO" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleApplayItemBO" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleApplyItemScoreBO" %>
<%@ page import="com.hr319wg.title.pojo.bo.EmpTitleApplyDirBO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>

<html>
  <head>
  <title>打分情况</title>
     <link href="/css/style.css" rel="stylesheet" type="text/css"/>
  </head>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<body>
   <%
       String templateId = request.getParameter("templateId");
       String itemId = request.getParameter("itemId");
   	   TitleContentSetUCC ucc=null;
   	   EmpTitleApplyUcc applyUcc=null;
   	   EmpTitleScoreTempBO templatebo=null;
   	   EmpTitleApplayItemBO applyItembo=null;
   	   String personName="";
       try {
           ucc = (TitleContentSetUCC) SysContext.getBean("titleContentSetUcc");
           applyUcc=(EmpTitleApplyUcc)SysContext.getBean("empTitleApplayUcc");
           templatebo = ucc.findEmpTitleScoreTempBO(templateId);
           applyItembo=applyUcc.findEmpTitleApplayItemBOById(itemId);
           personName=SysCacheTool.findPersonById(applyItembo.getPersonId()).getName();
       }
       catch (Exception e) {

       }
   %>
   <br>
   <table width=98% align="center" >
      <tr><td align="center"><span style="font-size:18px;font-weight:bold;align:center"><%=personName%>(<%=applyItembo.getScore() %>分)</span></td></tr>
       <tr><td height=8>

       </td></tr>

       <tr><td>
           <table class="table02"  align="center" width="60%">
               <%
                   List root = ucc.getAllEmpTitleTempDirBO(templateId);
               	   Hashtable dirHash=new Hashtable();
               	   Hashtable dirHash1=new Hashtable();
               	   Hashtable itemHash=new Hashtable();
               	   List dirList=applyUcc.getAllEmpTitleApplyDirBO(itemId);
               	   if(dirList!=null&&dirList.size()>0){
               		   for(int i=0;i<dirList.size();i++){
               			EmpTitleApplyDirBO dir=(EmpTitleApplyDirBO)dirList.get(i);
               			dirHash.put(dir.getTemDir(),CommonFuns.filterNull(dir.getScore()));
               			dirHash1.put(dir.getTemDir(),CommonFuns.filterNull(dir.getRefScore()));
               			List scoreList=applyUcc.getAllEmpTitleApplyItemScoreBO(dir.getDirId());
               			if(scoreList!=null&&scoreList.size()>0){
               				for(int j=0;j<scoreList.size();j++){
               					EmpTitleApplyItemScoreBO bo=(EmpTitleApplyItemScoreBO)scoreList.get(j);
               					itemHash.put(bo.getTempItemId(),CommonFuns.filterNull(bo.getScore()));
               				}
               			}
               		   }
               	   }
               	   out.println("<tr><td class='td_top'>项目名称</td><td class='td_top'>得分</td><td class='td_top'>参考分</td><td class='td_top'>子项目</td><td class='td_top'>得分</td></tr>");
                   for (int i = 0; i < root.size(); i++) {
                	   EmpTitleTempDirBO rootset = (EmpTitleTempDirBO) root.get(i);
                       List items = ucc.getAllEmpTitleTempItemBO(rootset.getDirId());
                       int count = items.size() > 0 ? items.size() : 1;
                       out.println("<tr>");
                       out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(count) + "'>");
                       out.println(rootset.getDirName());
                       out.println("</td>");
                       out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(count) + "'>");
                       out.println(dirHash.get(rootset.getDirId())+"分 ");
                       out.println("</td>");
                       out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(count) + "'>");
                       out.println(dirHash1.get(rootset.getDirId())+"分");
                       out.println("</td>");
                       if (items!=null && items.size()>0){
                    	   EmpTitleTempItemBO itembo = (EmpTitleTempItemBO) items.get(0);
                           out.println("<td class='td_middle_left'>");
                           out.println(itembo.getItemName());
                           out.println("</td>");
                           out.println("<td class='td_middle_left'>");
                           out.println(itemHash.get(itembo.getItemId()));
                           out.println("分</td>");
                           out.println("</tr>");
                           if(items.size()>1){
	                           for (int j = 1; j < items.size(); j++) {
	                        	   EmpTitleTempItemBO itembo1= (EmpTitleTempItemBO) items.get(j);
	                               out.println("<tr>");
	                               out.println("<td class='td_middle_left'>");
	                               out.println(itembo1.getItemName());
	                               out.println("</td>");
	                               out.println("<td class='td_middle_left'>");
	                               out.println(itemHash.get(itembo1.getItemId()));
	                               out.println("分</td>");
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