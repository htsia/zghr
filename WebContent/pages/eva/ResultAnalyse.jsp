<%@ page contentType="text/html;charset=GBK" language="java"%>
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
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function forcheck()
    {
      if(document.all("form1:superID").value=="")
      {
       alert("请选择机构");
       return false;     
      }
      if(document.all("form1:tem").value=="")
      {
       alert("请选择模板");
       return false;     
      }
      showProcessBar();
      return true;
	}
  
	function exportCvs(){
		window.open("/pages/eva/resultAnalyseExcel.jsp", "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:yes;scroll:yes;");
        return true;
	}
	function showProcessBar() {
	    x = document.body.clientWidth / 2 - 150;
	    y = document.body.clientHeight / 2;
	    document.all('processbar').style.top = y;
	    document.all('processbar').style.left = x;
	    document.all('processbar').style.display = "";
	 }
</script>
<x:saveState value="#{eva_resultAnalyseBB}"></x:saveState>
<h:form id="form1">

	<h:inputHidden value="#{eva_resultAnalyseBB.initTemplate}"></h:inputHidden>
	<h:inputHidden id="superID" value="#{eva_resultAnalyseBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				
				</c:verbatim> <h:panelGrid align="left">
					<h:panelGroup>
						<h:outputText value="当前机构:"></h:outputText>
						<h:outputText value="#{eva_resultAnalyseBB.superName}"></h:outputText>
					</h:panelGroup>
				</h:panelGrid> 
				 <h:panelGrid align="right" columns="2">
					<h:panelGroup>
						<h:outputText value="记录数:#{eva_resultAnalyseBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="页数:#{eva_resultAnalyseBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="每页有#{eva_resultAnalyseBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="当前为第#{eva_resultAnalyseBB.mypage.currentPage}页"></h:outputText>
						<h:commandButton value="首页"
							action="#{eva_resultAnalyseBB.first}" styleClass="button01" onclick="showProcessBar();"></h:commandButton>
						<h:commandButton value="上页"
							action="#{eva_resultAnalyseBB.pre}" styleClass="button01" onclick="showProcessBar();"></h:commandButton>
						<h:commandButton value="下页"
							action="#{eva_resultAnalyseBB.next}" styleClass="button01" onclick="showProcessBar();"></h:commandButton>
						<h:commandButton value="尾页"
							action="#{eva_resultAnalyseBB.last}" styleClass="button01" onclick="showProcessBar();"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> 
				<c:verbatim></td>
			</tr>
			<br />
			<tr>
			
				<td align="right"><br /></c:verbatim>
                <h:outputText value="模板类型:"></h:outputText>
				<h:selectOneMenu id="tem" value="#{eva_resultAnalyseBB.templateID}"
					style="width:200px">
					<c:selectItems value="#{eva_resultAnalyseBB.templateList}" />
				</h:selectOneMenu>
                 <h:outputText value="显示模式:"></h:outputText>
				<h:selectOneMenu id="showMode" value="#{eva_resultAnalyseBB.showMode}"
					style="width:200px">
					<c:selectItem itemLabel="显示计算分数" itemValue="0"/>
                    <c:selectItem itemLabel="显示打分分数" itemValue="1"/>
				</h:selectOneMenu>
                <h:commandButton value="开始分析" styleClass="button01"
					onclick="return forcheck();"
					action="#{eva_resultAnalyseBB.doParameter}"></h:commandButton> <c:verbatim></td>
			</tr>
			
			<tr>
				<td align="center">
				
				<table width=98% align="center">
	<tr>
		<td align="center"><span
			style="font-size: 18px; font-weight: bold;"></span></td>
		<td></td>
	</tr>
	<tr>
		<td height=8 colspan=2 align="right"><input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportCvs()"></td>
	</tr>
	<tr>
		<td colspan=2>
		<table class="table02" align="center" id="dateList11">
			<%
				String templateID = (String) session.getAttribute("templateID");
				String planId=(String)session.getAttribute("planID");
                String showMode=(String)session.getAttribute("showMode");
				String notShowPercent="0";
				EvaTemplateBO tbo = null;
				EvaKeyItemUCC ucc = null;
				EvaObjectsUCC objectucc = null;
				EvaScoreUCC scoreucc = null;
				EvaPlanUCC planucc = null;
				List objList = (ArrayList) session.getAttribute("objectList");

				try {
					ucc = (EvaKeyItemUCC) SysContext.getBean("eva_keyitemucc");
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					scoreucc = (EvaScoreUCC) SysContext.getBean("eva_scoreUCC");
					planucc = (EvaPlanUCC) SysContext.getBean("eva_planUCC");
				} catch (Exception e) {
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

		</td>
	</tr>
</table>
			   
				</td>
			</tr>
		</table>
		<h:inputHidden id="c" value="#{eva_resultAnalyseBB.clear}"></h:inputHidden>
		<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList11");
</script>
