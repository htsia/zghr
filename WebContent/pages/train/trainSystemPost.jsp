<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function refreshList(orgId) {
        document.all("form1:currentID").value=orgId;
        document.main.location.href = "/train/trainSystemPostList.jsf?superId="+orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>

<h:form id="form1">
	  <h:inputHidden id="currentID" value="#{trainSystemPostBB.currentID}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="培训体系管理"></h:outputText>
        </h:panelGroup>
      </h:panelGrid>

       <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="230">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
                        </td>
                    </tr>
                    <tr><td height="8px">
                   		<table>
                   			<tr>
                   				<td align="center"  class=tab><a href="trainSystem.jsf">按类型分</a></td>
                				<td align="center"  class=activeTab><a href="trainSystemPost.jsf">按岗位分</a></td>
                   			</tr>
                   		</table>
                    </td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" frameborder="1"  scrolling="auto" width="100%"
                                    src="/pages/train/showPostList.jsp"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" frameborder="0"  scrolling="auto" width="100%"
                                    src="/train/trainSystemPostList.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


