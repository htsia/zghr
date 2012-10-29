<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(setId, rsType) {
            document.rs.location.href = "/employee/batch/BatchAddInfo.jsf?setId=" + setId + "&flag=2";
        }

        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 50;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("rs").style.height = "" + mainHeight + "px";
        }
    </script>

<h:inputHidden value="#{emp_BatchPersonListBB.pageInit}"/>
<h:form>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="bottom" class="td_title"><img src="/images/tips.gif" />批量增加</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table03">
        <tr>
            <td width="210" align="center" valign="top" id=showTree>
                <iframe name="tree" height="100%"  frameborder="0" framespacing="0" width="100%"
                        scrolling="auto" src="/pages/ccp/batch/InfoSetTree.jsp?setType=A"></iframe>
            </td>
            
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="right" valign="top">
                <iframe name="rs" frameborder="0" framespacing="0" width="100%" scrolling="yes"
                        src="/employee/batch/BatchAddInfo.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
