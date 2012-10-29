<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


    <script type="text/javascript">
        function refreshList(personId) {
            document.main.location.href ="<%=Constants.LEAD_SHOW_PERSONURL%>?ShowReport=false&flag=2&fk="+personId+"&typeId=2001010000,2001010100&setId=A001"
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
    <tr><td width="100%" class="td_title">
        <img src="/images/tips.gif" alt=""> 浏览本部门员工
    </td></tr>
    </table>

<table width="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td  id="showTree" width="25%">
                    <iframe name="tree" frameborder="0"  scrolling="auto" width="100%"
                             src="/pages/lead/personview/DeptPersonTree.jsp?filterSQL=p.personType in ('<%=Constants.IN_SERVICE_TYPE.replaceAll(",","','")%>')"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
        </td>


        <td align="center" valign="top" class="explorer">
                        <iframe name="main" frameborder="0"  scrolling="auto" width="100%"    src=""></iframe>
        </td>
    </tr>
</table>
</c:verbatim>
</script>
