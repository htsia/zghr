<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
User user = (User) (session.getAttribute(Constants.USER_INFO));
String rootid = user.getOrgId();
String itemType = request.getParameter("itemType");
%>
<script type="text/javascript">
        function refreshList(orgId) {       
            document.main.location.href = "/custom/att/attEleCheckinList.jsf?act=init&createType=1&orgID=" + orgId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 34;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
<f:view>
<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">µç×ÓÇ©µ½</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
	            <iframe name="tree" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
	                   src="/pages/common/ShowOrgTree.jsp?rootId=<%=rootid%>"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top">
				<iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%" src="/custom/att/attEleCheckinList.jsf?act=init&createType=1"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
</f:view>
