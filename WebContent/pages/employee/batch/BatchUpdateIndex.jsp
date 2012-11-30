<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    <script type="text/javascript">
        function refreshList(orgId) {
                document.main.location.href = "/employee/batch/BatchUpdateQuery.jsf?flag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight -40;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>
</c:verbatim>
    <h:form id="form1">
        <h:panelGrid width="100%" border="0" cellspacing="0" cellpadding="0" styleClass = "td_title">
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                 <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0300","员工管理")%> ->
              <%=LanguageSupport.getResource("RYGL-0317"," 批量修改 ")%>   
            </f:verbatim>
            </h:panelGroup>
        </h:panelGrid>

        <f:verbatim>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td id="showTree" width="210">
                            <iframe name="tree" height="400"  frameborder="0"  scrolling="yes" width="100%"
                                    src="/pages/common/ShowOrgTree.jsp"></iframe>
                </td>

                <td width="10" class="ctrlbar" valign="middle">
                    <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

                <td align="center" valign="top">
                                <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%"
                                        src="/employee/batch/BatchUpdateIndex.jsf"></iframe>
                </td>
            </tr>
        </table>
 </f:verbatim>
    </h:form>
