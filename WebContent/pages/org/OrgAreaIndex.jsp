<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function refreshList(orgId) {
                document.main.location.href = "/org/AreaInfoAuery.jsf?flag=1&superId="+orgId+"&flag=1&pageFlag=2";

    }
     with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 30;
        $("iframe[name=tree]").height(mainHeight);
        $("iframe[name=main]").height(mainHeight);
    }
</script>

<h:form id="form1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
		    <td class="td_title">
 				<%=LanguageSupport.getResource("JGGL-1090"," 机构隶属关系 ")%>:
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                    <iframe name="tree" height="400"  frameborder="0"  scrolling="yes" width="100%"
                             src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>

           <td width="10" class="ctrlbar" valign="middle"><img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                    <iframe name="main" height="100%"  frameborder="0"  scrolling="yes" width="100%"
                            src="/org/AreaInfoAuery.jsf"></iframe>
            </td>
        </tr>
    </table>
</h:form>
