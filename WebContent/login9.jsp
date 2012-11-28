<%@page import="com.hr319wg.custom.util.CommonUtil"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<script src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js" type="text/javascript"></script>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" align="center" >
       <tr>
           <td  height='100%' width='100%' ><img alt="" src='/<%=CommonUtil.getSYS_INTERFACE()[0]%>' width=100% height=100% style='position:absolute;top:0;left:0;z-index:-1'></td>
       </tr>
    </table>

    <table id="center" style='POSITION: absolute;' cellspacing=0 cellpadding=0 border=0>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>用户名</font></td>
        <td width=5></td>
        <td>
           <input type= "text" id="username" alt="用户名|0|s|50" tabindex="1" class="inputDark"/>&nbsp;&nbsp;
        </td>  
    </tr>
    <tr>
        <td align="right" height="40"><font color=<%=Constants.LOGIN_FONT_COLOR%>>密&nbsp;&nbsp;&nbsp;码</font></td>
        <td width=5></td>
        <td>
           <input type= "password" id="password" alt="密码|0|s|50" tabindex="2" class="inputDark"/>&nbsp;
           <input type="button" id = "btnLogin" value= "登录" onclick="check()" tabindex="3" class="button01" tabindex="3"/>
        </td>  
    </tr>
    
    </table>

    <script type="text/javascript">
   		document.onkeydown = function(e){ 
	    	e = e ? e : window.event; 
	    	var keyCode = e.which ? e.which : e.keyCode; 
	    	if(keyCode == 13) 
	    	{ 
	    		check(); //按下“回车”键时调用表单验证函数 
	    	} 
    	}; 

		function setpos(){
			var logintop=document.body.clientHeight/5*2+10;
			var loginleft=document.body.clientWidth /3*2-20;
			document.all("center").style.top=logintop;
			document.all("center").style.left=loginleft;

			logintop=document.body.clientHeight*0.86;
		}
		setpos();

		window.onresize=setpos;
		function check(){
			var username = document.all("username").value;
			var password = document.all("password").value;
			if(username == ""){
				alert("请输入登录名");
// 			}else if(password == ""){
// 				alert("请输入密码");
			}else{
// 				$.post("/pages/uum/valLogin9.jsp?para="+$("#password").val(),function(data){
// 					if(data!=1){
// 						alert("密码错误");
// 					}else{
						var url = "/pages/uum/Login_ehr.jsp?username="+username;
						window.location=url;
// 					}
// 				});
			}
		}
		document.all("username").focus();
    </script>
