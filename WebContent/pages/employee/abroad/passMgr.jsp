<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO"%>

<%@ include file="../../include/taglib.jsp" %>


    <script type="text/javascript">
        function refreshList(orgId) {
                document.main.location.href = "/employee/abroad/PersonPassQuery.jsf?flag=1&superId=" + orgId;
        }
        function forChange() {
            if (document.getElementById("form1:mType").value == "1") {
                document.tree.location.href = "/pages/common/ShowOrgTree.jsp";
                document.main.location.href = "/employee/abroad/PersonPassQuery.jsf";
            } else {
                document.tree.location.href = "/pages/ccp/PartyTree.jsp?rightFlag=2";
                document.main.location.href = "/ccp/member/InfoQuery.jsf";
            }
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
    <f:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 
               <%=LanguageSupport.getResource("RYGL-0300","人员管理 ")%> ->
              <%=LanguageSupport.getResource("RYGL-1330","出国管理")%>           
                           
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
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>

            <td align="center" valign="top">
                 <iframe name="main" frameborder="0"  scrolling="no" width="100%"
                                    src="/employee/abroad/PersonPassQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>    
</h:form>
