<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId,treeId) {
            document.main.location.href = "/datachk/VerifyItemList.jsf?orgId="+orgId+"&treeId="+treeId;
        }
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 39;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
        <tr>
            <td colspan=3 class="td_title">
    </c:verbatim>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 信息校验"/>
<c:verbatim>
            </td>
        </tr>
        <tr>
            <td class="table01" id="showTree" width="159">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                height="465" src="/pages/datachk/VerifyItemOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                   <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                    height="465" src="/datachk/VerifyItemList.jsf"></iframe>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
