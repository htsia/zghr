<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="java.util.List"%>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
  %>

<script type="text/javascript">
        function refreshList(orgId) {
                  document.main.location.href = "/doc/OrgIndex.jsf?fk="+orgId;
        }
        function queryPerson() {
        }

        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 55;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

</head>

<h:form id="form1">
<f:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0"	bgcolor="#FFFFFF">
		<tr>
			<td class="td_title">　
</f:verbatim>
              <h:graphicImage value="/images/tips.gif"/>
              <h:outputText value="机构档案浏览"></h:outputText>
<f:verbatim>
            </td>
		</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td id="showTree" width="210">
                  <iframe name="tree" frameborder="0"	scrolling="auto" width="100%"	src="/pages/common/ShowOrgTree.jsp"></iframe>
			</td>

           <td width="10" class="ctrlbar" id="ctrlbar" valign="middle"></td>

            <td align="center" valign="top" class="explorer">
               <iframe name="main" frameborder="0" scrolling="auto" width="100%"	src="/doc/OrgIndex.jsf"></iframe>
			</td>
		</tr>
	</table>
</f:verbatim>
</h:form>
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

