<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/employee/QueryDeptPersonList.jsf?flag=1&orgId=" + orgId;
        }
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
        <tr><td height=10 colspan=3></td></tr>
        <tr>
            <td class="table01" id="showTree" width="159">
                        <iframe name="tree" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                 src="/pages/common/ShowOrgTree.jsp"></iframe>
             </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top" width="5">¡¡</td>

            <td align="center" valign="top">
                            <iframe name="main" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                     src="/employee/QueryDeptPersonList.jsf"></iframe>
            </td>
        </tr>
    </table>
</h:form>
