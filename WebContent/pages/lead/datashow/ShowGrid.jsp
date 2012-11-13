<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.lead.pojo.bo.LeadOrgBO" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String title = "";
    String url = "";
    if (user == null) {
        response.sendRedirect("/pages/overtime.htm");
    } else {
        String userId = user.getUserId();
        String unitId = SysCacheTool.findPersonById(userId).getOrgId();
        LeadOrgBO unit = SysCacheTool.findLeadUnit(unitId);
        String superId = Constants.ORG_BENBU;
        if (unit != null) {
            superId = unit.getSuperId();
        }
        title = "表格分析结果查看";
        url = "/lead/GridResult.jsf";
    }
%>

    <script type="text/javascript" language="javascript">
        function refreshList(resId) {
                document.list.location = "/lead/GridResult.jsf?resId=" + resId;
        }
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 46;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("list").style.height = "" + mainHeight + "px";
        }
    </script>

<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"><%=title%></td>
    </tr>
    <tr>
        <td align="center" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" class="explorer" id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0"  scrolling="yes" width="100%"
                                            src="/pages/lead/datashow/GridResourceTree.jsp"></iframe>
                    </td>

                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
                    </td>

                    <td align="center" valign="top" class="explorer">
                        <iframe name="list" frameborder="0"  scrolling="auto" width="100%"
                                            src="<%=url%>"></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
