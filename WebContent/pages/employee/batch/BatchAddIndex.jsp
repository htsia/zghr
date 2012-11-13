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
                document.main.location.href = "/employee/batch/BatchAddQuery.jsf?flag=1&superId=" + orgId;
        }

        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <h:panelGrid width="100%" border="0" cellspacing="0" cellpadding="0" styleClass = "td_title">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <f:verbatim>
             <%=LanguageSupport.getResource("RYGL-0300","Ա������")%> ->
              <%=LanguageSupport.getResource("RYGL-0316"," �������� ")%>   
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
                                    src="/employee/batch/BatchAddQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>
</h:form>
