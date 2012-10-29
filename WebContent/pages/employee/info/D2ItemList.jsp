<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
        window.showModalDialog("/employee/info/AddD2Item.jsf", null, "dialogWidth:500px; dialogHeight:90px;center:center;resizable:no;status:no;scroll:no;");
    }

    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的项目!");
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
        document.main.location.href = "/employee/info/D2ItemConfigList.jsf?currentID=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
</script>
<h:form id="form1">
      <h:inputHidden id="currentID" value="#{emp_d2AnaBB.currentID}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <c:verbatim>
                <%=LanguageSupport.getResource("RYGL-2296","分析项目设置")%>
            </c:verbatim>
        </h:panelGroup>
      </h:panelGrid>

      <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="250">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
      </f:verbatim>
                        <h:commandButton styleClass="button01"  value="增加" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="删除" action="#{emp_d2AnaBB.Delete}" onclick="return deletedDictionary();">
                        </h:commandButton>
      <f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                    		<iframe name="tree" frameborder="1"  scrolling="auto" width="100%"
                                    src="/employee/info/ShowD2Item.jsf" ></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                     <iframe name="main" frameborder="0"  scrolling="auto" width="100%"  src="/employee/info/D2ItemConfigList.jsf"></iframe>
            </td>
        </tr>
    </table>
   </f:verbatim>    
</h:form>


