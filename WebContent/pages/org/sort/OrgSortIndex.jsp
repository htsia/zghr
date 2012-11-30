<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
                document.main.location.href = "/org/sort/OrgSort.jsf?flag=1&superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 70;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
<f:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr><td class="td_title">　
</f:verbatim>
               <h:graphicImage value="/images/tips.gif" />
                <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-0114","字更電會")%> 
        </f:verbatim>
<f:verbatim>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/org/sort/OrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>
            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                    src="/org/sort/OrgSort.jsf">
                             </iframe>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
