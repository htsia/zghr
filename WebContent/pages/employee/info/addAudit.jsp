<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
           document.main.location.href = "/employee/info/addAuditChild.jsf?type=2&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> <%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER,"0369")%> </td>
        </tr>
    </table>

    <table   width="100%" border="0"  cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" valign="top">
                        <iframe name="tree" height="400"  frameborder="0"  scrolling="yes" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                 <iframe name="main" height="100%"  frameborder="0" width="100%"  scrolling="no"
                                     src="/employee/info/addAuditChild.jsf?type=2"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
