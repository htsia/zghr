<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String pk = request.getParameter("pk");
    if(pk == null || "".equals(pk.trim())){
        pk = (String)request.getAttribute("P_ORGID");
    }
    String type = CommonFuns.filterNull(request.getParameter("type"));
    String cancel = CommonFuns.filterNull(request.getParameter("cancel"));

    OrgBO org = SysCacheTool.findOrgById(pk);
%>

    <script type="text/javascript">
        var fk = "<%=pk%>";
        var type = "<%=type%>";
        function refreshList(setId, rsType) {
            if (rsType == "1") {
                document.rs.location.href = "/org/info/OrgInfoDetail.jsf?setId=" + setId + "&flag=2&fk=" + fk + "&type=" + type;
            } else {
                document.rs.location.href = "/org/info/OrgInfoDetailList.jsf?setId=" + setId + "&flag=2&fk=" + fk + "&type=" + type;
            }
        }

        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 29;
            $("iframe[name=tree]").height(mainHeight);
            document.getElementById("rs").style.height = "" + mainHeight + "px";
        }
        function changeInfo(){
            var url="/org/info/ChangeInfo.jsf?FieldList=B001005,B001701&ID="+<%=org.getOrgId()%>;
            window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
            return false;
        }
    </script>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title" height='20px'><img src="/images/tips.gif" alt="">
        <%
            out.print(LanguageSupport.getResource("JGGL-1073"," 机构名称")+":"+org.getName()+"&nbsp;&nbsp;");
            out.print(LanguageSupport.getResource("JGGL-1119"," 机构唯一标识")+":"+org.getOrgId()+"&nbsp;&nbsp;");
            out.print(LanguageSupport.getResource("JGGL-1120"," 机构代码")+":"+CommonFuns.filterNull(org.getOrgCode())+"&nbsp;&nbsp;");
        %>
        </td>
        <td align="right" class="td_title">
            <%
                if ("1".equals(Constants.ORG_OPEN_BASICINFO_MODI)){
            %>
            <input value="<%=LanguageSupport.getResource("JGGL-1121"," 基本信息变更") %>" onclick="changeInfo();" type="button"  class="button01">
            <%
                }
            %>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="180" align="center" valign="top" id=showTree>
           <iframe name="tree" height="400"  frameborder="0"  width="100%"
                                scrolling="auto" src="/pages/common/InfoItemTree.jsp?setType=B"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
        </td>

        <td align="right" valign="top">
               <iframe name="rs" frameborder="0"  width="100%"  scrolling="auto" src="/org/info/OrgInfoDetail.jsf?setId=B001&flag=2&fk=<%=pk%>&type=<%=type%>"></iframe>
         </td>
</table>