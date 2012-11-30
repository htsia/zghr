<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>
<%
    String pid = CommonFuns.filterNull(request.getParameter("pk"));
    String partyName = CommonFuns.filterNull(CodeUtil.interpertCode("PA", pid));
    String type = CommonFuns.filterNull(request.getParameter("type"));
%>
 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        var fk = "<%=pid%>";
        var type = "<%=type%>";
        function refreshList(setId, setType) {
            if (setType == "1") {
                if (setId == "D001") {
                    document.main.location.href = "/ccp/PartyBaseInfo.jsf?setId=" + setId + "&flag=2&fk=" + fk + "&type=" + type;
                }else{
                    document.main.location.href = "/ccp/PartyInfoDetail.jsf?setId=" + setId + "&flag=2&fk=" + fk + "&type=" + type;
                }
            } else {
                document.main.location.href = "/ccp/PartyInfoDetailList.jsf?setId=" + setId + "&flag=2&fk=" + fk + "&type=" + type;
            }
        }

        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 50;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
     <f:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td_title">
        <tr>
            <td width="600" valign="bottom" class="title">&nbsp;&nbsp;党组织名称：<font id="show"><%=partyName%></font></td>
            <td width="20" valign="bottom"></td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table03">
        <tr>
            <td class="table01" id="showTree" width="210">
                <iframe name="tree" height="400"  frameborder="0" framespacing="0" width="100%"
                        scrolling="auto" src="/ccp/PartyItemTree.jsf?setType=D"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>
            <td align="center" valign="top" width="5">　</td>
            
              <td align="left" valign="top">
              <iframe name="main" height="100%"  frameborder="0"  width="100%" scrolling="auto" src=""></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>
</h:form>
 