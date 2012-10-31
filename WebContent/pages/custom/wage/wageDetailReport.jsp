<%@page import="java.util.Map"%>
<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.custom.wage.service.WageDataServiceImpl"%>
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
<title>薪酬发放详情</title>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	#download{color:black;float:rigth;font-size:14px;text-decoration: none;}
	#download:hover{text-decoration: underline;}
</style>
<%
	String date = request.getParameter("date");
	String setId = request.getParameter("setId");
	date = date==null?CommonFuns.getSysDate("yyyy-MM"):date;
%>
<script language="javascript" src="/pages/common/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function exportword(){
		document.all("download").href="wageDetail.jsp?out=1&setId=<%=setId%>&date="+document.all("date").value;
		download.click();		
	}
	function search1(){
		document.all("search11").href="wageDetailReport.jsp?setId="+document.all("setId").value+"&date="+document.all("date").value;
		search11.click();
	}
</script>
</head>
<body>
	<div style="margin-left:20px;">
		所属帐套
		<select id="setId">
			<%
				User user = (User)session.getAttribute(Constants.USER_INFO);
					WageDataServiceImpl service = (WageDataServiceImpl)SysContext.getBean("wage_dataservice");
					List<Map> wageset = service.getWageSet(user.getUserId());
					if(wageset!=null){
						for(Map m : wageset){
							String sel="";
							if(setId!=null){
								if(setId.indexOf(m.get("set_id").toString())!=-1){
									sel="selected";
								}
							}
			%>						
						<option <%=sel %> value="<%=m.get("set_id")%>"><%=m.get("set_name")%></option>
						<%
					}
				}
			%>
		</select>
		日期<input id="date" type="text" value="<%=date %>" class="input" readonly="readonly"/>
		<img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM',alwaysUseStartDate:true,el:'date'})" src="../../../images/search.gif" class="button_select" align="absmiddle">
		<a id="search11" href=""></a><a id="download" href=""></a>
		<input type="button" class="button01" value="查询" onclick="search1();"/>
		<input type="button" class="button01" value="输出为word文档" onclick="exportword();"/>
		<br/>
	</div>
	<jsp:include page="wageDetail.jsp?date=<%=date %>&setId=<%=setId %>"></jsp:include>
</body>
</html>