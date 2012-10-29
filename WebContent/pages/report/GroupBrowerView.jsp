<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function refreshList(str){
        document.main.location.href = "/report/ArchiveReportShow.jsf?staticdate="+document.all("form1:processDate").value+"&unitId=" + str;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 40;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
</script>

<x:saveState value="#{Rpt_GroupIndexBB}"/>
<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=20 class="td_title"><img src="/images/tips.gif">集团报表查看</td>
            <td height=20 class="td_title" align="right">
              <h:outputText value="统计时间："></h:outputText>
              <h:inputText id="processDate" readonly="true" value="#{Rpt_GroupIndexBB.processDate}" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                               src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
             </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"></iframe>
            </td>
        </tr>
    </table>
</h:form>
