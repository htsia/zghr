<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<%
    String paperId=request.getParameter("paperID");
%>
    <script type="text/javascript">
        function refreshList(unitId) {
            document.main.location.href = "/system/survey/SurveyDetail.jsf?act=init&paperID=<%=paperId%>&unitId="+unitId;
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
            <td height=20 class="td_title"><img src="/images/tips.gif">问卷调查明细查询</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                   <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%" src="/pages/common/ShowOrgTree.jsf"></iframe>
             </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>
            <td align="center" valign="top">
                   <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%" src="/system/survey/SurveyDetail.jsf?act=init&paperID=<%=paperId%>"></iframe>
            </td>
        </tr>
    </table>
   </c:verbatim>
</h:form>
