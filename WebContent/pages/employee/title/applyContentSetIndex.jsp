<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
    	window.showModalDialog("/employee/title/applyContentDirEdit.jsf?templateId="+document.all("form1:templateId").value, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/employee/title/applyContentDir.jsp";
    }
    function modifyDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要修改的类别!");
            return false;
        }
        window.showModalDialog("/employee/title/applyContentDirEdit.jsf?dirId="+document.all("form1:currentID").value, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/employee/title/applyContentDir.jsp";
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的类别!");
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
        document.all("form1:currentID").value=orgId;
        document.main.location.href = "/employee/title/applyContentItem.jsf?dirId="+orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        $("iframe[name=tree]").height(mainHeight);
        $("iframe[name=main]").height(mainHeight);
    }
    
</script>
<x:saveState value="#{titleContentSetBB}"></x:saveState>
<h:form id="form1">
	  <h:inputHidden value="#{titleContentSetBB.initSet}"></h:inputHidden>
	  <h:inputHidden id="currentID" value="#{titleContentSetBB.currentId}"></h:inputHidden>
	  <h:inputHidden id="templateId" value="#{titleContentSetBB.templateId}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="职称评审内容设置"></h:outputText>
        </h:panelGroup>
      </h:panelGrid>

       <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
</f:verbatim>
                        <h:commandButton styleClass="button01" type="button" value="增加" onclick="addDictionary();"></h:commandButton>
                        <h:outputText value="  "></h:outputText>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary();"></h:commandButton>
                        <h:outputText value="  "></h:outputText>
                        <h:commandButton styleClass="button01"  value="删除" action="#{titleContentSetBB.deleteDir}" onclick="return deletedDictionary();"></h:commandButton>
<f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="400"  frameborder="1"  scrolling="auto" width="100%"
                                    src="/pages/employee/title/applyContentDir.jsp"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                                    src="/employee/title/applyContentItem.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


