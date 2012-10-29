<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>

<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String setType = request.getParameter("setType"); // 数据来源
    String qsType = request.getParameter("qsType");    // 操作类型
    String unitType = request.getParameter("unitType"); // 机构类型
    session.setAttribute("CONTRAL_SAVE","");
    String classId=CommonFuns.filterNull(request.getParameter("classID"));
    if (setType == null || "".equals(setType))
        setType = "A";
    if (qsType == null || "".equals(qsType))
        qsType = "Q";
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user == null)
        user = new User();
    String privateTreeRoot = qsType + setType + user.getUserId();
    String operFlag=request.getParameter("operFlag");
    if  (operFlag==null){
        operFlag="1";
    }
    String para ="";
    if (!"".equals(classId)){
       para="?qsType=" + qsType + "&setType=" + setType + "&unitType=" + unitType + "&classId=" + classId + "&publicFlag=PRIVATE&operFlag="+operFlag;
    }
    else{
       para="?qsType=" + qsType + "&setType=" + setType + "&unitType=" + unitType + "&classId=" + privateTreeRoot + "&publicFlag=PRIVATE&operFlag="+operFlag;
    }
    if("Q".equals(qsType))
        para = "/qry/QueryList.jsf" + para;
    else
        para = "/qry/StaticList.jsf" + para;
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
    <td class="td_title"><img src="../../images/tips.gif" alt="" >　<%=("S".equals(request.getParameter("qsType")) ? "统计" : "查询")%>处理</td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" >
    <tr>
        <td width="240" align="center" valign="top" class="explorer" id="showTree">
               <iframe name="tree" height="100%"  frameborder="0"  width="100%" scrolling="auto"
                        src="/qry/QueryClass.jsf?operFlag=<%=operFlag%>&classID=<%=CommonFuns.filterNull(request.getParameter("classID"))%>&qsType=<%=CommonFuns.filterNull(request.getParameter("qsType"))%>&setType=<%=CommonFuns.filterNull(request.getParameter("setType"))%>&unitType=<%=CommonFuns.filterNull(request.getParameter("unitType"))%>"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id="ctrlBnt" src="/images/button_1.gif"    onclick="ctrlbar()" style="cursor:pointer ">
        </td>

        <td align="center" valign="top" class="explorer">
                <iframe name="rs" frameborder="0"  width="100%" scrolling="auto"   src="<%=para%>"></iframe>
        </td>
    </tr>
</table>
