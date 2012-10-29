<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Calendar;"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" type="text/JavaScript">

function getCalendar() {
    var cal=document.all.year.value +"-"+document.all.month.value;
	window.returnValue=cal;
	self.close();
}
function clearCalendar(){
    window.returnValue="";
    self.close();
}

</script>
<style type="text/css">
<!--
td,input {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
}
-->
</style>

<%
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH );
	String title = request.getParameter("title");
%>
<title><%=(title!=null?title:"选择日期") %></title>
</head>

<body style="overflow:hidden;">
	<table border='0' cellspacing='0' align=center style='margin-top:10px;border:2px solid #0066FF;'>
		<tr>
			<td style='background-color:#C7D8FA'>
				<select name='year' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=2010;i<2030;i++){
						%>
						<option value=<%=i%> <%=(i==year)?"selected":""%>><%=i%></option>
						<%
					}
				%>
				</select>
				<select name='month' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=0;i<12;i++){
					%>
						<option value=<%=(i+1<10)?"0"+(i+1):i+1%> <%=(i==month)?"selected":""%>><%=(i+1<10)?"0"+(i+1):i+1%></option>
					<%
					}
				%>
				</select>
			</td>
			<td style='background-color:#C7D8FA; font-weight:bold; font-size:12px; padding-top:2px; color:#4477FF; cursor:hand' align='center' title='确定' onclick='javascript:getCalendar()'>确定</td>
			<td style='background-color:#C7D8FA; font-weight:bold; font-size:12px; padding-top:2px; color:#4477FF; cursor:hand' align='center' title='清空' onclick='javascript:clearCalendar()'>清空</td>
		</tr>
	</table>
</body>
</html>