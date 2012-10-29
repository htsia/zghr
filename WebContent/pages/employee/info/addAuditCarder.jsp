<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
           document.main.location.href = "/employee/info/addAuditChild.jsf?type=1&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">  <%=LanguageSupport.getResource("RYGL-2250","新进干部审批")%>    </td>
        </tr>
    </table>

    <table   width="100%" border="0"  cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" valign="top">
                        <iframe name="tree" frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                 <iframe name="main" frameborder="0" width="100%" framespacing="0" scrolling="no"
                                     src="/employee/info/addAuditChild.jsf?type=1"></iframe>
            </td>
        </tr>
    </table>
</h:form>
