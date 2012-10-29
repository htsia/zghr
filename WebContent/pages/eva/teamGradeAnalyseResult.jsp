<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="java.util.Iterator"%>
<%@ include file="../include/taglib.jsp"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="java.util.Set"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaGradeUCC"%>
<%@page import="com.hr319wg.emp.ucc.impl.teamManagerImpl"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<br>

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
				EvaObjectsUCC objectucc=null;
			    EvaScoreUCC  scoreucc=null;
			    EvaGradeUCC  evaGradeUcc=null;
			    teamManagerImpl teamucc=null;
			    String gradeId=(String)session.getAttribute("gradeId");
				List list = (ArrayList)session.getAttribute("objectList");
				try {				
					objectucc=(EvaObjectsUCC)SysContext.getBean("eva_objectUCC");
					scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
					evaGradeUcc=(EvaGradeUCC)SysContext.getBean("eva_gradeUCC");
					teamucc=(teamManagerImpl)SysContext.getBean("teamucc");
				} catch (Exception e) {
					e.printStackTrace();
				}
				List root =scoreucc.getPersonType();//人员类型
			    String value = "";
				List items = new ArrayList();
				items=evaGradeUcc.getAllGradeItem(gradeId);//等级
				if (root != null && root.size() > 0) {
					out.println("<tr>");
					out.println("<td id='locked' class='locked_top' valign='center' align='center' rowspan='2'>");
					out.println("团队名称");
					out.println("</td>");
					for (int i = 0; i < root.size(); i++) {
						CodeItemBO rootset = (CodeItemBO) root.get(i);
						int count = items.size() > 0 ? items.size()+1 : 1;
						if(rootset.getItemStatus().equals("")){
							out.println("<td valign='center' id='locked' class='locked_top' align='center' colspan='"+ String.valueOf(count) + "'>");
							out.println(rootset.getItemName());
							out.println("</td>");
						}
					}
					out.println("</tr>");
					out.println("<tr>");
					for (int i = 0; i < root.size(); i++) {
						CodeItemBO rootset = (CodeItemBO) root.get(i);
						if(rootset.getItemStatus().equals("")){
							if (items != null && items.size() > 0) {
								for (int j = 0; j < items.size(); j++) {
									EvaGradeItemBO itembo=new EvaGradeItemBO();
									itembo=(EvaGradeItemBO) items.get(j);
									out.println("<td id='locked' class='locked_top'>");
									out.println(itembo.getItemName());
									out.println("</td>");
								}
								out.println("<td id='locked' class='locked_top'>");
								out.println("票数");
								out.println("</td>");
							} else {
								out.println("</tr>");
							}
						}
					}
					out.println("</tr>");
				}
		
				//从这里循环数据
				if (list != null && list.size()>0) {
					for (int m=0;m<list.size();m++) {
						EvaObjectsBO bo=(EvaObjectsBO)list.get(m);
						out.println("<tr>");
						out.println("<td class='td_middle_left'>");
						out.println(teamucc.findEmpTeamInfoBoById(bo.getPersonID()).getTeamName());
						out.println("</td>");
						for(int i=0;i<root.size();i++){
							int count1=0;
							CodeItemBO rootset = (CodeItemBO) root.get(i);
							if(rootset.getItemStatus().equals("1")){
								List masterList=objectucc.getMastersByMasterType(bo.getObjectID(),rootset.getItemId());
								count1=masterList.size();
								for(int j=0;j<items.size();j++){
									int count2=0;
									EvaGradeItemBO gradeItem=(EvaGradeItemBO)items.get(j);
									double hivalue=Double.parseDouble(gradeItem.getHighValue());
									double lowValue=Double.parseDouble(gradeItem.getLowValue());
									if(masterList!=null&&masterList.size()>0){
										for(int mm=0;mm<masterList.size();mm++){
											EvaMasterBO msterbo=(EvaMasterBO)masterList.get(mm);
											double caculateScore=0;
											List scores=scoreucc.getAllEvaScoreBOByObjIdAndMasterId(bo.getObjectID(),msterbo.getMasterID());
											if(scores!=null&&scores.size()>0){
												for(int ii=0;ii<scores.size();ii++){
													EvaScoreBO score=(EvaScoreBO)scores.get(ii);
													if(score.getCalascore()!=null&&!score.getCalascore().equals("")){
														caculateScore+=Double.parseDouble(score.getCalascore());
													}
												}
											}
											if(caculateScore>=lowValue&&caculateScore<hivalue){
												count2++;
											}
										}
									}
									out.println("<td id='locked' class='td_middle_left'>");
									out.println(count2);
									out.println("</td>");
								}
								out.println("<td id='locked' class='td_middle_left'>");
								out.println(count1);
								out.println("</td>");
							}
						}
						out.println("</tr>");
					}
				}
			%>
		</table>
		</td>
	</tr>
</table>

