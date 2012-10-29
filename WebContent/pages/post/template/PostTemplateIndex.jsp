<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function refreshList(postType) {
            document.main.location.href = "/post/template/PostInfoQuery.jsf?superId=" + postType + "&flag=1&pageFlag=2";
        }
        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 50;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
</head>

<body>
<h:form id="form1">
    <h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" styleClass="td_title">
        <f:verbatim>
           <%=LanguageSupport.getResource("GWGL-1064", "说明书模板维护")%>
			</f:verbatim>
    </h:panelGrid>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table03">
        <tr>
            <td width="210" align="center" valign="top" id=showTree>
                <iframe name="tree" frameborder="0" framespacing="0" scrolling="yes" width="100%"
                        src="/pages/post/template/PostClassTree.jsp?dict_num=0110"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>
            <td align="center" valign="top" width="5">　</td>
            <td align="center" valign="top">
                <iframe name="main" frameborder="0" framespacing="0" scrolling="yes" width="100%"
                        src="/post/template/PostInfoQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
</h:form>
</body>
</html>