<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 
<html>
<head>
    <title>机构浏览</title>
	<link rel="stylesheet" type="text/css"		href="<%=request.getContextPath()%>/css/style.css" />

    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
    function refreshList(orgId) {
               document.main.location.href = "/doc/OrgBasicInfo.jsf?setId=B001&orgId="+orgId;
           }
        function queryPerson() {
        	var obj11 = document.all("form1:input1Name");
        	//alert(obj11.value);
            retval = window.showModalDialog("/doc/QueryPersonResult.jsf?personName= " + obj11.value, "", "dialogWidth:800px; dialogHeight:600px; center:yes; status:1;");
		  document.tree.location.href = "/pages/doc/PersonTree.jsp?personId="+retval;

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
<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height="22" valign="top" class="f04">机构信息浏览</td>
        </tr>
    </table>

    
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="table02">
        <tr>
            <td class="table01" id="showTree" width="159">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                 height="465" src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>
            <td width="6" class="ctrlbar" id="ctrlbar" valign="middle" >
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top" class="explorer">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                   height="465" src="/doc/OrgBasicInfo.jsf"></iframe>
            </td>
        </tr>
    </table>
</h:form>
</body>
</html>