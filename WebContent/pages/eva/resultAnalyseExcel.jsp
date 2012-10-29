<%@ page language="java" pageEncoding="UTF-8"%>  
<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@page import="java.util.*"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaScoreUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaObjectsUCC"%>
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.NumberFormat"%>
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
 <table  align="center" id="dateList11" border="1">
			<%
				String templateID = (String) session.getAttribute("templateID");
				String planId=(String)session.getAttribute("planID");
				String superId=(String)session.getAttribute("superId");
                String showMode=(String)session.getAttribute("showMode");
				String notShowPercent="0";
				EvaTemplateBO tbo = null;
				EvaKeyItemUCC ucc = null;
				EvaObjectsUCC objectucc = null;
				EvaScoreUCC scoreucc = null;
				EvaPlanUCC planucc = null;

				try {
					ucc = (EvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
					planucc = (EvaPlanUCC) SysContext.getBean("eva_planUCC");
				} catch (Exception e) {
				}
				List objList=new ArrayList(); 
				if(superId!=null&&!superId.equals("")){
					objList=objectucc.getEvaObjectsBOForResutlShow(null, planId, templateID, superId);
				}
			%>
			<%
				EvaPlanBO pb=planucc.findPlanById(planId);
				if(pb.getNotShowPercent()!=null&&pb.getNotShowPercent().equals("1")){
					notShowPercent=pb.getNotShowPercent();
				}
				List root = ucc.getAllChildItemSet(templateID);
				String value = "0";
				String id = "";
				int itemcount = 0;
				Hashtable ht=ucc.getAllChildItemForHash(templateID);
				Hashtable itemslist1=ucc.getAllKeyItemBOByTemlateId(templateID);
				if (templateID != null && !"".equals(templateID)) {
					tbo = ucc.findTemplateBO(templateID);
					if (tbo != null) {
						out.println("<tr>");
						out.println("<td id='locked' class='locked_top' valign='center' align='center' colspan='"
										+ String.valueOf(itemslist1.size() + 2)
										+ "'>"
										+ tbo.getTemplateName() + "</a></td>");
						out.println("</tr>");
					}
				}
				if (root != null && root.size() > 0) {
					out.println("<tr>");
					out.println("<td id='locked' class='locked_top' valign='center' align='center' rowspan='2'>");
					out.println("姓名");
					out.println("</td>");
					List items = new ArrayList();
					for (int i = 0; i < root.size(); i++) {
						TemplateItemSetBO rootset = (TemplateItemSetBO) root.get(i);
						items = (ArrayList)ht.get(rootset.getSetID());
						TemplateItemBO itembo = null;
						int itemscore = 0;
						if (items != null && items.size() > 0) {
							for (int it = 0; it < items.size(); it++) {
								itembo = (TemplateItemBO) items.get(it);
								if (itembo != null
										&& !(itembo.getScore()).equals("")) {
									itemscore += Integer
											.parseInt(itembo.getScore());

								}
							}

						}
						int count = items.size() > 0 ? items.size() : 1;
						itemcount += items.size();
						out.println("<td valign='center' id='locked' class='locked_top' align='center' colspan='"
										+ String.valueOf(count) + "'>");
						if(notShowPercent.equals("1")){
							out.println(rootset.getSetName() + "(" + itemscore + ")");
						}else{
							out.println(rootset.getSetName() + "(" + itemscore + "%)");
						}
						out.println("</td>");

					}
					out.println("<td class='locked_top' valign='center' align='center' rowspan='2'>总分</td>");
					out.println("</tr>");
					out.println("<tr>");
					for (int i = 0; i < root.size(); i++) {
						TemplateItemSetBO rootset = (TemplateItemSetBO) root.get(i);
						items =(ArrayList)ht.get(rootset.getSetID());
						if (items != null && items.size() > 0) {
							TemplateItemBO itembo = (TemplateItemBO) items.get(0);
							EvaKeyItemBO keybo = (EvaKeyItemBO)itemslist1.get(itembo.getItemID());
							for (int j = 0; j < items.size(); j++) {
								itembo = (TemplateItemBO) items.get(j);
								keybo = (EvaKeyItemBO)itemslist1.get(itembo.getItemID());
								String title = "";
								if(notShowPercent.equals("1")){
									if (itembo != null
											&& !(itembo.getScore()).equals("")) {
										title = keybo.getItemName()
												+ "("
												+ CommonFuns.filterNull(itembo
														.getScore()) + ")";
									} else {
										title = keybo.getItemName() + "(0)";
	
									}
								}else{
									if (itembo != null
											&& !(itembo.getScore()).equals("")) {
										title = keybo.getItemName()
												+ "("
												+ CommonFuns.filterNull(itembo
														.getScore()) + "%)";
									} else {
										title = keybo.getItemName() + "(0%)";
	
									}
								}

								out.println("<td id='locked' class='locked_top'>");
								out.println(title);
								out.println("</a></td>");
							}
						} else {
							out.println("</tr>");
						}
					}
					out.println("</tr>");
				}
				//
				int per = 0;
			    String pers = pb.getScorePers();
				if (pers != null && !pers.equals("")) {
					per = Integer.parseInt(pers);
				} else {
					per = 0;
				}
				NumberFormat nf = NumberFormat.getInstance();
				nf.setMaximumFractionDigits(per);
				//从这里循环数据
				if (objList != null && objList.size() > 0) {
					String objIds[]=new String[objList.size()];
					for(int n=0;n<objList.size();n++){
						EvaObjectsBO bo = (EvaObjectsBO) objList.get(n);
						objIds[n]=bo.getObjectID();
					}
					Hashtable caculatScoreList=scoreucc.getEvaCaclScoresBOByObjectIds(objIds);
					Hashtable scoreHash=scoreucc.getEvaScoreBOForItemHash(objIds,templateID);
					Hashtable masterHash=objectucc.getEvaMasterBOByObjectIds(objIds);
					for (int n = 0; n < objList.size(); n++) {
						EvaObjectsBO bo = (EvaObjectsBO) objList.get(n);
						PersonBO po = SysCacheTool.findPersonById(bo.getPersonID());
						out.println("<tr>");
						out.println("<td class='td_middle_left'>");
						out.println(po.getName());
						out.println("</td>");
						for (int i = 0; i < root.size(); i++) {
							TemplateItemSetBO rootset = (TemplateItemSetBO) root
									.get(i);
							List items1 = (ArrayList)ht.get(rootset.getSetID());
							if (items1 != null && items1.size() > 0) {
								TemplateItemBO itembo = (TemplateItemBO) items1
										.get(0);
								EvaKeyItemBO keybo =(EvaKeyItemBO)itemslist1.get(itembo.getItemID());
								for (int j = 0; j < items1.size(); j++) {
									itembo = (TemplateItemBO) items1.get(j);
									keybo = (EvaKeyItemBO)itemslist1.get(itembo.getItemID());
									if (!keybo.getItemType().equals("2")) {
										double itemscore = 0;
										List itemScoreList =(ArrayList)scoreHash.get(bo.getObjectID()+itembo.getItemID());
										if (itemScoreList != null
												&& itemScoreList.size() > 0) {
											for (int m = 0; m < itemScoreList
													.size(); m++) {
												EvaScoreBO esbo = (EvaScoreBO) itemScoreList
														.get(m);
												EvaMasterBO mastorbo = (EvaMasterBO)masterHash.get(esbo.getMasterID());
												double score1 = 0;
												if(showMode.equals("0")){
                                                  if (esbo.getCalascore() != null&& !"".equals(esbo.getCalascore())) {
													score1 = Double.parseDouble(esbo.getCalascore());
												  }
                                                }else{
                                                  if (esbo.getScore() != null&& !"".equals(esbo.getScore())) {
													score1 = Double.parseDouble(esbo.getScore());
												  }
                                                }
												double qz = 0;
												if (mastorbo != null&&mastorbo.getPurview()!=null&&!mastorbo.getPurview().equals("")) {
													qz = Double.parseDouble(mastorbo.getPurview());
												}
												double score2 = score1 * qz / 100;
												itemscore += score2;
											}

										}
										out.println("<td class='td_middle_left'>");
										out.println(nf.format(itemscore));
										out.println("</td>");
									} else {
										double itemscore = 0;
										EvaCaclScoresBO score =(EvaCaclScoresBO)caculatScoreList.get(bo.getObjectID()+keybo.getItemID());
										if(showMode.equals("0")){
										   itemscore = Double.parseDouble(score
												.getPurview())
												* Double.parseDouble(score
														.getScore())
												* Double.parseDouble(tbo
														.getTotalscore())
												/ (100 * Double.parseDouble(keybo
														.getHighValue()));
                                        }else{
                                           itemscore = Double.parseDouble(score
														.getScore());
                                        }
										out.println("<td class='td_middle_left'>");
										if (score != null) {
											out.println(nf.format(itemscore));
										}
										out.println("</td>");
									}
								}
							}

						}//ht1循环结束
						if (bo.getScore() != null && !bo.getScore().equals("")) {
							out.println("<td class='td_middle_left'>"
									+ nf.format(Double.parseDouble(bo.getScore()))
									+ "</td>");
						} else {
							out.println("<td class='td_middle_left'></td>");
						}
					}
					out.println("</tr>");

				}
			%>
		</table>
 </body>  
</html> 

