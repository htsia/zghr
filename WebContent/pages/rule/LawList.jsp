<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function refreshList(orgId) {
        document.main.location.href = "/rule/LawListChild.jsf?superId=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    function doQueryLaw(){
        window.showModalDialog("/rule/LawIndex.jsf", null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
</script>

<h:form id="form1">
	  <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="·¨¹æä¯ÀÀ"/>
        </h:panelGroup>
         <h:panelGrid align="right">
             <h:commandButton value="¼ìË÷" type="button" styleClass="button01" onclick="doQueryLaw();"></h:commandButton>
         </h:panelGrid>
      </h:panelGrid>
    
      <c:verbatim>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                    <iframe name="tree" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                            src="/pages/common/ShowLawType.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                    <iframe name="main" frameborder="0" framespacing="0" scrolling="no" width="100%"
                            src="/rule/LawListChild.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>


