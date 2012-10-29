<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        <%
            String title = "";
            if ("TOMCAT".equals(CommonFuns.getAppType())) {
                title = CommonFuns.getParaFromURL(request.getQueryString(), "Title");
            } else {
                title=request.getParameter("Title");
            }
            String oldtype = request.getParameter("oldtype");
            String newtype = request.getParameter("newtype");
            String operId = request.getParameter("OperId");
         %>
        function refreshList(orgId) {
            document.main.location.href = "/employee/info/changetypeChild.jsf?OperId=<%=operId%>&newtype=<%=newtype%>&flag=1&oldtype=<%=oldtype%>&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<c:verbatim>
    <input type="hidden" name="mode" value=<%String mode=request.getParameter("mode"); out.print(mode);%> >
    <input type="hidden" name="operId" value='<%=operId%>' >
</c:verbatim>
<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 
                <%
                    out.println(LanguageSupport.getResource("RYGL-0300","人员管理")+"->"+CommonFuns.filterNull(title));
                %>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                 <iframe name="tree" frameborder="0"  scrolling="yes" width="100%"
                               src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                    <iframe name="main" frameborder="0" scrolling="yes" width="100%"
                        <%
                          out.println("src=\"/employee/info/changetypeChild.jsf?newtype="+newtype+"&flag=1&oldtype="+oldtype+"&operId="+operId+"\"");
                        %>
                     ></iframe>
            </td>
        </tr>
    </table>
</h:form>
