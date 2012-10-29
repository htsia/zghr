<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <%
        String mode=(String)request.getParameter("mode");
    %>

    <script type="text/javascript">
        function refreshList(orgId) {
           document.main.location.href = "/employee/chg/ManagerOpinionList.jsf?mode=<%=mode%>&superId=" + orgId;
        }
        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

</head>

<body>
<h:form id="form1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title" colspan=3><img src="/images/tips.gif">
            <%=LanguageSupport.getResource( "RYGL-2179", "调配管理")%>
            <%
                if ("cadres".equals(mode)){
                    out.println("-> 干部调动审批");
                }
                else if("worker".equals(mode)){
                    out.println("-> 工人调动审批");
                }
            %>
            </td>
        </tr>

        <tr>
            <td id="showTree" width=230 valign="top">
                  <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/employee/chg/OrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                 <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="no"
                                    width="100%" src="/employee/chg/ManagerOpinionList.jsf?mode=<%=mode%>"></iframe>
            </td>
        </tr>
    </table>
</h:form>
</body>
</html>