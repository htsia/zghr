<%@ page language="java" pageEncoding="UTF-8"%>  
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.*"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.post.util.PostTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@page import="java.util.*"%>
<%@page import="com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC"%>
<%@page import="com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC"%>
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
			    IXysKpiPersonUCC ucc = null;
			    IXysEvaPlanUCC pucc=null;
				try {
					ucc = (IXysKpiPersonUCC) SysContext.getBean("xysKpiPersonUCC");
					ucc.exportPersonKpiByPlanId(planId);
					pucc=(IXysEvaPlanUCC) SysContext.getBean("xys_evaPlanUCC");
				} catch (Exception e) {
				}
				List temList=null;
			%>
			<%	
				if(planId!=null&&!planId.equals("")){
					temList=pucc.getXysExportTempBOByPlanId(planId);
					if(temList!=null&&temList.size()>0){
						out.println("<tr>");
						out.println("<td>");
						out.println("姓名");
						out.println("</td>");
						out.println("<td>");
						out.println("部门");
						out.println("</td>");
						out.println("<td>");
						out.println("岗位名称");
						out.println("</td>");
						out.println("<td>");
						out.println("上上级");
						out.println("</td>");
						out.println("<td>");
						out.println("直接上级");
						out.println("</td>");
						out.println("<td>");
						out.println("其他上级");
						out.println("</td>");
					    out.println("</tr>");
					    
					    if(temList!=null&&temList.size()>0){
					    	int size=temList.size();
					    	for(int i=0;i<size;i++){
					    		StringBuffer sb=new StringBuffer();
					    		sb.append("<tr>");
					    		XysExportTempBO vo=(XysExportTempBO)temList.get(i);
					    		PersonBO pbo=SysCacheTool.findPersonById(vo.getPersonId());
					    		sb.append("<td>");
					    		sb.append(pbo.getName());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(PostTool.getPostName(pbo.getPostId()));
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(CommonFuns.filterNull(vo.getV1()));
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(CommonFuns.filterNull(vo.getV2()));
					    		sb.append("</td>");
					    		sb.append("<td>");
					    		sb.append(CommonFuns.filterNull(vo.getV3()));
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

