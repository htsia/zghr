<%@ page import="com.hr319wg.eva.ucc.impl.EvaGradeUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="java.util.Iterator"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="java.util.Set"%>

<%@page import="java.text.DecimalFormat"%><br>
<%@page import="java.text.NumberFormat"%><br>

<table width=98% align="center">
	<tr>
		<td align="center"><span
			style="font-size: 18px; font-weight: bold;"></span></td>
		<td></td>
	</tr>
	<tr>
		<td height=8 colspan=2></td>
	</tr>
	<tr>
		<td colspan=2>
		<table class="table02" align="center" id="dateList">
			<%
				String planId=request.getParameter("planID");
				String personId=request.getParameter("PersonID");
			   
				EvaGradeUCC ucc = null;
				EvaObjectsUCC objectucc = null;
				EvaScoreUCC scoreucc=null;
				EvaPlanUCC planucc=null;
				
				try {
					ucc = (EvaGradeUCC) SysContext.getBean("eva_gradeUCC");
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
					planucc=(EvaPlanUCC)SysContext.getBean("eva_planUCC");
				} catch (Exception e) {
				}
			%>
			<%	
				EvaObjectsBO objectbo=objectucc.getEvaObjectsBOByPlanIdAndPersonId(planId,personId);
				EvaPlanBO planbo=planucc.findPlanById(planId);
				List root = ucc.getAllGradeItem(planbo.getPlanGrade());
				String value = "0";
				String id = "";
				int itemcount=0;
				if (root != null && root.size() > 0) {
					out.println("<tr>");
					out.println("<td id='locked' class='locked_top' valign='center' align='center'>");
					out.println("姓名");
					out.println("</td>");
					if(root!=null&&root.size()>0){
						for(int i=0;i<root.size();i++){
							EvaGradeItemBO itembo=(EvaGradeItemBO)root.get(i);
							out.println("<td id='locked' class='locked_top' valign='center' align='center'>");
							out.println(itembo.getItemName());
							out.println("</td>");
						}
					}
					out.println("<td id='locked' class='locked_top' valign='center' align='center' >");
					out.println("考核得分");
					out.println("</td>");
					out.println("<td id='locked' class='locked_top' valign='center' align='center' >");
					out.println("考核等级");
					out.println("</td>");
					out.println("</tr>");
				}
				//从这里循环数据
						int per=0;
						if (objectbo != null) {
							String pers=planucc.findPlanById((objectucc.findEvaObjectBOById(objectbo.getObjectID())).getPlanID()).getScorePers();
							if(pers!=null&&!pers.equals("")){
								per=Integer.parseInt(pers);
							}else{
								per=0;
							}
						}
						NumberFormat   nf   =   NumberFormat.getInstance(); 
						nf.setMaximumFractionDigits(per);
						PersonBO po = SysCacheTool.findPersonById(objectbo.getPersonID());
						out.println("<tr>");
						out.println("<td class='td_middle_center'>");
						out.println(po.getName());
						out.println("</td>");
							for (int i = 0; i < root.size(); i++) {
								EvaGradeItemBO itembo=(EvaGradeItemBO)root.get(i);
								List gradeList=objectucc.getEvaMasterBOByObjectIdAndGradeId(objectbo.getObjectID(),itembo.getItemID());
								out.println("<td id='locked' class='td_middle_center' valign='center' align='center' rowspan='2'>");
								out.println(gradeList.size());
								out.println("</td>");
							}//ht1循环结束
							
							out.println("<td class='td_middle_center'>");
							out.println(objectbo.getScore());
							out.println("</td>");
							out.println("<td class='td_middle_center'>");
							if(objectbo.getGradeItem()!=null&&!objectbo.getGradeItem().equals("")){
								out.println(ucc.getGradeItem(objectbo.getGradeItem()).getItemName());
							}else{
								out.println("");
							}
							out.println("</td>");
						out.println("</tr>");
			%>
		</table>
		
		</td>
	</tr>
</table>

