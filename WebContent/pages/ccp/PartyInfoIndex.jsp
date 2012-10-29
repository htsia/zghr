<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>
    <f:verbatim>
        <script type="text/javascript">
            function refreshList(partyId) {
                document.main.location.href = "/ccp/PartyInfoQuery.jsf?superId=" + partyId + "&flag=1&pageFlag=2";
            }
            with (window) onload = onresize = function(){
                var mainHeight = document.body.offsetHeight - 39;
                document.getElementById("tree").style.height = "" + mainHeight + "px";
                document.getElementById("main").style.height = "" + mainHeight + "px";
            }
        </script>
    </f:verbatim>

<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height="25" valign="middle" class="td_title"> <img src="/images/tips.gif" />党组织维护</td>
        </tr>
    </table>


    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
        <tr>
            <td  id="showTree" width="159">
                    <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                             src="/pages/ccp/PartyTree.jsp?paType=1"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
             </td>


            <td align="center" valign="top">
                   <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                     src="/ccp/PartyInfoQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
</c:verbatim>   
</h:form>
