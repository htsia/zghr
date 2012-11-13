<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function refreshList(orgId) {
        //alert(orgId);
        document.main.location.href = "/train/CWMoreChild.jsf?superID=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 50;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>

<h:form id="form1">
	  <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="ÅàÑµ¿Î¼þÁÐ±í"/>
        </h:panelGroup>
      </h:panelGrid>
      <c:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                            <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                    src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                    src="/train/CWMoreChild.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>


