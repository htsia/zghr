<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title><%=Constants.SYSTEM_NAME%></title>
<link href="/css/css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style1 a{color:#FFFFFF}
.style2 {
	color: #2674BE;
	font-weight: bold;
}
body{color:#FFFFFF; background-color:#FFFFFF}
-->
</style>
    <script type="text/javascript">
        var info="";
        //XMLHttpRequest状态改变时要执行的函数
        function handleStateChange() {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    //解析从xml文件得到的结果,动态画树
                    parseResults();
                }
            }
        }

        //解析从xml文件得到的结果
        function parseResults() {
            var results = xmlHttp.responseXML;
            var orgs = null;
            var trees = results.getElementsByTagName("CheckLogin");
            for (var i = 0; i < trees.length; i++) {
                orgs = trees[i];
                info = orgs.getElementsByTagName("Result")[0].firstChild.nodeValue;
            }
        }
        //创建XMLHttpRequest对象
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }
        
        function doLogin(){
            if (document.all('form1:loginName').value==''){
                alert("必须输入用户名!");
                return false;
            }
            if (document.all('form1:password').value==''){
                alert("必须输入密码!");
                return false;
            }
            createXMLHttpRequest();
            xmlHttp.open("POST", "/pages/ajax/CheckLogin.jsp?loginName="+document.all('form1:loginName').value+"&password="+document.all('form1:password').value, false);
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
            xmlHttp.send(null);
            if (info=="true"){
                 window.location.href="/Logininterface.jsf";
            }
            else{
                alert(info);
            }
        }
        //document.oncontextmenu=function(e){return false;}

        function UserKeyDown(){
             if(event.keyCode == 13)
             event.keyCode = 9;
        }
        function PassKeyDown(){
            if(event.keyCode == 13){
                doLogin();
            }
        }
    </script>
</head>

<body>
<form id="form1" method="post" action="/Logininterface2.jsf">
<table class="login_bg" width="100" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td >
	<table class="kuang" width="339" height="61" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="65" height="36"><div align="left">用户名：</div></td>
        <td width="160"><input style="height:20px;width:150px" type="text" name="form1:loginName" onKeyDown="UserKeyDown();"></td>
        <td colspan="2" rowspan="2">
            <img id="loginButton" onmouseover="this.src='/pages/project/images/an-down.jpg';" onmouseout="this.src='/pages/project/images/an-dl.jpg';" src="/pages/project/images/an-dl.jpg" width="88" height="45" border="0" onclick="doLogin();">
        </td>
      </tr>
      <tr>
        <td><div align="left">密码：</div></td>
        <td><input style="height:20px;width:150px" type="password" name="form1:password" onKeyDown="PassKeyDown();"></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</form>
</body>
</html>
