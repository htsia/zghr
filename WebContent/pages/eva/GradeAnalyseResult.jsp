
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
		<div style='width:100%;height:500px;overflow:auto' id=datatable>
		<table class="table02" align="center" id="dateList">
			<%
				EvaObjectsUCC objectucc = null;
				List objList = (List) session.getAttribute("objectList");
				try {
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
				} catch (Exception e) {
				}
			%>
			<%
				String[] root = (String[]) session.getAttribute("masterType");
				String value = "";
				List items = new ArrayList();

				if (root != null && root.length > 0) {
					out.println("<tr>");
					out.println("<td id='locked' class='locked_top td_fixtop' valign='center' align='center' rowspan='2'>");
					out.println("姓名");
					out.println("</td>");
					items = (ArrayList) session.getAttribute("gradeItem");
					for (int i = 0; i < root.length; i++) {
						CodeItemBO rootset =SysCacheTool.findCodeItem("",root[i]);
						int count = items.size() > 0 ? items.size() + 1 : 1;
						if (rootset.getItemStatus().equals("1")) {
							out.println("<td valign='center' id='locked' class='locked_top td_fixtop' align='center' colspan='"+ String.valueOf(count) + "'>");
							out.println(rootset.getItemName());
							out.println("</td>");
						}
					}
					out.println("</tr>");
					out.println("<tr>");
					for (int i = 0; i < root.length; i++) {
						CodeItemBO rootset =SysCacheTool.findCodeItem("",root[i]);
						if (rootset.getItemStatus().equals("1")) {
							if (items != null && items.size() > 0) {
								for (int j = 0; j < items.size(); j++) {
									EvaGradeItemBO itembo = new EvaGradeItemBO();
									itembo = (EvaGradeItemBO) items.get(j);
									out.println("<td id='locked' class='locked_top td_fixtop'>");
									out.println(itembo.getItemName());
									out.println("</td>");
								}
								out.println("<td id='locked' class='locked_top td_fixtop'>");
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
				if (objList != null && objList.size() > 0) {
					for (int n = 0; n < objList.size(); n++) {
						EvaObjectsBO bo = (EvaObjectsBO) objList.get(n);
						PersonBO po = SysCacheTool.findPersonById(bo.getPersonID());
						out.println("<tr>");
						out.println("<td class='td_middle_left'>");
						out.println(po.getName());
						out.println("</td>");
						for (int i = 0; i < root.length; i++) {
							int count1 = 0;
							CodeItemBO rootset =SysCacheTool.findCodeItem("",root[i]);
							if (rootset.getItemStatus().equals("1")) {
								EvaMasterBO masterscorebo = null;
								List ht2=objectucc.getMastersByMasterType(bo.getObjectID(),rootset.getItemId());
								int count3=0;
								for(int m=0;m<ht2.size();m++) {
									masterscorebo = (EvaMasterBO) ht2.get(m);
									if(masterscorebo.getIsMark()!=null&&masterscorebo.getIsMark().equals("1")){
										count3++;
									}
								}
								if (items != null && items.size() > 0) {
									for (int j = 0; j < items.size(); j++) {
										int count2 = 0;
										EvaGradeItemBO itembo = (EvaGradeItemBO) items.get(j);
										if (ht2 != null&&ht2.size()>0) {
											for(int m=0;m<ht2.size();m++) {
												masterscorebo = (EvaMasterBO) ht2.get(m);
												if(masterscorebo.getGradeId()!=null&&masterscorebo.getGradeId().equals(itembo.getItemID())){
													count2++;
												}
											}
											if (count2 == 0) {
												value = "";
											}else {
												value = Integer.toString(count2);
											}
										} else {
											value = "";
										}
										out.println("<td id='locked' class='td_middle_left'>");
										out.println(value);
										out.println("</td>");
									}
									out.println("<td id='locked' class='td_middle_left'>");
									out.println(count3);
									out.println("</td>");
								} else {
									if (ht2 != null&&ht2.size()>0) {
										for(int m=0;m<ht2.size();m++ ){
											masterscorebo = (EvaMasterBO) ht2
													.get(m);
											if (masterscorebo != null) {
												count1 += 1;

											}
										}
									}
									out.println("<td id='locked' class='td_middle_left'>");
									out.println(count1 + "票");
									out.println("</td>");
								}

							}
						}
						out.println("</tr>");
					}
				}
			%>
		</table>
		</div>
		</td>
	</tr>
</table>

