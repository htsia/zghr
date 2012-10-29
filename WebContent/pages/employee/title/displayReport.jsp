<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<script src="/js/CreateControl.js" language="javascript"></script>
<title>显示报表</title>
</head>
<%
	String itemId=request.getParameter("itemId");
	String applyId=request.getParameter("applyId");
%>
<body style="margin:0">
	<table width="100%" height="800px" ><tr><td height="800px" >
	<script language="javascript">
	CreatePrintViewer("/grf/zcps_self_apply.grf", "/pages/employee/title/ApplyXmlData.jsp?itemId=<%=itemId%>&applyId=<%=applyId%>");
    </script>
    </td></tr></table>
</body>
</html>