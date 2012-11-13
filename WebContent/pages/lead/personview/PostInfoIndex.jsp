<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    <script type="text/javascript">
        var scale = "";

        function refreshList(postId) {
               document.main.location.href = "/doc/SinglePostBookQuery.jsf?postid="+postId;
        }
        function queryPerson() {
        	var obj11 = document.all("input1Name");
            var sql = "<%=com.hr319wg.util.CommonFuns.filterNull(request.getParameter("filterSQL"))%>";
            if(scale != ""){
                sql = sql + " and p.orgTreeId like '" + scale + "%'";
            }
            retval = window.showModalDialog("/doc/QueryPostResult.jsf?filterSQL=" + sql + "&postName=" + obj11.value, "", "dialogWidth:800px; dialogHeight:600px; center:yes; status:1;");
            if(retval!=null){
			  document.tree.location.href = "/pages/doc/DocPostTree.jsp?filterSQL=<%=CommonFuns.filterNull(request.getParameter("filterSQL"))%>&personId="+retval;
			  document.main.location.href = "/doc/PostIndex.jsf?postid="+retval+"&fk="+retval;
		  }
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title" colspan="3">
                <img src="/images/tips.gif">岗位说明书浏览 &nbsp;&nbsp;&nbsp;
				<input type="text" name="input1Name" id="input1Name" class="input">
				<input type="button" onclick="javascript:queryPerson();" class="button01" value=" 查询 ">
                <span id="scaleName"></span>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td id="showTree" width="200">
                    <iframe name="tree" height="400"  frameborder="0"  scrolling="auto" width="220"  src="/pages/doc/DocPostTree.jsp"></iframe>
           </td>

           <td width="6" class="ctrlbar" id="ctrlbar" valign="middle" >
               <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
           </td>

            <td align="center" valign="top" class="explorer">
                    <iframe name="main" height="100%"  frameborder="0"  scrolling="no" width="100%"       src="/doc/SinglePostBookQuery.jsf"></iframe>
            </td>
        </tr>
    </table>
</c:verbatim>