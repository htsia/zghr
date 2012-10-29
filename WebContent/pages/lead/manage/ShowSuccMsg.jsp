<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
  String workpath =(String)(request.getContextPath());
%>
<title></title>
<link href="<%=workpath%>/css/style.css" rel="stylesheet" type="text/css">
<link href="<%=workpath%>/images/Style.css" rel="stylesheet" type="text/css">

<script language="javascript">
var mins = 5;
function countmin()
{
	try{
	mins = mins - 1;
	s_min.innerHTML = mins;
	if(mins >= 1)
		setTimeout("countmin()",1000);
	else
		window.close();
}catch(e){}
}
</script>

<body onLoad="countmin();">
<br>
<br>
<table width="280" height="230" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="230" background="/approve/images/success.gif">&nbsp;</td>
  </tr>
</table>
<table width="280" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" align="center" class="bluefont">版次发布成功，查阅！<br><span id="s_min" class="redfont">
    5</span>&nbsp;秒后系统将自动关闭该页！</td>
  </tr>
</table>
</body>


