<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/org/dismiss/OrgInfoQuery.jsf?flag=1&superId=" + orgId;
        }

        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td class="td_title">
        <%=LanguageSupport.getResource("JGGL-0107"," 已撤销机构维护")%>  
    </td></tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                   <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp?cancelFlag=1"></iframe>
             </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                    <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                                   src="/org/dismiss/OrgInfoQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
</c:verbatim>    
</h:form>
