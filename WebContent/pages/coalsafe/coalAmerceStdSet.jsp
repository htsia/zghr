<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
        window.showModalDialog("/coalsafe/amerceStdDirEidt.jsf?create=create", null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/coalsafe/ShowMajorDir.jsp";
    }
    function modifyDictionary(){
        if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
            alert("请选择要修改的目录!");
            return false;
        }
        window.showModalDialog("/coalsafe/amerceStdDirEidt.jsf?dirId="+document.all("form1:superId").value, null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/coalsafe/ShowMajorDir.jsp";
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
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
    function refreshList(orgId) {
        document.all("form1:superId").value=orgId;
        document.main.location.href = "/coalsafe/dirChildList.jsf?superID=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>

<h:form id="form1">
	  <h:inputHidden id="superId" value="#{cocalAmerceStdSetBB.superId}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="岗位作业标准设置"/>
        </h:panelGroup>
      </h:panelGrid>

       <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="240">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
</f:verbatim>
                        <h:commandButton styleClass="button01" type="button" value="增加" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="删除" action="#{cocalAmerceStdSetBB.deleteDir}" onclick="return deletedDictionary();"></h:commandButton>
<f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" frameborder="1" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/coalsafe/ShowMajorDir.jsp"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/coalsafe/dirChildList.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


