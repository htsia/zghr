<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
           document.main.location.href = "/cont/ContQueryListChild.jsf?superId=" + orgId;
        }
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 合同信息维护  </td>
        </tr>
    </table>
    <table  width="100%" border="0"  cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="230">
                        <iframe name="tree" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                    <iframe name="main" height="100%"  frameborder="0"  scrolling="no"
                            width="100%" src="/cont/ContQueryListChild.jsf"></iframe>
            </td>
        </tr>
    </table>
</h:form>
