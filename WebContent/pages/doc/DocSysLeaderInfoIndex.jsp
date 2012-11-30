<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String str = " or p.sysCadreCode='018823'";
    User bo = (User) session.getAttribute(Constants.USER_INFO); //add by yejb 061230
    //add by yejb 061230 start 判断是否上级，是的话将判断风险总监的去除
    if (bo != null){
        if (Constants.ORG_BENBU.equals(bo.getOrgId())){
            str = "";
        }
    }
    //add by yejb end
%>
 
<html>
<head>
    <title>人员档案浏览</title>
	<link rel="stylesheet" type="text/css"		href="<%=request.getContextPath()%>/css/style.css" />

	<style>
.td_sec1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
    background-color: #EFEFEF;
    border-left: 0px;
    border-top: 0px;
    border-right: 1px solid #BCBCBC;
    border-bottom: 1px solid #BCBCBC;
	text-align:center;
	height:30;
}
.td_sec2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
    background-color: #DDDDDD;
    border-left: 0px;
    border-top: 0px;
    border-right: 1px solid #BCBCBC;
    border-bottom: 1px solid #BCBCBC;
	text-align:center;
	height:30;
}
.table{ 
	border-collapse:collapse;
	border-top: 1px #BCBCBC solid;
	border-left: 1px #BCBCBC solid;
}
a:link {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #444444;text-decoration: none;}
a:active {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #C54320;text-decoration: none;}
a:visited {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #444444;text-decoration: none;}
a:hover {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #C54320;text-decoration: none;}
</style>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
    	function refreshList(personId) {
               //alert("点击!")
                document.main.location.href = "/pages/doc/PersonIndex.jsf?setId=A001&fk="+personId;
         
        }
        function queryPerson() {
        	var obj11 = document.all("input1Name");
        	//alert(obj11.value);
            retval = window.showModalDialog("/doc/QueryPersonResult.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and((p.sysCadreCode='018822')or(p.sysCadreCode='018823'))&personName= " + obj11.value, "", "dialogWidth:800px; dialogHeight:600px; center:yes; status:1;");
            if(retval!=null){
			  document.tree.location.href = "/pages/doc/SysPersonTree.jsp?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and((p.sysCadreCode='018822')or(p.sysCadreCode='018823'))&personId="+retval;
			  document.main.location.href = "/pages/doc/PersonIndex.jsf?setId=A001&fk="+retval;
			  }
			else
			  document.tree.location.href = "/pages/doc/SysPersonTree.jsp?(p.personCancel='00900')and(p.partyCancel='00900')and((filterSQL=p.sysCadreCode='018822')or(p.sysCadreCode='018823'))&";

        }
          with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 50;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

</head>

<body>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height="30" width="20%" class="td_title">
            <%
            String filterSql = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("filterSQL"));

	            out.println("<table border='0' width='100%' class='table'><tr>");
					out.println("<td class='td_sec2'>");



		       
		       out.println("风险条线");
	    	   out.println("</td>");
					out.println("<td class='td_sec1'>");

	            out.println("<a href=\"/pages/doc/DocSysLeaderInfoIndex1.jsf?filterSQL=p.personCancel='00900'%20and%20p.partyCancel='00900'%20and%20p.sysCadreCode=\'018821\'\">");
	            out.println("审计条线");
	            out.println("</a></td>");
	            
	            out.println("</tr>");
		        out.println("</table>");

            %>
            </td>
            
			<td class="td_title" width="45%">				按姓名模糊查询	
				<input type="text" name="input1Name" id="input1Name">
				<input type="button" onclick="javascript:queryPerson();" styleClass="button" value="查询">
			</td>
			<td width="35%">
				&nbsp;
			</td>
        </tr>
    </table>

    
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table02">
        <tr>
            <td class="table01" id="showTree" width="210">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="260"  valign="top">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                 height="465" src="/pages/doc/SysPersonTreeLeader.jsp?filterSQL=p.personCancel='00900' and p.partyCancel='00900' and (p.sysCadreCode='018822' <%=str%>)"></iframe>
                    </td>
                </tr>
            </table>
           </td>
           <td width="6" class="ctrlbar" id="ctrlbar" valign="middle"></td>
            <td align="center" valign="top" class="explorer">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                   height="465" src="/pages/doc/PersonIndex.jsf"></iframe>
                        </td>
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