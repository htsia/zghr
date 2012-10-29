<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
        window.showModalDialog("/attence/groupMgrEdit.jsf?okID=100", null, "dialogWidth:390px; dialogHeight:230px;center:center;resizable:yes;status:no;scroll:no;");
        document.tree.location.href="/pages/attence/ShowGroupMgrType.jsp";
    }
    function modifyDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要修改的排班项目!");
            return false;
        }
        window.showModalDialog("/attence/groupMgrEdit.jsf?TypeID="+document.all("form1:currentID").value, null, "dialogWidth:390px; dialogHeight:270px;center:center;resizable:yes;status:no;scroll:no;");
        document.tree.location.href="/pages/attence/ShowGroupMgrType.jsp";
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的排班项目!");
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
        //debugger;
        document.main.location.href = "/attence/groupMgrList.jsf?groupId=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 50;
        document.getElementById("tree").style.height = "" + (mainHeight -30) + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>

<h:form id="form1">
    <h:inputHidden id="currentID" value="#{group_mgrBB.groupID}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="排班管理"/>
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
                        <h:commandButton styleClass="button01" type="button" value="增加班组" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()"></h:commandButton>
                       <h:commandButton styleClass="button01"  value="删除" action="#{group_mgrBB.DeleteType}" onclick="return deletedDictionary();"></h:commandButton>
<c:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" frameborder="1" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/attence/ShowGroupMgrType.jsp"></iframe>

                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
                            <iframe name="main" frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/attence/groupMgrList.jsf"></iframe>
                    </td></tr>
                </table>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>


