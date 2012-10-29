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
<%@page import="com.hr319wg.eva.ucc.impl.EvaPlanUCC"%>
<%@page import="java.util.Set"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="java.text.NumberFormat"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script>
function exportToExcel() {
    try {
        var range = document.body.createTextRange();
        range.moveToElementText(dateList11);
        range.execCommand('Copy');
        excel = new ActiveXObject('Excel.Application');
        excel.Application.Visible = true;
        book = excel.Workbooks.Add;
        sheet = book.Worksheets.Add;
        sheet.Paste;
    } catch(e) {
        alert("您的电脑可能没有安装Microsoft Excel软件，或者没有将本站点设为信任站点。");
        return false;
    }
}
</script>
<br>

<table width=98% align="center">
	<tr>
		<td align="center"><span
			style="font-size: 18px; font-weight: bold;"></span></td>
		<td></td>
	</tr>
	<tr>
		<td height=8 colspan=2><input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportToExcel()"> </td>
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
								if(bo.getFvalueByIndex(i+1)!=null&&!bo.getFvalueByIndex(i+1).equals("")){
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
						out.println("<td class='td_middle'>");
						out.println(nf3.format(Double.parseDouble(bo.getF())));
						out.println("</td>");
						out.println("<td class='td_middle'>");
						out.println(nf.format(Double.parseDouble(bo.getS())));
						out.println("</td>");
						out.println("<tr>");
					}
				}
			%>
		</table>
		</div>
		</td>
	</tr>
</table>
<script>
   function showSort(indexId){
      document.all("form1:indexId").value=indexId;
      document.all("form1:showValue").click();
	}
</script>
