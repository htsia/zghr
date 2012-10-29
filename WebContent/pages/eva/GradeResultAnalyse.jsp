<%@ page contentType="text/html;charset=GBK" language="java"%>
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
      return true;
	}
   function exportToExcel() {
	   window.open("/pages/eva/GradeAnalyseResultExcel.jsp", "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:yes;scroll:yes;");
	    return true;
	}
</script>
<x:saveState value="#{eva_gradeResultAnalyseBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="initTemplat" value="#{eva_gradeResultAnalyseBB.initTemplat}"></h:inputHidden>
	<h:inputHidden id="superID" value="#{eva_gradeResultAnalyseBB.superId}"></h:inputHidden>
	<h:inputHidden id="indexId" value="#{eva_gradeResultAnalyseBB.indexValue}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right"></c:verbatim> <h:panelGrid align="left">
					<h:panelGroup>
						<h:outputText value="当前机构:"></h:outputText>
						<h:outputText value="#{eva_gradeResultAnalyseBB.superName}"></h:outputText>
					</h:panelGroup>
				</h:panelGrid> <h:panelGrid align="right" columns="2">
					<h:panelGroup>
						<h:outputText value="记录数:#{eva_gradeResultAnalyseBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="页数:#{eva_gradeResultAnalyseBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="每页有#{eva_gradeResultAnalyseBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText
							value="当前为第#{eva_gradeResultAnalyseBB.mypage.currentPage}页"></h:outputText>
						<h:commandButton value="首页"
							action="#{eva_gradeResultAnalyseBB.first}" styleClass="button01"></h:commandButton>
						<h:commandButton value="上页"
							action="#{eva_gradeResultAnalyseBB.pre}" styleClass="button01"></h:commandButton>
						<h:commandButton value="下页"
							action="#{eva_gradeResultAnalyseBB.next}" styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页"
							action="#{eva_gradeResultAnalyseBB.last}" styleClass="button01"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <c:verbatim></td>
			</tr>
			<br />
			<tr>
				<td align="right"><br />
				</c:verbatim> 
				<h:outputText value="模板类型:"></h:outputText> <h:selectOneMenu
					id="tem" value="#{eva_gradeResultAnalyseBB.templateID}"
					style="width:170px">
					<c:selectItems value="#{eva_gradeResultAnalyseBB.templateList}" />
				</h:selectOneMenu>
				<h:outputText value="分析模式:"></h:outputText> <h:selectOneMenu
					id="showMode" value="#{eva_gradeResultAnalyseBB.showMode}"
					style="width:170px">
					<c:selectItem itemLabel="票数分析" itemValue="1"/>
					<c:selectItem itemLabel="分数分析" itemValue="2"/>
				</h:selectOneMenu>
				<h:commandButton id="showValue" value="开始分析" styleClass="button01"
					onclick="return forcheck();"
					action="#{eva_gradeResultAnalyseBB.doQuery}"></h:commandButton> <c:verbatim></td>
			</tr>
			<tr>
				<td align="center">
				<% 
					String showMode=(String)session.getAttribute("showMode");
					if(showMode!=null&&showMode.equals("2")){
				%>
					<table width=98% align="center">
	<tr>
		<td align="center"><span
			style="font-size: 18px; font-weight: bold;"></span></td>
		<td></td>
	</tr>
	<tr>
		<td height=8 colspan=2 align="right"><input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportToExcel()"> </td>
	</tr>
	<tr>
		<td colspan=2>
		<div style='width:100%;height:500px;overflow:auto' id=datatable>
		<table class="table02" align="center" id="dateList11" width="100%">
			<%
				EvaObjectsUCC objectucc = null;
				EvaPlanUCC planucc = null;
				List objList = (List) session.getAttribute("objectList");
				try {
					objectucc = (EvaObjectsUCC) SysContext.getBean("eva_objectUCC");
					planucc = (EvaPlanUCC) SysContext.getBean("eva_planUCC");
				} catch (Exception e) {
				}
			%>
			<%
				String[] root = (String[]) session.getAttribute("masterType");
				String planId=(String)session.getAttribute("planID");
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
		</div>
		</td>
	</tr>
</table>
					
				<%  }else{%>
					<jsp:include page="/pages/eva/GradeAnalyseResult.jsp"></jsp:include>
				<%} %>
				</td>
			</tr>
		</table>
		<h:inputHidden id="c" value="#{eva_gradeResultAnalyseBB.clear}"></h:inputHidden>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
   function showSort(indexId){
	      document.all("form1:indexId").value=indexId;
	      document.all("form1:showValue").click();
		}
</script>
