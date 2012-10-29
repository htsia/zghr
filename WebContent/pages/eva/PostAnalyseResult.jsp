<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.eva.pojo.bo.*"%>
<%@page import="com.hr319wg.qry.pojo.vo.StaticResultItemVO"%>
<%@page import="com.hr319wg.qry.pojo.vo.StaticResultVO"%>
<%@page import="java.util.ArrayList"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

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
				List ht = (List)session.getAttribute("jobEstimateScoreht");
				
			    String value = "";
				List items = new ArrayList();

				out.println("<tr>");
				
				items=(ArrayList)session.getAttribute("gradeItem");
				if(items!=null && items.size()>0){
						out.println("<td id='locked' class='locked_top' valign='center' align='center' rowspan='2'>");
						out.println("人数合计");
						out.println("</td>");
				}
					
				out.println("<tr>");
					
				if (items != null && items.size() > 0) {
                    for (int j = 0; j < items.size(); j++) {
                        EvaGradeItemBO itembo=new EvaGradeItemBO();
                        itembo=(EvaGradeItemBO) items.get(j);
                        out.println("<td id='locked' class='locked_top'>");
                        out.println(itembo.getItemName());
                        out.println("</td>");
                    }
                } else {
                    out.println("</tr>");
                }
						
				out.println("</tr>");
				
				//从这里循环数据
				if(ht!=null && ht.size()>0){
                	if (items != null && items.size() > 0){
                                out.println("<tr>");
                                out.println("<td id='locked' class='td_middle_left'>");
                                out.println(ht.size());
                                out.println("</td>");

                                com.hr319wg.qry.pojo.vo.StaticResultVO[] resultvo=new com.hr319wg.qry.pojo.vo.StaticResultVO[items.size()];
                                for (int j = 0; j < items.size(); j++) {
                                    int count2=0;
                                    EvaGradeItemBO itembo=(EvaGradeItemBO) items.get(j);
														
                                    if(itembo!=null && !itembo.equals("")){
                                        String hv=itembo.getHighValue();
                                        String lv=itembo.getLowValue();
                                        if (ht != null && ht.size()>0) {
                                            for(int h=0;h<ht.size();h++){
                                                EvaJobEstimateBO bo=(EvaJobEstimateBO)ht.get(h);
                                                String score=bo.getScore();
                                                if(score!=null && !score.equals("")){
                                                    if(hv!=null && !hv.equals("") && lv!=null && !lv.equals("")){
                                                        if(Double.parseDouble(score)>=Double.parseDouble(lv) && Double.parseDouble(score)<Double.parseDouble(hv)){
                                                            count2+=1;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        if(count2==0){
                                              value="0";
                                        }
                                        else{
                                             value=Integer.toString(count2);
                                        }

                                        out.println("<td id='locked' class='td_middle_left'>");
                                        out.println(value);
                                        out.println("</td>");
                                }
														
                                resultvo[j]=new StaticResultVO();
                                StaticResultItemVO[] Item=new StaticResultItemVO[1];
                                Item[0]=new StaticResultItemVO();
                                Item[0].setAllValue(itembo.getItemName()); // 设置标题
                                if(value.equals("")){
                                    Item[0].setCount(0);
                                }
                                else{
                                    Item[0].setCount(Integer.parseInt(value));
                                }// 设置数值
                                resultvo[j].setItems(Item);
					  	  }
                            session.setAttribute("STATIC_RESULT", resultvo);
                            out.println("</tr>");
                        }
                        else{
                            out.println("<tr>");
                            out.println("<td class='td_middle_left'>");
                            out.println("受考核人数："+ht.size());
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='td_middle_left'>");
                            out.println("请设置对应计划的考核等级，以便结果分析");
                            out.println("</td>");
                            out.println("</tr>");
                        }
					}
			%>
		</table>
		</td>
	</tr>
    <tr>
        <td align="center"><jsp:include page="/pages/qry/StaticResultPie.jsp?height=300&width=500"></jsp:include></td>
    </tr>
</table>

