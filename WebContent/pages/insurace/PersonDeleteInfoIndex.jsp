<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/insurace/PersonDeleteInfoQuery.jsf?QryID=143&backFlag=3&flag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 34;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">保险人员减少处理</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
             <td id="showTree" width="210">
                    <iframe name="tree" height="100%"  frameborder="0"  scrolling="yes" width="100%"   src="/pages/insurace/OrgTree.jsp"></iframe>
             </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                     <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%"   src="/insurace/PersonDeleteInfoQuery.jsf?QryID=143&backFlag=3&flag=1&superId=<%=user.getOrgId()%>" ></iframe>
            </td>
        </tr>
    </table>
</h:form>
