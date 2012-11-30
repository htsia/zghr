<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<f:verbatim>
    <script type="text/javascript">
        function refreshList(orgId) {
                document.main.location.href = "/cont/contSheetChild.jsf?superId=" + orgId;
        }

        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
         <td class="td_title" colspan="3"><img src="/images/tips.gif">∫œÕ¨Ã®’ </td>
    </tr>

    <tr>
        <td id="showTree" width="210">
              <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp?rootId=<%User user=(User)session.getAttribute(Constants.USER_INFO); out.println(user.getOrgId());%>"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
        </td>

        <td align="center" valign="top">
             <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%"
                          src="/cont/contSheetChild.jsf"></iframe>
        </td>
    </tr>
</table>
</f:verbatim>
