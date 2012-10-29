<%@page import="com.hr319wg.util.CommonFuns"%>
<%@page import="java.util.Map"%>
<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.custom.wage.service.WageDataService"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String wageDate = request.getParameter("date");
	String wageSetID = request.getParameter("setId");
	String p1 = request.getParameter("out");
	if(p1!=null){
		response.setContentType("application/msword;charset=UTF-8");
		String filename = URLEncoder.encode("工资发放说明.doc", "utf-8");
		response.setHeader("Content-Disposition","Disposition; filename=" + filename);
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人工资发放说明</title>
<style type="text/css">
	.big1{font-size:17px;font-weight:bold;margin-top:10px;}
	.big2{font-size:13px;font-weight:bold;margin:10px 0 0 20px;}
	table{margin:5px 0 0 20px;}
</style>
<script language="javascript" src="/pages/common/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function search1(){
		document.all("search11").href="selfWageCheck.jsp?date="+document.all("date").value;
		search11.click();
	}
</script>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body class="td_title">

    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="margin:0 0 20px 0;">
        <tr>
            <td class="td_title" style="border-bottom: 1px solid #6392c6;"><img src="/images/tips.gif">个人工资发放说明</td>
        </tr>
    </table>

	<div id="main" style="margin-left:20px;">
		<%
			String date = request.getParameter("date");
			date = date==null?CommonFuns.getSysDate("yyyy-MM"):date;
			User user = (User)session.getAttribute(Constants.USER_INFO);
			WageDataService service = (WageDataService)SysContext.getBean("wage_dataservice");
		%>
		
		</select>
		日期<input id="date" type="text" value="<%=date %>" class="input" readonly="readonly"/>
		<img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'date'})" src="../../../images/search.gif" class="button_select" align="absmiddle">
		<a id="search11" href=""></a><a id="download" href=""></a>
		<input type="button" class="button01" value="查询" onclick="search1();"/>
		
<!-- 		其他1 -->
		<div class="big1">其他1</div>
		<table class="table03" border="1" width="600">
			<tr>
				<th class="td_top">项目</th><th class="td_top">金额</th><th class="td_top">备注</th>
			</tr>
			<%
				List recList = service.getSelfWageOtherItemDetail("1", wageDate, user.getUserId());
				if(recList!=null){
					for(int i=0;i<recList.size();i++){
						Map m = (Map)recList.get(i);
						%>
						<tr>
							<td class="td_middle_center"><%=m.get("name") %></td>
							<td class="td_middle_center"><%=m.get("money") %></td>
							<td class="td_middle_center"><%=m.get("remark")==null?"":m.get("remark") %></td>
						</tr>
						<%
					}
				}
			%>
		</table>
<!-- 		其他1 -->
		<div class="big1">其他2</div>
		<table class="table03" border="1" width="600">
			<tr>
				<th class="td_top">项目</th><th class="td_top">金额</th><th class="td_top">备注</th>
			</tr>
			<%
				List recList2 = service.getSelfWageOtherItemDetail("2", wageDate, user.getUserId());
				if(recList!=null){
					for(int i=0;i<recList2.size();i++){
						Map m = (Map)recList2.get(i);
						%>
						<tr>
							<td class="td_middle_center"><%=m.get("name") %></td>
							<td class="td_middle_center"><%=m.get("money") %></td>
							<td class="td_middle_center"><%=m.get("remark")==null?"":m.get("remark") %></td>
						</tr>
						<%
					}
				}
			%>
		</table>
<!-- 		扣其他1 -->
		<div class="big1">扣其他1</div>
		<table class="table03" border="1" width="600">
			<tr>
				<th class="td_top">项目</th><th class="td_top">金额</th><th class="td_top">备注</th>
			</tr>
			<%
				List recList4 = service.getSelfWageOtherItemDetail("4", wageDate, user.getUserId());
				if(recList!=null){
					for(int i=0;i<recList4.size();i++){
						Map m = (Map)recList4.get(i);
						%>
						<tr>
							<td class="td_middle_center"><%=m.get("name") %></td>
							<td class="td_middle_center"><%=m.get("money") %></td>
							<td class="td_middle_center"><%=m.get("remark")==null?"":m.get("remark") %></td>
						</tr>
						<%
					}
				}
			%>
		</table>
		<!-- 		扣其他2 -->
		<div class="big1">扣其他2</div>
		<table class="table03" border="1" width="600">
			<tr>
				<th class="td_top">项目</th><th class="td_top">金额</th><th class="td_top">备注</th>
			</tr>
			<%
				List recList5 = service.getSelfWageOtherItemDetail("5", wageDate, user.getUserId());
				if(recList!=null){
					for(int i=0;i<recList5.size();i++){
						Map m = (Map)recList5.get(i);
						%>
						<tr>
							<td class="td_middle_center"><%=m.get("name") %></td>
							<td class="td_middle_center"><%=m.get("money") %></td>
							<td class="td_middle_center"><%=m.get("remark")==null?"":m.get("remark") %></td>
						</tr>
						<%
					}
				}
			%>
		</table>
	</div>
</body>
</html>