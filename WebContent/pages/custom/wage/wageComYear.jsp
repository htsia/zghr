<%@page import="com.hr319wg.custom.wage.service.IWageDataService"%>
<%@page import="java.util.Map"%>
<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@page import="com.hr319wg.custom.util.CommonUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.util.CommonFuns"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>薪资</title>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	#download{color:black;float:rigth;font-size:14px;text-decoration: none;}
	#download:hover{text-decoration: underline;}
</style>
<%
	String date = request.getParameter("date");
	date = date==null?CommonFuns.getSysDate("yyyy"):date;
%>
<script language="javascript" src="/pages/common/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function exportword(){
		document.all("download").href="wageComYearRep.jsp?out=1&date="+document.all("date").value;
		download.click();		
	}
	function search1(){
		document.all("search11").href="wageComYearRep.jsp?date="+document.all("date").value;
		search11.click();
	}
</script>
</head>
<body>
	<div style="margin-left:20px;">
		
		日期<input id="date" type="text" value="<%=date %>" class="input" readonly="readonly"/>
		<img onclick="WdatePicker({startDate:'%y',dateFmt:'yyyy',alwaysUseStartDate:true,el:'date'})" src="../../../images/search.gif" class="button_select" align="absmiddle">
		<a id="search11" href=""></a><a id="download" href=""></a>
		<input type="button" class="button01" value="查询" onclick="search1();"/>
		<input type="button" class="button01" value="输出为word文档" onclick="exportword();"/>
		<br/>
	</div>
	<jsp:include page="wageComYearRep.jsp?date=<%=date %>"></jsp:include>
</body>
</html>