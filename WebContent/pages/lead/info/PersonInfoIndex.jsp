<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/lead/info/PersonInfoQuery.jsf?OperID="+document.all("form1:operateID").value+"&flag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<x:saveState value="#{lead_personListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{lead_personListBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="operateID" value="#{lead_personListBB.operateID}"></h:inputHidden>
    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 查询所属员工信息
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                            <iframe name="tree" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                    src="/pages/common/LeadQueryShowOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>

            <td align="center" valign="top">
                <%
                    out.println("<iframe name='main' frameborder='0'  scrolling='no' width='100%'  src='/lead/info/PersonInfoQuery.jsf?flag=1&OperID=" + CommonFuns.filterNull(request.getParameter("OperID")) + "'></iframe>");
                %>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
