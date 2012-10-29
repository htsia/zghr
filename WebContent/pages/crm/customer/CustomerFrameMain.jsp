<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<base target="_self">
<title>客户管理主界面</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Appclient.js"></script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="table03">
	<tr>

		<td align="center" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><iframe name="main1" frameborder="0" framespacing="0"
					scrolling="yes" width="100%" height="420"
					src="/crm/customer/CustomerList.jsf?init=true"></iframe></td>
			</tr>
		</table>
		</td>

		<td width="2" class="ctrlbar" valign="middle"><img id="ctrlBnt" 
			src="/images/button_1.gif" onclick='ctrlbar();'></td>
		<td class="table01" id="showTree" width="170">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200" height="410" valign="top"><iframe name="tree" height="100%" 
					frameborder="0" framespacing="0" scrolling="no" width="100%"
					height="420" src="/pages/crm/customer/CustomerFunction.jsp"></iframe>
				</td>
			</tr>
		</table>
		</td>

	</tr>
</table>
</body>

</html>