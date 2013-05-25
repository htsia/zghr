<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	User user = (User) session.getAttribute(Constants.USER_INFO);
	if (user == null) {
	    response.sendRedirect("/pages/overtime.jsp");
	}
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/insurace/ChangeQueryRight.jsf?backFlag=2&flag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 30;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif" alt=""> 保险变动人员查询</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"
                               src="/pages/common/ShowOrgTree.jsp">
                         </iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                  <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%"   src="/insurace/ChangeQueryRight.jsf?superId=<%=user.getOrgId()%>" >
                  </iframe>
            </td>
        </tr>
    </table>
</h:form>
</body>
</html>