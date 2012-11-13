<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/employee/info/PersonRetireQuery.jsf?backFlag=2&flag=1&superId=" + orgId+"&mode="+document.all("mode").value+"&title="+document.all("title").value+"&afterType="+document.all("afterType").value;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
<%
    String mode = CommonFuns.filterNull(request.getParameter("mode"));
    String afterType=CommonFuns.filterNull(request.getParameter("afterType"));
    String title = "";
    if ("TOMCAT".equals(CommonFuns.getAppType())) {
        title = CommonFuns.getParaFromURL(request.getQueryString(), "title");
    } else {
        title=request.getParameter("title");
    }
%>
<h:form id="form1">
    <input type="hidden" name="mode" value=<%=mode%> >
    <input type="hidden" name="title" value=<%=title%> >
    <input type="hidden" name="afterType" value=<%=afterType%> >

    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
             <%=CodeUtil.interpertCode(CodeUtil.TYPE_MODULEID, OperateBO.CHANGEMODULEID) %>->
              <%
                   out.println(title);
              %>
            </td>
            <td class="td_title" align="right">
                 <%
                     if ("1".equals(Constants.EMP_REDUCE_AFTER_APPROVE) || "2".equals(Constants.EMP_REDUCE_AFTER_APPROVE)) {
                         out.print("<font color=red>注意：减员需审批后才可以生效</font>");
                     }
                     if ("2".equals(Constants.EMP_REDUCE_AFTER_APPROVE)) {
                         out.println("<input type='button' class='button01' value='流程说明' onclick='showWorkDefine(\"" + WFTypeBO.RYGL_COMMON_OUT + "\")'>");
                     }
                 %>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                    <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" height="400" width="100%"
                           src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                    <iframe name="main" height="100%"  frameborder="0"  scrolling="no" height="400" width="100%"
                            <%
                              out.println("src='/employee/info/PersonRetireQuery.jsf?mode="+mode+"&afterType="+afterType+"'");
                            %>
                            >
                    </iframe>
            </td>
        </tr>
    </table>
</h:form>
