<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/employee/info/sendQuery.jsf?backFlag=2&flag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 34;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>


<h:form id="form1">
    <c:verbatim>
    <input type="hidden" name="mode" value=<%String mode=request.getParameter("mode"); out.print(mode);%> >
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
            <%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID, OperateBO.CHANGEMODULEID) %> ->
            <%=CodeUtil.interpertCode(CodeUtil.TYPE_OPERATER, "0367") %>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                               src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>
            <td align="center" valign="top">
                    <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%"
                            src='/employee/info/sendQuery.jsf'></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
