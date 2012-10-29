<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
    if (rightFlag == null || "".equals(rightFlag.trim())) {
        rightFlag = "1";
    }

%>
    <script type="text/javascript">
        function refreshList(orgId) {
                document.main.location.href = "/org/chart/OrgChart.jsf?superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 60;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
<f:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr><td class="td_title">¡¡
</f:verbatim>
                <h:graphicImage value="/images/tips.gif" />
                  <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-0115","»ú¹¹Í¼")%> 
        </f:verbatim>
<f:verbatim>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp?rightFlag=<%=rightFlag%>"></iframe>
              </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" scrolling="auto" width="100%"
                                    src="/org/chart/OrgChart.jsf?superId=<%=user.getOrgId()%>"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
