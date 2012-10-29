<%@ page language="java" pageEncoding="UTF-8"%>  
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.attence.ucc.impl.AttAnnualUCC"%>
<%@ page import="com.hr319wg.attence.pojo.bo.AttMimicReportRecBO" %>
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
<table border="1"  align="center" id="dateList" width="100%">
			<%
				String superId =request.getParameter("superId");
                String personValue=request.getParameter("personValue");
                String timeValue=request.getParameter("timeValue");
                String statusValue=request.getParameter("statusValue");
				AttAnnualUCC attAnnualUcc = null;
				try {
					attAnnualUcc = (AttAnnualUCC) SysContext.getBean("attAnnualUcc");
				} catch (Exception e) {
				}
                List personList=attAnnualUcc.getAllAttMimicReportRecBO(null,superId,personValue,timeValue,statusValue);

			%>
			<%	

						out.println("<tr>");
				    	out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left'>");
						out.println("序号");
						out.println("</td>");
						out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left' >");
						out.println("姓名");
						out.println("</td>");
                        out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left' >");
						out.println("拟定休假地点");
						out.println("</td>");
                        out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left'>");
						out.println("拟定休假时间");
						out.println("</td>");
                         out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left'>");
						out.println("应享受年假（天）");
						out.println("</td>");
					    out.println("</tr>");
					    if(personList!=null&&personList.size()>0){
					    	for(int i=0;i<personList.size();i++){
                                out.println("<tr>");
					    		AttMimicReportRecBO vo=(AttMimicReportRecBO)personList.get(i);
			    				out.println("<td class='td_middle_left'>");
				    			out.println(i+1);
				    			out.println("</td>");
                                out.println("<td class='td_middle_left'>");
				    			out.println(SysCacheTool.findPersonById(vo.getPersonID()).getName());
				    			out.println("</td>");
                                out.println("<td class='td_middle_left'>");
				    			out.println(vo.getDest());
				    			out.println("</td>");
                                out.println("<td class='td_middle_left'>");
				    			out.println(vo.getMrMonth());
				    			out.println("</td>");
                                out.println("<td class='td_middle_left'>");
				    			out.println(vo.getLastDate());
				    			out.println("</td>");
				    			out.println("</tr>");
					    	}
					    }

			%>
		</table>
 </body>  
</html> 

