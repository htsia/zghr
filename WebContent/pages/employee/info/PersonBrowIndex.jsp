<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            var filter='';
            <%
               if (request.getParameter("filter")!=null && !"".equals(request.getParameter("filter"))){
                  out.println("   filter=\""+request.getParameter("filter")+"\";");
               }
            %>
            document.main.location.href = "/employee/info/PersonBrowChild.jsf?superId=" + orgId+"&filter="+filter;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">  <%= LanguageSupport.getResource("RYGL-2366", "浏览人员信息")%>  &nbsp;-&nbsp;
            <%
                String title="";
                if ("TOMCAT".equals(CommonFuns.getAppType())) {
                    title = CommonFuns.getParaFromURL(request.getQueryString(), "Title");
                } else {
                    title=request.getParameter("Title");
                }
                title=CommonFuns.filterNull(title);
                out.println(title);
            %>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                   <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                               src="/pages/common/ShowOrgTree.jsp"></iframe>
             </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
             </td>
            
            <td align="center" valign="top">
               <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%" src="/employee/info/PersonBrowChild.jsf"></iframe>
            </td>
        </tr>
    </table>
</h:form>
