<%@ page language="java" pageEncoding="UTF-8"%>  
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.attence.ucc.impl.AttAnnualUCC"%>
<%@ page import="com.hr319wg.attence.pojo.bo.AttAnnualItemBO" %>
<%@ page import="com.hr319wg.attence.pojo.vo.AttPersonAnnualQryVO" %>
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
				String recId =request.getParameter("recId");
				AttAnnualUCC attAnnualUcc = null;
				List gradeList = (ArrayList) session.getAttribute("gradeList1");
				try {
					attAnnualUcc = (AttAnnualUCC) SysContext.getBean("attAnnualUcc");
				} catch (Exception e) {
				}
				 List queryVoList=new ArrayList();
                List list = attAnnualUcc.getAllAttAnnualItemBO(null, recId,null);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					AttAnnualItemBO bo = (AttAnnualItemBO) list.get(i);
                    AttPersonAnnualQryVO vo=new AttPersonAnnualQryVO();
					vo.setPersonName(SysCacheTool.findPersonById(bo.getPersonID()).getName());
                    if(bo.getCriticalDate()!=null&&!bo.getCriticalDate().equals("")){
                       vo.setCanLeaveDay(bo.getCriticalAnnDay());
                       vo.setHaveLeaveDay(bo.getCalcAnnDay());
                       vo.setAvaLeaveDay(bo.getCriticalAvaDay());
                       vo.setCriticalDate(bo.getCriticalDate());
                    }else{
                       vo.setCanLeaveDay(bo.getAnnDay());
                       vo.setHaveLeaveDay(bo.getUseDay());
                       vo.setAvaLeaveDay(bo.getAvaDay());
                    }
                    vo.setEnterDate(bo.getEnterDate());
                    vo.setWorkDate(bo.getWorkDate());
                   queryVoList.add(vo);
				}
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
						out.println("年假（天）");
						out.println("</td>");
                        out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='left'>");
						out.println("剩余天数");
						out.println("</td>");
					    out.println("</tr>");
					    if(queryVoList!=null&&queryVoList.size()>0){
					    	for(int i=0;i<queryVoList.size();i++){
                                out.println("<tr>");
					    		AttPersonAnnualQryVO vo=(AttPersonAnnualQryVO)queryVoList.get(i);
			    				out.println("<td class='td_middle_left'>");
				    			out.println(i+1);
				    			out.println("</td>");
                                out.println("<td class='td_middle_left'>");
				    			out.println(vo.getPersonName());
				    			out.println("</td>");
                                out.println("<td class='td_middle_left'>");
				    			out.println(vo.getCanLeaveDay());
				    			out.println("</td>");
                                out.println("<td class='td_middle_left'>");
				    			out.println(vo.getAvaLeaveDay());
				    			out.println("</td>");
				    			out.println("</tr>");
					    	}
					    }
					}

			%>
		</table>
 </body>  
</html> 

