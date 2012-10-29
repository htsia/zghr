<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String pk = request.getParameter("pk");
    User user = (User)session.getAttribute(Constants.USER_INFO);
    if (pk == null || "".equals(pk)) {
        if (request.getParameter("fk")!=null && !"".equals(request.getParameter("fk"))) {
            pk=request.getParameter("fk");
        }
        else{
            pk = user.getUserId();
        }
    }
%>

    <script type="text/javascript">
        var fk = "<%=pk%>";
        function refreshList(setId, rsType) {
            if (rsType == "1") {
                document.rs.location.href = "/self/info/PersonInfoDetail.jsf?setId=" + setId + "&fk=" + fk;
            } else {
                document.rs.location.href = "/self/info/PersonInfoDetailList.jsf?setId=" + setId + "&fk=" + fk;
            }
        }

        function forPrint() {
            var rel = document.all("perFlagId").value;
            windowOpen("/pages/employee/DocPrint.jsf?id=" + rel , "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
        }
        function doShowCard(){
            showPersonCard(fk);
        }

        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("rs").style.height = "" + mainHeight + "px";
        }
    </script>
<body scroll="no">
<h:form id="form1">
<c:verbatim>
<input type="hidden" name="perFlagId" value="<%=pk%>"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td  height="10" colspan=2></td>
    </tr>
    <tr>
        <td  valign="center" class="td_title"><img src="/images/tips.gif" alt="">
            <%
                PersonBO pb = SysCacheTool.findPersonById(pk);
                out.print("人员姓名："+pb.getName()+"&nbsp;&nbsp;");
                out.print("人员编号:"+pb.getPersonCode());
            %>
        </td>
    </tr>
</table>

<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0" class="table03">
    <tr>
        <td width="180" align="center" valign="top" id=showTree>
            <iframe name="tree" frameborder="0"  width="100%"  scrolling="auto" src="/pages/self/info/InfoSetTree.jsp"></iframe>
        </td>
        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
        </td>
        <td align="right" valign="top">
             <iframe name="rs" frameborder="0"  width="100%" scrolling="auto" src="/self/info/PersonInfoDetail.jsf?setId=A001&fk=<%=pk%>"></iframe>
        </td>
   </tr>
 </table>
</c:verbatim>
 </h:form>
</body>