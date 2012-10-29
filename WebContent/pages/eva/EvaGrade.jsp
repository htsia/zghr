<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
        window.showModalDialog("/eva/GradeDictEdit.jsf", null, "dialogWidth:400px; dialogHeight:210px;center:center;resizable:yes;status:no;scroll:no;");
        document.tree.location.href="/pages/eva/ShowGradeType.jsp";
    }
    function modifyDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要修改的考核等级!");
            return false;
        }
        window.showModalDialog("/eva/GradeDictEdit.jsf?TypeID="+document.all("form1:currentID").value, null, "dialogWidth:400px; dialogHeight:210px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/eva/ShowGradeType.jsp";
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的考核等级!");
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
        document.main.location.href = "/eva/EvaGradeChild.jsf?superID=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 50;
        document.getElementById("tree").style.height = "" + (mainHeight -30) + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>

<h:form id="form1">
      <h:inputHidden id="currentID" value="#{eva_gradeBB.currentDic}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="考核等级管理"/>
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
                        <h:commandButton styleClass="button01" type="button" value="增加" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="删除" action="#{eva_gradeBB.DeleteType}" onclick="return deletedDictionary();"></h:commandButton>
<c:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="100%"  frameborder="1" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/eva/ShowGradeType.jsp"></iframe>

                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/eva/EvaGradeChild.jsf"></iframe>
                    </td></tr>
                </table>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>


