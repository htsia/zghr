<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String planid=request.getParameter("planID");
    session.setAttribute("planId",planid);
%>

    <script type="text/javascript">
        function refreshList(orgId) {
               document.all("form1:selOrg").value=orgId;
               var perType=document.all("form1:personType").value;
               document.main.location.href = "/eva/EvaScoreObjectsList.jsf?planID="+document.all("planID").value+"&orgId=" + orgId+"&personType="+perType;
        }
        function forSel() {
           if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
               var orgId = document.all("form1:selOrg").value;
               var perType=document.all("form1:personType").value;
               document.main.location.href = "/eva/EvaObjectsList.jsf?orgId=" + orgId+"&personType="+perType;
           }
            return false;
        }
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight-10;
            var treeHeight = mainHeight - 32;
            document.getElementById("tree").style.height = "" + treeHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <h:inputHidden id="personType"></h:inputHidden>
    <h:inputHidden id="personTypeValue"></h:inputHidden>
    <h:inputHidden id="selOrg"></h:inputHidden>
    <f:verbatim>
    <input id="planID" type="hidden" value=<%=planid%>>
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
        <tr>
            <td class="table01" id="showTree" width="210">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="260" valign="top"  class="td_title">
    </f:verbatim>
                        <h:commandButton value="选择人员类别" onclick="return forSel()" styleClass="button01"></h:commandButton>
<f:verbatim>
                    </td>
                </tr>
                    <tr>
                        <td width="260" valign="top">
                            <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/common/ShowOrgTree.jsp"></iframe>
                        </td>
                    </tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                   <iframe  name="main" frameborder="0"  scrolling="auto" width="100%"  src="/eva/EvaScoreObjectsList.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
