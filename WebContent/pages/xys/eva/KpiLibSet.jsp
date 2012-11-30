<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user=(User)session.getAttribute(Constants.USER_INFO);
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/xys/eva/KpiLibPost.jsf?superId="+orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
        function uploadKeySet(){
            window.showModalDialog("/xys/eva/KpiLibUpLoad.jsf", null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return false;
        }
    </script>
 <f:view>
<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->KPI指标库管理
           </td>
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
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/xys/eva/KpiLibPost.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
</f:view>