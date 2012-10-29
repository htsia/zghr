<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String orgId = CodeUtil.interpertCode("OU",CommonFuns.filterNull(request.getParameter("orgId")));
%>

    <script type="text/javascript">
         function clearws() {
		    document.getElementById("checkSubmitFlg").value="0";
        }

        function clearStatew() {
            setInterval("clearws()",2000);
        }

         function showProcessBar() {
            x = document.body.clientWidth / 2 - 150;
            y = document.body.clientHeight / 2;
            document.all('processbar').style.top = y;
            document.all('processbar').style.left = x;
            document.all('processbar').style.display = "";
            return true;
         }

    </script>

    <x:saveState value="#{qry_namelistBB}"/>
    <h:inputHidden id="orgId" value="#{qry_namelistBB.orgId}"/>
    <h:form id="form1">
    <c:verbatim>
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" height=98%>
        <tr>
            <td height=8> <%=LanguageSupport.getResource("JGGL-1073","机构名称 ")%>：<%=orgId%></td>
            <td height=8>
             <%=LanguageSupport.getResource("RYGL-2419","人员名单 ")%>
</c:verbatim>
                <h:selectOneMenu id="mType" value="#{qry_namelistBB.listID}" >
                    <f:selectItems value="#{qry_namelistBB.nameList}"/>
                </h:selectOneMenu>
                <h:commandButton value="显示" styleClass="button01" onclick="return showProcessBar();" action="#{qry_namelistBB.queryPersonDeptList}"></h:commandButton>
<c:verbatim>
            </td>
        </tr>
        <tr><td colspan=2 valign="top">
            <jsp:include page="/pages/employee/QueryPersonList.jsp"></jsp:include>
        </td></tr>
    </table>

</c:verbatim>
    </h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr>
    </table>
</marquee>