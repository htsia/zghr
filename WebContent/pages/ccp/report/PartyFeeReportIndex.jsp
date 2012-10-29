<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/ccp/report/PartyFeeReport.jsf?flag=1&superId="+orgId;
        }
         with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 29;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
<c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif" />党费收支结存</td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
        <tr>
            <td class="table01" id="showTree" width="210">
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                 src="/pages/ccp/PartyTree.jsp?rightFlag=1&paType=1"></iframe>
                    </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/ccp/report/PartyFeeReport.jsf"></iframe>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>