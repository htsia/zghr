<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" language="javascript">
        function refreshList(sueprID) {
                document.list.location = "/lead/GridResult.jsf?resId=" + document.all('form1:resId').value+"&superID="+sueprID;
        }
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 46;
            $("iframe[name=tree]").height(mainHeight);
            document.getElementById("list").style.height = "" + mainHeight + "px";
        }
    </script>

<x:saveState value="#{gridget}"/>
<h:form id="form1">
<h:inputHidden value="#{gridget.initUnitShow}"></h:inputHidden>
<h:inputHidden id="resId" value="#{gridget.resId}"></h:inputHidden>
<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title">
        <img src="/images/tips.gif">
</c:verbatim>
        <h:outputText value="#{gridget.showname}"></h:outputText>
<c:verbatim>
        </td>
    </tr>
    <tr>
        <td align="center" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" class="explorer" id="showTree" width="210">
                               <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="100%"  src="/pages/lead/UnitTree.jsp"></iframe>
                    </td>

                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
                    </td>

                    <td align="center" valign="top" class="explorer">
                                    <iframe name="list" frameborder="0"  scrolling="auto" width="100%"   src="/lead/GridResult.jsf"></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</c:verbatim>
</h:form>
