<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
function deletedDictionary(){
    if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
        alert("请选择要删除的目录!");
        return false;
    }
    if (confirm("确定要删除吗?")){
        return true;
    }
    else{
        return false;
    }
}
function rptDesigner(){
    window.showModalDialog("/report/ReportDefineEdit.jsf?ok=10000", null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
    document.tree.location.href="/pages/report/showReportDefine.jsp";
}
function modifyDictionary(){
    if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
        alert("请选择要修改的目录!");
        return false;
    }
    window.showModalDialog("/report/ReportDefineEdit.jsf?rptcode="+document.all("form1:currentID").value, null, "dialogWidth:390px; dialogHeight:230px;center:center;resizable:no;status:no;scroll:no;");
    document.tree.location.href="/pages/report/showReportDefine.jsp";
    return false;
}
function refreshList(orgId) {
	document.all("form1:currentID").value=orgId;
    //debugger;
    document.main.location.href = "/report/ReportDefineList.jsf?groupId=" + orgId;
}
with (window) onload = onresize = function(){
    var mainHeight = document.body.offsetHeight - 50;
    document.getElementById("tree").style.height = "" + (mainHeight -30) + "px";
    document.getElementById("main").style.height = "" + mainHeight + "px";
}

function receiveRpt(){
	window.showModalDialog("/report/ReceiveRptFile.jsf", null, "dialogWidth:450px;  dialogHeight:130px;center:center;resizable:yes;status:no;scroll:yes;");
	document.tree.location.href="/pages/report/showReportDefine.jsp";
}

</script>

<h:form id="form1">
    <h:inputHidden id="currentID" value="#{Rpt_DefineListBB.groupIDS}"></h:inputHidden>
     
    <h:panelGrid columns="2" styleClass="td_title"  width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"  >
        <h:panelGroup>
               <h:panelGrid  columns="2"  styleClass="f04"  >
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="报表定义"/>
              </h:panelGrid>
       </h:panelGroup>
      
       <h:panelGroup>
           <h:panelGrid align="right">
           <h:commandButton styleClass="button01" value="接收表样"  onclick="return receiveRpt();" />
           </h:panelGrid>
      </h:panelGroup> 
      
     </h:panelGrid>
      
      <c:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
        </c:verbatim>
                        <h:commandButton styleClass="button01" type="button" value="定义类别" onclick="rptDesigner();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()"></h:commandButton>
                                               <h:commandButton styleClass="button01"  value="删除" action="#{Rpt_DefineListBB.DeleteType}" onclick="return deletedDictionary();"></h:commandButton>
<c:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="400"  frameborder="1" framespacing="0" scrolling="yes" height=600 width="100%"
                                    src="/pages/report/showReportDefine.jsp"></iframe>

                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" height=600 width="100%"
                                    src="/report/ReportDefineList.jsf"></iframe>
                    </td></tr>
                </table>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>




