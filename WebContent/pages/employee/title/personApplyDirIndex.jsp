<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function refreshList(orgId) {
        document.all("form1:currentID").value=orgId;
        document.main.location.href = "/employee/title/personApplyScoreItem.jsf?scoreId="+orgId+"&showType="+document.all("form1:showType").value;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>
<x:saveState value="#{persontitleapplyBB}"></x:saveState>
<h:form id="form1">
	  <h:inputHidden value="#{persontitleapplyBB.initItemDir}"></h:inputHidden>
	  <h:inputHidden id="currentID" value="#{persontitleapplyBB.currentId}"></h:inputHidden>
	  <h:inputHidden id="itemId" value="#{persontitleapplyBB.itemId}"></h:inputHidden>
	  <h:inputHidden id="showType" value="#{persontitleapplyBB.showType}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="Ö°³ÆÆÀÉóÄÚÈÝÉèÖÃ"></h:outputText>
        </h:panelGroup>
      </h:panelGrid>

       <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="400"  frameborder="1"  scrolling="auto" width="100%"
                                    src="/pages/employee/title/personApplyDirTree.jsp"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%"
                                    src="/employee/title/personApplyScoreItem.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


