<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageUnitBO"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String type = request.getParameter("type");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user == null) {
        response.sendRedirect("/pages/overtime.jsp");
    } 
%>
<html>
<head>
    <title></title>
    <script type="text/javascript" language="javascript">
        function refreshList(orgID) {
           document.main.location = "/custom/ins/insDataManagerQueryList.jsf?act=init&orgID=" + orgID;
        }
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 32;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">保险基础信息维护</td>
    </tr>
    <tr>
        <td align="center" valign="bottom">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" class="explorer" id="showTree" width="210">
                                    <iframe name="tree" height="400"  frameborder="0"  height="400" scrolling="auto" width="100%"
                                            src="/pages/common/ShowOrgTree.jsp"></iframe>
                    </td>

                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
                     </td>

                    <td align="center" valign="top" class="explorer">
                                    <iframe name="main" frameborder="0" height="400" scrolling="no" width="100%"
                                            src="/custom/ins/insDataManagerQueryList.jsf?act=init&orgID=<%=user.getOrgId()%>"></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>