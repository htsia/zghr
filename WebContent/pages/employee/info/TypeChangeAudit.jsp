<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        <%
            String title = "";
            if ("TOMCAT".equals(CommonFuns.getAppType())) {
                title = CommonFuns.getParaFromURL(request.getQueryString(), "Title");
            } else {
                title=request.getParameter("Title");
            }
            
            String type = request.getParameter("type");
        %>
        function refreshList(orgId) {
           document.main.location.href = "/employee/info/TypeChangeAuditChild.jsf?type=<%=type%>&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>


<h:form id="form1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
            <%
                out.println(CommonFuns.filterNull(title));
            %>
            </td>
        </tr>
    </table>

    <table   width="100%" border="0"  cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" valign="top">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                 <iframe name="main" height="100%"  frameborder="0" width="100%" framespacing="0" scrolling="no"
                                     src="/employee/info/TypeChangeAuditChild.jsf?type=<%=type%>"></iframe>
            </td>
        </tr>
    </table>
</h:form>
