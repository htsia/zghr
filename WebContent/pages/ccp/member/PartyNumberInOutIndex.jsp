<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>

<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
     
     
%>

    <script type="text/javascript">
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("rs").style.height = "" + mainHeight + "px";
        }
        function ctrlbar() {
            if (document.all.showTree.style.display == "") {
                document.all.showTree.style.display = "none"
                document.all.ctrlBnt.src = '../../images/button_2.gif';
            } else {
                document.all.showTree.style.display = ""
                document.all.ctrlBnt.src = '../../images/button_1.gif';
            }
        }
   </script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="td_title"><img src="../../images/tips.gif" alt="" >党员流动信息查询</td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" >
    <tr>
        <td width="160" align="center" valign="top" class="explorer" id="showTree">
                <iframe name="tree" height="100%"  frameborder="0"  width="100%" scrolling="auto"
                        src="/ccp/member/PartyQueryTypeView.jsf"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id="ctrlBnt" src="../../../images/button_1.gif"    onclick="ctrlbar()" style="cursor:pointer ">
        </td>

        <td align="center" valign="top" class="explorer">
                <iframe name="main" height="100%"  frameborder="0"  width="100%" scrolling="auto" height="600"  ></iframe>
        </td>
    </tr>
</table>
