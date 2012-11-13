<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.all('form1:superId').value=orgId;
            var planId=document.all('form1:planId').value;
            document.main.location.href = "/xys/eva/SelPostList.jsf?flag=1&superId="+orgId
                    +"&showMode=1&planId="+planId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
        function selEvaPost(value){
            window.returnValue=value;
            window.close();
        }
    </script>

<x:saveState value="#{xys_PlanPostMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{xys_PlanPostMgrBB.initIndex}"/>
    <h:inputHidden id="superId" value="#{xys_PlanPostMgrBB.superId}"/>
    <h:inputHidden id="planId" value="#{xys_PlanPostMgrBB.planId}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->查看考核岗位

           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/xys/eva/SelPostList.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
