<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" language="javascript">
        function refreshList(orgId) {
                document.main.location.href = "/lead/ShowHtmlChild.jsf?ResID="+document.all('form1:resID').value+"&superId=" + orgId;
        }

        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
<x:saveState value="#{htmlBackingBean}"/>
<h:form id="form1">
    <h:inputHidden value="#{htmlBackingBean.initShow}"></h:inputHidden>
    <h:inputHidden id="resID" value="#{htmlBackingBean.resID}"></h:inputHidden>
    <c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title">
    <img src="/images/tips.gif">
    </c:verbatim>
        <h:outputText value="#{htmlBackingBean.title}"></h:outputText>
     <c:verbatim>
        </td>
    </tr>
    <tr>
        <td align="center" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" class="explorer" id="showTree" width="210">
                        <iframe name="tree" frameborder="0"  scrolling="yes" width="100%"
                                            src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
                    </td>

                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
                    </td>

                    <td align="center" valign="top" class="explorer">
                        <iframe name="main" frameborder="0"  scrolling="auto" width="100%"    src=""></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
    </c:verbatim>
</h:form>