<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageUnitBO"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String type = request.getParameter("type");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String title = "";
    String url = "";
    if (user == null) {
        response.sendRedirect("/pages/overtime.htm");
    } else {
        String userId = user.getUserId();
        String unitId = SysCacheTool.findPersonById(userId).getGongZiGX();
        WageUnitBO unit=SysCacheTool.findWageUnit(unitId);
        if(unit==null) {
            out.println("<script language='javascript'>alert('错误：用户没有发薪单位')</script>");
            return;
        }
        if (unitId == null || unitId.trim().length() == 0) return;
        title = "保险基本信息变更查询";
        url = "/insurace/PersonInfoChangeQry.jsf?act=init&unitId="+unitId;
    }
%>
<html>
<head>
    <title></title>
    <script type="text/javascript" language="javascript">
        function refreshList(unitId, childNum) {
           document.list.location = "/insurace/PersonInfoChangeQry.jsf?act=init&unitId=" + unitId;
        }
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 32;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("list").style.height = "" + mainHeight + "px";
        }
    </script>
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"><%=title%></td>
    </tr>
    <tr>
        <td align="center" valign="bottom">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" class="explorer" id="showTree" width="210">
                        <table width="100%" border=0 cellpadding="0" cellspacing="0" valign="top">
                            <tr>
                                <td>
                                    <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                            src="/pages/wage/unit/UnitTree.jsp"></iframe>
                                </td>
                            </tr>
                        </table>
                    </td>

                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
                     </td>

                    <td align="center" valign="top" class="explorer">
                        <table width="100%" border=0 cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top">
                                    <iframe name="list" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                            src="<%=url%>"></iframe>
                                </td>
                            </tr>
                        </table>
                    </td>

                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>