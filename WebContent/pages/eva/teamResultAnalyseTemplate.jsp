<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="java.util.Iterator"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.emp.ucc.impl.teamManagerImpl"%>
<%@page import="org.jaxen.function.RoundFunction"%>
<%@page import="java.text.DecimalFormat"%><br>


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
				EvaKeyItemUCC ucc = null;
				EvaObjectsUCC objectucc = null;
				EvaScoreUCC scoreucc=null;
				teamManagerImpl teamucc=null;
				try {
					ucc = (EvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
					teamucc=(teamManagerImpl)SysContext.getBean("teamucc");
				} catch (Exception e) {
				}
			%>
			<%	
				String templateID=(String)session.getAttribute("templateId");
				List root = ucc.getAllChildItemSet(templateID);
				String value = "0";
				String id = "";
				int itemcount=0;
				List itemslist1=ucc.getAllItemByTemplateID(templateID);
				if(templateID!=null && !"".equals(templateID)){
					EvaTemplateBO tbo=ucc.findTemplateBO(templateID);
					if(tbo!=null){
						out.println("<tr>");
						out.println("<td id='locked' class='locked_top' valign='center' align='center' colspan='"+String.valueOf(itemslist1.size()+2)+"'><a href='#' onclick=showTemplate('"+templateID+"')>"+tbo.getTemplateName()+"</a></td>");
						out.println("</tr>");
					}
				}
				if (root != null && root.size() > 0) {
					out.println("<tr>");
					out.println("<td id='locked' class='locked_top' valign='center' align='center' rowspan='2'>");
					out.println("团队名称");
					out.println("</td>");
					List items = new ArrayList();
					for (int i = 0; i < root.size(); i++) {
						TemplateItemSetBO rootset = (TemplateItemSetBO) root.get(i);
						items = ucc.getAllChildItem(rootset.getSetID());
						TemplateItemBO itembo=null;
						int itemscore=0;
						if(items!=null && items.size()>0)
						{
							for(int it=0;it<items.size();it++)
							{
								itembo = (TemplateItemBO) items.get(it);
								if(itembo!=null && !(itembo.getScore()).equals(""))
								{
									itemscore+=Integer.parseInt(itembo.getScore());
									
								}
							}
						  
						  
						}
						int count= items.size() > 0 ? items.size() : 1;
						itemcount+=items.size();
						out.println("<td valign='center' id='locked' class='locked_top' align='center' colspan='"
								+ String.valueOf(count) + "'>");
						out.println(rootset.getSetName()+"("+itemscore+"%)");
						out.println("</td>");
						
					}
					out.println("<td class='locked_top' valign='center' align='center' rowspan='2'>总分</td>");
					out.println("</tr>");
					out.println("<tr>");
					for (int i = 0; i < root.size(); i++) {
						TemplateItemSetBO rootset = (TemplateItemSetBO) root.get(i);
						items = ucc.getAllChildItem(rootset.getSetID());
						if (items != null && items.size() > 0) {
							TemplateItemBO itembo = (TemplateItemBO) items.get(0);
							EvaKeyItemBO keybo = ucc.getEvaKeyItemBO(itembo
									.getLinkID());
							for (int j = 0; j < items.size(); j++) {
								itembo = (TemplateItemBO) items.get(j);
								keybo = ucc.getEvaKeyItemBO(itembo.getLinkID());
								String title="";
								if(itembo!=null && !(itembo.getScore()).equals(""))
								{
									title= keybo.getItemName() + "("
									+ CommonFuns.filterNull(itembo.getScore())
									+ "%)";
								}
								else
								{
									title= keybo.getItemName() + "(0%)";

								}
								
								out.println("<td id='locked' class='locked_top'><a href='#' onclick=showItem('"+keybo.getItemID()+"')>");
								out.println(title);
								out.println("</a></td>");
							}
						} else {
							out.println("</tr>");
						}
					}
					out.println("</tr>");
				}
				//从这里循环数据
						List objectList=(ArrayList)session.getAttribute("objectList");
						if(objectList!=null&&objectList.size()>0){
							for(int mm=0;mm<objectList.size();mm++){
								EvaObjectsBO objectbo=(EvaObjectsBO)objectList.get(mm);
								out.println("<tr>");
								out.println("<td class='td_middle_left'>");
								out.println(teamucc.findEmpTeamInfoBoById(objectbo.getPersonID()).getTeamName());
								out.println("</td>");
									for (int i = 0; i < root.size(); i++) {
										TemplateItemSetBO rootset = (TemplateItemSetBO) root
												.get(i);
										List items1 = ucc.getAllChildItem(rootset
												.getSetID());
										if (items1 != null && items1.size() > 0) {
											TemplateItemBO itembo = (TemplateItemBO) items1
													.get(0);
											EvaKeyItemBO keybo = ucc.getEvaKeyItemBO(itembo
													.getLinkID());
											for (int j = 0; j < items1.size(); j++) {
												itembo = (TemplateItemBO) items1.get(j);
												double itemscore=0;
												List itemScoreList=scoreucc.getAllScoreByObjectIdAndItemId(objectbo.getObjectID(),itembo.getItemID());
												if(itemScoreList!=null&&itemScoreList.size()>0){
													for(int m=0;m<itemScoreList.size();m++){
														EvaScoreBO esbo=(EvaScoreBO)itemScoreList.get(m);
														EvaMasterBO mastorbo=objectucc.findEvaMasterBOById(esbo.getMasterID());
														double score1=0;
														if(esbo.getCalascore()!=null&&!"".equals(esbo.getCalascore())){
															score1=Double.parseDouble(esbo.getCalascore());
														}
														double qz=0;
														if(mastorbo!=null){
															qz=Double.parseDouble(mastorbo.getPurview());
														}
														double score2=score1*qz/100;
														itemscore+=score2;
													}
													
												}
												out.println("<td class='td_middle_left'>");
												DecimalFormat   to=   new  DecimalFormat("0.00"); 
												String val=to.format(new Double(itemscore));
												out.println(val);
												out.println("</td>");
											}
										}
										
									}//ht1循环结束
								out.println("<td class='td_middle_left'>"+objectbo.getScore()+"</td>");
								out.println("</tr>");
							}
						}
			%>
		</table>
		
		</td>
	</tr>
</table>
<script type="text/javascript">
	function showTemplate(id){
		 window.showModalDialog("/pages/eva/previewTemplate.jsp?templateID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
	     return true;
	}
	
	function showItem(id){
		 window.showModalDialog("/eva/KeyItemInfo.jsf?itemID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
	     return true;
	}
</script>
