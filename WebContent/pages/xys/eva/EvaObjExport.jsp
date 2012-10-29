<%@ page language="java" pageEncoding="gbk"%>  
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.xys.eva.pojo.vo.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hr319wg.xys.eva.ucc.IXysEvaObjUCC"%>
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
<table>
			<%
				String planId =request.getParameter("planId");
			IXysEvaObjUCC ucc = null;
				try {
					ucc = (IXysEvaObjUCC) SysContext.getBean("xysEvaObjUcc");
				} catch (Exception e) {
				}
				List list=null;
			%>
			<%	
				if(planId!=null&&!planId.equals("")){
					list=ucc.getXysObjExportVOByPlanId(planId);
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
						out.println("KPI");
						out.println("</td>");
						out.println("<td>");
						out.println("能力态度");
						out.println("</td>");
						out.println("<td>");
						out.println("学生评价");
						out.println("</td>");
						out.println("<td>");
						out.println("总分");
						out.println("</td>");
						out.println("<td>");
						out.println("自然排名");
						out.println("</td>");
						out.println("<td>");
						out.println("自然等级");
						out.println("</td>");
						out.println("<td>");
						out.println("强制排名");
						out.println("</td>");
						out.println("<td>");
						out.println("强制等级");
						out.println("</td>");
					    out.println("</tr>");
					    
					    if(list!=null&&list.size()>0){
					    	int size=list.size();
					    	for(int i=0;i<size;i++){
					    		boolean flag=true;
					    		StringBuffer sb=new StringBuffer();
					    		sb.append("<tr>");
					    		XysObjExportVO vo=(XysObjExportVO)list.get(i);
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
					    		sb.append(vo.getScoreKpi());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getScore360());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getScoreXspj());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getTotalScore());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getNatureSort());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getNatureGrade());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getForceSort());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(vo.getForceGrade());
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

