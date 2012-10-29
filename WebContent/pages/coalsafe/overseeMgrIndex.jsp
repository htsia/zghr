<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>

    <script type="text/javascript">
        function refreshList(orgId) {
                document.main.location.href = "/coalsafe/overseeMgr.jsf?orgId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
        function caclItems(){
       	 window.showModalDialog("/coalsafe/caclAmerce.jsf", null, "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
       }
    </script>

<h:form id="form1">
    <f:verbatim>
    <input type="hidden" id="flag" value="1">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">员工管理 ->　信息维护</td>
            <td class="td_title">
            	</f:verbatim>
            		<h:commandButton value="统计违法情况"  styleClass="button01" onclick="caclItems();"></h:commandButton>
            	<f:verbatim>
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
                                    src="/coalsafe/overseeMgr.jsf"></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>    
</h:form>
