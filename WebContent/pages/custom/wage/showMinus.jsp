<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>实发不小于零人员数据</title>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<%
    List<Map> list =(List<Map>)session.getAttribute("minusList");
%>
</head>
<body>
	<table width="80%" border="0" align="center" id="dataList" class="table03" style="margin:20px;">
		<tr align="left" class="td_top">
                <td height="27" colspan="6" class="td_top" style="color:red;font-size: 15px;">实发不大于零或无银行账号数据共<%=list.size() %>条</td>
        </tr>
	    <tr align="center">
	        <td class="td_top">序号</td>
	        <td class="td_top">员工编号</td>
	        <td class="td_top">姓名</td>
	        <td class="td_top">所在部门</td>
	        <td class="td_top">实发工资</td>
	        <td class="td_top">银行账号</td>
	    </tr>
	    <%
	    	int index=0;
	        for(Map m : list) {
	        boolean minus= Double.valueOf(String.valueOf(m.get("wage")))<=0;
	        boolean bank=m.get("bank")==null || "".equals(m.get("bank"));
	    %>
	    <tr align="center">
	        <td class="td_middle"><%=++index%></td>
	        <td class="td_middle"><%=m.get("pCode")%></td>
	        <td class="td_middle"><%=m.get("name")%></td>
	        <td class="td_middle"><%=m.get("deptName")%></td>
	        <td class="td_middle" style="<%=minus?"color:red;":""%>"><%=m.get("wage") %></td>
	        <td class="td_middle" style="<%=bank?"color:red;":""%>"><%=bank?"无":m.get("bank") %></td>	        
	    </tr>
	    <%
	        }
	    %>
	</table>
</body>
</html>