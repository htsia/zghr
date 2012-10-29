<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>
<%
response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

			%>

<html>
<head>
<title>人员档案浏览</title>
<link rel="stylesheet" type="text/css"	href="<%=request.getContextPath()%>/css/style.css" />

<script language="javascript"
	src="<%=request.getContextPath()%>/js/Appclient.js">
</script>
<script type="text/javascript">
    	function refreshList(personId) {
               //alert("点击!")
                document.main.location.href = "/pages/doc/PersonIndex.jsf?setId=A001&fk="+personId;
         
        }
        function queryPerson() {
        	var obj11 = document.all("input1Name");
        	//alert(obj11.value);
            retval = window.showModalDialog("/doc/QueryPersonResult.jsf?filterSQL=<%=com.hr319wg.util.CommonFuns.filterNull(request.getParameter("filterSQL"))%>&personName= " + obj11.value, "", "dialogWidth:800px; dialogHeight:600px; center:yes; status:1;");
            if(retval!=null){
			  document.tree.location.href = "/pages/doc/DeptLeaderTree.jsp?filterSQL=<%=CommonFuns.filterNull(request.getParameter("filterSQL"))%>&personId="+retval;
			  document.main.location.href = "/pages/doc/PersonIndex.jsf?setId=A001&fk="+retval;
			  }
			else
			  document.tree.location.href = "/pages/doc/DeptLeaderTree.jsp?filterSQL=<%=CommonFuns.filterNull(request.getParameter("filterSQL"))%>&";

        }
          with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 50;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

</head>

<body>
<table width="100%" border="0" cellpadding="2" cellspacing="0">
	<tr>
		<td id="showTree" width="210">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
		<td height="30" class="td_title">按姓名模糊查询
		<input type="text" name="input1Name" id="input1Name">
		<input type="button" onclick="javascript:queryPerson();"
			styleClass="button" value="查询"></td>

	</tr>
            <tr>
				<td valign="top"><iframe name="tree" height="100%"  frameborder="0"
					framespacing="0" scrolling="yes" width="100%" height="465"
					src="/pages/doc/DeptLeaderTree.jsp?filterSQL=<%=request.getParameter("filterSQL")%>
                                 "></iframe>
				</td>
			</tr>
		</table>
		</td>
		<td width="6" class="ctrlbar" id="ctrlbar" valign="middle"></td>
		<td align="center" valign="top" class="explorer">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><iframe name="main" height="100%"  frameborder="0" framespacing="0"
					scrolling="yes" width="100%" height="465"
					src="/pages/doc/PersonIndex.jsf"></iframe></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<script type="text/javascript">
        document.all('ctrlbar').onmousedown = mouseDown;  //ctrlbar为中间可脱拽的对象的名字
        var leftTd = document.all('showTree');        //showTree左边iframe所在的TD的名字
        document.write('<span id="mbar" style="position:absolute;top:0;width:23px;height:100%;visibility:hidden;background-color:gray;"></span>');

        function mouseMove(ev) {
            ev = window.event;
            var mousePos = mouseCoords(ev);
            mbar.style.position = 'absolute'
            mbar.style.left = mousePos.x - 8;
        }
        function mouseCoords(ev) {
            return {
                x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
                y:ev.clientY + document.body.scrollTop - document.body.clientTop
            };
        }
        function mouseUp(ev) {
            ev = window.event;
            var mousePos = mouseCoords(ev);
            mbar.style.visibility = 'hidden';
            tdwidth = mousePos.x - 12;
            if(tdwidth <0)
                tdwidth = 1;
            leftTd.style.width = tdwidth;
            mbar.select();
//            var r = document.body.createTextRange();
//            r.moveToPoint(0, 0);
//            r.expand("word");
//            r.select();
        }
        function mouseDown() {
            mbar.style.visibility = '';

        }
        document.onmousemove = mouseMove;
        mbar.onmouseup = mouseUp;
</script>
</body>
</html>
