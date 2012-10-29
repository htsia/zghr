<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
              document.main.location.href = "/employee/info/PersonBackQuery.jsf?flag=1&backFlag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif" alt=""> 
              <%=LanguageSupport.getResource("RYGL-0300","员工管理  ")%> ->
              <%=LanguageSupport.getResource("RYGL-0331","后备人才维护")%>  
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                    <iframe name="tree" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                            src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                    <iframe name="main" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                            src="/employee/info/PersonBackQuery.jsf?backFlag=1"></iframe>
            </td>
        </tr>
    </table>
</c:verbatim>    
</h:form>
