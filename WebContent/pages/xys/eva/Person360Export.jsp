<%@ page language="java" pageEncoding="UTF-8"%>  
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.xys.eva.pojo.vo.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hr319wg.xys.eva.ucc.IXys360UCC"%>
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
<table border="1"  align="center" id="dateList" width="100%" style="font-size:10pt">
			<%
				String planId =request.getParameter("planId");
			IXys360UCC ucc = null;
				try {
					ucc = (IXys360UCC) SysContext.getBean("xys360UCC");
				} catch (Exception e) {
				}
				List list=null;
			%>
			<%	
				if(planId!=null&&!planId.equals("")){
					list=ucc.getXysPerson360ExportVOByPlanId(planId);
					if(list!=null&&list.size()>0){
						out.println("<tr>");
						out.println("<td>");
						out.println("二级部门名称");
						out.println("</td>");
						out.println("<td>");
						out.println("部门名称");
						out.println("</td>");
						out.println("<td>");
						out.println("姓名");
						out.println("</td>");
						out.println("<td>");
						out.println("员工编号");
						out.println("</td>");
						out.println("<td>");
						out.println("分数");
						out.println("</td>");
					    out.println("</tr>");
					    
					    if(list!=null&&list.size()>0){
					    	int size=list.size();
					    	for(int i=0;i<size;i++){
					    		boolean flag=true;
					    		StringBuffer sb=new StringBuffer();
					    		sb.append("<tr>");
					    		XysPerson360ExportVO vo=(XysPerson360ExportVO)list.get(i);
					    		sb.append("<td>");
					    		sb.append(vo.getErjiDept());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getDept());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getName());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getCode());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getScore());
					    		sb.append("</td>");
					    		sb.append("</tr>");
					    		out.println(sb.toString());
					    	}
					    }
					}
				}
			
			%>
		</table>
 </body>  
</html> 

