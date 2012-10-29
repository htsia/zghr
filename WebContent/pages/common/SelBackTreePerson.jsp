<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));

%>
<c:verbatim>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/common/PersonQuery.jsf?flag=1&superId=" + orgId+"&rightFlag=<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>";
        }
        with (window) onload = onresize = function()   {
            var mainHeight = document.body.offsetHeight - 39;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>


<table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
    <tr>
        <td class="table01" id="showTree" width="200">
                    <iframe name="tree" height="100%"  frameborder="0"  scrolling="yes" width="100%"
                            height="465" src="/pages/common/ShowOrgTree.jsp?rootId=<%=rootId%>"></iframe>
        </td>

        <td width="5" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

        <td align="center" valign="top">
                   <iframe name="main" height="100%"  frameborder="0"  scrolling="yes" width="100%"
                       height="465" src="/common/PersonQuery.jsf?superId=<%=user.getOrgId()%>=&rightFlag=<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>"></iframe>
        </td>
    </tr>
</table>
</c:verbatim>