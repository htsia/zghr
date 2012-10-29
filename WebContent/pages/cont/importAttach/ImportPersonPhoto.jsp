<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script language="javascript">

function showProcessBar() {
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
}

function checkSubmit(form1) {
        flag = true;
        var directoryPersonPhoto = form1.all("form1:directoryPersonPhoto").value;
        if (directoryPersonPhoto == "" || directoryPersonPhoto == null){
            alert("��Ƭ�����ļ�Ŀ¼����Ϊ�գ�");
            flag = false;
            return flag;
        }
        //alert(name);
        showProcessBar();
        return flag;
 }
</script>
<body>
<c:view>
<h:panelGrid width="100%" border="0" cellspacing="0" cellpadding="0" >
   <h:outputText value="����Ա����Ƭ" styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
<br/><br/>
<h:panelGrid  border="0"  align="center" columns="1" width="95%">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="ע����Ƭ��ŵ��ļ�Ŀ¼��ָ������Ƭ�����weblogic���ڻ����ϵ��ļ�·���������㱾�ؼ�����д�ŵ���Ƭ�ļ�·����"></h:outputText>
     </h:panelGrid>
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
         <h:outputText styleClass="td_title" value="��Ա��Ƭ��ŵ��ļ�Ŀ¼"></h:outputText>
         <h:inputText size="50" id="directoryPersonPhoto" value="#{cont_importAttachBB.directoryPersonPhoto}" />
         <h:commandButton  value="����" action="#{cont_importAttachBB.importPersonPhoto}" onclick="javascript:return checkSubmit(document.forms(0));"/>
     </h:panelGrid>

     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="2" >
         <h:outputText styleClass="td_title" value="�����������Ϣ��"></h:outputText>
         <h:outputText styleClass="td_title" value=" "></h:outputText>
         <h:outputText styleClass="td_title" value="�Ƿ�ɹ���Ϣ"></h:outputText>
         <h:outputText styleClass="td_title" value="#{cont_importAttachBB.successInfo}"></h:outputText>
         <h:outputText styleClass="td_title" value="�ɹ�������Ƭ����"></h:outputText>
         <h:outputText styleClass="td_title" value="#{cont_importAttachBB.count}"></h:outputText>
         <h:outputText styleClass="td_title" value="��ʱ(��)"></h:outputText>
         <h:outputText styleClass="td_title" value="#{cont_importAttachBB.runTime}"></h:outputText>
     </h:panelGrid>

</h:panelGrid>


</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr></table>
</marquee>
</c:view>
</body>
</html>