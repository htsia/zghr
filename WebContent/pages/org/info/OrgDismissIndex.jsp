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
                document.main.location.href = "/org/info/OrgDismissQuery.jsf?flag=1&superId="+orgId;
        }
         with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 50;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
<f:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
		    <td class="td_title">¡¡<img src="/images/tips.gif" >
		        <%=LanguageSupport.getResource("JGGL-0104"," »ú¹¹³·Ïú")%>  
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
             </td>
           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>
            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                                    src="/org/info/OrgDismissQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>
