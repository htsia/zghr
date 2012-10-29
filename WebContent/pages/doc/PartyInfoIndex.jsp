<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            	//alert(orgId);
                document.main.location.href = "/doc/PartyBasicInfo.jsf?setId=D001&superId="+orgId;
        }
       
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title">　党组织信息</td>
        </tr>
    </table>
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top">
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                src="/pages/ccp/PartyTree.jsp?rightFlag=1&paType=1"></iframe>
                    </td>
                </tr>
            </table>
           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            
            <td align="center" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                   src="/doc/PartyBasicInfo.jsf"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</h:form>
