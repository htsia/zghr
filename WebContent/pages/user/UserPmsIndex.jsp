<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
               document.all("form1:selOrg").value=orgId;
               var perType=document.all("form1:personType").value;
               document.main.location.href = "/user/UserPmsManager.jsf?orgId=" + orgId+"&personType="+perType;
        }
                
        function forSel() {
           if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
               var orgId = document.all("form1:selOrg").value;
               var perType=document.all("form1:personType").value;
               document.main.location.href = "/user/UserPmsManager.jsf?orgId=" + orgId+"&personType="+perType;
           }
            return false;
        }

        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight-10;
            var treeHeight = mainHeight - 30;
            document.getElementById("tree").style.height = "" + treeHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
</head>


<h:form id="form1">
    <h:inputHidden id="personType"></h:inputHidden>
    <h:inputHidden id="personTypeValue"></h:inputHidden>
    <h:inputHidden id="selOrg"></h:inputHidden>
    <f:verbatim>
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
        <tr>
            <td class="table01" id="showTree" width="210">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="260" valign="top" class="td_title" height="10%">
     </f:verbatim>
                            <h:commandButton value="选择人员类别" onclick="return forSel()" styleClass="button01"></h:commandButton>
     <f:verbatim>
                        </td>
                   </tr>
                   <tr>
                        <td width="260" valign="top" >
                            <iframe name="tree" height="100%"  frameborder="0"  height="450" scrolling="yes" width="100%"
                                    src="/pages/common/ShowOrgTree.jsp"></iframe>
                        </td>
                    </tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top" width="5">　</td>

            <td align="center" valign="top">
                  <iframe name="main" height="100%"  frameborder="0" height="450" scrolling="auto" width="100%"
                                src="/user/UserPmsManager.jsf?orgId="></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
