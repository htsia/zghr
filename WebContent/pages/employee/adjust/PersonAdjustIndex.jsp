<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/employee/adjust/PersonAdjustQuery.jsf?backFlag=2&flag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
               <%=LanguageSupport.getResource("RYGL-0300","员工管理")%> ->
              <%=LanguageSupport.getResource("RYGL-0306","单位内部人员调配")%>   
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top">
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                               src="/pages/common/ShowOrgTree.jsp"></iframe>
                    </td>
                </tr>
            </table>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="no" width="100%"
                                   src="/employee/adjust/PersonAdjustQuery.jsf"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</h:form>
