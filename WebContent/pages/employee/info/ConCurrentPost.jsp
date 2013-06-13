<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
	User user = (User)session.getAttribute(Constants.USER_INFO);
	String rootid = user.getOrgId();
	String superID=user.getOrgId();
    List<OrgBO> orgList= user.getHaveOperateOrgScale();
    if(orgList!=null && orgList.size()>0){
    	superID=orgList.get(0).getOrgId();
    }
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/employee/info/ConCurrentPostList.jsf?superId=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
               
              <%=LanguageSupport.getResource("RYGL-0300","员工管理")%> ->
              <%=LanguageSupport.getResource("RYGL-0327","跨单位兼职管理")%>
                    </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                <iframe name="tree" height="400" frameborder="0" scrolling="auto" width="100%" src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>
            <td align="center" valign="top">
	            <iframe name="main" height="100%" frameborder="0" scrolling="auto" width="100%"
	                   src="/employee/info/ConCurrentPostList.jsf??act=init&superId=<%=superID %>"></iframe>
            </td>
        </tr>
    </table>
</h:form>
