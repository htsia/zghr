<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(partyId) {
            document.main.location.href = "/ccp/PartyBackQuery.jsf?flag=1&superId="+partyId;
        }

         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 39;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>


<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height="22" valign="top" class="td_title"> <img src="/images/tips.gif" />已撤销党组织维护</td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
        <tr>
            <td class="table01" id="showTree" width="159"> 
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                 src="/pages/ccp/PartyTree.jsp?rightFlag=2&paType=0"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
           </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                   src="/ccp/PartyBackQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
