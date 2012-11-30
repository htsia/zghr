<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
User user = (User) (session.getAttribute(Constants.USER_INFO));
String rootid = "";
rootid =user.getOrgId();
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/attence/QueryCardLogList.jsf?backFlag=1&flag=1&superId=" + orgId;
        }
        function forChange() {
            if (document.getElementById("form1:mType").value == "1") {
                document.tree.location.href = "/pages/attence/OrgTree.jsp";
            } else {
            }
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=20 class="td_title"><img src="/images/tips.gif">Ë¢¿¨Êý¾Ý²éÑ¯</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                   <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                               src="/pages/common/ShowOrgTree.jsp"></iframe>
             </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                   <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="no" width="100%"   src="/attence/QueryCardLogList.jsf" ></iframe>
            </td>
        </tr>
    </table>
   </c:verbatim>
</h:form>
