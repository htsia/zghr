<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
%>
<html>
<head>
    <base target="_self">
    <title>—°‘Ò»À‘±</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/pages/employee/TreePerson.jsf?flag=1&rightFlag=2&superId=" + orgId;
            main.showProcessBar();
        }
        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 39;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
</head>

<body>
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
    <tr>
        <td class="table01" id="showTree" width="200">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="260" height="465" valign="top">
                    <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                            height="465" src="/pages/common/ShowOrgTree.jsp?rightFlag=2"></iframe>
                </td>
            </tr>
        </table>
        <td width="5" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
        <td align="center" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                height="465" src="/pages/employee/TreePerson.jsf"></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>

</html>