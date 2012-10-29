<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" language="javascript">
        function refreshList(sueprID) {
                document.list.location = "/lead/TextResult.jsf?resId=" + document.all('form1:resId').value+"&superID="+sueprID;
        }
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 46;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("list").style.height = "" + mainHeight + "px";
        }
    </script>
<x:saveState value="#{textget}"/>
<h:form id="form1">
<h:inputHidden value="#{textget.initUnitShow}"></h:inputHidden>
<h:inputHidden id="resId" value="#{textget.resId}"></h:inputHidden>
<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title">
        <img src="/images/tips.gif">
</c:verbatim>
        <h:outputText value="#{textget.showname}"></h:outputText>
<c:verbatim>
        </td>
    </tr>
    <tr>
        <td align="center" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" class="explorer" id="showTree" width="210">
                               <iframe name="tree" frameborder="0"  scrolling="auto" width="100%"  src="/pages/lead/UnitTree.jsp"></iframe>
                    </td>

                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
                    </td>

                    <td align="center" valign="top" class="explorer">
                                    <iframe name="list" frameborder="0"  scrolling="auto" width="100%"   src="/lead/TextResult.jsf"></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</c:verbatim>        
</h:form>
