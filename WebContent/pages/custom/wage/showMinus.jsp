<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ʵ����С������Ա����</title>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<%
    List<Map> list =(List<Map>)session.getAttribute("minusList");
%>
</head>
<body>
	<table width="80%" border="0" align="center" id="dataList" class="table03" style="margin:20px;">
		<tr align="left" class="td_top">
                <td height="27" colspan="5" class="td_top" style="color:red;font-size: 15px;">ʵ�������������ݹ�<%=list.size() %>��</td>
        </tr>
	    <tr align="center">
	        <td class="td_top">���</td>
	        <td class="td_top">Ա�����</td>
	        <td class="td_top">����</td>
	        <td class="td_top">���ڲ���</td>
	        <td class="td_top">ʵ������</td>
	    </tr>
	    <%
	    	int index=0;
	        for(Map m : list) {
	    %>
	    <tr align="center">
	        <td class="td_middle"><%=++index%></td>
	        <td class="td_middle"><%=m.get("pCode")%></td>
	        <td class="td_middle"><%=m.get("name")%></td>
	        <td class="td_middle"><%=m.get("deptName")%></td>
	        <td class="td_middle"><%=m.get("wage")%></td>
	    </tr>
	    <%
	        }
	    %>
	</table>
</body>
</html>