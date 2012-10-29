<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    User user=(User)session.getAttribute(Constants.USER_INFO);
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.all('form1:superId').value=orgId;
            var planId=document.all('form1:planId').value;
            document.main.location.href = "/xys/eva/PersonKpiDataCtrInfo.jsf?superId="+orgId
                    +"&planId="+planId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
        function exportError(id) {
    	    window.open("/pages/xys/eva/PersonKpiDataExport.jsp?planId="+id);
    	    return true;
    	}
    </script>

<x:saveState value="#{person_KpiAuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{person_KpiAuditCtrBB.initDataCtr}"/>
    <h:inputHidden id="superId" value="#{person_KpiAuditCtrBB.superId}"/>
    <h:inputHidden id="planId" value="#{person_KpiAuditCtrBB.planId}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                        绩效管理 ->个人KPI数据合法性监控
           </td>
           <td class="td_title">
               </c:verbatim>
               <h:commandButton value="导出不合法数据" onclick="exportError('#{person_KpiAuditCtrBB.planId}')" styleClass="button01"></h:commandButton>
               <c:verbatim>
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/xys/eva/PersonKpiDataCtrInfo.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
