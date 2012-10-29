<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
<head>
<title>薪酬关系转移</title>
<script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript">
function selectOut(){
	document.all.outSec.className='activeTab';
	document.all.inSec.className='tab';
	infoiframe.location='SalaryOutList.jsf';
}
function selectIn(){
	document.all.outSec.className='tab';
	document.all.inSec.className='activeTab';
	infoiframe.location='SalaryInList.jsf';
}
</script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
  <tr>
    <td  valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td height="22" valign="top" class="td_title"> 薪酬关系转移 </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="top"><table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0"  >
      <tr >
        <td height="25" colspan="3" >发薪单位：上级机关</td>
      </tr>
      <tr >
        <td width="20%" height="25" align="center" class="activeTab" id="outSec" onclick="selectOut()">薪酬关系转出</td>
        <td width="20%" align="center" class="tab" id="inSec" onclick="selectIn()">薪酬关系转入</td>
        <td width="60%" >&nbsp;</td>
        </tr>
      <tr >
        <td colspan="3" class="tab" ><iframe  id="infoiframe" frameborder=0 width="100%" height="420"  scrolling="yes"  src="SalaryOutList.jsf"></iframe></td>
      </tr>

    </table>
    </td>
  </tr>
</table>
</body>
</html>
