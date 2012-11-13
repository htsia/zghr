<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    Map map = user.getPmsQueryCode();
    String sql = null;
    String inpart = "";
    if(map != null){
        List list = (List) map.get(Constants.SYS_SAVE_ABILITY_PERSON);
        //System.out.println(list.size());
        if(list != null && !list.isEmpty()){
            for(int i=0;i<list.size();i++){
                CodeItemBO code = (CodeItemBO) list.get(i);
                inpart += code.getItemId() + ",";
            }

            inpart = inpart.replaceAll(",","','");
            inpart = "'" + inpart;
            inpart = inpart.substring(0,inpart.length() -2);
            //System.out.println("inpart" + inpart);
        }
    }
    if(inpart == null || inpart.length() <=0)
        inpart = "'9999'";
    sql = "p.sysSaveAbilityCode in (" + inpart + ") and p.personCancel ='00900' and p.partyCancel = '00900' and p.retireCancel='00900' ";

%>
 
<html>
<head>
    <title></title>
	<link rel="stylesheet" type="text/css"  		href="<%=request.getContextPath()%>/css/style.css" />

    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
    	function refreshList(personId) {
               //alert("点击!")
                document.main.location.href = "/pages/doc/SavePersonIndex.jsf?fk="+personId;
         
        }
        function queryPerson() {
        	var obj11 = document.all("input1Name");
        	//alert(obj11.value);
            retval = window.showModalDialog("/doc/QueryPersonResult.jsf?filterSQL=<%=sql%>&personName=" + obj11.value, "", "dialogWidth:800px; dialogHeight:600px; center:yes; status:1;");
            if(retval!=null){
                document.tree.location.href = "/pages/doc/SysPersonTree.jsp?filterSQL=<%=sql%>&personId="+retval;
                document.main.location.href = "/pages/doc/SavePersonIndex.jsf?fk="+retval;
            }
        }
          with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 70;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + (parseInt(mainHeight)+ 40 )+ "px";
        }
    </script>

</head>

<body style="overflow:hidden;">
<h:form id="form1">
    
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
		            <td class="td_title">　按姓名模糊查询：
						<input type="text" name="input1Name" id="input1Name" class="input" onkeypress ="enterKeyDown('querybutton')">
						<input type="button" onclick="javascript:queryPerson();" class="button01" value=" 查询 " id="querybutton">
					</td>
	        	</tr>
                <tr>
                    <td valign="top">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                 src="/pages/doc/SysPersonTree.jsp?filterSQL=<%=sql%>
                                 "></iframe>
                    </td>
                </tr>
            </table>
           </td>
           <td  class="ctrlbar" id="ctrlbar" valign="middle"></td>
            <td align="center" valign="top" class="explorer">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                   src="/pages/doc/SavePersonIndex.jsf"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
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
</body>
</html>