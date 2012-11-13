<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<script type="text/javascript">
    function refreshList(orgId) {
            if (orgId!='<%=Constants.ORG_BENBU%>'){
                document.main.location.href = "/lead/chart/OrgChart.jsf?superId=" + orgId;
            }
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 30;
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
                <h:outputText value="»ú¹¹ä¯ÀÀ"></h:outputText>
<f:verbatim>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"
                                src="/pages/common/LeadQueryShowOnlyOrgTree.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                    <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                            src="/lead/chart/OrgChart.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
