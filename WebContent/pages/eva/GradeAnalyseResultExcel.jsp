<%@ page language="java" pageEncoding="UTF-8"%>  
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaGradersBO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="java.util.Set"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.hr319wg.common.web.PageVO"%>
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
<table border="1" align="center" id="dateList11" width="100%">
			<%
				EvaObjectsUCC objectucc = null;
				EvaPlanUCC planucc = null;
				String superId = (String) session.getAttribute("superId");
				String indexValue = (String) session.getAttribute("indexValue");
				String templateID = (String) session.getAttribute("templateID");
				PageVO mypage=(PageVO)session.getAttribute("mypage");
				try {
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					planucc = (EvaPlanUCC) SysContext.getBean("eva_planUCC");
				} catch (Exception e) {
				}
			%>
			<%
				String[] root = (String[]) session.getAttribute("masterType");
				String planId=(String)session.getAttribute("planID");
				List objList=new ArrayList();
				mypage.setPageSize(mypage.getTotalRecord());
				objList=objectucc.getAllEvaGradersBOByPlanIdAndOrgId(mypage, templateID, superId, planId,indexValue);
				if(planId!=null&&!planId.equals("")&&root!=null){
					String value = "";
					EvaPlanBO plbo=planucc.findPlanById(planId);
					NumberFormat nf = NumberFormat.getInstance();
					if (plbo.getScorePers() != null && !plbo.getScorePers().equals("")) {
						int intPers = Integer.parseInt(plbo.getScorePers());
						nf.setMaximumFractionDigits(intPers);
					} else {
						nf.setMaximumFractionDigits(2);
					}
					NumberFormat nf2 = NumberFormat.getInstance();
					if (plbo.getLevelPers() != null && !plbo.getLevelPers().equals("")) {
						int intPers = Integer.parseInt(plbo.getLevelPers());
						nf2.setMaximumFractionDigits(intPers);
					} else {
						nf2.setMaximumFractionDigits(2);
					}
					NumberFormat nf3 = NumberFormat.getInstance();
					nf3.setMaximumFractionDigits(0);
					if (root != null && root.length > 0) {
						out.println("<tr>");
						out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center'>");
						out.println("序号");
						out.println("</td>");
						out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center'>");
						out.println("姓名");
						out.println("</td>");
						for (int i = 0; i < root.length; i++) {
							CodeItemBO rootset =SysCacheTool.findCodeItem("",root[i]);
							if (rootset.getItemStatus().equals("1")) {
								out.println("<td valign='center' id='locked' class='locked_top td_fixtop' align='center'>");
								out.println("<a href='#' onclick=showSort('"+(i+1)+"')>"+rootset.getItemName()+"</a>");
								out.println("</td>");
								out.println("<td valign='center' id='locked' class='locked_top td_fixtop' align='center'>");
								out.println(rootset.getItemName()+"权重");
								out.println("</td>");
							}
						}
						out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center'>");
						out.println("总权重");
						out.println("</td>");
						out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center'>");
						out.println("<a href='#' onclick=showSort('0')>总分</a>");
						out.println("</td>");
						out.println("</tr>");
					}
	
					//从这里循环数据
					if (objList != null && objList.size() > 0) {
						for (int n = 0; n < objList.size(); n++) {
							EvaGradersBO bo = (EvaGradersBO) objList.get(n);
							PersonBO po = SysCacheTool.findPersonById(bo.getPersonId());
							out.println("<tr>");
							out.println("<td class='td_middle'>");
							out.println(n+1);
							out.println("</td>");
							out.println("<td class='td_middle'>");
							out.println(po.getName());
							out.println("</td>");
							for (int i = 0; i < root.length; i++) {
								CodeItemBO rootset =SysCacheTool.findCodeItem("",root[i]);
								if (rootset.getItemStatus().equals("1")) {
									if(bo.getFvalueByIndex(i+1)!=null&&!bo.getFvalueByIndex(i+1).equals("")&&bo.getSvalueByIndix(i+1)!=null&&!bo.getSvalueByIndix(i+1).equals("")){
										out.println("<td valign='center' id='locked' class='td_middle' align='center'>");
										out.println(nf.format(Double.parseDouble(bo.getSvalueByIndix(i+1))));
										out.println("</td>");
										out.println("<td valign='center' id='locked' class='td_middle' align='center'>");
										out.println(nf2.format(Double.parseDouble(bo.getFvalueByIndex(i+1))));
										out.println("</td>");
									}else{
										out.println("<td valign='center' id='locked' class='td_middle' align='center'>");
										out.println("");
										out.println("</td>");
										out.println("<td valign='center' id='locked' class='td_middle' align='center'>");
										out.println("");
										out.println("</td>");
									}
								}
							}
							if(bo.getF()!=null&&!bo.getF().equals("")&&bo.getS()!=null&&!bo.getS().equals("")){
								out.println("<td class='td_middle'>");
								out.println(nf3.format(Double.parseDouble(bo.getF())));
								out.println("</td>");
								out.println("<td class='td_middle'>");
								out.println(nf.format(Double.parseDouble(bo.getS())));
								out.println("</td>");
								out.println("</tr>");
							}else{
								out.println("<td class='td_middle'>");
								out.println("");
								out.println("</td>");
								out.println("<td class='td_middle'>");
								out.println("");
								out.println("</td>");
								out.println("</tr>");
							}
						}
					}
				}
			%>
		</table>
 </body>  
</html> 

