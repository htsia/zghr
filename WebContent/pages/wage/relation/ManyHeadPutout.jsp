<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
<head>
<title>��ͷ��������</title>
<script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript">
function selectOut(){
	document.all.outSec.className='activeTab';
	document.all.inSec.className='tab';
	infoiframe.location='ManyHeadPersonSetup.jsf';
}
function selectIn(){
	document.all.outSec.className='tab';
	document.all.inSec.className='activeTab';
	infoiframe.location='ViewManyHeadPerson.jsf';
}
</script>
</head>
<body>
<h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
  <h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >
        <h:outputText value=" ��ͷ���Ź�ϵ����"/>
   </h:panelGrid>
    <f:verbatim>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0"  >
      <tr >
        <td height="25" colspan="3" >��н��λ���ϼ�����</td>
      </tr>
      <tr >
        <td width="20%" height="25" align="center" class="activeTab" id="outSec" onclick="selectOut()">��ͷ���Ź�ϵ��Ȩ</td>
        <td width="20%" align="center" class="tab" id="inSec" onclick="selectIn()">�鿴��ͷ������Ա</td>
        <td width="60%" >&nbsp;</td>
        </tr>
      <tr >
        <td colspan="3" class="tab" ><iframe  id="infoiframe" frameborder=0 width="100%" height="420"  scrolling="yes"  src="ManyHeadPersonSetup.jsf"></iframe></td>
      </tr>
    </table> </f:verbatim>
</h:panelGrid>
</body>
</html>
