<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/employee/probation/ProbationPersonAduitList.jsf?superId=" + orgId+"&OperID="+document.all('form1:operate').value;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 34;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <h:inputHidden value="#{empprobastionaduitBB.init}"></h:inputHidden>
    <h:inputHidden id="operate" value="#{empprobastionaduitBB.operate}"></h:inputHidden>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title">
    </c:verbatim>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="#{empprobastionaduitBB.opername}"/>
     <c:verbatim>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" frameborder="0"  scrolling="auto" width="100%"
                               src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
             </td>
            <td align="center" valign="top">
                    <iframe name="main" frameborder="0"  scrolling="auto" width="100%"
                           src="/employee/probation/ProbationPersonAduitList.jsf">
                     </iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
