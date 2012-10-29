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
    var cal=document.all.year.value +"-"+document.all.month.value+"-"+document.all.day.value
    	+" "+document.all.hour.value+"-"+document.all.minute.value+"-"+document.all.second.value;
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
tr{background-color:red;}
td{background-color:#C7D8FA;}
-->
</style>

<%
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH );
	int day = cal.get(Calendar.DAY_OF_MONTH);
	int hour = cal.get(Calendar.HOUR_OF_DAY);
	int minute = cal.get(Calendar.MINUTE);
	int second = cal.get(Calendar.SECOND);
%>
</head>

<body style="overflow:hidden;">
	<table border='1' cellspacing='0' align="center" width="90%" style="margin-top:10px;">
		<tr>
			<td>日期</td>
			<td>
				<select name='year' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=2010;i<2030;i++){
						%>
						<option value=<%=i%> <%=(i==year)?"selected":""%>><%=i%></option>
						<%
					}
				%>
				</select>年
				<select name='month' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=0;i<12;i++){
						%>
						<option value=<%=(i+1<10)?"0"+(i+1):i+1%> <%=(i==month)?"selected":""%>><%=(i+1<10)?"0"+(i+1):i+1%></option>
						<%
					}
				%>
				</select>月
				<select name='day' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=1;i<=31;i++){
						%>
						<option value=<%=(i<10)?"0"+i:i%> <%=(i==day)?"selected":""%>><%=(i<10)?"0"+i:i%></option>
						<%
					}
				%>
				</select>日
			</td>
		</tr>
		<tr>
			<td>时间</td>
			<td>
				<select name='hour' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=1;i<=24;i++){
						int j=i;
						if(i==24){
							j=0;
						}
						%>
						<option value=<%=(j<10)?"0"+j:j%> <%=(j==hour)?"selected":"" %>><%=(j<10)?"0"+j:j%></option>
						<%
					}
				%>
				</select>时
				<select name='minute' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=1;i<=60;i++){
						%>
						<option value=<%=(i<10)?"0"+i:i%> <%=(i==minute)?"selected":"" %>><%=(i<10)?"0"+i:i%></option>
						<%
					}
				%>
				</select>分
				<select name='second' style='font-family:Verdana; font-size:12px'>
				<%
					for(int i=1;i<=60;i++){
						%>
						<option value=<%=(i<10)?"0"+i:i%> <%=(i==second)?"selected":"" %>><%=(i<10)?"0"+i:i%></option>
						<%
					}
				%>
				</select>秒
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="button" onclick='javascript:getCalendar()' value="确定"/>
				<input type="button" onclick='javascript:clearCalendar()' value="清空"/>
			</td>
		</tr>
	</table>
</body>
</html>